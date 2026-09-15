#!/usr/bin/env python
"""Prove the report parsers before spending a four-hour build on them.

    make -C freq_sweep test

TWO HALVES, and the second is the one that matters.

GROUND TRUTH. The shipped 180 MHz build's reports are on disk under
pl_fixed/_x/ap16_3_hw/reports/link/imp/ (linked 2026-08-20). The numbers checked
below were copied from the report TEXT -- the `Used Resources` row
(`407628 [ 78.47%]`), the clock summary (`5.556  180.000`), the design summary
(`0.000 ... 1387521`) -- not from this parser. If the parser reproduces them the
parser is right. If pl_fixed/ holds a different build, the numeric cross-check is
skipped and says so; everything else still runs against whatever is there.

BOTH REPORT LAYOUTS. pl_fixed links with --temp_dir _x/<VARIANT>_<TARGET> since
2026-08-20; older trees keep reports under _x/reports/. A parser that knows only
one of them reads every build of the other as `no_reports`, so both are staged.

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
FOUND = R.find_reports(REAL)
IMP = Path(FOUND['timing']).parent
STAMP = 'ap16_3_hw'

FAILURES: list[str] = []
CHECKS = 0


def check(label, got, want):
    global CHECKS
    CHECKS += 1
    ok = (got == want)
    if isinstance(want, float) and isinstance(got, float):
        ok = abs(got - want) < 1e-9
    print(f'  {"ok  " if ok else "FAIL"}  {label:<56} {got!r}'
          + ('' if ok else f'   want {want!r}'))
    if not ok:
        FAILURES.append(f'{label}: got {got!r}, want {want!r}')


def base(dst: Path, layout: str = 'stamped') -> Path:
    """Where a link writes: _x/<VARIANT>_<TARGET> now, _x before 2026-08-20."""
    return dst / '_x' / STAMP if layout == 'stamped' else dst / '_x'


def stage(dst: Path, timing=True, kutil=True, synth=True, layout='stamped'):
    """A minimal pl_fixed-shaped tree holding copies of the real reports."""
    b = base(dst, layout)
    imp = b / 'reports' / 'link' / 'imp'
    syn = b / 'reports' / 'link' / 'syn'
    imp.mkdir(parents=True, exist_ok=True)
    syn.mkdir(parents=True, exist_ok=True)
    if timing:
        shutil.copy(IMP / 'impl_1_route_report_timing_summary_0.rpt',
                    imp / 'impl_1_route_report_timing_summary_0.rpt')
    if kutil:
        shutil.copy(IMP / 'impl_1_kernel_util_routed.rpt',
                    imp / 'impl_1_kernel_util_routed.rpt')
    if synth and FOUND['synth_util']:
        src = Path(FOUND['synth_util'])
        shutil.copy(src, syn / src.name)
    return dst


def retime(path: Path, wns: float, met: bool):
    """Set every WNS column in a timing report to `wns`, whatever build it is.

    The first version of this replaced exact strings copied out of one report,
    which silently did nothing in a tree holding another build -- the fixture then
    equalled the original and the test compared unmutated data against a mutated
    expectation. Anchor on the table shape instead.
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
    if not (IMP / 'impl_1_route_report_timing_summary_0.rpt').is_file():
        print(f'SKIP: no real reports under {REAL}/_x (looked in {FOUND["link_dir"]})')
        return 0

    rec = R.read_point(REAL)
    ship = rec['achieved_mhz']
    shipped = rec['wns'] == 0.0 and rec['lut_used'] == 407628
    print(f'\n1. GROUND TRUTH -- the build in {Path(FOUND["link_dir"]).relative_to(REPO)}, '
          f'{ship} MHz, WNS {rec["wns"]}, LUT {rec["lut_pct"]}%\n')
    if not shipped:
        print('   note: not the 2026-08-20 shipped 180 MHz build (WNS 0.000 / 407,628 LUT),')
        print('   so the report-text cross-check is skipped for this tree.')
        print('   Everything below still runs against whatever build is here.\n')
    check('verdict', rec['verdict'], R.PASS)
    check('verdict when asked for the achieved clock',
          R.read_point(REAL, request_mhz=ship)['verdict'], R.PASS)
    check('failing endpoints', rec['failing_endpoints'], 0)
    check('constraints-met sentence found', rec['constraints_met'], True)
    if shipped:
        check('achieved kernel clock (MHz)     [report: 180.000]', rec['achieved_mhz'], 180.000)
        check('achieved period (ns)            [report: 5.556]', rec['achieved_period_ns'], 5.556)
        check('kernel-clock WNS (ns)           [report: 0.000]', rec['wns'], 0.0)
        check('LUT used                        [report: 407628]', rec['lut_used'], 407628)
        check('LUT percent                     [report: 78.47%]', rec['lut_pct'], 78.47)
        check('REG percent                     [report: 59.69%]', rec['reg_pct'], 59.69)
        check('BRAM percent                    [report: 33.33%]', rec['bram_pct'], 33.33)
        check('DSP used                        [report: 289]', rec['dsp_used'], 289)
        check('DSP percent                     [report: 22.03%]', rec['dsp_pct'], 22.03)
        # By endpoint count, not by name: at 180 MHz there is also a clkout1_primitive,
        # the 100 MHz control clock, one character away.
        check('kernel clock picked by endpoints [1,384,153]', rec['kernel_clock'],
              'clkout1_primitive_1')
        if Path(FOUND['csynth']).is_file():
            check('csynth TrackLoop worst case     [report: 17078]', rec['csynth_cycles'], 17078)

    print('\n2. THE POISON CASE -- a clock we did not ask for must not read as PASS\n')
    rec = R.read_point(REAL, request_mhz=ship + 20.0)
    check(f'{ship + 20:.0f} MHz requested, {ship:.0f} achieved -> verdict', rec['verdict'], R.FAIL)
    check(f'{ship + 20:.0f} MHz requested, {ship:.0f} achieved -> reason', rec['reason'], 'clock_mismatch')

    print('\n3. BOTH LAYOUTS -- _x/<VARIANT>_<TARGET>/ and the pre-2026-08-20 _x/\n')
    with tempfile.TemporaryDirectory() as td:
        td = Path(td)
        want_wns = R.read_point(REAL)['wns']
        for layout in ('stamped', 'flat'):
            d = stage(td / layout, layout=layout)
            rec = R.read_point(d, request_mhz=ship)
            check(f'{layout:<7} layout -> verdict', rec['verdict'], R.PASS)
            check(f'{layout:<7} layout -> kernel WNS read', rec['wns'], want_wns)
        # A stale flat _x/reports next to a stamped build must not shadow it.
        d = stage(td / 'both', layout='stamped')
        stage(d, layout='flat')
        retime(base(d, 'flat') / 'reports/link/imp/impl_1_route_report_timing_summary_0.rpt',
               -0.500, met=False)
        rec = R.read_point(d, request_mhz=ship)
        check('stamped build beside a stale flat one -> verdict', rec['verdict'], R.PASS)

    print('\n4. BROKEN INPUT -- classify, never raise\n')
    with tempfile.TemporaryDirectory() as td:
        td = Path(td)

        # -- absent entirely: a build that died before writing anything
        rec = R.read_point(td / 'nothing-here', request_mhz=ship)
        check('missing tree            -> verdict', rec['verdict'], R.FAIL)
        check('missing tree            -> reason', rec['reason'], 'no_reports')

        # -- zero-length reports: killed mid-write
        d = stage(td / 'empty', timing=False, kutil=False, synth=False)
        (base(d) / 'reports/link/imp/impl_1_route_report_timing_summary_0.rpt').write_text('')
        (base(d) / 'reports/link/imp/impl_1_kernel_util_routed.rpt').write_text('')
        rec = R.read_point(d, request_mhz=ship)
        check('zero-length reports     -> verdict', rec['verdict'], R.FAIL)
        check('zero-length reports     -> reason', rec['reason'], 'no_reports')

        # -- truncated mid-table, which is what a SIGKILL actually leaves
        d = stage(td / 'trunc')
        f = base(d) / 'reports/link/imp/impl_1_route_report_timing_summary_0.rpt'
        f.write_text('\n'.join(f.read_text().splitlines()[:120]))
        rec = R.read_point(d, request_mhz=ship)
        check('truncated timing        -> no crash', rec['verdict'] in
              (R.FAIL, R.UNKNOWN, R.MARGINAL, R.PASS), True)
        check('truncated timing        -> wns is None or float',
              rec['wns'] is None or isinstance(rec['wns'], float), True)

        # -- binary garbage
        d = stage(td / 'garbage', timing=False)
        (base(d) / 'reports/link/imp/impl_1_route_report_timing_summary_0.rpt'
         ).write_bytes(bytes(range(256)) * 40)
        rec = R.read_point(d, request_mhz=ship)
        check('binary garbage          -> no crash', isinstance(rec['verdict'], str), True)

        # -- met timing, but route_design failed. The 2026-08-14 build exactly:
        #    WNS +0.213 ns, placed fine, 469,480 signals unrouted.
        d = stage(td / 'unrouted')
        (base(d) / 'logs' / 'link').mkdir(parents=True, exist_ok=True)
        (base(d) / 'logs/link/vivado.log').write_text(
            'INFO: [Route 35-254] Multithreading enabled\n'
            'Router Utilization Summary\n'
            'congestion level 6\n'
            'ERROR: [Route 35-2] Design is not legally routed.\n'
            '469480 signals failed to route due to routing congestion.\n')
        rec = R.read_point(d, request_mhz=ship)
        check('routed=no, timing ok    -> verdict', rec['verdict'], R.FAIL)
        check('routed=no, timing ok    -> reason', rec['reason'], 'place_congestion')
        check('unrouted signal count', rec['unrouted'], 469480)
        check('congestion level', rec['congestion'], 6)

        # -- OOM outranks everything: the numbers in a half-written report lie
        d = stage(td / 'oom')
        (base(d) / 'logs' / 'link').mkdir(parents=True, exist_ok=True)
        (base(d) / 'logs/link/vivado.log').write_text('Killed process 12345 (vivado)\n')
        rec = R.read_point(d, request_mhz=ship)
        check('OOM                     -> reason', rec['reason'], 'oom')

        # -- negative slack, both sides of the MARGINAL band
        for wns, want_v, tag in ((-0.050, R.MARGINAL, 'small'), (-0.500, R.FAIL, 'large')):
            d = stage(td / f'wns{tag}')
            retime(base(d) / 'reports/link/imp/impl_1_route_report_timing_summary_0.rpt',
                   wns, met=False)
            rec = R.read_point(d, request_mhz=ship)
            check(f'WNS {wns:+.3f}             -> verdict', rec['verdict'], want_v)
            check(f'WNS {wns:+.3f}             -> parsed', rec['wns'], wns)

        # -- the threshold is a REPORTING knob: same build, stricter bar
        d = td / 'wnssmall'
        rec = R.read_point(d, request_mhz=ship, wns_threshold=-1.0)
        check('WNS -0.050 with --wns-threshold=-1.0 -> PASS', rec['verdict'], R.PASS)

    print(f'\n{"=" * 72}')
    if FAILURES:
        print(f'FAILED {len(FAILURES)} of {CHECKS} checks:')
        for f in FAILURES:
            print(f'  - {f}')
        return 1
    print(f'PASS -- {CHECKS} checks: parsers agree with the report text, read both '
          f'layouts, and survive every broken input.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
