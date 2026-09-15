#!/usr/bin/env python
"""Shared body of the fake vitis_hls / v++ shims.

WHY THE MOCK REWRITES REAL REPORTS INSTEAD OF INVENTING FILES
A mock that emits reports of its own design tests the mock, not the parser. It
would agree with whatever `reports.py` happens to expect and go on agreeing
after both drifted away from what Vivado writes.

So the fixtures here are the shipped build's own reports -- found through
`reports.find_reports()`, so whichever build pl_fixed/ holds -- with the numbers
substituted. The timing summary keeps all three of its tables, its real clock
tree, its endpoint counts and its column alignment; only the frequency, the
period and the slack change. If the parser can read the mock it can read the
real thing, because they are the same file.

EVERY SUBSTITUTION IS ANCHORED ON TABLE SHAPE, AND FAILS LOUDLY
The first version replaced exact strings copied out of the 150 MHz report. On
the 180 MHz report they matched nothing, and a substitution that matches nothing
does not raise -- the mock would have handed the parser the unmodified shipped
report at every frequency. Rows are now found by structure and by the kernel
clock's own name, and a table that cannot be found stops the mock.

THE TOY MODEL, which is a stand-in for physics and nothing more:
  slack falls from the shipped build's value as the period tightens, and LUT
  rises as HLS adds pipeline registers to keep up. Past MOCK_FMAX_MHZ slack goes
  negative; past MOCK_CLIFF_MHZ the LUT crosses the congestion cliff and routing
  fails the way the 2026-08-14 build did. Both thresholds are env-settable so the
  driver's search can be tested against several shapes of reality, including the
  awkward one where the design stops FITTING before it stops CLOSING.
"""
from __future__ import annotations

import os
import re
import shutil
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))
import reports as R                                                # noqa: E402

REAL = HERE.parent.parent / 'pl_fixed'
_FOUND = R.find_reports(REAL)
REAL_TIMING, REAL_KUTIL = Path(_FOUND['timing']), Path(_FOUND['kernel_util'])
REAL_SYNTH = Path(_FOUND['synth_util']) if _FOUND['synth_util'] else None
REAL_CSYNTH = Path(_FOUND['csynth'])

_T = R.parse_timing_summary(REAL_TIMING)
_K = R.parse_kernel_util(REAL_KUTIL)
KCLK = _T['kernel_clock']
BASE_MHZ = _T['achieved_mhz'] or 180.0
BASE_WNS = _T['kernel_wns'] if _T['kernel_wns'] is not None else 0.0
BASE_LUT, BASE_LUT_PCT = _K.get('lut_used'), _K.get('lut_pct')
DEVICE_LUT = round(BASE_LUT * 100.0 / BASE_LUT_PCT) if BASE_LUT and BASE_LUT_PCT else 519470

# The pretend device. Override to rehearse a different outcome.
FMAX = float(os.environ.get('MOCK_FMAX_MHZ', '195'))
CLIFF = float(os.environ.get('MOCK_CLIFF_MHZ', '215'))
HLS_MAX = float(os.environ.get('MOCK_HLS_MAX_MHZ', '260'))
DELAY = float(os.environ.get('MOCK_DELAY_S', '0.3'))


def _need_fixtures():
    if not (_T['ok'] and _K['ok'] and KCLK):
        raise SystemExit(f'[mock] no readable shipped reports under {REAL} '
                         f'(looked in {_FOUND["link_dir"]}) -- the mock rewrites real '
                         f'reports and cannot run without them')


def model(mhz: float) -> dict:
    """What the pretend device does at this frequency."""
    period = 1000.0 / mhz
    # Slack: the shipped value at the shipped frequency, falling as the period
    # tightens, crossing zero at MOCK_FMAX_MHZ.
    wns = round(BASE_WNS - (1000.0 / FMAX - period) * 1.0, 3)
    # LUT: pipelining cost, roughly linear in the frequency ratio.
    lut_pct = round((BASE_LUT_PCT or 78.47) * (1.0 + 1.15 * (mhz / BASE_MHZ - 1.0)), 2)
    lut = int(DEVICE_LUT * lut_pct / 100.0)
    return {
        'mhz': mhz, 'period': period, 'wns': wns,
        'lut_pct': min(lut_pct, 99.9), 'lut': min(lut, DEVICE_LUT),
        'hls_ok': mhz <= HLS_MAX,
        'routes': mhz < CLIFF,
        'timing_ok': wns >= 0.0,
    }


def _fit(new: str, old: str) -> str:
    """`new` right-aligned into the width `old` occupied (spaces included)."""
    return new.rjust(len(old))


def retime(txt: str, mhz: float, wns: float, failing: int) -> str:
    """Rewrite the three tables for the kernel clock. Raises if any is not found."""
    period = 1000.0 / mhz
    tns = 0.0 if failing == 0 else -12.5
    lines = txt.splitlines(keepends=True)
    done = {'design': False, 'clock': False, 'intra': False}
    table = None
    for i, ln in enumerate(lines):
        body = ln.rstrip('\n')
        if 'WNS(ns)' in body and 'TNS(ns)' in body and not body.lstrip().startswith('Clock'):
            table = 'design'; continue
        if body.startswith('Clock') and 'Period(ns)' in body and 'Frequency(MHz)' in body:
            table = 'clock'; continue
        if body.startswith('Clock') and 'WNS(ns)' in body:
            table = 'intra'; continue
        if table is None or body.strip().startswith('---'):
            continue
        if not body.strip():
            if table in ('clock', 'intra') and done[table]:
                table = None
            continue
        if table == 'design' and not done['design']:
            m = re.match(r'^(\s*-?\d+\.\d+)(\s+-?\d+\.\d+)(\s+\d+)(.*)$', body)
            if m:
                lines[i] = (_fit(f'{wns:.3f}', m.group(1)) + _fit(f'{tns:.3f}', m.group(2))
                            + _fit(str(failing), m.group(3)) + m.group(4) + '\n')
                done['design'] = True
                table = None
        elif table == 'clock':
            m = re.match(r'^(\s*)(\S+)(\s+)\{[\d.]+\s+[\d.]+\}(\s+[\d.]+)(\s+[\d.]+)(.*)$', body)
            if m and m.group(2) == KCLK:
                lines[i] = (m.group(1) + m.group(2) + m.group(3)
                            + f'{{0.000 {period / 2:.3f}}}'
                            + _fit(f'{period:.3f}', m.group(4)) + _fit(f'{mhz:.3f}', m.group(5))
                            + m.group(6) + '\n')
                done['clock'] = True
        elif table == 'intra':
            m = re.match(r'^(\s*\S+)(\s+-?\d+\.\d+)(\s+-?\d+\.\d+)(\s+\d+)(.*)$', body)
            if m and m.group(1).strip() == KCLK:
                lines[i] = (m.group(1) + _fit(f'{wns:.3f}', m.group(2))
                            + _fit(f'{tns:.3f}', m.group(3)) + _fit(str(failing), m.group(4))
                            + m.group(5) + '\n')
                done['intra'] = True
    missing = [k for k, v in done.items() if not v]
    if missing:
        raise SystemExit(f'[mock] could not find the {", ".join(missing)} row(s) for '
                         f'{KCLK} in {REAL_TIMING} -- refusing to hand the parser an '
                         f'unmodified report')
    txt = ''.join(lines)
    if wns < 0.0:
        txt = txt.replace('All user specified timing constraints are met.',
                          'Timing constraints are not met.')
    return txt


def rescale_util(txt: str, lut: int, lut_pct: float) -> str:
    """The LUT cell of the `Used Resources` row, found by the header's column name."""
    lines = txt.splitlines(keepends=True)
    header, col = None, None
    for i, ln in enumerate(lines):
        if header is None and '| Name' in ln and 'LUT' in ln:
            header = ln.split('|')
            col = next(j for j, c in enumerate(header) if c.strip() == 'LUT')
        elif header is not None and 'Used Resources' in ln:
            cells = ln.split('|')
            old = cells[col]
            cells[col] = _fit(f'{lut} [ {lut_pct:5.2f}%] ', old)
            lines[i] = '|'.join(cells)
            return ''.join(lines)
    raise SystemExit(f'[mock] no LUT column / Used Resources row in {REAL_KUTIL}')


def write_link_reports(root: Path, mhz: float, temp_dir: str = '_x') -> None:
    """Produce a report tree for `root` as `v++ --link --temp_dir <temp_dir>` would."""
    _need_fixtures()
    m = model(mhz)
    base = root / temp_dir
    imp = base / 'reports' / 'link' / 'imp'
    syn = base / 'reports' / 'link' / 'syn'
    logs = base / 'logs' / 'link'
    for d in (imp, syn, logs):
        d.mkdir(parents=True, exist_ok=True)

    txt = REAL_TIMING.read_text(errors='replace')
    (imp / 'impl_1_route_report_timing_summary_0.rpt').write_text(
        retime(txt, mhz, m['wns'], 0 if m['timing_ok'] else 12))

    (imp / 'impl_1_kernel_util_routed.rpt').write_text(
        rescale_util(REAL_KUTIL.read_text(errors='replace'), m['lut'], m['lut_pct']))

    if REAL_SYNTH and REAL_SYNTH.is_file():
        s = REAL_SYNTH.read_text(errors='replace')
        s, n = re.subn(r'(\|\s*CLB LUTs\*?\s*\|\s*)(\d+)(\s*\|.*\|\s*)([\d.]+)(\s*\|)',
                       lambda g: f'{g.group(1)}{m["lut"]}{g.group(3)}{m["lut_pct"]:.2f}{g.group(5)}',
                       s, count=1)
        if n != 1:
            raise SystemExit(f'[mock] no CLB LUTs row in {REAL_SYNTH}')
        (syn / REAL_SYNTH.name).write_text(s)

    # -- the log. Routing failure lives here and nowhere else.
    log = ['# mock v++ link\n', f'INFO: kernel clock {mhz:.3f} MHz\n']
    if not m['routes']:
        n = int(9000 * (m['lut_pct'] - 96.0) + 12000)
        log += ['Router Utilization Summary\n',
                'INFO: [Route 35-449] congestion level 6\n',
                'ERROR: [Route 35-2] Design is not legally routed.\n',
                f'{n} signals failed to route due to routing congestion.\n']
    (logs / 'vivado.log').write_text(''.join(log))
    time.sleep(DELAY)


def write_hls(root: Path, period_ns: float) -> bool:
    """Pretend to run csynth. Returns True if it 'met' the period."""
    mhz = 1000.0 / period_ns
    m = model(mhz)
    lines = [f'*****  hls period     : {period_ns:.3f} ns ({mhz:.3f} MHz)\n',
             '***** C/RTL SYNTHESIS *****\n']
    if not m['hls_ok']:
        lines += [f'Estimated clock period 5.900 ns exceeds the target {period_ns:.3f} ns\n',
                  'TIMING VIOLATION\n']
    else:
        lines += [f'Estimated clock period {period_ns * 0.95:.3f} ns\n',
                  '***** C/RTL SYNTHESIS DONE *****\n']
    (root / 'vitis_hls.log').write_text(''.join(lines))
    time.sleep(DELAY)
    if m['hls_ok']:
        xo = root / 'pl' / 'ip'
        xo.mkdir(parents=True, exist_ok=True)
        (xo / 'rtda_split.xo').write_bytes(b'mock xo\n')
        # The sweep projects ns/track from each point's own csynth report; give it
        # the shipped one so that path is exercised.
        if REAL_CSYNTH.is_file():
            rpt = root / 'rtda_split_hls' / 'solution1' / 'syn' / 'report'
            rpt.mkdir(parents=True, exist_ok=True)
            shutil.copy2(REAL_CSYNTH, rpt / REAL_CSYNTH.name)
        return True
    return False
