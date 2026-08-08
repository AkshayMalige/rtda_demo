#!/usr/bin/env python
"""Interval / throughput of the last aiesimulator run. numpy only, no aie4ml.

aiesimulator timestamps every PLIO output line in `aiesimulator_output/data/
y_p<N>.txt` with `T <ns> <ps>` markers. The interval between successive frames
on a port is the graph's II; divided by BATCH it is the per-track cost.
"""
from __future__ import annotations

import argparse
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
    print(f'  ns per track  = {iv.mean() / a.batch:.1f}   (batch = {a.batch})')

    # MACs/track for the shipping topology, so GOPs cross-checks the II.
    in_dim = ports['inputs']['x'][0].np_boundary[-1]
    solvers = sum(1 for t in ports['inputs'] if t.endswith('_in'))
    macs = in_dim * 128 + 128 * 128 + solvers * (2 * 128 * 128 + 3 * 128 * 128)
    gops = a.batch * macs * 2 / (iv.mean() * 1e-9) / 1e9
    print(f'  GOPs          = {gops:.1f}   ({macs:,} MACs/track x {a.batch} tracks / II)')

    print('\n  per port:')
    for k, v in sorted(per_port.items()):
        print(f'    {k:22s} {v.mean():8.1f} ns   n={v.size}')


if __name__ == '__main__':
    main()
