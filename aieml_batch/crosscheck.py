#!/usr/bin/env python
"""Cross-check aieml_batch against the aieml/ reference output.

Three-way comparison over the real 50-track stimulus in data_fp32/:

    numpy golden  <->  data_fp32/aieml10_output_aie.txt   (validates the reference)
    numpy golden  <->  aieml_batch AIE simulation          (validates the new graph)

The golden model is the full 14-layer chain rebuilt in numpy from the same weight
files, with leaky-ReLU max(y, 0.1*y) after every dense layer (LEAKY_SLOPE = 0.1,
common/nn_defs10.h:40) and the roll-concat expressed as
    assemble(a) = concat([a, roll(a, 1, axis=0)], axis=-1)
which is what aieml/roll_concat.cpp computes.

WARM-UP: tracks 0,1,2 are excluded. roll_concat starts with zero-initialised
history and the network's receptive field is 4 tracks deep, so the first three
outputs are contaminated. This is WARMUP = 3 in the reference notebooks, and it is
expected -- those tracks differ by ~0.2 while tracks 3..49 agree to 1e-6.

Usage:  crosscheck.py [--sim aie|x86] [--solvers N] [--batch N]
"""
from __future__ import annotations

import argparse
import os
import sys
from pathlib import Path

import numpy as np

import aie_io

HERE = Path(__file__).resolve().parent
REPO = HERE.parent
# NOT 'DATA_DIR': ../set_envs.sh exports that pointing at data/, which holds int16
# text. Loading it into a float32 model yields integer weights and garbage.
D = Path(os.environ.get('WEIGHTS_DIR') or REPO / 'data_fp32')
H = 128
N_TRACKS = 50
WARMUP = 3
SLOPE = 0.1


def L(n):
    return np.loadtxt(D / n).astype(np.float32)


def P(stem, n, r, c):
    return np.concatenate([L(f'{stem}_part{i}.txt') for i in range(n)]).reshape(r, c).astype(np.float32)


def lrelu(a):
    return np.maximum(a, SLOPE * a)


def assemble(a):
    """roll_concat: row j -> [a[j], a[j-1]]  (circular over the 50-track event)."""
    return np.concatenate([a, np.roll(a, 1, axis=0)], axis=-1)


def golden():
    """Full 14-layer chain in numpy. Returns (emb, [s0,s1,s2])."""
    X = L('embed_input.txt').reshape(-1, 8)
    h = lrelu(X @ L('embed_dense_0_weights.txt').reshape(8, H) + L('embed_dense_0_bias.txt'))
    emb = lrelu(h @ P('embed_dense_1_weights', 2, H, H) + L('embed_dense_1_bias.txt'))
    outs, cur = [], emb
    for s in range(3):
        z = lrelu(assemble(cur) @ P(f'solver_{s}_dense_0_weights', 4, 2 * H, H)
                  + L(f'solver_{s}_dense_0_bias.txt'))
        for n in (1, 2, 3):
            z = z @ P(f'solver_{s}_dense_{n}_weights', 2, H, H) + L(f'solver_{s}_dense_{n}_bias.txt')
            if n < 3:
                z = lrelu(z)
        cur = lrelu(z)
        outs.append(cur)
    return emb, outs


# 1e-4, not 1e-5. float32 on AIE-ML is emulated on the bfloat16 datapath
# (VCONV.bf16.fp32 + paired VMAC/VMSC), so results are not IEEE-exact fp32. Over a
# 14-layer chain a few elements land ~1e-5 off on values of order 1, while the mean
# stays ~1e-7. For scale: the aieml/ reference itself only agrees with a numpy
# float64-ish golden to 1.1e-06, and the final output agrees to 4.0e-06.
# Tolerance is a property of the arithmetic, not of the design. float32 on
# AIE-ML is emulated on the bf16 datapath and lands ~1e-5 from a float64 model;
# a true bf16 build keeps ~8 mantissa bits and lands ~2e-2 on values of order 1.
# One tolerance for both would either pass a broken fp32 build or fail every
# healthy bf16 one.
TOL = {'fp32': 1e-4, 'bf16': 5e-2}[os.environ.get('RTDA_PRECISION', 'fp32')]


def compare(name, a, b, tol=TOL):
    d = np.abs(a[WARMUP:N_TRACKS] - b[WARMUP:N_TRACKS])
    ok = d.max() < tol
    print(f'  {name:34s} max|diff| = {d.max():.3e}  mean = {d.mean():.3e}   {"ok" if ok else "FAIL"}')
    return ok


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--sim', choices=('aie', 'x86'), default='aie')
    ap.add_argument('--solvers', type=int, default=int(os.environ.get('SOLVERS', '1')))
    ap.add_argument('--batch', type=int, default=int(os.environ.get('BATCH', '8')))
    ap.add_argument('--skip-aie', action='store_true', help='only validate the reference file')
    ap.add_argument('--slope', type=float, default=None,
                    help='leaky-ReLU slope for the golden used in check [2]. The RTDA '
                         'model uses 0.1, but aie4ml only emits plain ReLU (slope 0), so '
                         'pass 0 to check the graph against what it actually computes.')
    a = ap.parse_args()

    emb_g, soln_g = golden()          # slope 0.1 -- the real RTDA model
    print(f'numpy golden: {N_TRACKS} tracks, comparing tracks {WARMUP}..{N_TRACKS - 1}\n')

    ok = True
    ref_path = D / 'aieml10_output_aie.txt'
    if ref_path.exists():
        ref = L(ref_path.name).reshape(-1, H)
        print(f'[1] reference file vs numpy golden   ({ref_path})')
        ok &= compare('aieml10_output_aie.txt', soln_g[2], ref, tol=1e-4)  # the file is fp32
        pre = np.abs(soln_g[2][:WARMUP] - ref[:WARMUP]).max(axis=1)
        print(f'      (warm-up tracks 0..2 differ by {np.round(pre, 4)} -- expected)\n')
    else:
        print(f'[1] SKIP: {ref_path} not found\n')

    if a.skip_aie:
        raise SystemExit(0 if ok else 1)

    sys.path.insert(0, str(HERE))
    import run_sim

    batch, solvers = a.batch, a.solvers
    iters = -(-N_TRACKS // batch)                       # ceil, e.g. 7 blocks of 8 => 56 slots
    pad = iters * batch
    INPUT_DIM = aie_io.load_ports()['inputs']['x'][0].np_boundary[-1]

    def blocks(arr):
        out = np.zeros((pad, arr.shape[1]), dtype=np.float32)
        out[:N_TRACKS] = arr
        return out.reshape(iters, batch, arr.shape[1])

    # The golden that check [2] compares against, and that drives the solver
    # inputs, must use the SAME activation the graph implements. aie4ml emits
    # plain ReLU (passes/fuse_activation.py handles only 'relu' and 'linear'),
    # whereas the RTDA model uses leaky ReLU slope 0.1. Feeding leaky-derived
    # inputs while comparing against a plain-ReLU golden compares two different
    # networks and fails for the wrong reason.
    global SLOPE
    if a.slope is not None:
        SLOPE = a.slope
    emb_c, soln_c = golden()

    X = np.zeros((N_TRACKS, INPUT_DIM), dtype=np.float32)
    X[:, :8] = L('embed_input.txt').reshape(-1, 8)
    feed = {'x': blocks(X)}

    # Solver inputs are external only while the graph still exposes them. Once
    # the roll kernels are wired in, the graph produces them internally and the
    # whole chain is driven from x alone -- a stricter test, because errors then
    # compound across stages instead of each stage being fed a golden input.
    graph_inputs = set(aie_io.load_ports()['inputs'])
    external_rolls = sorted(t for t in graph_inputs if t.endswith('_in'))
    if external_rolls:
        stage_in = [emb_c] + soln_c[:-1]
        for s in range(solvers):
            if f's{s}_in' in graph_inputs:
                feed[f's{s}_in'] = blocks(assemble(stage_in[s]))
        print(f'    (solver inputs fed externally: {external_rolls})')
    else:
        print('    (solver inputs produced in-graph by the roll kernels; '
              'driven from x alone)')

    # The graph was compiled with a fixed N_ITER; feeding a different count
    # stalls it waiting for data that never arrives.
    if iters != run_sim.n_iter():
        raise SystemExit(f'batch {batch} needs {iters} iterations but the graph was '
                         f'built with N_ITER={run_sim.n_iter()}. Rebuild with '
                         f'ITERS={iters} or pick a batch that divides {N_TRACKS} evenly.')
    got = run_sim.run(feed, sim=a.sim)

    def flat(name):
        return np.asarray(got[name]).reshape(-1, H)[:N_TRACKS]

    if a.slope is not None and a.slope != 0.1:
        print(f'\n    (check [2] golden uses leaky slope {a.slope}; the RTDA model is 0.1)')
    print(f'[2] AIE ({a.sim} sim, batch={batch}, solvers={solvers}, iters={iters}) vs numpy golden')
    ok &= compare('emb_out', emb_c, flat('emb_out'))
    for s in range(solvers):
        ok &= compare(f's{s}_out', soln_c[s], flat(f's{s}_out'))

    # --- event tail: track average + output dense, if the graph has it -------
    if 'track_out' in got:
        Wo = np.loadtxt(D / 'output_weights.txt').astype(np.float32).reshape(128, 27)
        Bo = np.loadtxt(D / 'output_bias.txt').astype(np.float32)
        # Two references, because they answer different questions.
        # (orientation per host/host.cpp:394: y = avg @ W + B, W is [128][27])
        #
        #  - from the AIE's OWN s2_out: tests the accumulator and output dense
        #    in isolation. Must be ~1e-6.
        #  - from the pure numpy golden: also carries the warm-up difference,
        #    because the mean includes tracks 0..2 where the graph's zero-pad
        #    roll differs from the reference's circular roll by ~0.2. That shows
        #    up as ~4e-3 here and is expected, not a defect.
        y_aie_ref = flat('s2_out')[:N_TRACKS].mean(axis=0) @ Wo + Bo
        y_g = soln_c[2][:N_TRACKS].mean(axis=0) @ Wo + Bo

        width = np.asarray(got['track_out']).size // run_sim.n_iter()
        frames = np.asarray(got['track_out']).reshape(-1, width)
        nz = [i for i, f in enumerate(frames) if np.abs(f).max() > 0]
        print(f'\n[4] event tail (track average + output dense 128->27)')
        print(f'  emitting frames: {nz} of {len(frames)}   '
              f'(expect only the last -- one event completes)')
        if len(nz) != 1:
            print(f'  FAIL: expected exactly 1 non-zero frame, got {len(nz)}')
            ok = False
        else:
            f = frames[nz[0]]
            if width == 128:
                # graph emitted the mean; host applies the dense (as aieml/ does)
                y = f @ Wo + Bo
                y_aie_ref = flat('s2_out')[:N_TRACKS].mean(axis=0) @ Wo + Bo
                print('  (graph emits the 128-wide mean; output dense applied host-side)')
            else:
                y = f[:27]
            d = np.abs(y - y_aie_ref)
            good = d.max() < TOL
            ok &= good
            print(f'  {"vs mean of the AIE own s2_out":34s} max|diff| = {d.max():.3e}  '
                  f'mean = {d.mean():.3e}   {"ok" if good else "FAIL"}')
            dg = np.abs(y - y_g)
            print(f'  {"vs pure numpy golden":34s} max|diff| = {dg.max():.3e}  '
                  f'(warm-up tracks 0..2 in the mean; expected)')
            if width != 128:
                pad = np.abs(f[27:]).max()
                print(f'  padding lanes 27..31 max|.| = {pad:.3e} (expect 0)')

    if solvers == 3 and ref_path.exists():
        print(f'\n[3] AIE final output vs {ref_path.name} (the aieml/ reference)')
        # TOL, not 1e-4: this is the AIE's output, so it carries the build's own
        # arithmetic error. 1e-4 is right for fp32 and fails every healthy bf16 run.
        ok &= compare('s2_out vs aieml reference', flat('s2_out'), ref)
    elif solvers != 3:
        print(f'\n[3] SKIP end-to-end vs aieml reference: needs --solvers 3 (have {solvers})')

    print('\nPASS' if ok else '\nFAIL')
    raise SystemExit(0 if ok else 1)


if __name__ == '__main__':
    main()
