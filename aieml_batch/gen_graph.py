#!/usr/bin/env python
"""Generate / verify / report the batched RTDA AIE-ML project via aie4ml.

The graph is built as ONNX from the exported weights in data_fp32/, handed to
aie4ml, which lowers each Gemm to an aie::mmul kernel and emits a normal Vitis
AIE project (app.cpp, aie.cfg, src/). The Makefile drives compilation and
simulation from there.

Subcommands
    gen      build the ONNX and emit the AIE project into this directory
    verify   run the x86 or aie simulator and compare against a Keras reference
    report   print interval / throughput numbers from the last aie simulation

Key knobs (env or CLI): BATCH, INPUT_DIM, ITERS, SOLVERS.
"""
from __future__ import annotations

import argparse
import json
import os
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
REPO = HERE.parent

# --- Weights ---------------------------------------------------------------
# data_fp32/, never data/. The repo's data/ dir is manually swapped between fp32
# and int16 payloads; loading int16 text into a float32 model silently yields
# integer-valued weights and meaningless results.
DATA_DIR = Path(os.environ.get('WEIGHTS_DIR') or REPO / 'data_fp32')

HIDDEN = 128            # HIDDEN_SIZE from common/nn_defs10.h
REAL_FEATURES = 6       # physically meaningful embed inputs; cols 6:8 are zero pad

# INPUT_DIM: width presented to the first dense layer.
# aie4ml aligns the contracted dimension to lhs_align = 2 * microtile_k = 16.
# At width 6 or 8 the input is padded 6->16, and that strided staging needs one
# memory-tile buffer descriptor per batch row, which exhausts the BD pool for
# batch > 8 ("[aiecompiler 77-4352] Failed to allocate buffer descriptors for
# buffer_x"). At width 16 the copy is contiguous and the problem disappears.
INPUT_DIM = int(os.environ.get('INPUT_DIM', '16'))
BATCH = int(os.environ.get('BATCH', '8'))
ITERS = int(os.environ.get('ITERS', '10'))
SOLVERS = int(os.environ.get('SOLVERS', '1'))
PLATFORM = os.environ.get('AIE_PLATFORM', 'xilinx_vek280_base_202520_1')
PROJECT = 'rtda_batch'
# common/nn_defs10.h:40 -- LEAKY_SLOPE. The 0.125 variant is HLS/PL only (DSP saving).
LEAKY_SLOPE = float(os.environ.get('LEAKY_SLOPE', '0.1'))


def _load(name):
    return np.loadtxt(DATA_DIR / name).astype(np.float32)


def _parts(stem, n, rows, cols):
    return np.concatenate([_load(f'{stem}_part{i}.txt') for i in range(n)]).reshape(rows, cols).astype(np.float32)


def load_weights(solvers: int):
    w = {}
    raw = _load('embed_dense_0_weights.txt').reshape(8, HIDDEN)
    W_e0 = np.zeros((INPUT_DIM, HIDDEN), dtype=np.float32)
    W_e0[:min(8, INPUT_DIM), :] = raw[:min(8, INPUT_DIM), :]
    w['W_e0'] = W_e0
    w['B_e0'] = _load('embed_dense_0_bias.txt')
    w['W_e1'] = _parts('embed_dense_1_weights', 2, HIDDEN, HIDDEN)
    w['B_e1'] = _load('embed_dense_1_bias.txt')

    for s in range(solvers):
        # dense0 is 256x128: rows 0:128 act on the current track, 128:256 on the
        # previous one -- i.e. exactly what roll_concat concatenates today.
        w[f'W_s{s}_d0'] = _parts(f'solver_{s}_dense_0_weights', 4, 2 * HIDDEN, HIDDEN)
        w[f'B_s{s}_d0'] = _load(f'solver_{s}_dense_0_bias.txt')
        for n in (1, 2, 3):
            w[f'W_s{s}_d{n}'] = _parts(f'solver_{s}_dense_{n}_weights', 2, HIDDEN, HIDDEN)
            w[f'B_s{s}_d{n}'] = _load(f'solver_{s}_dense_{n}_bias.txt')
    return w


def layer_names(solvers: int):
    """Dense layer names in graph order. Also the set that takes cas_num directives."""
    names = ['emb_d0', 'emb_d1']
    for s in range(solvers):
        names += [f's{s}_d0', f's{s}_d1', f's{s}_d2', f's{s}_d3']
    return names


def build_reference(w, solvers: int):
    """Keras model used purely as the numerical golden reference.

    Every ReLU deliberately follows a Dense. aie4ml's passes/fuse_activation.py
    fuses relu only when `producer.op_type == 'dense'`; a relu after an Add
    survives as a bare 'activation' node and passes/resolve.py then raises
    NotImplementedError. That is why solver dense0 is one Dense(256->128) here
    rather than Relu(Add(Gemm(curr), Gemm(prev))). Same MAC count either way,
    and this form matches the shipping graph (SUBSOLVER0_INPUT_SIZE = 256).
    """
    from keras.layers import Dense, Input, LeakyReLU
    from keras.models import Model

    x_in = Input(shape=(INPUT_DIM,), name='x')
    h = Dense(HIDDEN, name='emb_d0')(x_in); h = LeakyReLU(alpha=LEAKY_SLOPE)(h)
    emb = Dense(HIDDEN, name='emb_d1')(h); emb = LeakyReLU(alpha=LEAKY_SLOPE)(emb)

    inputs, outputs = [x_in], [emb]
    for s in range(solvers):
        s_in = Input(shape=(2 * HIDDEN,), name=f's{s}_in')
        inputs.append(s_in)
        h = Dense(HIDDEN, name=f's{s}_d0')(s_in); h = LeakyReLU(alpha=LEAKY_SLOPE)(h)
        h = Dense(HIDDEN, name=f's{s}_d1')(h); h = LeakyReLU(alpha=LEAKY_SLOPE)(h)
        h = Dense(HIDDEN, name=f's{s}_d2')(h); h = LeakyReLU(alpha=LEAKY_SLOPE)(h)
        outputs.append(LeakyReLU(alpha=LEAKY_SLOPE)(Dense(HIDDEN, name=f's{s}_d3')(h)))

    ref = Model(inputs, outputs)
    ref.get_layer('emb_d0').set_weights([w['W_e0'], w['B_e0']])
    ref.get_layer('emb_d1').set_weights([w['W_e1'], w['B_e1']])
    for s in range(solvers):
        for n in range(4):
            ref.get_layer(f's{s}_d{n}').set_weights([w[f'W_s{s}_d{n}'], w[f'B_s{s}_d{n}']])
    return ref


def build_onnx(w, batch: int, solvers: int):
    import onnx
    from onnx import TensorProto, helper, numpy_helper

    def _act(ins, outs, name):
        # LeakyRelu, not Relu: aieml/bias_relu_fused.cpp computes max(y, 0.1*y).
        return helper.make_node('LeakyRelu', ins, outs, name=name, alpha=LEAKY_SLOPE)

    nodes = [
        helper.make_node('Gemm', ['x', 'W_e0', 'B_e0'], ['h_e0'], name='emb_d0', transB=0),
        _act(['h_e0'], ['r_e0'], 'emb_r0'),
        helper.make_node('Gemm', ['r_e0', 'W_e1', 'B_e1'], ['h_e1'], name='emb_d1', transB=0),
        _act(['h_e1'], ['emb_out'], 'emb_r1'),
    ]
    graph_in = [helper.make_tensor_value_info('x', TensorProto.FLOAT, [batch, INPUT_DIM])]
    graph_out = [helper.make_tensor_value_info('emb_out', TensorProto.FLOAT, [batch, HIDDEN])]
    init_names = ['W_e0', 'B_e0', 'W_e1', 'B_e1']

    for s in range(solvers):
        sin = f's{s}_in'
        graph_in.append(helper.make_tensor_value_info(sin, TensorProto.FLOAT, [batch, 2 * HIDDEN]))
        prev = sin
        for n in range(4):
            wn, bn = f'W_s{s}_d{n}', f'B_s{s}_d{n}'
            init_names += [wn, bn]
            # Every dense layer is followed by an activation, dense3 included --
            # aieml/graph.h instantiates solverN_bias_relu3 after solverN_dense3.
            out = f'h_s{s}_{n}'
            nodes.append(helper.make_node('Gemm', [prev, wn, bn], [out], name=f's{s}_d{n}', transB=0))
            prev = f's{s}_out' if n == 3 else f'r_s{s}_{n}'
            nodes.append(_act([out], [prev], f's{s}_r{n}'))
        graph_out.append(helper.make_tensor_value_info(f's{s}_out', TensorProto.FLOAT, [batch, HIDDEN]))

    graph = helper.make_graph(
        nodes, PROJECT, inputs=graph_in, outputs=graph_out,
        initializer=[numpy_helper.from_array(w[k], k) for k in init_names],
    )
    proto = helper.make_model(graph, opset_imports=[helper.make_opsetid('', 13)])
    proto.ir_version = 8
    onnx.checker.check_model(proto)
    return proto


# PRECISION -> aie4ml's AIEConfig.ComputeDtype (passes/force_float_mode.py).
# On AIE-ML both use the SAME aie::mmul microtile, (4,8,4) -- see
# op_impls/families/matmul/common.py MICROTILE_OPTIONS -- so BATCH stays 8 and
# the whole batching argument is unchanged by the precision switch.
COMPUTE_DTYPE = {'fp32': 'float32', 'bf16': 'bfloat16'}


def make_config(batch: int, solvers: int, precision: str = 'fp32'):
    # cas_num is capped at 2 on the 128-wide layers: the default of 4 saturates
    # the 6 MM2S DMA channels of a memory tile (per aie4ml tutorial_3).
    # cas_length is pinned, not left to the resolver. bf16 halves the weight bytes,
    # so the resolver picks a SHORTER cascade for the same layer (emb_d1 2->1,
    # solver d0 4->2). That changes the kernel count per layer, hence the graph
    # structure, the RTP port count and the hand-added Phase 3 wiring -- and it
    # would confound the comparison, since fp32 and bf16 would then differ in
    # parallelism as well as precision. Pinning keeps the two trees structurally
    # identical so precision is the only variable.
    CAS_LENGTH = {'emb_d0': 1, 'emb_d1': 2}
    for s in range(solvers):
        CAS_LENGTH[f's{s}_d0'] = 4
        for d in (1, 2, 3):
            CAS_LENGTH[f's{s}_d{d}'] = 2
    directives = {n: {'parallelism': {'cas_num': 2, 'cas_length': CAS_LENGTH[n]}}
                  for n in layer_names(solvers) if n != 'emb_d0'}
    aie_cfg = {'BatchSize': batch, 'Iterations': ITERS}
    if precision not in COMPUTE_DTYPE:
        raise ValueError(f'precision {precision!r}; use one of {list(COMPUTE_DTYPE)}')
    if precision != 'fp32':
        aie_cfg['ComputeDtype'] = COMPUTE_DTYPE[precision]
    return {
        'Part': PLATFORM,
        'AIEConfig': aie_cfg,
        'LayerDirectives': directives,
    }


def stimulus(batch: int, solvers: int, seed: int = 42):
    rng = np.random.default_rng(seed)
    x = np.zeros((batch, INPUT_DIM), dtype=np.float32)
    x[:, :REAL_FEATURES] = rng.random((batch, REAL_FEATURES), dtype=np.float32)
    feed = {'x': x}
    for s in range(solvers):
        feed[f's{s}_in'] = rng.random((batch, 2 * HIDDEN), dtype=np.float32)
    return feed


def _model(batch, solvers, precision='fp32', output_dir=None):
    from aie4ml.frontends.onnx import from_onnx
    w = load_weights(solvers)
    proto = build_onnx(w, batch, solvers)
    return w, from_onnx(proto, make_config(batch, solvers, precision),
                        output_dir=str(output_dir or HERE), project_name=PROJECT)


def cmd_gen(a):
    _, m = _model(a.batch, a.solvers, a.precision, a.out)
    # aie4ml's write() drops its own Makefile into output_dir, clobbering ours.
    # Keep ours as Makefile and park theirs alongside for reference.
    mk = HERE / 'Makefile'
    saved = mk.read_bytes() if mk.exists() else None
    m.write()
    if saved is not None:
        if mk.exists() and mk.read_bytes() != saved:
            (HERE / 'Makefile.aie4ml').write_bytes(mk.read_bytes())
        mk.write_bytes(saved)
    macs = INPUT_DIM * HIDDEN + HIDDEN * HIDDEN + a.solvers * (2 * HIDDEN * HIDDEN + 3 * HIDDEN * HIDDEN)
    print(f'Generated {PROJECT}: batch={a.batch} input_dim={INPUT_DIM} solvers={a.solvers} '
          f'iters={ITERS}\n  dense layers : {len(layer_names(a.solvers))}'
          f'\n  MACs / track : {macs:,}'
          f'\n  ops  / track : {2 * macs:,}   (1 MAC = 1 multiply + 1 add)')


def cmd_verify(a):
    w, m = _model(a.batch, a.solvers)
    ref = build_reference(w, a.solvers)
    feed = stimulus(a.batch, a.solvers)
    names = ['emb_out'] + [f's{s}_out' for s in range(a.solvers)]
    got = m.predict(feed, simulator=a.sim)
    exp = ref.predict([feed['x']] + [feed[f's{s}_in'] for s in range(a.solvers)], verbose=0)
    if not isinstance(exp, list):
        exp = [exp]
    ok = True
    for name, e in zip(names, exp):
        mse = float(np.mean((e[:a.batch] - got[name][:a.batch]) ** 2))
        flag = 'ok' if mse < 1e-8 else 'FAIL'
        ok &= mse < 1e-8
        print(f'  {name:10s} MSE = {mse:.3e}  {flag}')
    print('PASS' if ok else 'FAIL')
    raise SystemExit(0 if ok else 1)


def cmd_report(a):
    from aie4ml.simulation import read_aie_report
    rep = read_aie_report(str(HERE))
    gi = (rep.get('output_interval') or {}).get('global') or {}
    print(json.dumps({k: v for k, v in rep.items() if k != 'AIE_info'}, indent=1))
    if gi.get('avg_ns'):
        print(f'\n  II            = {gi["avg_ns"]:.1f} ns  '
              f'(min {gi.get("min_ns")}, max {gi.get("max_ns")}, n={gi.get("samples")})')
        print(f'  ns per track  = {gi["avg_ns"] / a.batch:.1f}   (batch = {a.batch})')


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--batch', type=int, default=BATCH)
    p.add_argument('--solvers', type=int, default=SOLVERS)
    p.add_argument('--precision', choices=('fp32', 'bf16'),
                   default=os.environ.get('RTDA_PRECISION', 'fp32'))
    p.add_argument('--out', default=None,
                   help='generate into this directory instead of aieml_batch/ '
                        '(use a scratch dir - write() also drops a Makefile)')
    sub = p.add_subparsers(dest='cmd', required=True)
    sub.add_parser('gen').set_defaults(fn=cmd_gen)
    v = sub.add_parser('verify'); v.add_argument('--sim', choices=('x86', 'aie'), default='x86')
    v.set_defaults(fn=cmd_verify)
    sub.add_parser('report').set_defaults(fn=cmd_report)
    args = p.parse_args()
    args.fn(args)
