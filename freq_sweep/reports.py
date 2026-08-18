#!/usr/bin/env python
"""Read a Vitis/Vivado build's verdict out of its reports, without ever raising.

    ./reports.py <point-dir-or-pl_fixed-dir> [--request-mhz 190]

THE ONE RULE HERE: a parser that throws is worse than no parser. This runs on
the output of builds that FAILED, which is exactly when reports are truncated,
empty, or absent -- a build killed in route_design leaves a half-written table.
Every function returns a value or None, `read_point()` catches everything, and a
report that cannot be read becomes a classified verdict rather than a traceback
that loses a 4-hour build's evidence.

THREE FILE FORMATS, and they do not resemble each other
------------------------------------------------------
1. impl_1_route_report_timing_summary_0.rpt -- three separate tables:

     design summary (~line 140)
        WNS(ns)   TNS(ns)   TNS Failing Endpoints   ...
          0.050     0.000                       0   ...

     the sentence that is the real pass/fail (~line 145)
        All user specified timing constraints are met.

     clock summary (~line 155), which gives the ACHIEVED period
        Clock                  Waveform(ns)     Period(ns)    Frequency(MHz)
          clkout2_primitive    {0.000 3.333}    6.667         150.000

     intra-clock summary (~line 186), WNS per clock
        clkout2_primitive      0.050  0.000  0  1319470  ...

2. impl_1_kernel_util_routed.rpt -- `N [ PCT%]` cells, one row per role:
        |    Used Resources   |  585049 [ 56.28%] | 394548 [ 75.95%] | ...

3. *_utilization_synth.rpt -- the EARLY gate, plain pipe-delimited:
        | CLB LUTs*           |    0 |   0 |   0 |  520704 |  0.00 |

WHICH CLOCK IS THE KERNEL CLOCK
Not by name. `clkout2_primitive` is what the VEK280 base platform happens to
call it today, and a sweep that hardcodes it would silently report the 100 MHz
control clock's slack the day that changes. It is identified by ENDPOINT COUNT
instead -- 1,319,470 against 3,236 -- which is a property of the design, not of
the platform's naming.

That also buys the check this whole project depends on: the achieved frequency
is read back and compared against what was requested. A `--clock.defaultFreqHz`
that is quietly ignored or clamped would otherwise look like a clean PASS at a
frequency the design never ran at.

Self-test:  make -C freq_sweep test
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

# Verdicts. PASS/MARGINAL/FAIL are the only three a caller should branch on.
PASS, MARGINAL, FAIL, UNKNOWN = 'PASS', 'MARGINAL', 'FAIL', 'UNKNOWN'

# Why it failed. Ordered roughly by how early in the build it can be known,
# which is also the order a reader wants them in.
REASONS = (
    'hls_missing',        # csynth never produced the .xo
    'hls_period_miss',    # csynth ran but could not meet the requested period
    'synth_lut_over',     # post-synthesis utilization already over budget
    'place_congestion',   # placer gave up
    'route_unrouted',     # route_design left signals unrouted
    'timing_wns',         # routed, but negative slack
    'clock_mismatch',     # achieved clock is not the clock we asked for
    'toolerror',          # v++/vitis_hls returned non-zero for another reason
    'oom',                # killed by the OOM killer
    'killed',             # killed by us or by the user
    'no_reports',         # build produced nothing readable
)

# route_design's own words. From tools/watch_pl_build.sh, which recorded them
# off the 2026-08-14 failure.
RE_UNROUTED = re.compile(r'(\d+)\s+signals failed to route due to routing congestion')
RE_NOTROUTED = re.compile(r'Design is not legally routed')
RE_CONGEST = re.compile(r'congestion level (\d+)', re.I)
RE_OOM = re.compile(r'Out of memory|Killed process|std::bad_alloc|MEMORY_EXHAUSTED', re.I)

# `N [ PCT%]`, the accelerator-utilization cell.
RE_CELL = re.compile(r'(\d+)\s*\[\s*([<>]?\s*[\d.]+)%\s*\]')


# ---------------------------------------------------------------------------
#  Small helpers. Every one of these returns None rather than raising.
# ---------------------------------------------------------------------------

def _text(path) -> str | None:
    """File contents, or None. Binary, unreadable and absent all give None."""
    try:
        p = Path(path)
        if not p.is_file() or p.stat().st_size == 0:
            return None
        return p.read_text(errors='replace')
    except (OSError, ValueError):
        return None


def _f(tok):
    try:
        return float(tok)
    except (TypeError, ValueError):
        return None


def _i(tok):
    try:
        return int(tok)
    except (TypeError, ValueError):
        return None


# ---------------------------------------------------------------------------
#  1. Timing summary
# ---------------------------------------------------------------------------

def parse_timing_summary(path) -> dict:
    """WNS, the pass sentence, the achieved clock, and per-clock slack.

    Returns a dict that is always shaped the same; unreadable fields are None.
    `ok` is True only when every field the verdict depends on was found.
    """
    out = {
        'file': str(path), 'ok': False,
        'constraints_met': None,          # the sentence, verbatim pass/fail
        'design_wns': None, 'design_tns': None, 'failing_endpoints': None,
        'kernel_clock': None,             # name, for the report only
        'kernel_wns': None, 'kernel_endpoints': None,
        'achieved_period_ns': None, 'achieved_mhz': None,
        'clocks': {},                     # name -> (period_ns, mhz)
    }
    txt = _text(path)
    if txt is None:
        return out
    lines = txt.splitlines()

    # -- the sentence. Vivado prints one or the other, never both.
    if 'All user specified timing constraints are met' in txt:
        out['constraints_met'] = True
    elif re.search(r'Timing constraints are not met', txt):
        out['constraints_met'] = False

    # -- design summary: the first numeric row under the WNS(ns) header.
    for i, ln in enumerate(lines):
        if 'WNS(ns)' in ln and 'TNS(ns)' in ln and not ln.strip().startswith('Clock'):
            for probe in lines[i + 1:i + 5]:
                tok = probe.split()
                if len(tok) >= 4 and _f(tok[0]) is not None:
                    out['design_wns'] = _f(tok[0])
                    out['design_tns'] = _f(tok[1])
                    out['failing_endpoints'] = _i(tok[2])
                    break
            break

    # -- clock summary: name, period, frequency.
    for i, ln in enumerate(lines):
        if ln.startswith('Clock') and 'Period(ns)' in ln and 'Frequency(MHz)' in ln:
            for probe in lines[i + 2:]:
                if not probe.strip():
                    break
                m = re.match(r'\s*(\S+)\s+\{[^}]*\}\s+([\d.]+)\s+([\d.]+)', probe)
                if m:
                    out['clocks'][m.group(1)] = (_f(m.group(2)), _f(m.group(3)))
            break

    # -- intra-clock table: WNS and endpoint count per clock. The kernel clock
    #    is the one with the most endpoints, never the one with a known name.
    best = None
    for i, ln in enumerate(lines):
        if ln.startswith('Clock') and 'WNS(ns)' in ln:
            for probe in lines[i + 2:]:
                if not probe.strip():
                    break
                tok = probe.split()
                # name + at least WNS, TNS, failing, total
                if len(tok) >= 5 and _f(tok[1]) is not None and _i(tok[4]) is not None:
                    n_ep = _i(tok[4])
                    if best is None or n_ep > best[2]:
                        best = (tok[0], _f(tok[1]), n_ep)
            break
    if best:
        out['kernel_clock'], out['kernel_wns'], out['kernel_endpoints'] = best
        if best[0] in out['clocks']:
            out['achieved_period_ns'], out['achieved_mhz'] = out['clocks'][best[0]]

    out['ok'] = (out['constraints_met'] is not None
                 and out['kernel_wns'] is not None
                 and out['achieved_mhz'] is not None)
    return out


# ---------------------------------------------------------------------------
#  2. Post-route accelerator utilization
# ---------------------------------------------------------------------------

def parse_kernel_util(path) -> dict:
    """LUT / REG / BRAM / DSP from the `Used Resources` row.

    Column order comes from the header row rather than from position, because
    URAM and LUTAsMem sit between the ones we care about.
    """
    out = {'file': str(path), 'ok': False}
    txt = _text(path)
    if txt is None:
        return out

    header, used = None, None
    for ln in txt.splitlines():
        if header is None and '| Name' in ln and 'LUT' in ln:
            header = [c.strip() for c in ln.strip().strip('|').split('|')]
        elif header and 'Used Resources' in ln:
            used = [c.strip() for c in ln.strip().strip('|').split('|')]
            break
    if not header or not used or len(used) != len(header):
        return out

    for name, cell in zip(header[1:], used[1:]):
        m = RE_CELL.search(cell)
        if not m:
            continue
        key = name.lower()
        out[f'{key}_used'] = _i(m.group(1))
        out[f'{key}_pct'] = _f(m.group(2).replace('<', '').replace('>', '').strip())
    out['ok'] = out.get('lut_pct') is not None
    return out


# ---------------------------------------------------------------------------
#  3. Post-synthesis utilization -- the early gate
# ---------------------------------------------------------------------------

def parse_synth_util(path) -> dict:
    """CLB LUT percent, ~1 h into the link and about 2 h before the verdict.

    RESOURCES.md: the 2026-08-14 build read 99.68% here and 98.87% after
    placement, then failed to route. Post-synth tracks post-place closely
    enough to be a sound early signal.

    The percent is the SECOND-TO-LAST field, not the sixth. tools/watch_pl_build.sh
    carries the same note: counting to $6 lands on `Available` (520704), which is
    over any threshold, so the check appears to work while being nonsense.
    """
    out = {'file': str(path), 'ok': False, 'lut_pct': None, 'lut_used': None}
    txt = _text(path)
    if txt is None:
        return out
    for ln in txt.splitlines():
        if re.match(r'\s*\|\s*CLB LUTs', ln):
            cells = [c.strip() for c in ln.strip().strip('|').split('|')]
            if len(cells) >= 2:
                out['lut_pct'] = _f(cells[-1])
                out['lut_used'] = _i(cells[1])
                out['ok'] = out['lut_pct'] is not None
            break
    return out


# ---------------------------------------------------------------------------
#  4. Logs -- the only place a routing failure is recorded
# ---------------------------------------------------------------------------

def scan_logs(paths) -> dict:
    """Routing/congestion/OOM evidence. No report file carries this.

    Vivado writes no congestion report unless asked, so route_design's own
    ERROR text is the record. Reads the tail of each log: these run to
    hundreds of MB and the failure is always at the end.
    """
    out = {'unrouted': None, 'congestion_level': None, 'not_routed': False,
           'oom': False, 'logs_read': []}
    for p in paths:
        try:
            p = Path(p)
            if not p.is_file():
                continue
            size = p.stat().st_size
            with p.open('rb') as fh:                # tail, not the whole file
                if size > 4_000_000:
                    fh.seek(size - 4_000_000)
                txt = fh.read().decode('utf-8', errors='replace')
        except (OSError, ValueError):
            continue
        out['logs_read'].append(str(p))
        if m := RE_UNROUTED.search(txt):
            n = _i(m.group(1))
            if n is not None and (out['unrouted'] is None or n > out['unrouted']):
                out['unrouted'] = n
        if RE_NOTROUTED.search(txt):
            out['not_routed'] = True
        if m := RE_CONGEST.search(txt):
            out['congestion_level'] = _i(m.group(1))
        if RE_OOM.search(txt):
            out['oom'] = True
    return out


def scan_hls_log(path) -> dict:
    """Did csynth meet the period it was given, and what did it estimate?

    Vitis HLS reports the estimated clock period and flags a violation in the
    log; the same numbers are in csynth.xml but the log exists even when the
    run died before writing reports.
    """
    out = {'period_requested': None, 'period_estimated': None,
           'timing_violation': False, 'ok': False}
    txt = _text(path)
    if txt is None:
        return out
    if re.search(r'Estimated clock period.*exceed|TIMING VIOLATION|'
                 r'Timing constraint not met|failed timing', txt, re.I):
        out['timing_violation'] = True
    if m := re.search(r'\*\*\*\*\*\s+hls period\s*:\s*([\d.]+)\s*ns', txt):
        out['period_requested'] = _f(m.group(1))
    for m in re.finditer(r'[Ee]stimated clock period[^\d\-]*([\d.]+)', txt):
        out['period_estimated'] = _f(m.group(1))
    out['ok'] = out['period_requested'] is not None
    return out


# ---------------------------------------------------------------------------
#  Putting it together
# ---------------------------------------------------------------------------

def find_reports(root) -> dict:
    """Locate the report set inside a pl_fixed working tree.

    Globs rather than fixed paths: v++ names the synth-stage report after the
    generated block, which is not stable, and the kernel-only report is the one
    among many that matters.
    """
    root = Path(root)
    imp = root / '_x' / 'reports' / 'link' / 'imp'
    got = {
        'timing': imp / 'impl_1_route_report_timing_summary_0.rpt',
        'kernel_util': imp / 'impl_1_kernel_util_routed.rpt',
        'synth_util': None,
        'logs': [], 'hls_log': root / 'vitis_hls.log',
        'xo': root / 'pl' / 'ip' / 'rtda_split.xo',
    }
    syn = root / '_x' / 'reports' / 'link' / 'syn'
    cands = sorted(syn.glob('*rtda_split_top*utilization_synth.rpt')) if syn.is_dir() else []
    if not cands and syn.is_dir():
        cands = sorted(syn.glob('*utilization_synth.rpt'))
    if cands:
        got['synth_util'] = cands[0]
    for rel in ('_x/logs/link/vivado.log', '_x/logs/link/imp/impl_1_runme.log',
                '_x/link/vivado/vpl/vivado.log', '_x/link/vivado/vpl/runme.log'):
        p = root / rel
        if p.is_file():
            got['logs'].append(p)
    got['logs'].extend(sorted(root.glob('v++_*.log')))
    return got


def classify(timing, kutil, sutil, logs, hls, request_mhz,
             wns_threshold=0.0, lut_warn=90.0, clock_tol_mhz=1.0) -> tuple:
    """(verdict, reason, note). The single place a build is judged.

    wns_threshold is a REPORTING knob, not a search knob. Slack is recorded
    exactly as measured; this only decides which of three words goes in the
    verdict column, so the bar can be moved when reading the table rather than
    being baked into a build that took four hours.
    """
    if logs.get('oom'):
        return FAIL, 'oom', 'killed by the OOM killer'
    if not (timing.get('ok') or kutil.get('ok')):
        # Nothing to judge. Say which stage it did not survive.
        if hls.get('timing_violation'):
            return FAIL, 'hls_period_miss', 'csynth could not meet the period'
        # `hls_missing` means csynth RAN and produced no .xo. Without an HLS log
        # there is no evidence it ran at all, and blaming HLS for a tree that
        # was never built points the reader at the wrong three hours.
        xo = logs.get('xo')
        if hls.get('ok') and xo is not None and not Path(str(xo)).is_file():
            return FAIL, 'hls_missing', 'csynth ran but produced no .xo'
        if logs.get('not_routed') or logs.get('unrouted'):
            n = logs.get('unrouted')
            lvl = logs.get('congestion_level')
            note = f'{n:,} signals unrouted' if n else 'design not legally routed'
            if lvl:
                note += f', congestion level {lvl}'
            return FAIL, ('place_congestion' if lvl and lvl >= 5 else 'route_unrouted'), note
        if sutil.get('ok') and sutil['lut_pct'] is not None and sutil['lut_pct'] > lut_warn:
            return FAIL, 'synth_lut_over', f'post-synth LUT {sutil["lut_pct"]:.2f}%'
        return FAIL, 'no_reports', 'no readable reports'

    # Routing failures can coexist with a written timing report; check first.
    if logs.get('not_routed') or logs.get('unrouted'):
        n, lvl = logs.get('unrouted'), logs.get('congestion_level')
        note = f'{n:,} signals unrouted' if n else 'design not legally routed'
        if lvl:
            note += f', congestion level {lvl}'
        return FAIL, ('place_congestion' if lvl and lvl >= 5 else 'route_unrouted'), note

    # Did we get the clock we asked for? A silently clamped or ignored
    # --clock.defaultFreqHz otherwise reads as a clean PASS at a frequency the
    # design never ran at, which is the one failure that would poison the whole
    # sweep rather than one point of it.
    got = timing.get('achieved_mhz')
    if request_mhz and got is not None and abs(got - request_mhz) > clock_tol_mhz:
        return FAIL, 'clock_mismatch', f'asked {request_mhz:.0f} MHz, got {got:.3f} MHz'

    wns = timing.get('kernel_wns')
    if wns is None:
        return UNKNOWN, 'no_reports', 'timing report unreadable'

    # At the default bar, Vivado's own sentence is required as well as the
    # slack number. It is not redundant: it also covers hold (WHS) and pulse
    # width (TPWS), so a design can have positive setup slack and still not be
    # legally timed. Below zero the caller has explicitly overridden Vivado's
    # bar, so slack alone governs -- otherwise the knob could never do anything.
    met = timing.get('constraints_met')
    if wns >= wns_threshold and (met or wns_threshold < 0.0):
        note = '' if met else f'WNS {wns:+.3f} ns, below Vivado\'s own bar'
        return PASS, '', note
    if wns >= -0.100:
        return MARGINAL, 'timing_wns', f'WNS {wns:+.3f} ns'
    return FAIL, 'timing_wns', f'WNS {wns:+.3f} ns'


def read_point(root, request_mhz=None, wns_threshold=0.0, lut_warn=90.0) -> dict:
    """Everything about one frequency point. Never raises."""
    root = Path(root)
    rec = {'dir': str(root), 'request_mhz': request_mhz}
    try:
        f = find_reports(root)
        timing = parse_timing_summary(f['timing'])
        kutil = parse_kernel_util(f['kernel_util'])
        sutil = parse_synth_util(f['synth_util']) if f['synth_util'] else {'ok': False, 'lut_pct': None}
        logs = scan_logs(f['logs'])
        logs['xo'] = f['xo']
        hls = scan_hls_log(f['hls_log'])
        verdict, reason, note = classify(timing, kutil, sutil, logs, hls,
                                         request_mhz, wns_threshold, lut_warn)
        rec.update(
            verdict=verdict, reason=reason, note=note,
            wns=timing.get('kernel_wns'), design_wns=timing.get('design_wns'),
            failing_endpoints=timing.get('failing_endpoints'),
            achieved_mhz=timing.get('achieved_mhz'),
            achieved_period_ns=timing.get('achieved_period_ns'),
            kernel_clock=timing.get('kernel_clock'),
            constraints_met=timing.get('constraints_met'),
            lut_used=kutil.get('lut_used'), lut_pct=kutil.get('lut_pct'),
            reg_pct=kutil.get('reg_pct'), bram_pct=kutil.get('bram_pct'),
            dsp_used=kutil.get('dsp_used'), dsp_pct=kutil.get('dsp_pct'),
            synth_lut_pct=sutil.get('lut_pct'),
            unrouted=logs.get('unrouted'), congestion=logs.get('congestion_level'),
        )
    except Exception as exc:                      # noqa: BLE001 -- see module docstring
        rec.update(verdict=UNKNOWN, reason='toolerror',
                   note=f'{type(exc).__name__}: {exc}')
    return rec


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument('root', help='a pl_fixed working tree (the one with _x/ in it)')
    ap.add_argument('--request-mhz', type=float, default=None)
    ap.add_argument('--wns-threshold', type=float, default=0.0)
    a = ap.parse_args()
    rec = read_point(a.root, a.request_mhz, a.wns_threshold)
    w = max(len(k) for k in rec)
    for k, v in rec.items():
        print(f'  {k:<{w}} : {v}')
    return 0 if rec['verdict'] == PASS else 1


if __name__ == '__main__':
    sys.exit(main())
