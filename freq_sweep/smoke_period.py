#!/usr/bin/env python
"""The one thing a mock cannot prove: does Vitis HLS accept the period we inject?

    make -C freq_sweep smoke          # ~2 min, needs set_envs.sh sourced

Everything else in this directory is verified against reports that already
exist or against fake tools. This is the single claim that needs the real
toolchain: that `create_clock -period [env_or RTDA_HLS_PERIOD 6.667]` in
../pl_fixed/pl/rtda_split_project.tcl actually re-times the design rather than
being rejected, ignored, or silently clamped.

It is cheap to check because `create_clock` runs in the first seconds of
csynth, and the expensive part -- "Checking Synthesizability", about 100
minutes -- comes long after. So this starts a real csynth in a throwaway tree,
waits for the evidence, and kills it. Nothing here runs to completion and
nothing touches the repo's own build tree.

WHAT COUNTS AS PROOF
Not that the run survived: it is killed on purpose. The proof is the two lines
the TCL prints before any synthesis happens --

    *****  hls period     : 5.2632 ns (190.005 MHz)
    INFO: [HLS 200-10] Setting target device to 'xcve2802-...'

-- with no error between them, and the requested period appearing in HLS's own
solution settings rather than 6.667.
"""
from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import sweep_freq as S                                             # noqa: E402


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('--mhz', type=float, default=190.0)
    ap.add_argument('--root', default='/home/synthara/VersalPrjs/LDRD/freq_sweep_work/_smoke')
    ap.add_argument('--timeout', type=float, default=300.0)
    ap.add_argument('--yes', action='store_true',
                    help='required: this starts a REAL csynth (killed after ~2 min)')
    a = ap.parse_args()

    period = 1000.0 / a.mhz
    tcl = S.REPO / 'pl_fixed' / 'pl' / 'rtda_split_project.tcl'

    print(f'smoke: does vitis_hls accept RTDA_HLS_PERIOD={period:.4f} '
          f'({a.mhz:g} MHz)?\n')

    if 'RTDA_HLS_PERIOD' not in tcl.read_text(errors='replace'):
        print(f'FAIL: {tcl} does not read RTDA_HLS_PERIOD')
        return 2
    if shutil.which('vitis_hls') is None:
        print('FAIL: vitis_hls not on PATH -- source set_envs.sh first')
        return 2

    if not a.yes:
        print('stopping: this starts a real csynth (killed after ~2 min).')
        print('  go ahead: make smoke YES=1')
        return 0

    root = Path(a.root)
    if root.exists():
        shutil.rmtree(root)
    tree = S.provision(root, a.mhz, dry=False)
    print(f'  isolated tree : {tree}')

    env = dict(os.environ)
    env['RTDA_HLS_PERIOD'] = f'{period:.4f}'
    log = tree / 'smoke.log'
    print(f'  starting      : make kernels   (will be killed once it has told us)\n')

    with log.open('wb') as fh:
        proc = subprocess.Popen(['make', 'kernels'], cwd=str(tree), env=env,
                                stdout=fh, stderr=subprocess.STDOUT)
        t0, seen, part = time.time(), {}, ''
        try:
            while time.time() - t0 < a.timeout:
                if proc.poll() is not None:
                    break
                time.sleep(2)
                part = log.read_text(errors='replace')
                if m := re.search(r'\*{5}\s+hls period\s*:\s*([\d.]+)\s*ns', part):
                    seen['tcl_period'] = float(m.group(1))
                if re.search(r'Setting target device', part):
                    seen['device'] = True
                # HLS echoes the clock it is actually scheduling for.
                if m := re.search(r'[Tt]arget clock period[^\d]*([\d.]+)', part):
                    seen['hls_target'] = float(m.group(1))
                if re.search(r'ERROR|invalid command name|can.t read', part):
                    seen['error'] = True
                    break
                if 'tcl_period' in seen and ('device' in seen or 'hls_target' in seen):
                    break
        finally:
            proc.terminate()
            try:
                proc.wait(timeout=20)
            except subprocess.TimeoutExpired:
                proc.kill()

    print(f'  ran for       : {time.time() - t0:.0f} s, then killed on purpose\n')
    ok = True

    got = seen.get('tcl_period')
    if got is None:
        print('  FAIL  the TCL never printed its period -- it may not have been read')
        ok = False
    elif abs(got - period) > 1e-3:
        print(f'  FAIL  TCL used {got} ns, we asked for {period:.4f} ns')
        ok = False
    else:
        print(f'  ok    TCL took the period: {got} ns')

    if (ht := seen.get('hls_target')) is not None:
        if abs(ht - period) < 0.05:
            print(f'  ok    HLS is scheduling for {ht} ns')
        else:
            print(f'  FAIL  HLS is scheduling for {ht} ns, not {period:.4f}')
            ok = False

    if seen.get('error'):
        tail = '\n      '.join(
            l for l in log.read_text(errors='replace').splitlines()[-15:] if l.strip())
        print(f'  FAIL  an error appeared before synthesis started:\n      {tail}')
        ok = False
    elif got is not None:
        print('  ok    no error before synthesis started')

    print(f'\n  log: {log}')
    if ok:
        print('\nPASS -- the injected period reaches Vitis HLS. `make sweep` is safe '
              'to launch.')
    else:
        print('\nFAIL -- do NOT launch the sweep; every point would synthesise at '
              'the wrong clock.')
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main())
