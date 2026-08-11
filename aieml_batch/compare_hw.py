#!/usr/bin/env python
"""Cross-check a hardware run's track_mean_128.txt against every reference.

    ./compare_hw.py results/hw_emu_track_mean_128.txt

Three references, and they do NOT use the same averaging convention. Comparing
against the wrong one looks like an error when it isn't:

  A. aieml/ hardware output, averaged over ALL 50 tracks
     data_fp32/aieml10_output_aie.txt -> mean(axis=0)
     This is what track_average_pl computes (TRACK_AVERAGE_THRESHOLD = 50) and
     what this design's AIE accumulator computes. *** The apples-to-apples one. ***

  B. mlp_hls.ipynb's `aie_27`, averaged over tracks WARMUP..49 (47 tracks)
         aie_27 = aie_s2[WARMUP:].mean(axis=0) @ out_W + out_B
     Skipping the warm-up gives a different mean, so expect a visible offset.

  C. numpy golden -- the full 14-layer chain recomputed from data_fp32 weights
     with leaky ReLU 0.1 and a circular roll.

Known, expected difference: tracks 0..2 are warm-up in both designs (the roll has
no predecessor for track 0, and the receptive field is 4 deep). They sit inside
the 50-track mean, so A differs from this design by ~5e-3 while tracks 3..49
agree to ~7e-6. That is convention, not error.
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import crosscheck as C  # noqa: E402  (golden model + weight loaders)

H, N_TRACKS, WARMUP = 128, 50, 3


def report(label, a, b, note=''):
    d = np.abs(a - b)
    denom = max(np.abs(b).max(), 1e-30)
    print(f'  {label:<44s} max|diff| = {d.max():.3e}   mean = {d.mean():.3e}'
          f'   rel = {100*d.max()/denom:5.2f}%')
    if note:
        print(f'  {"":44s} {note}')
    return d.max()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('mean_file', nargs='?', default='results/hw_emu_track_mean_128.txt',
                    help='the 128-wide event mean written by host_batch')
    ap.add_argument('--sim', choices=('aie', 'x86', 'none'), default='none',
                    help='also compare against a local simulation run')
    a = ap.parse_args()

    hw = np.loadtxt(HERE / a.mean_file if not Path(a.mean_file).is_absolute()
                    else a.mean_file).astype(np.float64)
    if hw.size != H:
        raise SystemExit(f'{a.mean_file}: expected {H} values, got {hw.size}')
    print(f'hardware event mean : {a.mean_file}')
    print(f'                      {hw.size} values, range [{hw.min():.5f}, {hw.max():.5f}]\n')

    ref = C.L('aieml10_output_aie.txt').reshape(-1, H)[:N_TRACKS]   # aieml/ hardware output
    _, soln = C.golden()
    gold = soln[2][:N_TRACKS]                                       # numpy golden s2_out

    Wo = np.loadtxt(C.D / 'output_weights.txt').astype(np.float64).reshape(H, 27)
    Bo = np.loadtxt(C.D / 'output_bias.txt').astype(np.float64)
    proj = lambda v: v @ Wo + Bo        # host/host.cpp:394 convention

    print('[A] 128-wide mean, SAME convention (all 50 tracks) -- the real check')
    report('vs aieml/ hardware output', hw, ref.mean(axis=0))
    report('vs numpy golden', hw, gold.mean(axis=0))

    print('\n[B] 128-wide mean, notebook convention (skip 3 warm-up tracks)')
    report('vs aieml/ output, tracks 3..49', hw, ref[WARMUP:].mean(axis=0),
           'expected to differ: this design averages all 50')

    print('\n[C] 27-dim output (after the host-side output dense)')
    report('vs aieml/, all 50', proj(hw), proj(ref.mean(axis=0)))
    report("vs mlp_hls.ipynb 'aie_27'", proj(hw), proj(ref[WARMUP:].mean(axis=0)),
           'aie_s2[WARMUP:].mean(0) @ out_W + out_B')

    if a.sim != 'none':
        try:
            import aie_io
            got = aie_io.read_outputs(aie_io.load_ports(), HERE, sim=a.sim)
            s2 = np.asarray(got['s2_out']).reshape(-1, H)[:N_TRACKS]
            print(f'\n[D] vs the local {a.sim} SIMULATION of this same graph')
            report('simulation s2_out mean (all 50)', hw, s2.mean(axis=0),
                   'should be ~1e-6: proves hardware == simulation')
        except Exception as e:
            print(f'\n[D] simulation comparison unavailable: {e}')

    print("""
How to read this:
  [A] is the meaningful comparison -- same averaging on both sides. A few 1e-3
      here is the warm-up convention (tracks 0..2 use a zero-pad roll rather than
      the circular one and are inside the mean), not a hardware fault.
  [B]/[C] will differ MORE, because the notebook drops the warm-up tracks before
      averaging. That gap is definitional.
  [D] is the one that should be ~1e-6. If hardware and simulation disagree, that
      is a real problem; everything else above is convention.

  Per-track agreement (tracks 3..49) is checked separately by
      make crosscheck        -> currently 7.369e-06 vs the aieml/ reference""")


if __name__ == '__main__':
    main()
