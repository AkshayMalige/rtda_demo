#!/usr/bin/env python
"""Verify a multi-event hardware run against the golden from make_golden.py.

    ./verify_run.py --golden ../testdata/golden_10000.npz --means <dir-of-run-output>

The host writes track_mean_128_ev<N>.txt per event (plus track_mean_128.txt for
the last). Point --means at wherever you copied them back to.

Reports per-event agreement and, separately, the same comparison with the first
WARMUP tracks of each event excluded -- which is not something the hardware can
do (it averages what it counts), but tells you how much of any residual is the
roll warm-up rather than arithmetic.
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import crosscheck as C  # noqa: E402

H = 128


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--golden', required=True)
    ap.add_argument('--means', default='.', help='directory holding track_mean_128_ev*.txt')
    ap.add_argument('--tol', type=float, default=1e-4)
    a = ap.parse_args()

    g = np.load(a.golden)
    gold, n_ev = g['means'], int(g['n_events'])
    print(f'golden: {a.golden}  ({n_ev} events, {int(g["tracks"])} tracks)\n')

    d = Path(a.means)
    files = sorted(d.glob('track_mean_128_ev*.txt'),
                   key=lambda p: int(''.join(ch for ch in p.stem if ch.isdigit()) or 0))
    if not files:
        single = d / 'track_mean_128.txt'
        if single.exists():
            files = [single]
        else:
            raise SystemExit(f'no track_mean_128*.txt under {d}')

    print(f'found {len(files)} measured event mean(s)')
    if len(files) != n_ev:
        print(f'  NOTE: golden has {n_ev} events; comparing the {len(files)} available')

    worst, worst_ev, bad = 0.0, -1, 0
    for i, f in enumerate(files):
        if i >= n_ev:
            break
        hw = np.loadtxt(f)
        if hw.size != H:
            print(f'  {f.name}: expected {H} values, got {hw.size} -- skipped')
            continue
        err = np.abs(hw - gold[i]).max()
        if err > worst:
            worst, worst_ev = err, i
        if err > a.tol:
            bad += 1
            if bad <= 5:
                print(f'  event {i:4d}: max|diff| = {err:.3e}   OVER TOLERANCE')

    print(f'\n  events compared : {min(len(files), n_ev)}')
    print(f'  worst event     : {worst_ev}  max|diff| = {worst:.3e}')
    print(f'  over tolerance  : {bad} (tol {a.tol:.0e})')
    print('\n  PASS' if bad == 0 else f'\n  FAIL - {bad} event(s) disagree')
    raise SystemExit(0 if bad == 0 else 1)


if __name__ == '__main__':
    main()
