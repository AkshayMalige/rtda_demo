#!/usr/bin/env python
"""Interval / throughput of the last aiesimulator run. numpy only, no aie4ml.

aiesimulator timestamps every PLIO output line in `aiesimulator_output/data/
y_p<N>.txt` with `T <ns> <ps>` markers. The interval between successive frames
on a port is the graph's II; divided by BATCH it is the per-track cost.
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


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--batch', type=int, default=8)
    ap.add_argument('--iters', type=int, default=7)
    ap.add_argument('--event', type=int, default=50, help='real tracks per event')
    a = ap.parse_args()

    data_dir = HERE / 'aiesimulator_output' / 'data'
    if not data_dir.exists():
        raise SystemExit('No aiesimulator_output/ -- run `make sim` first.')

    ports = aie_io.load_ports()
    per_port, all_iv = {}, []
    for tensor, plist in ports['outputs'].items():
        for p in plist:
            f = data_dir / f'y_p{p.port}.txt'
            if not f.exists():
                continue
            iv = frame_intervals_ns(f)
            if iv.size == 0:
                continue
            per_port[f'{tensor}:y_p{p.port}'] = iv
            all_iv.append(iv)

    if not all_iv:
        raise SystemExit('No TLAST intervals found. Was the run cycle-accurate '
                         '(aiesimulator), not x86?')

    iv = np.concatenate(all_iv)
    print(f'  II            = {iv.mean():.1f} ns  '
          f'(min {iv.min():.1f}, max {iv.max():.1f}, n={iv.size})')
    # Two different questions, and they differ by 56/50 = 12%.
    #   per slot  : II / BATCH -- what you get if the workload is a multiple of 8
    #   per track : ITERS * II / 50 -- what you actually get on a 50-track event,
    #               because the 7th iteration carries only 2 real tracks + 6 padding
    iters = a.iters
    print(f'  ns per slot   = {iv.mean() / a.batch:.1f}   (II / batch {a.batch})')
    print(f'  ns per TRACK  = {iters * iv.mean() / a.event:.1f}   '
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
    gops = a.event * macs * 2 / (a.iters * iv.mean() * 1e-9) / 1e9
    print(f'  GOPs          = {gops:.1f}   ({macs:,} MACs/track over {len(layers)} '
          f'dense layers, {a.event} real tracks per event)')

    print('\n  per port:')
    for k, v in sorted(per_port.items()):
        print(f'    {k:22s} {v.mean():8.1f} ns   n={v.size}')


if __name__ == '__main__':
    main()
