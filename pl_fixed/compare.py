#!/usr/bin/env python
"""Score a PL run against the reference, in the same metric the AIE uses.

    ./compare.py --dir ../results/pl_fixed/sim --events 20 --warmup 3
    ./compare.py --dir ... --vs-model     # also: does sweep.py predict this?

Reads track_means_all.txt (the 128-wide event means, the format every
implementation in this repo writes) and compares against model/rtda_ref.py.

THE WARM-UP CONVENTION, which decides which reference this uses
The ONNX rolls circularly inside an event; the hardware streams. They disagree
on exactly tracks 0, 1, 2 -- by ~1e-1, which is 100x the arithmetic error. So:

    warmup=3   average tracks 3..49. The roll difference is excluded and the
               number measures ARITHMETIC. Compare against the circular
               reference over the same tracks.
    warmup=0   average all 50. This is what the AIE hardware physically
               produces, because its accumulator cannot skip the head. The
               number is then dominated by the roll convention, not precision.

Mixing them silently is the single easiest way to get a wrong answer here, so
this script refuses to guess: --warmup must match what produced the run, and it
reads it back out of run_info.txt to check.
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


def read_run_info(p: Path) -> dict:
    if not p.exists():
        return {}
    out = {}
    for line in p.read_text().splitlines():
        if '=' in line:
            k, v = line.split('=', 1)
            out[k.strip()] = v.strip()
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--dir', required=True)
    ap.add_argument('--events', type=int, default=0)
    ap.add_argument('--warmup', type=int, default=R.WARMUP)
    ap.add_argument('--vs-model', action='store_true',
                    help='also report how well sweep.py predicts this run')
    a = ap.parse_args()

    d = Path(a.dir)
    means_f = d / 'track_means_all.txt'
    if not means_f.exists():
        raise SystemExit(f'no {means_f} -- run `make fastsim` first')

    info = read_run_info(d / 'run_info.txt')
    got = np.loadtxt(means_f, skiprows=1)
    if got.ndim == 1:
        got = got[None, :]
    n_ev = got.shape[0]

    # The run's own record of its warm-up wins over the flag; disagreeing
    # would compare against the wrong reference and look like a precision bug.
    if 'warmup' in info and int(info['warmup']) != a.warmup:
        print(f'  note: run_info says warmup={info["warmup"]}, using that '
              f'(--warmup {a.warmup} ignored)')
        a.warmup = int(info['warmup'])

    W, B = MW.load()
    tracks = R.synth_tracks(n_ev * R.TRACKS_PER_EVENT)
    ref_m, _ = R.event_means(tracks, roll='circular', warmup=a.warmup, W=W, B=B)
    ref27 = R.out27(ref_m, W, B)
    y = R.out27(got, W, B)
    fs = np.abs(ref27).max()

    e_mean = np.abs(got - ref_m).max()
    e27 = np.abs(y - ref27).max()
    per_ev = np.abs(y - ref27).max(axis=1)

    fmt = (f"ap_fixed<{info.get('ap_w','?')},{info.get('ap_i','?')}> "
           f"alpha={info.get('leaky_alpha','?')}") if info else 'unknown format'
    print(f'\n  {n_ev} events, tracks {a.warmup}..49 averaged, {fmt}')
    print(f'  vs model/rtda_ref.py (circular roll, full precision)\n')
    print(f'    128-wide event means   max|diff| = {e_mean:.3e}')
    print(f'    27 outputs             max|diff| = {e27:.3e}   '
          f'({100*e27/fs:.3f}% of full scale {fs:.4f})')
    print(f'    per event              median {np.median(per_ev):.3e}   '
          f'worst {per_ev.max():.3e} (event {int(per_ev.argmax())})')

    # What the AIE achieves in this exact metric, on this exact stimulus.
    bm, _ = R.event_means(tracks, roll='circular', warmup=a.warmup,
                          quant=R.BF16, W=W, B=B)
    e_bf16 = np.abs(R.out27(bm, W, B, quant=R.BF16) - ref27).max()
    print(f'\n    AIE bf16, same metric            {e_bf16:.3e}')
    print(f'    this run / bf16                  {e27/e_bf16:.2f}x'
          f'  ({"better" if e27 < e_bf16 else "worse"})')

    if a.vs_model:
        w = int(info.get('ap_w', 16))
        i = int(info.get('ap_i', 3))
        alpha = float(info.get('leaky_alpha', 0.1))
        q = R.fixed(w, i, alpha=None if abs(alpha - 0.0996094) < 1e-6 else alpha)
        pm, _ = R.event_means(tracks, roll='circular', warmup=a.warmup,
                              quant=q, W=W, B=B)
        e_model = np.abs(R.out27(pm, W, B, quant=q) - ref27).max()
        print(f'\n    sweep.py model for this format   {e_model:.3e}')
        print(f'    native (ground truth)            {e27:.3e}')
        print(f'    the model is {e27/e_model:.2f}x optimistic -- it is a ranking '
              f'tool, not the answer')


if __name__ == '__main__':
    main()
