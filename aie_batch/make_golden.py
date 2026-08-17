#!/usr/bin/env python
"""Generate an N-track input and the exact golden the hardware should produce.

    ./make_golden.py --tracks 10000 --out ../testdata

Writes  embed_input_<N>.txt   the stimulus
        golden_<N>.npz        per-event 128-wide means + the 27-dim projection

Only 50 real tracks exist in the repo (model/weights_fp32/embed_input.txt), so anything
larger is synthesised: 6 Gaussian features matched to the real per-column mean
and std, columns 6..7 left at zero as in the physics data. That is fine for an
end-to-end numerical check -- the question is whether the AIE computes the same
function as the reference model, not whether the input is physically meaningful.

WHAT MAKES THIS "EXACT"
The model is simulated over the *slot* sequence the hardware actually sees, not
over tracks, because three hardware behaviours leak across boundaries. All three
live in `model/rtda_ref.hw_golden`, which this script is now a thin wrapper over;
see its docstring. Modelling per-event in isolation gets the roll carry wrong and
quietly disagrees in the third decimal.
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
sys.path.insert(0, str(HERE.parent))
from model import rtda_ref as R   # noqa: E402
from model import weights as MW   # noqa: E402

H = R.H
TRACKS_PER_EVENT = R.TRACKS_PER_EVENT
SLOTS_PER_EVENT = R.SLOTS_PER_EVENT
REAL_FEATURES = R.IN_FEATURES
IN_DIM = R.IN_DIM

# The three functions this file used to define itself. Re-exported under their
# old names because sim_events.py and the notebooks import them from here.
synth_tracks = R.synth_tracks
slot_layout = R.slot_layout
golden = R.hw_golden


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--tracks', type=int, default=10000)
    ap.add_argument('--out', default='../testdata')
    ap.add_argument('--seed', type=int, default=1234)
    ap.add_argument('--no-flush', action='store_true',
                    help='model a guaranteed cold start instead (see golden())')
    ap.add_argument('--stimulus-only', action='store_true',
                    help='write the stimulus and skip the golden. golden() runs one '
                         'un-chunked forward over every slot, so at 500,000 tracks it '
                         'needs several GB for intermediates the performance scan never '
                         'looks at. The seeded stream is a prefix chain, so a larger '
                         'stimulus-only file still starts with -- and is verified '
                         'against -- the smaller files that DO have goldens.')
    a = ap.parse_args()

    outdir = (HERE / a.out).resolve()
    outdir.mkdir(parents=True, exist_ok=True)

    tracks = synth_tracks(a.tracks, a.seed)
    n_ev = (a.tracks + TRACKS_PER_EVENT - 1) // TRACKS_PER_EVENT
    print(f'  {a.tracks} tracks -> {n_ev} events, {n_ev*SLOTS_PER_EVENT} slots')
    if a.tracks % TRACKS_PER_EVENT:
        print(f'  WARNING: not a multiple of {TRACKS_PER_EVENT}. track_accum counts SLOTS, so'
              f'\n           the last event averages padding activations in with its'
              f'\n           {a.tracks % TRACKS_PER_EVENT} real tracks and the hardware will NOT match this golden.'
              f'\n           Use a multiple of {TRACKS_PER_EVENT}.')

    # Written in blocks rather than one '\n'.join over the whole array: at 500,000
    # tracks that join materialises 4 million format strings at once. The bytes are
    # identical either way -- `make stimulus` re-checks that against the committed
    # 50,000-track file.
    stim = outdir / f'embed_input_{a.tracks}.txt'
    flat = tracks.ravel()
    with stim.open('w') as f:
        for i in range(0, flat.size, 1 << 16):
            f.write(''.join(f'{v:.9e}\n' for v in flat[i:i + (1 << 16)]))
    print(f'  stimulus : {stim.name}  ({stim.stat().st_size/1024:.0f} KB)')

    if a.stimulus_only:
        print('  golden   : skipped (--stimulus-only)')
        return

    means, s2 = golden(tracks, flush=not a.no_flush)
    y27 = R.out27(means)

    npz = outdir / f'golden_{a.tracks}.npz'
    np.savez_compressed(npz, means=means, y27=y27, n_events=n_ev, tracks=a.tracks)
    print(f'  golden   : {npz.name}  ({n_ev} event means, 128-wide + 27-dim)')

    # Text form for the board: host_batch.cpp's RTDA_GOLDEN= reads "n_events n_cols"
    # then one row of n_cols floats per event. The board has no numpy, so it cannot
    # read the npz -- and copying result files off the SD card to diff them here is
    # exactly the loop this avoids.
    txt = outdir / f'golden_{a.tracks}.txt'
    with txt.open('w') as f:
        f.write(f'{n_ev} {H}\n')
        for row in means:
            f.write(' '.join(f'{v:.9e}' for v in row) + '\n')
    print(f'  golden   : {txt.name}  ({txt.stat().st_size/1024:.0f} KB, for RTDA_GOLDEN=)')
    print(f'  event 0 mean range [{means[0].min():.5f}, {means[0].max():.5f}]')
    if n_ev > 1:
        print(f'  event 1 mean range [{means[1].min():.5f}, {means[1].max():.5f}]')


if __name__ == '__main__':
    main()
