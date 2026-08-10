#!/usr/bin/env python
"""Drive the vendored AIE graph's simulators. No aie4ml import.

The graph, its kernels, its weights and its testbench (`app.cpp`) are committed
sources in this directory. All this does is marshal the PLIO text files around
the simulator, using `aie_io` and the vendored `aie_pipeline.json`.

    run_sim.py write   --feed <npz>   write data/ifm_c*.txt from an .npz
    run_sim.py read    --sim aie|x86  print output tensor shapes / checksums
    run_sim.py ports                  show the PLIO layout

Normal use is via the Makefile (`make sim`, `make crosscheck`), which calls
into this module rather than the CLI.
"""
from __future__ import annotations

import argparse
import os
import shlex
import subprocess
from pathlib import Path

import numpy as np

import aie_io

HERE = Path(__file__).resolve().parent


def n_iter() -> int:
    """N_ITER the graph was compiled with, read from the generated parameters.h.

    The input files must carry exactly this many iterations or the graph stalls
    waiting for data that never arrives.

    RTDA_N_ITER overrides it, for builds made with -DN_ITER_OVERRIDE (the
    multi-event simulation, `make x86_events`). app.cpp holds the override; the
    generated parameters.h is left alone so `make regen` stays reproducible.
    """
    env = os.environ.get('RTDA_N_ITER')
    if env:
        return int(env)
    for line in (HERE / 'src' / 'parameters.h').read_text().splitlines():
        if line.startswith('#define N_ITER'):
            return int(line.split()[-1])
    raise RuntimeError('N_ITER not found in src/parameters.h')


def simulate(sim: str = 'aie', extra=(), workdir: str | None = None):
    """Run the compiled graph. Assumes `make graph` / `make x86com` already ran.

    workdir defaults to the single-event build; a multi-event build lives in its
    own directory (Work_x86_ev<N>) so the two never overwrite each other.
    """
    if workdir is None:
        workdir = './Work' if sim == 'aie' else './Work_x86'
    exe = 'aiesimulator' if sim == 'aie' else 'x86simulator'
    # The two simulators announce success differently, and both trail the message
    # with unrelated chatter ("IP-INFO: deleting packet ip"), so match on the
    # marker rather than the tail.
    marker = 'Sim result: 0' if sim == 'aie' else 'Simulation completed successfully'

    # Extra aiesimulator flags, e.g. --dump-vcd=foo --profile (aieml/Makefile:116
    # passes exactly those). Off by default: VCD dumping is slow and the file grows
    # with the iteration count, which matters on a multi-event run.
    #
    # Do NOT add --output-time-stamp=no here, whatever aieml/ does: report.py reads
    # the `T <ns>` markers out of the PLIO output files to get the II, and that flag
    # suppresses them.
    cmd = [exe, f'--pkg-dir={workdir}', *extra]
    if sim == 'aie':
        cmd += shlex.split(os.environ.get('RTDA_AIESIM_ARGS', ''))
    r = subprocess.run(cmd, cwd=HERE, text=True, capture_output=True)
    out = r.stdout + r.stderr
    if r.returncode != 0 or marker not in out:
        why = f'rc={r.returncode}' if r.returncode else f'{marker!r} not found in output'
        interesting = [ln for ln in out.splitlines()
                       if any(k in ln for k in ('ERROR', 'Error', 'error', 'FAIL', 'Fatal'))]
        tail = '\n'.join((interesting or out.strip().splitlines())[-15:])
        raise RuntimeError(f'{exe} failed ({why}):\n{tail}')
    return out


def run(feed: dict, sim: str = 'aie', workdir: str | None = None,
        iterations: int | None = None) -> dict:
    """Write inputs, simulate, read outputs. The whole contract in one call."""
    ports = aie_io.load_ports()
    aie_io.write_inputs(feed, ports, HERE, iterations=iterations or n_iter())
    simulate(sim, workdir=workdir)
    return aie_io.read_outputs(ports, HERE, sim=sim)


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest='cmd', required=True)
    w = sub.add_parser('write'); w.add_argument('--feed', required=True)
    r = sub.add_parser('read');  r.add_argument('--sim', choices=('aie', 'x86'), default='aie')
    sub.add_parser('ports')
    a = ap.parse_args()

    ports = aie_io.load_ports()
    if a.cmd == 'ports':
        for d in ('inputs', 'outputs'):
            print(f'{d}:')
            for t, pl in ports[d].items():
                print(f'  {t:10s} boundary={pl[0].np_boundary} ports={[p.port for p in pl]}')
        print(f'N_ITER = {n_iter()}')
    elif a.cmd == 'write':
        feed = dict(np.load(a.feed))
        aie_io.write_inputs(feed, ports, HERE, iterations=n_iter())
        print(f'wrote data/ifm_c*.txt for {len(ports["inputs"])} tensors, {n_iter()} iterations')
    else:
        for t, arr in aie_io.read_outputs(ports, HERE, sim=a.sim).items():
            print(f'  {t:10s} {arr.shape}  sum={arr.sum():.6f}')


if __name__ == '__main__':
    main()
