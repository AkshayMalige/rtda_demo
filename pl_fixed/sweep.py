#!/usr/bin/env python
"""Pick the ap_fixed format before spending an hour in synthesis.

Runs model/rtda_ref.py over a grid of (word width, integer bits, rounding mode,
leaky slope) and reports the error on the 27 deliverable outputs against the
ONNX reference.

HOW MUCH TO TRUST THIS
It is a SCREENING tool, not the answer. The numpy model quantizes at the same
places the HLS design does, but hls4ml's resource-strategy dense splits its
accumulation in ways the model does not reproduce, and measured against the
native bit-accurate runner it comes out about 2x optimistic in absolute terms:

    ap_fixed<16,3> rnd_sat alpha=0.1     model 1.2e-04     native 2.6e-04

The RANKING is what this is for, and that holds -- the spread between formats
here is 100x, far larger than the 2x modelling gap. Use it to choose (W, I),
then get the real number from `make fastsim`, which runs the actual kernel
sources. `make validate` checks the two against each other.

    make sweep                  # the default grid, ~1 min
    make sweep EVENTS=20        # more events, tighter statistics

Writes results/pl_fixed/sweep.npz for analysis/rtda_compare.ipynb.

The two reference lines it prints are what the AIE achieves in the same metric,
so the question "does ap_fixed match bfloat16" has a number rather than an
opinion.
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
REPO = HERE.parent
sys.path.insert(0, str(REPO))
from model import rtda_ref as R      # noqa: E402
from model import weights as MW      # noqa: E402


def err27(tracks, q, W, B, ref27, warmup):
    """(max |27 outputs - reference|, fraction of activations clipped)."""
    q.n_sat = q.n_val = 0
    m, _ = R.event_means(tracks, roll='circular', warmup=warmup, quant=q, W=W, B=B)
    y = R.out27(m, W, B, quant=q)
    sat = q.n_sat / q.n_val if q.n_val else 0.0
    return np.abs(y - ref27).max(), sat


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--events', type=int, default=20)
    ap.add_argument('--warmup', type=int, default=R.WARMUP)
    ap.add_argument('--out', default=str(REPO / 'results' / 'pl_fixed' / 'sweep.npz'))
    a = ap.parse_args()

    W, B = MW.load()
    tracks = R.synth_tracks(a.events * R.TRACKS_PER_EVENT)

    # The reference: full precision, circular roll, same warm-up convention.
    ref_m, _ = R.event_means(tracks, roll='circular', warmup=a.warmup, W=W, B=B)
    ref27 = R.out27(ref_m, W, B)
    fs = np.abs(ref27).max()

    print(f'{a.events} events, tracks {a.warmup}..49 averaged, '
          f'full scale = {fs:.4f}')

    # The number that sets the integer-bit count. Activations, not accumulator
    # partial sums -- those live in the wide accum type and can go well past
    # this (the largest pre-activation value is -2.29, but leaky ReLU scales
    # negatives by 0.1, so it never reaches a stored activation).
    o = R.forward(tracks, roll='circular', W=W, B=B)
    amax = max(np.abs(o[k]).max() for k in ('emb', 's0', 's1', 's2'))
    print(f'largest activation seen = {amax:.4f}  ->  I=2 spans +-2 '
          f'({2/amax:.2f}x headroom), I=3 spans +-4 ({4/amax:.2f}x)\n')

    # What the AIE achieves, for scale.
    e_bf16, _ = err27(tracks, R.BF16, W, B, ref27, a.warmup)
    print(f'  reference points')
    print(f'    AIE bf16                          {e_bf16:.3e}   '
          f'({100*e_bf16/fs:.3f}% FS)')
    print(f'    AIE fp32 (measured on silicon)    7.500e-07   (0.001% FS)\n')

    rows, records = [], []
    grid = [(w, i, mode, alpha, wi)
            for w in (12, 14, 16, 18)
            for i in (2, 3, 4, 6)
            for mode in ('rnd_sat', 'trn_wrp')
            for alpha, wi in ((None, 1), (0.125, 1))]

    print(f'  {"W":>3} {"I":>2}  {"mode":8s} {"alpha":>6}   '
          f'{"err27":>10}  {"% FS":>7}   vs bf16   clipped')
    print('  ' + '-' * 70)
    for w, i, mode, alpha, wi in grid:
        q = R.fixed(w, i, mode=mode, alpha=alpha, wi=wi)
        e, sat = err27(tracks, q, W, B, ref27, a.warmup)
        ratio = e / e_bf16
        mark = ' <-- default' if (w, i, mode, alpha) == (16, 3, 'rnd_sat', None) else ''
        clip = f'{100*sat:7.4f}%' + ('!' if sat > 0 else ' ')
        print(f'  {w:3d} {i:2d}  {mode:8s} {str(alpha or 0.1):>6}   '
              f'{e:10.3e}  {100*e/fs:6.3f}%   {ratio:6.2f}x  {clip}{mark}')
        rows.append((w, i, 0 if mode == 'rnd_sat' else 1,
                     0.125 if alpha else 0.1, e, sat))
        records.append(dict(W=w, I=i, mode=mode, alpha=alpha or 0.1, err=e, sat=sat))

    arr = np.array(rows)
    out = Path(a.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    np.savez_compressed(out, grid=arr, err_bf16=e_bf16, err_fp32=7.5e-7,
                        full_scale=fs, events=a.events, warmup=a.warmup,
                        columns='W,I,mode(0=rnd_sat),alpha,err27,clipped_fraction')
    print(f'\n  -> {out}')

    # Lowest error among formats that clip NOTHING. A format that clips can
    # win on this stimulus and fail on the next one.
    safe = [r for r in records if r['sat'] == 0.0]
    best = min(safe, key=lambda r: r['err'])
    raw = min(records, key=lambda r: r['err'])
    print(f"\n  best with no clipping: <{best['W']},{best['I']}> {best['mode']} "
          f"alpha={best['alpha']}  ->  {best['err']:.3e}")
    if raw['err'] < best['err']:
        print(f"  (lower error at <{raw['W']},{raw['I']}>, {raw['err']:.3e}, but it "
              f"clips {100*raw['sat']:.4f}% of activations -- not a safe default)")
    dflt = next(r for r in records
                if (r['W'], r['I'], r['mode'], r['alpha']) == (16, 3, 'rnd_sat', 0.1))
    print(f"  rtda_fixed.h default <16,3> rnd_sat alpha=0.1  ->  {dflt['err']:.3e}"
          f"  ({dflt['err']/e_bf16:.2f}x bf16)")

    # ---------------------------------------------------------------------
    #  ABLATION: what was each change actually worth?
    #
    #  Worth printing because the answer is counter-intuitive and was got
    #  wrong once: NO SINGLE CHANGE HELPS. Three of the four make it worse on
    #  their own. With alpha=0.125 the design computes a different function
    #  from the reference, and making a wrong answer more precise just
    #  resolves the wrong answer better. alpha and rounding have to move
    #  together; only then do the integer-bit choices pay.
    # ---------------------------------------------------------------------
    orig = dict(W=16, I=6, aw=32, ai=18, mode='trn_wrp', alpha=0.125, wi=6)

    def err(**kw):
        cfg = dict(orig); cfg.update(kw)
        return err27(tracks, R.fixed(**cfg), W, B, ref27, a.warmup)[0]

    print('\n  ablation, from the original ap_fixed<16,6> trn_wrp alpha=0.125:')
    steps = [
        ('original', {}),
        ('alpha 0.1 alone', dict(alpha=None)),
        ('round+saturate alone', dict(mode='rnd_sat')),
        ('activation I=3 alone', dict(I=3)),
        ('weight I=1 alone', dict(wi=1)),
        ('alpha + rounding', dict(alpha=None, mode='rnd_sat')),
        ('  + activation I=3', dict(alpha=None, mode='rnd_sat', I=3)),
        ('  + weight I=1  (shipped)', dict(alpha=None, mode='rnd_sat', I=3, wi=1)),
    ]
    base = err()
    for name, kw in steps:
        e = err(**kw)
        arrow = '' if not kw else ('  better' if e < base else '  WORSE')
        print(f'    {name:28s} {e:.3e}{arrow}')

    # The accumulator is not a lever: it has ~160x headroom on this network,
    # so AP_SAT there is dead logic, and its fractional bits do not show up in
    # the result. Printed so nobody spends effort on it again.
    print('\n  accumulator width (activations fixed at <16,3> rnd_sat, alpha 0.1):')
    for aw, ai in ((32, 18), (32, 10), (40, 10)):
        e = err(alpha=None, mode='rnd_sat', I=3, wi=1, aw=aw, ai=ai)
        print(f'    accum <{aw},{ai}>  {aw-ai:2d} frac bits      {e:.3e}')
    o = R.forward(tracks, roll='circular', W=W, B=B)
    print(f'    -> largest activation {amax:.3f}; the accumulator sees at most a few'
          f'\n       times that, against a +-{2**(10-1)} range. AP_SAT there never fires.')


if __name__ == '__main__':
    main()
