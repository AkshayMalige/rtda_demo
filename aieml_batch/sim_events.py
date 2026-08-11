#!/usr/bin/env python
"""Simulate N events end to end and verify every event mean against the golden.

    ./sim_events.py --sim x86 --events 3

`make crosscheck` runs exactly ONE event, because the graph is compiled with
N_ITER fixed at 7 and its 50-track reference is a single event. That leaves the
whole class of event-BOUNDARY behaviour untested in simulation:

  * roll_concat_batch's carry chains from one event's last padding slot into the
    next event's track 0. Nothing resets it between events.
  * track_accum must count exactly 50 real tracks, emit, and reset -- for every
    event, not just the first.
  * The 6 padding slots per event are not neutral (every dense layer has a bias),
    so an off-by-one in the counting shows up as a small, plausible-looking error
    rather than as garbage.

Those are the paths that produced the reproducibility bug found on hardware. This
runs them in a simulator, where they are cheap to iterate on.

Requires a build made with -DN_ITER_OVERRIDE (see app.cpp):

    make x86_events EVENTS=3        # build + run, x86simulator
    make sim_events EVENTS=2        # build + run, aiesimulator (cycle-accurate, slow)

The stimulus and the golden both come from make_golden.py, so the comparison is
against the same model the hardware is checked against -- simulated over the slot
sequence, not over tracks.
"""
from __future__ import annotations

import argparse
import sys
import time
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import aie_io          # noqa: E402
import make_golden     # noqa: E402
import run_sim         # noqa: E402

H = 128
BATCH = 8
ITER_PER_EVENT = 7


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--sim', choices=('x86', 'aie'), default='x86')
    ap.add_argument('--events', type=int, default=2, help='real events to simulate')
    ap.add_argument('--tracks', type=int, default=None,
                    help='real tracks (default events x 50; a short final event is fine)')
    ap.add_argument('--workdir', default=None,
                    help='the build to run (default Work_x86_ev<N> / Work_ev<N>)')
    ap.add_argument('--no-flush', action='store_true',
                    help='drop the leading flush event. Exact in simulation (a simulator '
                         'is always cold) and 7 iterations cheaper, but then this no '
                         'longer mirrors what the host does on a board.')
    ap.add_argument('--tol', type=float, default=1e-4)
    ap.add_argument('--seed', type=int, default=1234)
    ap.add_argument('--out', default=None,
                    help='directory to write the results to: the stimulus, the per-event '
                         'means, and an .npz carrying both plus the golden. For checking '
                         'elsewhere (a notebook) rather than here.')
    a = ap.parse_args()

    flush = not a.no_flush
    n_ev = a.events
    n_tracks = a.tracks if a.tracks is not None else n_ev * make_golden.TRACKS_PER_EVENT
    n_iter = (n_ev + (1 if flush else 0)) * ITER_PER_EVENT
    workdir = a.workdir or (f'./Work_x86_ev{n_ev}' if a.sim == 'x86' else f'./Work_ev{n_ev}')

    target = 'x86_events' if a.sim == 'x86' else 'sim_events'
    if not (HERE / workdir).exists():
        raise SystemExit(
            f'{workdir} does not exist. Build it first:\n'
            f'    make {target} EVENTS={n_ev}')

    # The graph is compiled with N_ITER fixed. Feeding fewer iterations happens to
    # work under x86simulator (it stops when the input runs out) but STALLS
    # aiesimulator, and feeding more silently drops events -- so refuse both
    # rather than let a mismatched build look like it worked.
    built = run_sim.n_iter()
    if built != n_iter:
        raise SystemExit(
            f'this build runs N_ITER={built} but {n_ev} event(s) '
            f'{"with" if flush else "without"} a flush need {n_iter}.\n'
            f'    make {target} EVENTS={n_ev}{"" if flush else " FLUSH=0"}')

    print(f'{n_ev} event(s), {n_tracks} real tracks, {n_iter} iterations '
          f'({"with" if flush else "no"} flush event)')
    print(f'  simulator : {a.sim}   build: {workdir}\n')

    # track_accum counts slots, not real tracks (see kernels/track_accum/track_accum.h).
    # A short final event averages padding activations in with its real tracks and
    # comes out wrong -- measured 8.0e-02 for a 20-track event. Expect that FAIL.
    if n_tracks % make_golden.TRACKS_PER_EVENT:
        print(f'  WARNING: {n_tracks} is not a multiple of {make_golden.TRACKS_PER_EVENT}. '
              f'The last event has only {n_tracks % make_golden.TRACKS_PER_EVENT} real '
              f'tracks;\n           its mean is WRONG by design and will fail below. '
              f'Every other event is valid.\n')

    # --- stimulus + golden, both over the SLOT sequence ----------------------
    tracks = make_golden.synth_tracks(n_tracks, a.seed)
    X, n_real_ev, off = make_golden.slot_layout(tracks, flush)
    means, _ = make_golden.golden(tracks, flush=flush)

    if X.shape[0] != n_iter * BATCH:
        raise SystemExit(f'internal: {X.shape[0]} slots but {n_iter} iterations x {BATCH}')

    feed = {'x': X.reshape(n_iter, BATCH, make_golden.IN_DIM).astype(np.float32)}

    # --- run -----------------------------------------------------------------
    t0 = time.time()
    got = run_sim.run(feed, sim=a.sim, workdir=workdir, iterations=n_iter)
    print(f'  simulated in {time.time() - t0:.1f} s\n')

    if 'track_out' not in got:
        raise SystemExit('graph produced no track_out -- is this the right build?')
    frames = np.asarray(got['track_out']).reshape(-1, H)
    nz = [i for i, f in enumerate(frames) if np.abs(f).max() > 0]
    print(f'  event means in frame(s): {nz}  of {len(frames)}')
    print(f'  expected {n_real_ev + (1 if flush else 0)} '
          f'(at {ITER_PER_EVENT - 1}, {2*ITER_PER_EVENT - 1}, ...)')

    if flush:
        if not nz:
            raise SystemExit('FAIL: no non-zero frames at all')
        nz = nz[1:]
        print('  (flush event discarded)')
    if len(nz) != n_real_ev:
        print(f'  FAIL: {len(nz)} event means for {n_real_ev} events -- '
              f'the accumulator is not resetting as expected')
        raise SystemExit(1)

    # --- dump ----------------------------------------------------------------
    measured = np.stack([frames[i] for i in nz])          # (n_real_ev, 128)
    if a.out:
        outdir = Path(a.out) if Path(a.out).is_absolute() else HERE / a.out
        outdir.mkdir(parents=True, exist_ok=True)
        tag = f'{a.sim}_{n_real_ev}ev_{n_tracks}tr'
        for e in range(n_real_ev):
            np.savetxt(outdir / f'sim_mean_128_{tag}_ev{e}.txt', measured[e], fmt='%.9e')
        np.savetxt(outdir / f'sim_input_{tag}.txt', tracks.reshape(-1), fmt='%.9e')

        # PER-TRACK stage outputs as well as the event mean. The array only ever
        # sends track_out to the host, but in simulation the per-stage debug taps
        # are wired to PLIO, so we get every track's 128-wide activation for free.
        # That is the only way to analyse the warm-up tracks (0..2) separately --
        # from the event mean alone they are already averaged in and cannot be
        # separated. Laid out (slot, 128) over the whole run, flush event included,
        # so slot = event*56 + track once the flush offset is removed.
        stages = {}
        for name in ('emb_out', 's0_out', 's1_out', 's2_out'):
            if name in got:
                stages[name] = np.asarray(got[name]).reshape(-1, H).astype(np.float32)

        np.savez_compressed(outdir / f'sim_{tag}.npz',
                            measured=measured, golden=means, tracks=tracks,
                            frames=np.asarray(nz), n_events=n_real_ev,
                            n_tracks=n_tracks, flush=flush, sim=a.sim,
                            slots_per_event=make_golden.SLOTS_PER_EVENT,
                            tracks_per_event=make_golden.TRACKS_PER_EVENT,
                            flush_slots=(make_golden.SLOTS_PER_EVENT if flush else 0),
                            **stages)
        extra = f' + per-track {sorted(stages)}' if stages else ''
        print(f'  wrote {n_real_ev} event mean(s) + stimulus{extra} -> {outdir}/')
        print(f'        sim_{tag}.npz\n')

    # --- compare -------------------------------------------------------------
    print(f'  per-event agreement vs the numpy golden (tol {a.tol:.0e}):')
    worst, worst_ev, bad = 0.0, -1, 0
    for e, fi in enumerate(nz):
        err = np.abs(frames[fi] - means[e]).max()
        if err > worst:
            worst, worst_ev = err, e
        if err > a.tol:
            bad += 1
        if n_real_ev <= 12 or err > a.tol:
            print(f'    event {e:3d} (frame {fi:3d}) : max|diff| = {err:.3e}'
                  f'{"   OVER TOLERANCE" if err > a.tol else ""}')

    print(f'\n  events compared : {n_real_ev}')
    print(f'  worst event     : {worst_ev}  max|diff| = {worst:.3e}')
    print(f'  over tolerance  : {bad}')
    print('\n  PASS' if bad == 0 else f'\n  FAIL - {bad} event(s) disagree')
    raise SystemExit(0 if bad == 0 else 1)


if __name__ == '__main__':
    main()
