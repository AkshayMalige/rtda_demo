#!/usr/bin/env python
"""The weights, loaded once, in one canonical form.

`model/weights_fp32/` is the single source of truth for every implementation in
this repo. It was exported from `model/mlp_fp32.onnx` and matches it to 7.5e-09;
`analysis/rtda_reference.ipynb` re-checks that on every run.

Two things about the on-disk format regularly cost people an afternoon:

1. **`embed_dense_0_weights.txt` is (8, 128), not (6, 128).** The network takes
   6 features. The AIE pads the input vector to 8 for alignment, so rows 6 and 7
   of that matrix are exactly zero. `W['emb_d0']` here is the real (6, 128).

2. **`solver_*_dense_0_weights` is (256, 128)** because the AIE feeds it a
   roll-concat of [current track, previous track]. Rows 0..127 multiply the
   current track, rows 128..255 the previous one. The PL flow keeps them as two
   separate 128->128 denses plus an add, which is the same arithmetic; both
   forms are exposed here (`s0_d0`, and `s0_d0_curr` / `s0_d0_prev`), so neither
   flow has to know about the other's packing.

`_partN.txt` files are cascade slices and are simply concatenated in order.

Usage:
    from model import weights
    W, B = weights.load()
    W['emb_d0']        # (6, 128)
    W['s0_d0']         # (256, 128)   AIE form
    W['s0_d0_prev']    # (128, 128)   PL form
    B['out']           # (27,)
"""
from __future__ import annotations

import os
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
# NOT the DATA_DIR env var: set_envs.sh points that somewhere else entirely, and
# a silently wrong weight directory is the most expensive mistake available here.
DEFAULT_DIR = Path(os.environ.get('RTDA_WEIGHTS') or HERE / 'weights_fp32')

H = 128            # hidden width
IN_FEATURES = 6    # real input features
IN_PADDED = 8      # what the weight file and the stimulus carry
OUT_DIM = 27
SOLVERS = 3


# float64 throughout. The text files carry 10 significant digits, so float32
# would discard precision that is actually present, and the reference model has
# to be the most accurate thing in the repo -- otherwise a `quant=` experiment
# measures the reference's own error as well as the format's.
#
# The scripts this replaced were inconsistent about it: make_golden.py read the
# embed weights with a bare np.loadtxt (float64) and every other layer through
# crosscheck.L (float32). That is why regenerating a golden with this loader
# moves it by ~1e-09 -- three orders below the tightest tolerance anywhere in
# the project, and five below the board's 1e-4 self-check.
def _load(d: Path, name: str) -> np.ndarray:
    return np.loadtxt(d / name)


def _parts(d: Path, stem: str, n: int, rows: int, cols: int) -> np.ndarray:
    return np.concatenate(
        [_load(d, f'{stem}_part{i}.txt') for i in range(n)]
    ).reshape(rows, cols)


def load(d: Path | str | None = None) -> tuple[dict, dict]:
    """Return (W, B) keyed by canonical layer name."""
    d = Path(d) if d is not None else DEFAULT_DIR
    if not d.is_dir():
        raise FileNotFoundError(f'weight directory not found: {d}')

    W, B = {}, {}

    emb0 = _load(d, 'embed_dense_0_weights.txt').reshape(IN_PADDED, H)
    pad = np.abs(emb0[IN_FEATURES:]).max()
    if pad != 0.0:
        raise ValueError(
            f'embed_dense_0_weights.txt rows {IN_FEATURES}..{IN_PADDED-1} should be '
            f'zero padding but the largest is {pad:g}. The file is not the layout '
            f'this loader assumes.')
    W['emb_d0'] = emb0[:IN_FEATURES]                     # (6, 128)
    W['emb_d0_padded'] = emb0                            # (8, 128) as the AIE stores it
    B['emb_d0'] = _load(d, 'embed_dense_0_bias.txt')

    W['emb_d1'] = _parts(d, 'embed_dense_1_weights', 2, H, H)
    B['emb_d1'] = _load(d, 'embed_dense_1_bias.txt')

    for s in range(SOLVERS):
        w0 = _parts(d, f'solver_{s}_dense_0_weights', 4, 2 * H, H)
        W[f's{s}_d0'] = w0                               # (256, 128)  AIE
        W[f's{s}_d0_curr'] = w0[:H]                      # (128, 128)  PL
        W[f's{s}_d0_prev'] = w0[H:]                      # (128, 128)  PL
        B[f's{s}_d0'] = _load(d, f'solver_{s}_dense_0_bias.txt')
        for n in (1, 2, 3):
            W[f's{s}_d{n}'] = _parts(d, f'solver_{s}_dense_{n}_weights', 2, H, H)
            B[f's{s}_d{n}'] = _load(d, f'solver_{s}_dense_{n}_bias.txt')

    W['out'] = _load(d, 'output_weights.txt').reshape(H, OUT_DIM)
    B['out'] = _load(d, 'output_bias.txt')

    return W, B


def stimulus(d: Path | str | None = None) -> np.ndarray:
    """The 50 real physics tracks, (50, 8). Columns 6..7 are zero.

    float64, like everything else here. Round-tripping it through float32 shifts
    it by 4e-08, and because the synthesised tracks in rtda_ref.synth_tracks are
    seeded from this array's own mean and std, that drift lands in every one of
    the 50,000 rather than staying in the first 50.
    """
    d = Path(d) if d is not None else DEFAULT_DIR
    return np.loadtxt(d / 'embed_input.txt').reshape(-1, IN_PADDED)


if __name__ == '__main__':
    W, B = load()
    print(f'weights from {DEFAULT_DIR}')
    for k in sorted(W):
        print(f'  W[{k:14s}] {str(W[k].shape):12s} '
              f'[{W[k].min():+.4f}, {W[k].max():+.4f}]')
    for k in sorted(B):
        print(f'  B[{k:14s}] {str(B[k].shape):12s} '
              f'[{B[k].min():+.4f}, {B[k].max():+.4f}]')
    x = stimulus()
    print(f'  stimulus       {x.shape} [{x.min():+.4f}, {x.max():+.4f}]')
