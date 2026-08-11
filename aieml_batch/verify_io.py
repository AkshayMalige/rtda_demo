#!/usr/bin/env python
"""One-off proof that aie_io.py reproduces aie4ml's PLIO marshalling exactly.

Run this whenever the vendored graph is regenerated. It writes the same feed
twice -- once through aie4ml's prepare_inputs/write_input_files, once through our
aie_io.write_inputs -- and diffs the resulting data/ifm_c*.txt byte for byte.
Then it round-trips the outputs of the last simulation through both readers.

This is the gate that lets the project drop its aie4ml dependency: if it passes,
aie_io is a faithful replacement. Requires aie4ml (envaie2); nothing else does.
"""
from __future__ import annotations

import filecmp
import shutil
import sys
from pathlib import Path

import numpy as np

import aie_io

HERE = Path(__file__).resolve().parent


def main():
    batch, solvers, iters = 8, 3, 7
    rng = np.random.default_rng(7)
    feed = {'x': rng.random((iters, batch, 16), dtype=np.float32)}
    for s in range(solvers):
        feed[f's{s}_in'] = rng.random((iters, batch, 256), dtype=np.float32)

    ours = HERE / '.io_check_ours'
    theirs = HERE / '.io_check_theirs'
    for d in (ours, theirs):
        shutil.rmtree(d, ignore_errors=True)
        (d / 'data').mkdir(parents=True)

    # --- ours -------------------------------------------------------------
    ports = aie_io.load_ports()
    aie_io.write_inputs(feed, ports, ours, iterations=iters)

    # --- aie4ml's ---------------------------------------------------------
    import gen_graph as G
    from aie4ml.simulation import build_io_layout, prepare_inputs, write_input_files
    G.ITERS = iters
    _, model = G._model(batch, solvers)
    model._ensure_runtime_plan()   # predict() does this before build_io_layout
    layout = build_io_layout(model)
    prepared = prepare_inputs(layout, feed, iterations=iters, quantize=True)
    write_input_files(theirs, layout, prepared, plio_width_bits=aie_io.PLIO_WIDTH_BITS)

    # --- diff -------------------------------------------------------------
    a = sorted(p.name for p in (ours / 'data').glob('ifm_c*.txt'))
    b = sorted(p.name for p in (theirs / 'data').glob('ifm_c*.txt'))
    ok = True
    if a != b:
        print(f'  FILE SET MISMATCH\n    ours   {a}\n    theirs {b}'); ok = False
    for name in a:
        same = filecmp.cmp(ours / 'data' / name, theirs / 'data' / name, shallow=False)
        if not same:
            ok = False
            print(f'  {name:16s} DIFFER')
        else:
            print(f'  {name:16s} identical')

    # --- output reader round-trip, if a simulation has run -----------------
    for sim in ('aie', 'x86'):
        if (HERE / f'{sim}simulator_output' / 'data').exists():
            from aie4ml.simulation import collect_outputs
            mine = aie_io.read_outputs(ports, HERE, sim=sim)
            theirs_out = collect_outputs(HERE, sim, layout)
            for t in sorted(mine):
                d = np.abs(np.asarray(mine[t]) - np.asarray(theirs_out[t])).max()
                flag = 'identical' if d == 0 else f'DIFFER max={d:.3e}'
                if d != 0:
                    ok = False
                print(f'  {sim}: {t:10s} {flag}')
            break
    else:
        print('  (no simulator output present -- skipped read round-trip)')

    shutil.rmtree(ours, ignore_errors=True)
    shutil.rmtree(theirs, ignore_errors=True)
    print('\nPASS -- aie_io matches aie4ml' if ok else '\nFAIL')
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main())
