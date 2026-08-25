#!/usr/bin/env python
"""The RTDA network in torch -- a transcription of model/rtda_ref.py, nothing else.

WHY THIS FILE EXISTS AT ALL
    rtda_ref.py's own docstring records that there used to be four copies of
    this forward pass and they drifted. This is a fifth, and it is only
    justified because torch cannot execute numpy on a GPU. So it earns its
    place by being CHECKED against rtda_ref every time it runs, not by being
    carefully written once:

        rtda_torch.py --self-test          float64 on CPU vs rtda_ref float64
                                           expect ~1e-15. This is the gate that
                                           says the TRANSCRIPTION is right,
                                           separately from any float32 question.

WHAT IT IMPLEMENTS
    rtda_ref.forward(roll='streaming', quant=None) and nothing more. With
    quant=None every quantisation branch in the reference collapses, so the
    whole network is 14 GEMMs, each followed by bias and leaky-ReLU(0.1), with
    no rounding anywhere. `Quant.split_d0` -- the PL flow's two-128-wide-GEMM
    decomposition -- is unreachable when quant is None and is deliberately NOT
    implemented here.

FIVE DETAILS THAT ARE EASY TO GET WRONG, all load-bearing

    1. Feed exactly (n, 6).  rtda_ref.forward does NOT narrow x to 6 columns --
       it widens the WEIGHT to x.shape[1] via _pad_rows. Hand it (n, 8) and the
       summation length changes and the last couple of bits move. So the input
       here is (n, 6) and W['emb_d0'] is the (6, 128) slice, which is the
       _pad_rows no-op path.

    2. Concatenation order is [cur, prev], not [prev, cur].  W['s{s}_d0'] rows
       0..127 are the current track and 128..255 the previous one.

    3. The streaming head is a ZERO ROW in the run dtype, prepended to cur[:-1].
       Not a wrap-around: circular is the ONNX convention and is not what any
       hardware here does.

    4. Activation placement.  In the reference's inner loop d3 gets no
       activation, and then `cur = _act(z, ...)` applies one immediately after
       the loop. Net effect: every one of the 14 denses is followed by exactly
       one activation. Writing it as "no activation after d3" is the mistake.

    5. leaky-ReLU is max(a, 0.1*a), NOT where(a > 0, a, 0.1*a).  The two differ
       on signed zero. torch.nn.functional.leaky_relu uses the `where` form, so
       this file uses torch.maximum to match numpy exactly.

The roll is applied to the PREVIOUS solver's post-activation output, which is
what makes the receptive field exactly 4 tracks deep (1 embed + 3 rolls) and is
why cpu/scan_cpu.py's 3-track chunk overlap is exact rather than approximate.
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import numpy as np
import torch

HERE = Path(__file__).resolve().parent
REPO = HERE.parent
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

H = 128
TRACKS_PER_EVENT = 50
IN_FEATURES = 6
OUT_DIM = 27
SOLVERS = 3
SLOPE = 0.1
WARMUP_TRACKS = 3          # the receptive field, minus one

TORCH_DTYPE = {'fp32': torch.float32, 'fp64': torch.float64, 'bf16': torch.bfloat16}
# tf32 is not a storage dtype -- it is float32 storage with reduced-precision
# matmuls. It maps to float32 here and is selected by the TF32 backend flags.
TORCH_DTYPE['tf32'] = torch.float32


# ---------------------------------------------------------------------------
#  Weights
# ---------------------------------------------------------------------------

def load_weights(weights_dir=None, device='cpu', dtype=torch.float32):
    """model/weights.py's load(), moved onto a device.

    Goes through the real loader rather than re-parsing the text files, so the
    padding validation and the _partN concatenation order stay in one place.
    """
    from model import weights as MW
    W, B = MW.load(weights_dir)
    to = lambda a: torch.as_tensor(np.asarray(a), dtype=dtype, device=device)
    Wt = {k: to(v) for k, v in W.items()}
    Bt = {k: to(v) for k, v in B.items()}
    return Wt, Bt


# ---------------------------------------------------------------------------
#  The network
# ---------------------------------------------------------------------------

def _act(a, slope=SLOPE):
    """bias is already added; this is the leaky-ReLU, numpy's way. See detail 5."""
    return torch.maximum(a, slope * a)


def forward(x, W, B, slope=SLOPE):
    """The 14 dense layers over rows of x, streaming roll. Returns s2 (n, 128).

    x must be (n, IN_FEATURES) -- see detail 1.
    """
    if x.shape[1] != IN_FEATURES:
        raise ValueError(
            f'x has {x.shape[1]} columns; this takes exactly {IN_FEATURES}. '
            'rtda_ref widens the weight to the input width rather than '
            'narrowing the input, so a padded input changes the summation '
            'length and moves the last bits.')

    h = _act(x @ W['emb_d0'] + B['emb_d0'], slope)
    cur = _act(h @ W['emb_d1'] + B['emb_d1'], slope)

    for s in range(SOLVERS):
        head = torch.zeros((1, cur.shape[1]), dtype=cur.dtype, device=cur.device)
        prev = torch.cat([head, cur[:-1]], dim=0)          # detail 3
        pair = torch.cat([cur, prev], dim=1)               # detail 2
        z = _act(pair @ W[f's{s}_d0'] + B[f's{s}_d0'], slope)
        for n in (1, 2, 3):
            z = z @ W[f's{s}_d{n}'] + B[f's{s}_d{n}']
            if n < 3:
                z = _act(z, slope)                          # detail 4
        cur = _act(z, slope)
    return cur


def out27(mean128, W, B):
    """The deliverable. W['out'] is (128, 27) and y = mean @ W + B."""
    return mean128 @ W['out'] + B['out']


def event_means(x, W, B, warmup=WARMUP_TRACKS, chunk_events=0, slope=SLOPE):
    """(n_events, 128), the mean of the last solver's output over tracks warmup..49.

    chunk_events=0 runs the whole thing in one forward, which is the natural GPU
    shape and keeps the kernel-launch count at ~50 regardless of run size.
    Chunking is exact -- a chunk started WARMUP_TRACKS tracks early and trimmed
    reproduces the un-split run, because the receptive field is 4 deep -- but on
    a GPU it multiplies the launch count by the number of chunks, so it is off
    by default and exists only for memory-constrained runs.
    """
    n_ev = x.shape[0] // TRACKS_PER_EVENT
    if x.shape[0] % TRACKS_PER_EVENT:
        raise ValueError(f'{x.shape[0]} tracks is not a multiple of {TRACKS_PER_EVENT}')

    if not chunk_events or chunk_events >= n_ev:
        s2 = forward(x, W, B, slope)
        per = s2.reshape(n_ev, TRACKS_PER_EVENT, H)
        return per[:, warmup:, :].mean(dim=1)

    parts = []
    for lo in range(0, n_ev, chunk_events):
        hi = min(lo + chunk_events, n_ev)
        pre = WARMUP_TRACKS if lo > 0 else 0
        s2 = forward(x[lo * TRACKS_PER_EVENT - pre: hi * TRACKS_PER_EVENT], W, B, slope)
        if pre:
            s2 = s2[pre:]
        per = s2.reshape(hi - lo, TRACKS_PER_EVENT, H)
        parts.append(per[:, warmup:, :].mean(dim=1))
    return torch.cat(parts, dim=0)


# ---------------------------------------------------------------------------
#  The gate
# ---------------------------------------------------------------------------

def self_test(n_events=40, device='cpu', dtype='fp64', weights_dir=None,
              warmup=WARMUP_TRACKS, seed=1234):
    """torch vs model/rtda_ref.py on the same tracks. Returns 0 on pass.

    Run this at fp64 on CPU FIRST. At fp64 the two should agree to ~1e-15, and
    anything larger is a transcription error, not a precision one. Only once
    that passes does an fp32 or bf16 number mean anything.
    """
    from model import rtda_ref as R
    from model import weights as MW

    dt = TORCH_DTYPE[dtype]
    n_tracks = n_events * TRACKS_PER_EVENT
    x_np = R.synth_tracks(n_tracks, seed=seed)[:, :IN_FEATURES]   # (n, 6), detail 1

    W_np, B_np = MW.load(weights_dir)
    Wt, Bt = load_weights(weights_dir, device=device, dtype=dt)
    xt = torch.as_tensor(x_np, dtype=dt, device=device)

    print(f'  device={device}  dtype={dtype}  {n_events} events '
          f'({n_tracks} tracks)  warmup={warmup}')
    if device.startswith('cuda'):
        print(f'  tf32: matmul={torch.backends.cuda.matmul.allow_tf32} '
              f'cudnn={torch.backends.cudnn.allow_tf32}')

    # -- the reference, in float64 always. It is what "correct" means here.
    ref_per = R.forward(x_np, roll='streaming', W=W_np, B=B_np)['s2']
    ref_means = ref_per.reshape(n_events, TRACKS_PER_EVENT, H)[:, warmup:, :].mean(axis=1)
    ref_y = R.out27(ref_means, W_np, B_np)

    with torch.inference_mode():
        got_per = forward(xt, Wt, Bt)
        got_means = event_means(xt, Wt, Bt, warmup=warmup)
        got_y = out27(got_means, Wt, Bt)

    def cmp(label, got, ref, tol):
        g = got.detach().to(torch.float64).cpu().numpy()
        d = np.abs(g - ref)
        scale = max(float(np.abs(ref).max()), 1e-30)
        rel = d.max() / scale
        ok = rel <= tol
        print(f'  {label:34s} max|diff| {d.max():.3e}   rel {rel:.3e}   '
              f'{"ok" if ok else "FAIL"}  (tol {tol:.0e})')
        return ok

    # fp64 is a transcription gate; fp32/bf16 are precision measurements and
    # their tolerances are set by the format, not by how well this was written.
    tol = {'fp64': 1e-12, 'fp32': 1e-5, 'tf32': 1e-2, 'bf16': 1e-1}[dtype]
    ok = True
    ok &= cmp('per-track s2 vs rtda_ref', got_per, ref_per, tol)
    ok &= cmp(f'event means (warmup={warmup})', got_means, ref_means, tol)
    ok &= cmp('27 outputs', got_y, ref_y, tol)

    # Chunking must not change the answer. On CPU/fp64 this is exact; on a GPU
    # the reduction order can differ between chunk sizes, so it is a tolerance.
    with torch.inference_mode():
        chunked = event_means(xt, Wt, Bt, warmup=warmup, chunk_events=10)
    ok &= cmp('chunked(10) vs un-chunked', chunked, ref_means, tol)

    print(f'\n  {"PASS" if ok else "FAIL"}')
    return 0 if ok else 1


def main():
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--self-test', action='store_true')
    ap.add_argument('--device', default='cpu')
    ap.add_argument('--dtype', default='fp64', choices=sorted(TORCH_DTYPE))
    ap.add_argument('--events', type=int, default=40)
    ap.add_argument('--warmup', type=int, default=WARMUP_TRACKS)
    ap.add_argument('--weights', default=None)
    a = ap.parse_args()

    if not a.self_test:
        ap.print_help()
        return 0
    if a.device.startswith('cuda') and not torch.cuda.is_available():
        print('ERROR: --device cuda but torch.cuda.is_available() is False',
              file=sys.stderr)
        return 1
    print(f'torch {torch.__version__}')
    return self_test(a.events, a.device, a.dtype, a.weights, a.warmup)


if __name__ == '__main__':
    sys.exit(main())
