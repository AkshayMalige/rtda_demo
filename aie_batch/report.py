#!/usr/bin/env python
"""Interval / throughput of the last aiesimulator run. numpy only, no aie4ml.

aiesimulator timestamps every PLIO output line in `aiesimulator_output/data/
y_p<N>.txt` with `T <ns> <ps>` markers. The interval between successive frames
at the EVENT TAIL (track_out), in steady state, is the graph's II; divided by
BATCH it is the per-slot cost. The other ports are printed for diagnosis only.
"""
from __future__ import annotations

import argparse
import os
import re
from pathlib import Path

import numpy as np

import aie_io

HERE = Path(__file__).resolve().parent
_TS = re.compile(r'^T\s+(\d+)\s*(ps|ns|us|ms|s)', re.IGNORECASE)
_TO_NS = {'ps': 1e-3, 'ns': 1.0, 'us': 1e3, 'ms': 1e6, 's': 1e9}


def frame_intervals_ns(path: Path):
    """TLAST-to-TLAST intervals in ns -- one per emitted frame."""
    out, last, now = [], None, None
    for line in path.read_text().splitlines():
        line = line.strip()
        m = _TS.match(line)
        if m:
            now = int(m.group(1)) * _TO_NS[m.group(2).lower()]
            continue
        if 'TLAST' in line.upper():
            if last is not None and now is not None and now >= last:
                out.append(now - last)
            last = now
    return np.array(out, dtype=np.float64)


def frame_times_ns(path: Path):
    """TLAST time of every emitted frame, in ns."""
    out, now = [], None
    for line in path.read_text(errors='replace').splitlines():
        line = line.strip()
        m = _TS.match(line)
        if m:
            now = int(m.group(1)) * _TO_NS[m.group(2).lower()]
            continue
        if 'TLAST' in line.upper() and now is not None:
            out.append(now)
    return np.array(out, dtype=np.float64)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--batch', type=int, default=8)
    ap.add_argument('--iters', type=int, default=7)
    ap.add_argument('--event', type=int, default=50, help='real tracks per event')
    ap.add_argument('--dir', default=None,
                    help='simulator output directory; default is the one this '
                         'configuration would have written (run_sim.output_dir)')
    a = ap.parse_args()

    # run_sim owns the naming rule; ask it rather than spelling the directory
    # out again here. --dir overrides for a directory produced by hand.
    import run_sim
    simout = Path(a.dir) if a.dir else run_sim.output_dir('aie')
    data_dir = simout / 'data'
    if not data_dir.exists():
        raise SystemExit(
            f'No {simout.name}/ -- run the aie simulation for this configuration:\n'
            f'    make exactsim PRECISION={os.environ.get("RTDA_PRECISION", "fp32")}')

    # WHAT AM I ACTUALLY MEASURING?
    #
    # The output directory IS suffixed per configuration now, so this reads the
    # run belonging to the PRECISION/EVENTS asked for rather than whatever ran
    # last. Before that, every precision wrote into one aiesimulator_output/ and
    # `make report PRECISION=fp32` on a bf16 directory reported the bf16 II as
    # fp32 without complaint.
    #
    # The stamp check below stays. It is no longer the only defence, but a
    # directory can still be produced by hand, by an older revision, or with
    # RTDA_SIMOUT pointed somewhere deliberate -- refuse rather than mislabel.
    stamp = {}
    sf = simout / 'run_stamp.txt'
    if sf.exists():
        for line in sf.read_text().splitlines():
            if '=' in line:
                k, v = line.split('=', 1)
                stamp[k.strip()] = v.strip()

    want = os.environ.get('RTDA_PRECISION')
    if stamp:
        print(f"  measuring      : the {stamp.get('sim','?')} run of "
              f"{stamp.get('precision','?')}, {stamp.get('iterations','?')} iterations, "
              f"{stamp.get('when','?')}")
        if want and stamp.get('precision') and stamp['precision'] != want:
            raise SystemExit(
                f"\n  REFUSING: you asked for PRECISION={want} but "
                f"{simout.name}/ was produced by a {stamp['precision']} run.\n"
                f"  Re-run the simulation for {want}, or pass --dir to point at\n"
                f"  the directory you meant:\n"
                f"      make crosscheck PRECISION={want}      # 1 event, the II the docs quote\n"
                f"      make exactsim   PRECISION={want}      # or a multi-event run\n")
    else:
        print(f'  measuring      : UNKNOWN run -- no {simout.name}/run_stamp.txt.')
        print('                   Produced before stamping existed; re-run the '
              'simulation to be sure what this is.')

    ports = aie_io.load_ports()
    per_port, tail = {}, None
    for tensor, plist in ports['outputs'].items():
        for p in plist:
            f = data_dir / f'y_p{p.port}.txt'
            if not f.exists():
                continue
            t = frame_times_ns(f)
            if t.size < 2:
                continue
            per_port[f'{tensor}:y_p{p.port}'] = t
            if tensor == 'track_out':
                tail = t

    if not per_port:
        raise SystemExit('No TLAST frames found. Was the run cycle-accurate '
                         '(aiesimulator), not x86?')
    if tail is None:
        raise SystemExit('No track_out frames -- the event tail is the port that '
                         'defines the II.')

    # WHICH INTERVAL IS THE II?
    #
    # The one at the TAIL, in steady state. Until 2026-09-14 this averaged the
    # intervals of all nine output ports together. The eight stage taps drain
    # to their own PLIOs, so a stage upstream of a slower one keeps its own pace
    # while a queue builds behind it, and the average reports a rate the graph
    # does not deliver. bf16 read 1033 ns (7 iterations) and 1147 ns (42) that
    # way; its tail runs at 1650 ns, set by track_accum, and 7 x 1650 ns is
    # within 3.2% of silicon's us_kernel per event.
    #
    # Steady state: skip the first event's frames when enough are left to
    # average. A 7-iteration crosscheck run does not have them, and says so.
    #
    # And average over WHOLE events. The tail's PLIO framing is one 4-value line
    # out of step with the kernel's 128-value block, so frames near an event
    # boundary land ~1 us early or late. A window ending on one of them biases
    # (last - first) / n: fp32 read 4157 ns. A window that starts and ends on
    # the same event phase reads 4169-4172 ns on two runs whose VCD and upstream
    # ports all say 4172.0 -- closer than a least-squares slope (4168-4171), and
    # as close as the tail's PLIO timestamps allow.
    def window(t):
        s = a.iters if t.size > 2 * a.iters else 0
        e = s + ((t.size - 1 - s) // a.iters) * a.iters
        return (s, e) if e > s else (0, t.size - 1)

    def interval(t):
        s, e = window(t)
        return float((t[e] - t[s]) / (e - s))

    skip, end = window(tail)
    ii = interval(tail)
    note = '' if skip else ('   TOO FEW FRAMES for a steady-state II -- '
                            'make exactsim EVENTS=10, then report EVENTS=10')
    print(f'  II            = {ii:.1f} ns  at track_out, frames {skip}..{end}{note}')
    # Two different questions, and they differ by 56/50 = 12%.
    #   per slot  : II / BATCH -- what you get if the workload is a multiple of 8
    #   per track : ITERS * II / 50 -- what you actually get on a 50-track event,
    #               because the 7th iteration carries only 2 real tracks + 6 padding
    iters = a.iters
    print(f'  ns per slot   = {ii / a.batch:.1f}   (II / batch {a.batch})')
    print(f'  ns per TRACK  = {iters * ii / a.event:.1f}   '
          f'({iters} iterations x II / {a.event} real tracks)  <- the honest number')

    # MACs/track summed from the generated layer configs, so GOPs is an
    # independent cross-check on the II. Derived from parameters.h rather than
    # from the port names -- once the roll kernels moved in-graph there are no
    # s{k}_in ports left to count.
    params = (HERE / os.environ.get('RTDA_SRC', 'src_fp32') / 'parameters.h').read_text()
    # The negative lookbehind matters: parameters.h also has padded_IN_FEAT,
    # which a bare IN_FEAT pattern matches, double-counting every layer.
    ins = [int(m) for m in re.findall(r'(?<![A-Za-z_])IN_FEAT\s*=\s*(\d+)', params)]
    outs = [int(m) for m in re.findall(r'(?<![A-Za-z_])OUT_FEAT\s*=\s*(\d+)', params)]
    layers = [(i, o) for i, o in zip(ins, outs)]
    macs = sum(i * o for i, o in layers)
    gops = a.event * macs * 2 / (a.iters * ii * 1e-9) / 1e9
    print(f'  GOPs          = {gops:.1f}   ({macs:,} MACs/track over {len(layers)} '
          f'dense layers, {a.event} real tracks per event)')

    # A port faster than the tail sits upstream of a queue; its interval is not
    # the graph's. The first-frame times give the pipeline depth stage by stage.
    print('\n  per port   (diagnostic; a port faster than track_out is upstream of a queue)')
    for k, t in sorted(per_port.items(), key=lambda kv: kv[1][0]):
        print(f'    {k:22s} first frame {t[0] / 1e3:9.2f} us   '
              f'interval {interval(t):8.1f} ns   n={t.size}')


if __name__ == '__main__':
    main()
