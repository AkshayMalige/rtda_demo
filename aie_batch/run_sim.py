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
import contextlib
import fcntl
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
    src = os.environ.get('RTDA_SRC', 'src_fp32')
    for line in (HERE / src / 'parameters.h').read_text().splitlines():
        if line.startswith('#define N_ITER'):
            return int(line.split()[-1])
    raise RuntimeError(f'N_ITER not found in {src}/parameters.h')


def simulate(sim: str = 'aie', extra=(), workdir: str | None = None):
    """Run the compiled graph. Assumes `make graph` / `make x86com` already ran.

    workdir defaults to the single-event build; a multi-event build lives in its
    own directory (Work_x86_ev<N>) so the two never overwrite each other.
    """
    if workdir is None:
        pr = os.environ.get('RTDA_PRECISION', 'fp32')
        workdir = f'./Work_{pr}' if sim == 'aie' else f'./Work_x86_{pr}'
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

    # Stream rather than capture. aiesimulator on this graph runs for minutes and
    # prints nothing until it is done; buffering it makes a perfectly healthy run
    # look like a hang, which is exactly how it was first reported. Echo every
    # line as it arrives AND keep it, so the failure path can still scan for the
    # success marker. RTDA_QUIET=1 restores the silent behaviour.
    quiet = os.environ.get('RTDA_QUIET')
    print(f'  $ {" ".join(cmd)}', flush=True)
    lines = []
    proc = subprocess.Popen(cmd, cwd=HERE, text=True,
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                            bufsize=1)
    for line in proc.stdout:
        lines.append(line)
        if not quiet:
            print('  | ' + line.rstrip(), flush=True)
    rc = proc.wait()

    out = ''.join(lines)

    # x86simulator prints "Simulation completed successfully returning zero" and
    # exits 0 EVEN WHEN IT DEADLOCKS -- it diagnoses the deadlock a few lines
    # earlier and then reports success anyway. Trusting the marker alone let a
    # bf16 run with mismatched RTP types look like a pass while every output file
    # was empty. Treat a diagnosed deadlock or an ERROR line as failure.
    fatal = [ln for ln in out.splitlines()
             if 'Detected deadlock' in ln or ln.startswith('ERROR:')]
    if fatal:
        raise RuntimeError(
            f'{exe} reported success but emitted {len(fatal)} error/deadlock line(s):\n'
            + '\n'.join(fatal[:8])
            + ('\n  ...' if len(fatal) > 8 else ''))

    if rc != 0 or marker not in out:
        why = f'rc={rc}' if rc else f'{marker!r} not found in output'
        interesting = [ln for ln in out.splitlines()
                       if any(k in ln for k in ('ERROR', 'Error', 'error', 'FAIL', 'Fatal'))]
        tail = '\n'.join((interesting or out.strip().splitlines())[-15:])
        raise RuntimeError(f'{exe} failed ({why}):\n{tail}')
    return out


@contextlib.contextmanager
def _exclusive():
    """Serialise simulator runs in this directory.

    app.cpp hard-codes its PLIO paths as `data/ifm_c<n>.txt`, relative to the
    simulator's cwd, so EVERY run in this directory shares one input directory --
    and the output goes to <sim>simulator_output/, also shared. Two concurrent
    runs (two terminals, or a background job) overwrite each other's inputs
    mid-flight and produce plausible-looking wrong numbers, or a confusing
    mid-simulation failure. Fail fast and say why instead.
    """
    lock = HERE / '.sim.lock'
    with lock.open('w') as fh:
        try:
            fcntl.flock(fh, fcntl.LOCK_EX | fcntl.LOCK_NB)
        except BlockingIOError:
            raise RuntimeError(
                'another simulation is already running in this directory.\n'
                f'  {HERE} shares data/ and <sim>simulator_output/ across all runs, so they\n'
                '  cannot overlap. Wait for it to finish, or check for a stray process:\n'
                '      ps -ef | grep -E "x86simulator|aie2simmsm|sim_events"') from None
        try:
            yield
        finally:
            fcntl.flock(fh, fcntl.LOCK_UN)


def run(feed: dict, sim: str = 'aie', workdir: str | None = None,
        iterations: int | None = None) -> dict:
    """Write inputs, simulate, read outputs. The whole contract in one call."""
    ports = aie_io.load_ports()
    with _exclusive():
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
