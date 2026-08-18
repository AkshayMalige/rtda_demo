#!/usr/bin/env python
"""Shared body of the fake vitis_hls / v++ shims.

WHY THE MOCK REWRITES REAL REPORTS INSTEAD OF INVENTING FILES
A mock that emits reports of its own design tests the mock, not the parser. It
would agree with whatever `reports.py` happens to expect and go on agreeing
after both drifted away from what Vivado writes.

So the fixtures here are the shipped 150 MHz build's own reports with the
numbers substituted. The 629 KB timing summary keeps all three of its tables,
its real clock tree, its 1.3 M endpoint counts and its column alignment; only
the frequency, the period and the slack change. If the parser can read the
mock it can read the real thing, because they are the same file.

THE TOY MODEL, which is a stand-in for physics and nothing more:
  slack falls as the period tightens, and LUT rises as HLS adds pipeline
  registers to keep up. Past MOCK_FMAX slack goes negative; past
  MOCK_CLIFF_MHZ the LUT crosses the congestion cliff and routing fails the way
  the 2026-08-14 build did. Both thresholds are env-settable so the driver's
  search can be tested against several shapes of reality, including the
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
REAL_IMP = HERE.parent.parent / 'pl_fixed' / '_x' / 'reports' / 'link' / 'imp'
REAL_SYN = HERE.parent.parent / 'pl_fixed' / '_x' / 'reports' / 'link' / 'syn'

# The pretend device. Override to rehearse a different outcome.
FMAX = float(os.environ.get('MOCK_FMAX_MHZ', '195'))
CLIFF = float(os.environ.get('MOCK_CLIFF_MHZ', '215'))
HLS_MAX = float(os.environ.get('MOCK_HLS_MAX_MHZ', '260'))
DELAY = float(os.environ.get('MOCK_DELAY_S', '0.3'))
BASE_LUT_PCT, BASE_LUT, DEVICE_LUT = 75.95, 394548, 519453


def model(mhz: float) -> dict:
    """What the pretend device does at this frequency."""
    # Slack: +0.050 ns at 150 MHz, falling as the period tightens.
    period = 1000.0 / mhz
    wns = round(0.050 - (1000.0 / FMAX - period) * 1.0, 3)
    # LUT: pipelining cost, roughly linear in the frequency ratio.
    lut_pct = round(BASE_LUT_PCT * (1.0 + 1.15 * (mhz / 150.0 - 1.0)), 2)
    lut = int(DEVICE_LUT * lut_pct / 100.0)
    return {
        'mhz': mhz, 'period': period, 'wns': wns,
        'lut_pct': min(lut_pct, 99.9), 'lut': min(lut, DEVICE_LUT),
        'hls_ok': mhz <= HLS_MAX,
        'routes': mhz < CLIFF,
        'timing_ok': wns >= 0.0,
    }


def _sub_row(txt, old_wns='0.050', new_wns=0.05, failing=0):
    """Replace the design-summary and per-clock WNS, keeping column widths."""
    txt = txt.replace(
        '      0.050        0.000                      0              1322790',
        f'{new_wns:11.3f}  {0.0 if failing == 0 else -12.5:11.3f}  {failing:21d}              1322790')
    txt = txt.replace(
        '  clkout2_primitive                0.050        0.000                      0              1319470',
        f'  clkout2_primitive         {new_wns:12.3f}  {0.0 if failing == 0 else -12.5:11.3f}  '
        f'{failing:21d}              1319470')
    return txt


def write_link_reports(root: Path, mhz: float) -> None:
    """Produce a report tree for `root` as v++ --link would."""
    m = model(mhz)
    imp = root / '_x' / 'reports' / 'link' / 'imp'
    syn = root / '_x' / 'reports' / 'link' / 'syn'
    logs = root / '_x' / 'logs' / 'link'
    for d in (imp, syn, logs):
        d.mkdir(parents=True, exist_ok=True)

    # -- timing summary: the real file, retimed.
    txt = (REAL_IMP / 'impl_1_route_report_timing_summary_0.rpt').read_text(errors='replace')
    txt = _sub_row(txt, new_wns=m['wns'], failing=0 if m['timing_ok'] else 12)
    # the clock summary row -- this is what the parser reads the frequency from
    txt = txt.replace(
        '  clkout2_primitive          {0.000 3.333}          6.667           150.000',
        f'  clkout2_primitive          {{0.000 {m["period"]/2:.3f}}}          '
        f'{m["period"]:.3f}           {mhz:.3f}')
    if not m['timing_ok']:
        txt = txt.replace('All user specified timing constraints are met.',
                          'Timing constraints are not met.')
    (imp / 'impl_1_route_report_timing_summary_0.rpt').write_text(txt)

    # -- utilization: the real file, with the LUT row scaled.
    u = (REAL_IMP / 'impl_1_kernel_util_routed.rpt').read_text(errors='replace')
    u = u.replace(f'{BASE_LUT} [ {BASE_LUT_PCT}%]', f'{m["lut"]} [ {m["lut_pct"]}%]')
    (imp / 'impl_1_kernel_util_routed.rpt').write_text(u)

    src = sorted(REAL_SYN.glob('*rtda_split_top*utilization_synth.rpt'))
    if src:
        s = src[0].read_text(errors='replace')
        s = re.sub(r'(\|\s*CLB LUTs\*?\s*\|\s*)(\d+)(\s*\|.*\|\s*)([\d.]+)(\s*\|)',
                   lambda g: f'{g.group(1)}{m["lut"]}{g.group(3)}{m["lut_pct"]:.2f}{g.group(5)}',
                   s, count=1)
        (syn / src[0].name).write_text(s)

    # -- the log. Routing failure lives here and nowhere else.
    log = ['# mock v++ link\n', f'INFO: kernel clock {mhz:.3f} MHz\n']
    if not m['routes']:
        n = int(9000 * (m['lut_pct'] - 96.0) + 12000)
        log += ['Router Utilization Summary\n',
                'INFO: [Route 35-449] congestion level 6\n',
                'ERROR: [Route 35-2] Design is not legally routed.\n',
                f'{n} signals failed to route due to routing congestion.\n']
    (logs / 'vivado.log').write_text(''.join(log))

    if m['routes']:
        xsa = root / 'build'
        xsa.mkdir(parents=True, exist_ok=True)
        for d in xsa.iterdir():
            pass
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
        return True
    return False
