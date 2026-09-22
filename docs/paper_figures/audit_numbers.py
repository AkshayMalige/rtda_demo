"""Re-derive every PL number in the Results figures from the raw artefacts, and
print where each one came from so it can be checked without trusting anyone.

    python3 docs/paper_figures/audit_numbers.py [REPO]

Nothing here is typed in by hand except the paths. Every value is parsed out of
a file on disk and the raw line it came from is printed next to it. Numbers that
are DERIVED rather than measured are labelled and their arithmetic is shown.

Run it after any rebuild. If a number in the figures or the docs disagrees with
this output, the figures are wrong.
"""
import re, sys
from pathlib import Path

REPO = Path(sys.argv[1] if len(sys.argv) > 1 else '.').resolve()
NS = 1e9 / 180e6                       # 180 MHz, see the check below
ok = True

def head(t):  print(f'\n{"="*78}\n{t}\n{"="*78}')
def src(f):   print(f'  source: {f}')
def raw(l):   print(f'     raw: {l.strip()[:110]}')
def val(k,v): print(f'    -> {k:<44s} {v}')
def derived(expr, v): print(f'    DERIVED  {expr}  =  {v}')
def fail(m):
    global ok; ok = False; print(f'    *** {m} ***')

def need(p):
    f = REPO / p
    if not f.exists(): fail(f'MISSING {p}'); return None
    return f

# --------------------------------------------------------------------------
head('0. THE CLOCK  (everything in cycles depends on it)')
f = need('pl_fixed/Makefile')
if f:
    src(f.relative_to(REPO))
    for l in f.read_text().splitlines():
        if re.match(r'^KERNEL_FREQ\s*\?=', l):
            raw(l); hz = int(re.search(r'(\d+)', l).group(1))
            val('KERNEL_FREQ', f'{hz:,} Hz = {hz/1e6:.0f} MHz -> {1e9/hz:.4f} ns/cycle')
            if abs(1e9/hz - NS) > 1e-6: fail('clock differs from the 5.5556 ns assumed')

# --------------------------------------------------------------------------
head('1. MEASURED: RTL co-simulation  (the interval and the pipeline fill)')
cos = {}
for ev in (1, 10):
    f = need(f'results/pl_fixed/cosim_ev{ev}/rtda_split_top_cosim.rpt')
    if not f: continue
    src(f.relative_to(REPO))
    for l in f.read_text().splitlines():
        if l.strip().startswith('|   Verilog'):
            raw(l)
            c = [x.strip() for x in l.split('|')]
            if c[2] != 'Pass': fail(f'cosim_ev{ev} status is {c[2]}, not Pass')
            cos[ev] = int(c[3]); val(f'cosim {ev:>2} event(s), latency', f'{cos[ev]:,} cycles')
    g = need(f'results/pl_fixed/cosim_ev{ev}/cosim_ev{ev}.log')
    if g:
        t = g.read_text(errors='replace')
        m = re.search(r'tb events\s*:\s*(\d+)', t)
        val('log says tb events', m.group(1) if m else 'NOT FOUND')
        if not m or int(m.group(1)) != ev: fail(f'log event count != {ev}')
        val('log says', 'finished: PASS' if 'finished: PASS' in t else '*** no PASS line ***')

if len(cos) == 2:
    per  = (cos[10] - cos[1]) / 9
    fill = cos[1] - per
    derived(f'interval = ({cos[10]:,} - {cos[1]:,}) / 9', f'{per:,.0f} cyc/event = {per*NS/1e3:.1f} us')
    derived(f'per track = {per:,.0f} / 50',               f'{per/50:,.1f} cyc = {per/50*NS:.0f} ns')
    derived(f'fill = {cos[1]:,} - {per:,.0f}',            f'{fill:,.0f} cyc = {fill*NS/1e3:.1f} us')
    chk = fill + per        # interval is ALREADY per event (50 tracks); do not scale it again
    derived('check: latency(1 event) = fill + interval',
            f'{chk:,.0f} cyc  vs measured {cos[1]:,} cyc'
            + ('  OK' if abs(chk - cos[1]) < 1 else '   *** MISMATCH ***'))
    if abs(chk - cos[1]) >= 1: fail('fill + interval != measured 1-event latency')

# --------------------------------------------------------------------------
head('2. MEASURED: csynth  (does the static schedule agree with cosim?)')
f = need('pl_fixed/rtda_split_hls/solution1/syn/report/rtda_split_top_csynth.rpt')
csy_per = None
if f:
    src(f.relative_to(REPO))
    txt = f.read_text(errors='replace')
    lat = next((l for l in txt.splitlines()
                if l.strip().startswith('|') and len(l.split('|')) == 9
                and l.split('|')[1].strip().isdigit() and l.split('|')[7].strip().isalpha()), None)
    if lat:
        raw(lat)
        c = [x.strip() for x in lat.split('|')]
        val('Pipeline Type', c[7] + ('' if c[7] == 'dataflow' else '   *** not dataflow ***'))
        if c[7] != 'dataflow': fail('top level is not a dataflow region')
        ev = re.search(r'LOOP_TRIPCOUNT min=(\d+) max=(\d+)',
                       (REPO/'pl_fixed/pl/src/rtda_split_top.cpp').read_text())
        lo, hi = int(ev.group(1)), int(ev.group(2))
        csy_per = (int(c[6]) - int(c[5])) / (hi - lo)
        derived(f'interval slope = ({int(c[6]):,} - {int(c[5]):,}) / ({hi} - {lo})',
                f'{csy_per:,.1f} cyc/event = {csy_per/50:,.1f} cyc/track')
    if len(cos) == 2 and csy_per:
        d = abs(csy_per - (cos[10]-cos[1])/9) / csy_per * 100
        val('csynth vs cosim', f'{d:.3f}% apart' + ('' if d < 1 else '   *** disagree ***'))
        if d >= 1: fail('csynth and cosim disagree by more than 1%')

# --------------------------------------------------------------------------
head('3. MEASURED: the board  (does silicon agree with cosim?)')
f = need('results/pl_fixed/hw/run_info.txt')
if f:
    src(f.relative_to(REPO))
    for l in f.read_text().splitlines():
        if re.match(r'^(events|us_per_track|ms_kernel|warmup)=', l):
            raw(l)
    d = dict(x.split('=', 1) for x in f.read_text().split())
    val('us per track (1000 events)', d.get('us_per_track'))
    val('us per event = ms_kernel/events*1e3', f"{float(d['ms_kernel'])/int(d['events'])*1e3:.2f}")

try:
    import pandas as pd
    f = need('results/pl_fixed/hw/scan.csv')
    if f:
        src(f.relative_to(REPO))
        df = pd.read_csv(f); s = df[(df['mode'] == 'single') & (df['events'] > 0)]
        g = s.groupby('events')[['us_execute', 'us_kernel']].median()
        g = g.div(g.index.to_series(), axis=0)
        for e in g.index:
            val(f'scan, {e:>5} events: us_kernel/event',
                f"{g.loc[e,'us_kernel']:.2f}    us_execute/event {g.loc[e,'us_execute']:.2f}")
        if len(cos) == 2:
            dev = (cos[10]-cos[1])/9 * NS/1e3
            b = g['us_kernel'].iloc[-1]
            val('cosim vs board @ largest run', f'{dev:.2f} vs {b:.2f}  ->  {abs(dev-b)/dev*100:.3f}% apart')
            if abs(dev-b)/dev > 0.01: fail('cosim and board disagree by more than 1%')
except ImportError:
    print('  (pandas unavailable -- skipping scan.csv)')

# --------------------------------------------------------------------------
head('4. MEASURED: correctness  (is the output the same as the old design?)')
def load(p):
    f = need(p)
    if not f: return None
    with open(f) as fh:
        n, k = (int(x) for x in fh.readline().split())
        import numpy as np
        return np.loadtxt(fh).reshape(n, k)
import numpy as np
hw, sim, old = load('results/pl_fixed/hw/track_means_all.txt'), \
               load('results/pl_fixed/sim/track_means_all.txt'), \
               load('results/pl_fixed/hw_old/track_means_all.txt')
if hw is not None and sim is not None:
    v = np.abs(hw-sim).max(); val('board vs native model, max|diff|', f'{v:.3e}')
    if v != 0: fail('board does not match the bit-accurate model')
if hw is not None and old is not None:
    v = np.abs(hw-old).max(); val('board vs PRE-DATAFLOW board, max|diff|', f'{v:.3e}')
    if v != 0: fail('board output changed against the old design')

# --------------------------------------------------------------------------
head('5. MEASURED: routed resources, timing and power')
f = need('pl_fixed/_x/ap16_3_hw/reports/link/imp/impl_1_kernel_util_routed.rpt')
if f:
    src(f.relative_to(REPO))
    for l in f.read_text().splitlines():
        if l.strip().startswith('| rtda_split_top '): raw(l); break
f = need('pl_fixed/_x/ap16_3_hw/link/vivado/vpl/prj/prj.runs/impl_1/route_report_timing_summary_0.rpt')
if f:
    src(f.relative_to(REPO))
    t = f.read_text(errors='replace').splitlines()
    for i, l in enumerate(t):
        if 'Design Timing Summary' in l:
            for m in t[i:i+12]:
                if re.match(r'\s+-?\d+\.\d+\s+-?\d+\.\d+\s+\d+', m):
                    raw(m); wns = float(m.split()[0]); val('WNS', f'{wns:+.3f} ns')
                    if wns < 0: fail('timing NOT met')
                    break
            break
for tag, p in (('new', 'results/pl_fixed/hw/power_routed.rpt'),
               ('old', 'results/pl_fixed/hw_old/power_routed.rpt')):
    f = need(p)
    if f:
        src(f.relative_to(REPO))
        for l in f.read_text().splitlines():
            if 'Dynamic (W)' in l: raw(l); val(f'{tag} dynamic power', l.split('|')[2].strip()); break

# --------------------------------------------------------------------------
head('6. DERIVED, NOT MEASURED  -- the per-solver-block numbers in res_scaling.png')
print("""  ONLY THE 3-BLOCK POINT IS MEASURED. No 1- or 2-block bitstream was ever
  built. The 1- and 2-block points are derived, exactly as they were in the
  version of this figure that predates pipelining. Two claims:

  (a) THROUGHPUT IS FLAT.  Arithmetic, not a fit: a dataflow interval is the
      MAX over stages, not the sum. Every dense below reports the same value,
      so adding or removing blocks of the same stages cannot move the max.
      It is conditional on a further block still fitting and closing timing.

  (b) LATENCY GROWS BY ~29 us PER BLOCK.  The measured fill, apportioned by
      structural share. The structural sum alone UNDERCOUNTS -- that was a
      real error in this figure until 0e01413.""")
tot = {}
for f, name in (('embed_stage_csynth.rpt','embed'), ('solver0_stage_csynth.rpt','solver0')):
    p = need(f'pl_fixed/rtda_split_hls/solution1/syn/report/{f}')
    if not p: continue
    src(p.relative_to(REPO)); acc = 0.0
    for l in p.read_text(errors='replace').splitlines():
        c = [x.strip() for x in l.split('|')]
        if len(c) >= 10 and c[1].endswith('_U0') and c[3].isdigit() and c[8].isdigit():
            per = int(c[8])/1000/50
            if per > 0:
                mark = '   (parallel with dense3 -- NOT on the critical path)' if c[1].startswith('s0_dense5') else ''
                print(f'       {c[1]:16s} {per:8.1f} cyc/track{mark}')
                if not mark: acc += per
    tot[name] = acc; val(f'{name} critical path', f'{acc:,.1f} cycles')
if len(tot) == 2 and len(cos) == 2:
    struct = tot['embed'] + 3*tot['solver0'] + 130
    fillm  = cos[1] - (cos[10]-cos[1])/9
    derived(f'structural total = {tot["embed"]:.0f} + 3x{tot["solver0"]:.0f} + ~130 (mean)', f'{struct:,.0f} cyc')
    derived(f'measured fill (section 1)', f'{fillm:,.0f} cyc')
    derived(f'unaccounted (AXI latency + handshakes) = {fillm-struct:,.0f}', f'{(fillm-struct)/fillm*100:.0f}% of the fill')
    derived(f'per block = {tot["solver0"]:.0f} x {fillm:.0f}/{struct:.0f}',
            f'{tot["solver0"]*fillm/struct:,.0f} cyc = {tot["solver0"]*fillm/struct*NS/1e3:.1f} us')



# --------------------------------------------------------------------------
# 7. EVERY HARDCODED CONSTANT IN make_results_figures.py, against its raw file.
#
# The figure script types its numbers in by hand. That is fine -- the values
# come from four different tools and there is no single CSV to read -- but it
# means a rebuild can silently leave a figure quoting the previous design, which
# is exactly what happened to every PL value between 2026-09-16 and 2026-09-22.
# This section is the guard: it re-reads each one and compares.
# --------------------------------------------------------------------------
head('7. CROSS-CHECK: the figure script vs the raw files')
fig = need('docs/paper_figures/make_results_figures.py')
if fig:
    src(fig.relative_to(REPO))
    ftxt = fig.read_text()

    def const(pat, cast=float):
        m = re.search(pat, ftxt)
        return cast(m.group(1)) if m else None

    def cmp_(label, claimed, actual, tol=5e-3):
        if claimed is None:   fail(f'{label}: not found in the figure script'); return
        if actual is None:    fail(f'{label}: no raw value to compare'); return
        good = abs(claimed - actual) <= tol * max(1.0, abs(actual))
        val(label, f'script {claimed:>10.3f}   file {actual:>10.3f}   '
                   + ('OK' if good else '*** MISMATCH ***'))
        if not good: fail(f'{label} disagrees with the raw file')

    # -- power, from each power_routed.rpt ---------------------------------
    def dynw(impl):
        p = REPO / f'results/{impl}/hw/power_routed.rpt'
        if not p.exists(): return None
        for l in p.read_text().splitlines():
            if 'Dynamic (W)' in l: return float(l.split('|')[2].strip())
        return None
    for impl, pat in (('aie_fp32', r"POW\s*=\s*\{'fp32':\s*([\d.]+)"),
                      ('aie_bf16', r"POW\s*=.*?'bf16':\s*([\d.]+)"),
                      ('pl_fixed', r"POW\s*=.*?'pl':\s*([\d.]+)")):
        cmp_(f'POW[{impl}] dynamic W', const(pat), dynw(impl))

    # -- PL device timing, from cosim --------------------------------------
    if len(cos) == 2:
        per = (cos[10] - cos[1]) / 9
        cmp_("THR['pl'] us/update", const(r"THR\s*=.*?'pl':\s*([\d.]+)"), per * NS / 1e3, 1e-3)
        cmp_("LAT['pl'] us latency", const(r"LAT\s*=.*?'pl':\s*([\d.]+)"), cos[1] * NS / 1e3, 1e-3)

    # -- board series, from each scan.csv ----------------------------------
    try:
        import pandas as pd
        def series(impl, col='us_execute'):
            p = REPO / f'results/{impl}/hw/scan.csv'
            if not p.exists(): return None
            df = pd.read_csv(p)
            keep = ((df['mode'] == 'gmio') & (df['launches'] == 1)) if impl.startswith('aie') \
                   else (df['mode'] == 'single')
            g = df[keep & (df['events'] > 0)].groupby('events')[[col]].median()
            return [round(v, 2) for v in g.div(g.index.to_series(), axis=0)[col].tolist()]

        for key, impl in (('fp32', 'aie_fp32'), ('bf16', 'aie_bf16'), ('pl', 'pl_fixed')):
            m = re.search(rf"'{key}':\s*\[([\d.,\s]+)\]", ftxt)
            claimed = [float(x) for x in m.group(1).split(',')] if m else None
            actual = series(impl)
            good = claimed is not None and actual is not None and \
                   all(abs(a - b) < 0.02 for a, b in zip(claimed, actual))
            val(f'board[{key}] (res_batch)', ('OK' if good else '*** MISMATCH ***')
                + f'   script {claimed}' + ('' if good else f'   file {actual}'))
            if not good: fail(f'board[{key}] disagrees with scan.csv')

        # CPU: the variant column is fp32_tN -- there is NO 'threads' column, and a
        # filter on one silently averages every thread count together.
        p = REPO / 'results/cpu/native/scan.csv'
        if p.exists():
            df = pd.read_csv(p)
            g = df[(df['variant'] == 'fp32_t8') & (df['events'] > 0)].groupby('events')[['us_kernel']].median()
            actual = [round(v, 2) for v in g.div(g.index.to_series(), axis=0)['us_kernel'].tolist()]
            m = re.search(r"cpu8\s*=\s*\[([\d.,\s]+)\]", ftxt)
            claimed = [float(x) for x in m.group(1).split(',')] if m else None
            good = claimed is not None and all(abs(a - b) < 0.02 for a, b in zip(claimed, actual))
            val('cpu8 (res_batch)', ('OK' if good else '*** MISMATCH ***') + f'   script {claimed}'
                + ('' if good else f'   file {actual}'))
            if not good: fail('cpu8 disagrees with the CPU scan')
    except ImportError:
        print('  (pandas unavailable -- skipping the board/CPU series)')

print(f'\n{"="*78}\n{"ALL CHECKS PASSED" if ok else "*** SOMETHING FAILED -- see the *** lines above ***"}\n{"="*78}')
sys.exit(0 if ok else 1)
