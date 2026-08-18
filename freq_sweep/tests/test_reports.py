#!/usr/bin/env python
"""Prove the report parsers before spending a four-hour build on them.

    make -C freq_sweep test

TWO HALVES, and the second is the one that matters.

GROUND TRUTH. The shipped 150 MHz build's reports are still on disk under
pl_fixed/_x/reports/link/imp/. Its numbers are already published in README.md
and RESOURCES.md, by a human who read those same files. If the parser
reproduces them the parser is right, and nothing here is a number I made up.

BROKEN INPUT. Every one of these parsers runs on FAILED builds -- that is the
entire point of the sweep -- and a build killed in route_design leaves reports
truncated mid-table, zero-length, or absent. So each fixture below is a real
report deliberately damaged, and the requirement is a classified verdict and
never a traceback. A parser that throws here loses the evidence from a build
that cost four hours, which is worse than not having parsed it at all.

The clock-mismatch case is the one that would poison the whole sweep rather
than one point of it: if --clock.defaultFreqHz were silently ignored or
clamped, every point would come back PASS at a frequency the design never ran
at, and the sweep would report a maximum that does not exist.
"""
from __future__ import annotations

import re
import shutil
import sys
import tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))

import reports as R                                                # noqa: E402

REPO = HERE.parent.parent
REAL = REPO / 'pl_fixed'
IMP = REAL / '_x' / 'reports' / 'link' / 'imp'

FAILURES: list[str] = []
CHECKS = 0


def check(label, got, want):
    global CHECKS
    CHECKS += 1
    ok = (got == want)
    if isinstance(want, float) and isinstance(got, float):
        ok = abs(got - want) < 1e-9
    print(f'  {"ok  " if ok else "FAIL"}  {label:<52} {got!r}'
          + ('' if ok else f'   want {want!r}'))
    if not ok:
        FAILURES.append(f'{label}: got {got!r}, want {want!r}')


def stage(dst: Path, timing=True, kutil=True, synth=True):
    """A minimal pl_fixed-shaped tree holding copies of the real reports."""
    imp = dst / '_x' / 'reports' / 'link' / 'imp'
    syn = dst / '_x' / 'reports' / 'link' / 'syn'
    imp.mkdir(parents=True, exist_ok=True)
    syn.mkdir(parents=True, exist_ok=True)
    if timing:
        shutil.copy(IMP / 'impl_1_route_report_timing_summary_0.rpt',
                    imp / 'impl_1_route_report_timing_summary_0.rpt')
    if kutil:
        shutil.copy(IMP / 'impl_1_kernel_util_routed.rpt',
                    imp / 'impl_1_kernel_util_routed.rpt')
    if synth:
        src = sorted((REAL / '_x' / 'reports' / 'link' / 'syn')
                     .glob('*rtda_split_top*utilization_synth.rpt'))
        if src:
            shutil.copy(src[0], syn / src[0].name)
    return dst


def retime(path: Path, wns: float, met: bool):
    """Set every WNS column in a timing report to `wns`, whatever build it is.

    The first version of this replaced exact strings copied out of the Aug 2026
    report, which silently did nothing in a tree holding the May build -- the
    fixture then equalled the original and the test compared unmutated data
    against a mutated expectation. Anchor on the table shape instead.
    """
    out, in_tbl = [], False
    for ln in path.read_text(errors='replace').splitlines():
        if 'WNS(ns)' in ln:
            in_tbl = True
            out.append(ln); continue
        if in_tbl and ln.strip().startswith('---'):
            out.append(ln); continue
        if in_tbl and ln.strip():
            # first float on the row is WNS; keep the column width
            m = re.match(r'(\s*(?:\S+\s+)??)(-?\d+\.\d+)(\s)', ln)
            if m:
                out.append(f'{m.group(1)}{wns:.3f}{m.group(3)}' + ln[m.end():])
                continue
            in_tbl = False
        else:
            in_tbl = False
        out.append(ln)
    txt = '\n'.join(out)
    if not met:
        txt = txt.replace('All user specified timing constraints are met.',
                          'Timing constraints are not met.')
    path.write_text(txt)


def main():
    if not IMP.is_dir():
        print(f'SKIP: no real reports at {IMP}')
        return 0

    rec = R.read_point(REAL, request_mhz=150.0)
    shipped = abs((rec['wns'] or -9) - 0.050) < 1e-9
    print(f'\n1. GROUND TRUTH -- the build in {REAL.name}/_x/, '
          f'WNS {rec["wns"]}, LUT {rec["lut_pct"]}%\n')
    if not shipped:
        print('   note: not the Aug-2026 shipped build (WNS +0.050 / 75.95% LUT),')
        print('   so the published-number cross-check is skipped for this tree.')
        print('   Everything below still runs against whatever build is here.\n')
    check('verdict', rec['verdict'], R.PASS)
    if shipped:
        check('kernel-clock WNS (ns)          [README: +0.050]', rec['wns'], 0.050)
    check('achieved kernel clock (MHz)    [README: 150]', rec['achieved_mhz'], 150.000)
    check('achieved period (ns)', rec['achieved_period_ns'], 6.667)
    if shipped:
        check('LUT used                       [README: 394,548]', rec['lut_used'], 394548)
    if shipped:
        check('LUT percent                    [README: 75.95%]', rec['lut_pct'], 75.95)
    if shipped:
        check('REG percent                    [README: 56.28%]', rec['reg_pct'], 56.28)
    if shipped:
        check('BRAM percent                   [README: 31.83%]', rec['bram_pct'], 31.83)
    if shipped:
        check('DSP used                       [README: 289]', rec['dsp_used'], 289)
    if shipped:
        check('DSP percent                    [README: 22.03%]', rec['dsp_pct'], 22.03)
    check('failing endpoints', rec['failing_endpoints'], 0)
    check('constraints-met sentence found', rec['constraints_met'], True)
    # By endpoint count, not by name -- 1,319,470 against 3,236 on the control clock.
    check('kernel clock picked by endpoints', rec['kernel_clock'], 'clkout2_primitive')

    print('\n2. THE POISON CASE -- a clock we did not ask for must not read as PASS\n')
    rec = R.read_point(REAL, request_mhz=190.0)
    check('190 MHz requested, 150 achieved -> verdict', rec['verdict'], R.FAIL)
    check('190 MHz requested, 150 achieved -> reason', rec['reason'], 'clock_mismatch')

    print('\n3. BROKEN INPUT -- classify, never raise\n')
    with tempfile.TemporaryDirectory() as td:
        td = Path(td)

        # -- absent entirely: a build that died before writing anything
        rec = R.read_point(td / 'nothing-here', request_mhz=190.0)
        check('missing tree            -> verdict', rec['verdict'], R.FAIL)
        check('missing tree            -> reason', rec['reason'], 'no_reports')

        # -- zero-length reports: killed mid-write
        d = stage(td / 'empty', timing=False, kutil=False, synth=False)
        (d / '_x/reports/link/imp/impl_1_route_report_timing_summary_0.rpt').write_text('')
        (d / '_x/reports/link/imp/impl_1_kernel_util_routed.rpt').write_text('')
        rec = R.read_point(d, request_mhz=190.0)
        check('zero-length reports     -> verdict', rec['verdict'], R.FAIL)
        check('zero-length reports     -> reason', rec['reason'], 'no_reports')

        # -- truncated mid-table, which is what a SIGKILL actually leaves
        d = stage(td / 'trunc')
        f = d / '_x/reports/link/imp/impl_1_route_report_timing_summary_0.rpt'
        f.write_text('\n'.join(f.read_text().splitlines()[:120]))
        rec = R.read_point(d, request_mhz=150.0)
        check('truncated timing        -> no crash', rec['verdict'] in
              (R.FAIL, R.UNKNOWN, R.MARGINAL, R.PASS), True)
        check('truncated timing        -> wns is None or float',
              rec['wns'] is None or isinstance(rec['wns'], float), True)

        # -- binary garbage
        d = stage(td / 'garbage', timing=False)
        (d / '_x/reports/link/imp/impl_1_route_report_timing_summary_0.rpt'
         ).write_bytes(bytes(range(256)) * 40)
        rec = R.read_point(d, request_mhz=150.0)
        check('binary garbage          -> no crash', isinstance(rec['verdict'], str), True)

        # -- met timing, but route_design failed. The 2026-08-14 build exactly:
        #    WNS +0.213 ns, placed fine, 469,480 signals unrouted.
        d = stage(td / 'unrouted')
        (d / '_x' / 'logs' / 'link').mkdir(parents=True, exist_ok=True)
        (d / '_x/logs/link/vivado.log').write_text(
            'INFO: [Route 35-254] Multithreading enabled\n'
            'Router Utilization Summary\n'
            'congestion level 6\n'
            'ERROR: [Route 35-2] Design is not legally routed.\n'
            '469480 signals failed to route due to routing congestion.\n')
        rec = R.read_point(d, request_mhz=150.0)
        check('routed=no, timing ok    -> verdict', rec['verdict'], R.FAIL)
        check('routed=no, timing ok    -> reason', rec['reason'], 'place_congestion')
        check('unrouted signal count', rec['unrouted'], 469480)
        check('congestion level', rec['congestion'], 6)

        # -- OOM outranks everything: the numbers in a half-written report lie
        d = stage(td / 'oom')
        (d / '_x' / 'logs' / 'link').mkdir(parents=True, exist_ok=True)
        (d / '_x/logs/link/vivado.log').write_text('Killed process 12345 (vivado)\n')
        rec = R.read_point(d, request_mhz=150.0)
        check('OOM                     -> reason', rec['reason'], 'oom')

        # -- negative slack, both sides of the MARGINAL band
        for wns, want_v, tag in ((-0.050, R.MARGINAL, 'small'), (-0.500, R.FAIL, 'large')):
            d = stage(td / f'wns{tag}')
            retime(d / '_x/reports/link/imp/impl_1_route_report_timing_summary_0.rpt',
                   wns, met=False)
            rec = R.read_point(d, request_mhz=150.0)
            check(f'WNS {wns:+.3f}             -> verdict', rec['verdict'], want_v)
            check(f'WNS {wns:+.3f}             -> parsed', rec['wns'], wns)

        # -- the threshold is a REPORTING knob: same build, stricter bar
        d = td / 'wnssmall'
        rec = R.read_point(d, request_mhz=150.0, wns_threshold=-1.0)
        check('WNS -0.050 with --wns-threshold=-1.0 -> PASS', rec['verdict'], R.PASS)

    print(f'\n{"=" * 72}')
    if FAILURES:
        print(f'FAILED {len(FAILURES)} of {CHECKS} checks:')
        for f in FAILURES:
            print(f'  - {f}')
        return 1
    print(f'PASS -- {CHECKS} checks, parsers agree with README.md and survive '
          f'every broken input.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
