#!/usr/bin/env python
"""Generate an N-track input and the exact golden the hardware should produce.

    ./make_golden.py --tracks 10000 --out ../testdata

Writes  embed_input_<N>.txt   the stimulus
        golden_<N>.npz        per-event 128-wide means + the 27-dim projection

Only 50 real tracks exist in the repo (data_fp32/embed_input.txt), so anything
larger is synthesised: 6 Gaussian features matched to the real per-column mean
and std, columns 6..7 left at zero as in the physics data. That is fine for an
end-to-end numerical check -- the question is whether the AIE computes the same
function as the reference model, not whether the input is physically meaningful.

WHAT MAKES THIS "EXACT"
The model is simulated over the *slot* sequence the hardware actually sees, not
over tracks, because three hardware behaviours leak across boundaries:

  1. Each event occupies 56 slots (7 iterations x 8): 50 real tracks then 6
     PADDING slots of zeros. Padding is not neutral -- every dense layer has a
     bias, so a zero input still produces a sizeable activation.
  2. roll_concat_batch's carry is a single static that is NEVER reset. It chains
     through padding slots and across event boundaries, so event k's track 0
     pairs with event k-1's last padding slot.
  3. track_accum counts real tracks and stops at 50, then resets. It therefore
     ignores the padding slots -- by counting, not because they are zero.

Modelling per-event in isolation would get (2) wrong and quietly disagree in the
third decimal. This reproduces all three.
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
TRACKS_PER_EVENT = 50
SLOTS_PER_EVENT = 56          # 7 iterations x BATCH 8
REAL_FEATURES = 6
IN_DIM = 16                   # padded width the graph takes


def synth_tracks(n, seed=1234):
    """n x 8 stimulus matching the real data's per-column mean/std."""
    real = np.loadtxt(C.D / 'embed_input.txt').astype(np.float64).reshape(-1, 8)
    rng = np.random.default_rng(seed)
    out = np.zeros((n, 8))
    # reuse the real 50 verbatim up front, so the first event stays comparable
    k = min(n, real.shape[0])
    out[:k] = real[:k]
    if n > k:
        mu, sd = real[:, :REAL_FEATURES].mean(0), real[:, :REAL_FEATURES].std(0)
        out[k:, :REAL_FEATURES] = rng.normal(mu, sd, size=(n - k, REAL_FEATURES))
    return out


def slot_layout(tracks, flush=True):
    """Lay tracks into the slot matrix the hardware actually sees.

    Returns (X, n_real_ev, off) where X is (n_slots, IN_DIM). Events are padded
    INDIVIDUALLY -- 50 real tracks then 6 zero slots -- never concatenated and
    padded once at the end, because the accumulator stops at 50 and would
    otherwise let one event's tail swallow the next event's head.

    This is the single definition of the layout: host_batch.cpp reproduces it in
    C++, and sim_events.py feeds it to the simulator, so both are compared
    against a golden computed over exactly the same slots.
    """
    n_real_ev = (len(tracks) + TRACKS_PER_EVENT - 1) // TRACKS_PER_EVENT
    n_ev = n_real_ev + (1 if flush else 0)
    off = SLOTS_PER_EVENT if flush else 0     # real events start after the flush

    X = np.zeros((n_ev * SLOTS_PER_EVENT, IN_DIM))
    for t, row in enumerate(tracks):
        ev, idx = divmod(t, TRACKS_PER_EVENT)
        X[off + ev * SLOTS_PER_EVENT + idx, :8] = row
    return X, n_real_ev, off


def golden(tracks, flush=True):
    """Run the model over the slot sequence, returning per-event 128-wide means.

    flush=True prepends one all-zero event whose result is discarded. Without it
    the answer depends on whether the AIE was cold-started: roll_concat_batch's
    carry is a static initialised at ELF LOAD, so a second graph.run() on an
    already-loaded xclbin starts with the previous run's leftover state and
    event 0 comes out different (measured: 2.5e-3). After a few zero slots the
    roll state is bias-determined regardless of history, so a dummy event makes
    every real event reproducible cold or warm.

    A simulator is always cold (fresh process / fresh ELF), so flush=False is
    exact there; the host defaults to flush=True because a board is not.
    """
    X, n_real_ev, off = slot_layout(tracks, flush)

    W_e0 = np.zeros((IN_DIM, H))
    W_e0[:8] = np.loadtxt(C.D / 'embed_dense_0_weights.txt').reshape(8, H)
    h = C.lrelu(X @ W_e0 + C.L('embed_dense_0_bias.txt'))
    cur = C.lrelu(h @ C.P('embed_dense_1_weights', 2, H, H) + C.L('embed_dense_1_bias.txt'))

    # --- three solvers, each preceded by the 1-row-delay roll -----------------
    # roll[i] = [cur[i], cur[i-1]] with cur[-1] = 0 (the kernel's zero carry on
    # the very first block). Note this runs over ALL slots, so the carry crosses
    # padding and event boundaries exactly as the static in the kernel does.
    for s in range(3):
        prev = np.vstack([np.zeros((1, H)), cur[:-1]])
        z = C.lrelu(np.hstack([cur, prev]) @ C.P(f'solver_{s}_dense_0_weights', 4, 2 * H, H)
                    + C.L(f'solver_{s}_dense_0_bias.txt'))
        for n in (1, 2, 3):
            z = z @ C.P(f'solver_{s}_dense_{n}_weights', 2, H, H) + C.L(f'solver_{s}_dense_{n}_bias.txt')
            if n < 3:
                z = C.lrelu(z)
        cur = C.lrelu(z)

    # --- accumulate per event, counting real tracks (never trusting zeros) ----
    means = np.zeros((n_real_ev, H))
    for ev in range(n_real_ev):
        base = off + ev * SLOTS_PER_EVENT
        n_real = min(TRACKS_PER_EVENT, len(tracks) - ev * TRACKS_PER_EVENT)
        means[ev] = cur[base:base + n_real].sum(axis=0) / TRACKS_PER_EVENT
    return means, cur


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--tracks', type=int, default=10000)
    ap.add_argument('--out', default='../testdata')
    ap.add_argument('--seed', type=int, default=1234)
    ap.add_argument('--no-flush', action='store_true',
                    help='model a guaranteed cold start instead (see golden())')
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

    stim = outdir / f'embed_input_{a.tracks}.txt'
    stim.write_text('\n'.join(f'{v:.9e}' for v in tracks.ravel()) + '\n')
    print(f'  stimulus : {stim.name}  ({stim.stat().st_size/1024:.0f} KB)')

    means, s2 = golden(tracks, flush=not a.no_flush)
    Wo = np.loadtxt(C.D / 'output_weights.txt').reshape(H, 27)
    Bo = np.loadtxt(C.D / 'output_bias.txt')
    y27 = means @ Wo + Bo

    npz = outdir / f'golden_{a.tracks}.npz'
    np.savez_compressed(npz, means=means, y27=y27, n_events=n_ev, tracks=a.tracks)
    print(f'  golden   : {npz.name}  ({n_ev} event means, 128-wide + 27-dim)')
    print(f'  event 0 mean range [{means[0].min():.5f}, {means[0].max():.5f}]')
    if n_ev > 1:
        print(f'  event 1 mean range [{means[1].min():.5f}, {means[1].max():.5f}]')


if __name__ == '__main__':
    main()
