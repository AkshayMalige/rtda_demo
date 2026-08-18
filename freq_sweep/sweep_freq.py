#!/usr/bin/env python
"""Find the highest kernel clock the pl_fixed design still builds at.

    make -C freq_sweep dryrun     # every command, nothing run
    make -C freq_sweep mock       # the whole search against fake tools, ~1 min
    make -C freq_sweep sweep      # the real thing, hours per point

TWO CLOCKS, WHICH IS THE WHOLE REASON THIS EXISTS
`KERNEL_FREQ` in pl_fixed/Makefile reaches only `v++ --link
--clock.defaultFreqHz`. The HLS clock was a separate hardcoded 6.667 ns in
pl/rtda_split_project.tcl, so raising KERNEL_FREQ alone just re-times RTL that
was scheduled for 150 MHz -- and the shipped build closes at WNS +0.050 ns,
which leaves nothing to re-time into. Both are driven together here, through
RTDA_HLS_PERIOD (added to the TCL in the same env_or idiom it already used for
five other settings, defaulting to 6.667 so the shipped build is unchanged).

Raising the frequency therefore costs LUT: HLS pipelines harder to hold the
tighter period. The shipped design is at 75.95% and the 2026-08-14 build failed
to route at 98.87%, so this may find the design stops FITTING before it stops
CLOSING. Both outcomes are reported; neither is assumed.

THE SEARCH IS A LADDER, ON PURPOSE
Walk up the grid one frequency at a time and stop at the first one that fails.
csynth runs first and costs ~2 h; only if it succeeds is the ~2 h link spent.
So a frequency that HLS cannot schedule is rejected at half price, and the run
stops the moment something breaks rather than probing past it.

No bisection, no parallel bracketing. Those find the ceiling in fewer
wall-clock hours but they build frequencies you did not ask about, and when
one fails you cannot tell whether the next one down would have passed without
building it too. A ladder gives an unbroken chain of PASSes up to the first
FAIL, which is the thing you actually want to be able to state.

ISOLATION
Every Vivado and HLS output path in pl_fixed is CWD-relative and unstamped --
_x/, pl/ip/rtda_split.xo, rtda_split_hls/ (which does open_project -reset, i.e.
deletes the tree), .Xil/, .ipcache/, the logs. Two builds in one directory
destroy each other. Each point therefore gets its own rsync'd copy of the
sources under --root, outside the repo, and the repo's own build tree is never
written to. `--check-isolation` proves that rather than asserting it.

A FAILURE IS NOT A CEILING
Place and route is heuristic and seeded. One FAIL at 190 MHz does not prove
190 is impossible, so --confirm re-runs the boundary pair before the answer is
believed.
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parent
sys.path.insert(0, str(HERE))

import reports as R                                                # noqa: E402

DEFAULT_ROOT = Path('/home/synthara/VersalPrjs/LDRD/freq_sweep_work')
SHIPPED_MHZ = 150.0
# csynth reports 6335 cycles per track; ns/track = 6335 / f(GHz-scaled). At
# 150 MHz that is 42,233 ns, against 114,418 measured -- see README.md.
CSYNTH_CYCLES = 6335

# What to copy into an isolated tree. pl/ip is EXCLUDED on purpose: a copied
# .xo is a 150 MHz .xo, and linking it at another frequency is exactly the
# mistake this project exists to stop. Each point synthesises its own.
SYNC = [
    ('pl_fixed/Makefile', 'pl_fixed/Makefile'),
    ('pl_fixed/link.cfg', 'pl_fixed/link.cfg'),
    ('pl_fixed/gen_weights.py', 'pl_fixed/gen_weights.py'),
    ('pl_fixed/pl/src', 'pl_fixed/pl/src'),
    ('pl_fixed/pl/firmware', 'pl_fixed/pl/firmware'),
    ('pl_fixed/pl/weights', 'pl_fixed/pl/weights'),
    ('pl_fixed/pl/rtda_split_project.tcl', 'pl_fixed/pl/rtda_split_project.tcl'),
    ('pl_fixed/pl/Makefile', 'pl_fixed/pl/Makefile'),
    ('model', 'model'),          # gen_weights.py reads ../model/weights_fp32/
]

C = {'g': '\033[32m', 'r': '\033[31m', 'y': '\033[33m', 'b': '\033[1m', '0': '\033[0m'}
if not sys.stdout.isatty():      # a multi-hour run gets piped as often as watched
    C = dict.fromkeys(C, '')


def say(msg=''):
    print(msg, flush=True)


def hms(sec):
    return f'{int(sec // 3600)}h{int(sec % 3600 // 60):02d}m{int(sec % 60):02d}s'


# ---------------------------------------------------------------------------
#  The search
# ---------------------------------------------------------------------------

def ladder(known: dict, grid: list[float]) -> float | None:
    """The next frequency to try: the lowest one not yet known.

    Stops (returns None) as soon as anything has failed -- the ladder's whole
    point is that the first FAIL is the answer, so there is nothing above it
    worth four hours.
    """
    if any(v == R.FAIL for v in known.values()):
        return None
    for f in grid:
        if f not in known:
            return f
    return None


def boundary(known: dict):
    """(highest PASS, lowest FAIL) among what is known."""
    passed = [f for f, v in known.items() if v in (R.PASS, R.MARGINAL)]
    failed = [f for f, v in known.items() if v == R.FAIL]
    return (max(passed) if passed else None), (min(failed) if failed else None)


# ---------------------------------------------------------------------------
#  One build
# ---------------------------------------------------------------------------

def provision(root: Path, mhz: float, dry: bool) -> Path:
    """An isolated pl_fixed working tree for one frequency."""
    pt = root / f'f{mhz:g}'
    if dry:
        say(f'    mkdir -p {pt}')
        for src, dst in SYNC:
            say(f'    rsync -a --delete {REPO / src} -> {pt / dst}')
        return pt / 'pl_fixed'
    for src, dst in SYNC:
        s, d = REPO / src, pt / dst
        d.parent.mkdir(parents=True, exist_ok=True)
        if s.is_dir():
            if d.exists():
                shutil.rmtree(d)
            shutil.copytree(s, d, symlinks=True)
        elif s.is_file():
            shutil.copy2(s, d)
    return pt / 'pl_fixed'


def run_step(name, cmd, cwd, env, logfile, dry, timeout=None):
    """One tool invocation. Returns (rc, seconds)."""
    if dry:
        say(f'    [{name}] cd {cwd} && ' +
            ' '.join(f'{k}={v}' for k, v in sorted(env.items()) if k.startswith(('RTDA_', 'KERNEL'))) +
            ' ' + ' '.join(cmd))
        return 0, 0.0
    t0 = time.time()
    Path(logfile).parent.mkdir(parents=True, exist_ok=True)
    full = dict(os.environ)
    full.update(env)
    with open(logfile, 'ab') as fh:
        fh.write(f'\n===== {name} :: {" ".join(cmd)} =====\n'.encode())
        fh.flush()
        try:
            rc = subprocess.call(cmd, cwd=str(cwd), env=full, stdout=fh,
                                 stderr=subprocess.STDOUT, timeout=timeout)
        except subprocess.TimeoutExpired:
            fh.write(b'\n===== TIMEOUT, killed =====\n')
            rc = 124
        except OSError as exc:
            fh.write(f'\n===== could not exec: {exc} =====\n'.encode())
            rc = 127
    return rc, time.time() - t0


def build_point(mhz, args, logdir) -> dict:
    """csynth then link, at one frequency, in its own tree. Never raises."""
    period = 1000.0 / mhz
    hz = int(round(mhz * 1e6))
    log = Path(logdir) / f'f{mhz:g}.log'
    t0 = time.time()
    try:
        # A driver that died mid-build leaves a finished tree nobody recorded.
        # Rebuilding it costs four hours to learn what is already on disk, so
        # look before provisioning -- provisioning would delete the evidence.
        tree = Path(args.root) / f'f{mhz:g}' / 'pl_fixed'
        if not args.dry_run and tree.is_dir():
            found = R.read_point(tree, mhz, args.wns_threshold, args.lut_warn)
            if found['verdict'] in (R.PASS, R.MARGINAL) or found['reason'] not in (
                    '', 'no_reports'):
                found.update(mhz=mhz, period_ns=period, seconds=0.0,
                             stage='recovered', log=str(log), tree=str(tree),
                             note=(found.get('note') or '')
                                  + ' [recovered from an interrupted run]')
                return found

        tree = provision(Path(args.root), mhz, args.dry_run)
        env = {'RTDA_HLS_PERIOD': f'{period:.4f}'}

        rc, t_hls = run_step('csynth', ['make', 'kernels'], tree, env, log,
                             args.dry_run, args.timeout_hls)
        if rc != 0 and not args.dry_run:
            rec = R.read_point(tree, mhz, args.wns_threshold, args.lut_warn)
            if rec['verdict'] == R.PASS:              # rc lied; trust the reports
                rec['verdict'], rec['reason'] = R.FAIL, 'toolerror'
            if rec['reason'] in ('', 'no_reports'):
                rec['reason'] = 'hls_period_miss'
                rec['note'] = f'csynth exited {rc}'
            rec.update(mhz=mhz, period_ns=period, seconds=time.time() - t0,
                       stage='csynth', log=str(log), tree=str(tree))
            return rec

        rc, t_link = run_step('link', ['make', 'link', f'KERNEL_FREQ={hz}',
                                       'TARGET=hw'], tree, env, log,
                              args.dry_run, args.timeout_link)
        if args.dry_run:
            return {'mhz': mhz, 'period_ns': period, 'verdict': 'DRY',
                    'reason': '', 'note': '', 'seconds': 0.0, 'tree': str(tree),
                    'log': str(log), 'stage': 'dry'}

        rec = R.read_point(tree, mhz, args.wns_threshold, args.lut_warn)
        if rc != 0 and rec['verdict'] == R.PASS:
            rec['verdict'], rec['reason'] = R.FAIL, 'toolerror'
            rec['note'] = f'v++ exited {rc} despite clean reports'
        rec.update(mhz=mhz, period_ns=period, seconds=time.time() - t0,
                   stage='link', log=str(log), tree=str(tree), rc=rc)
        return rec
    except Exception as exc:                          # noqa: BLE001
        return {'mhz': mhz, 'period_ns': period, 'verdict': R.UNKNOWN,
                'reason': 'toolerror', 'note': f'{type(exc).__name__}: {exc}',
                'seconds': time.time() - t0, 'log': str(log), 'stage': 'driver'}


def harvest(rec, outdir: Path, dry: bool, keep_build: bool):
    """Copy the reports out, then delete the build tree.

    RESOURCES.md exists because `make clean` ate the only copy of a shipped
    build's reports; reference_may2026/ is a hand-made rescue of the previous
    ones. ~3.5 GB of Vivado project per point is not worth keeping, ~40 MB of
    reports is, and the choice must not be left to whoever cleans up later.
    """
    tree = Path(rec.get('tree', ''))
    dst = outdir / f'f{rec["mhz"]:g}'
    if dry:
        say(f'    harvest {tree}/_x/reports -> {dst}   then rm -rf {tree.parent}')
        return
    dst.mkdir(parents=True, exist_ok=True)
    got = R.find_reports(tree)
    for key in ('timing', 'kernel_util', 'synth_util'):
        p = got.get(key)
        if p and Path(p).is_file():
            shutil.copy2(p, dst / Path(p).name)
    for p in got.get('logs', [])[:2]:
        if Path(p).is_file():
            shutil.copy2(p, dst / f'log_{Path(p).name}')
    hls = tree / 'vitis_hls.log'
    if hls.is_file():
        shutil.copy2(hls, dst / 'vitis_hls.log')
    if Path(rec.get('log', '')).is_file():
        shutil.copy2(rec['log'], dst / 'driver.log')
    (dst / 'point.json').write_text(json.dumps(rec, indent=2, default=str))
    if not keep_build and tree.parent.is_dir():
        shutil.rmtree(tree.parent, ignore_errors=True)


# ---------------------------------------------------------------------------
#  Preflight and isolation
# ---------------------------------------------------------------------------

def manifest(root: Path) -> dict:
    """mtime+size of every file under root, for the isolation check."""
    out = {}
    for p in sorted(Path(root).rglob('*')):
        try:
            if p.is_file():
                st = p.stat()
                out[str(p.relative_to(root))] = f'{st.st_size}:{int(st.st_mtime)}'
        except OSError:
            continue
    return out


def preflight(args) -> list[str]:
    """Everything that can make a four-hour build die in the first second."""
    bad = []
    if not args.mock:
        for tool in ('v++', 'vitis_hls'):
            if shutil.which(tool) is None:
                bad.append(f'{tool} not on PATH -- source set_envs.sh first')
        plat = os.environ.get('PLATFORM', '')
        if not plat:
            bad.append('PLATFORM not set -- source set_envs.sh first')
        elif not Path(plat).is_file():
            bad.append(f'PLATFORM does not exist: {plat}')
    tcl = REPO / 'pl_fixed' / 'pl' / 'rtda_split_project.tcl'
    if 'RTDA_HLS_PERIOD' not in tcl.read_text(errors='replace'):
        bad.append(f'{tcl} has no RTDA_HLS_PERIOD -- the HLS clock cannot be set, '
                   'so every point would synthesise at 150 MHz')
    for src, _ in SYNC:
        if not (REPO / src).exists():
            bad.append(f'missing source: {REPO / src}')
    root = Path(args.root)
    try:
        root.mkdir(parents=True, exist_ok=True)
        free_gb = shutil.disk_usage(root).free / 2**30
        need = 4.0 * args.jobs + 2.0
        if free_gb < need:
            bad.append(f'{free_gb:.0f} GB free at {root}, need ~{need:.0f} GB for '
                       f'-j {args.jobs}')
    except OSError as exc:
        bad.append(f'cannot use --root {root}: {exc}')
    try:
        avail = int(next(l.split()[1] for l in open('/proc/meminfo')
                         if l.startswith('MemAvailable'))) / 2**20
        if not args.mock and avail < 18 * args.jobs:
            bad.append(f'{avail:.0f} GB RAM available, Vivado peaks at ~18 GB/impl '
                       f'so -j {args.jobs} wants {18 * args.jobs} GB')
    except (OSError, StopIteration, ValueError):
        pass
    if Path(args.root).resolve() == REPO.resolve() or REPO.resolve() in Path(args.root).resolve().parents:
        bad.append(f'--root {args.root} is inside the repo; builds must not be')
    return bad


# ---------------------------------------------------------------------------
#  Reporting
# ---------------------------------------------------------------------------

def _nspt(mhz):
    """csynth's 6335 cycles at f MHz, in ns."""
    return CSYNTH_CYCLES / mhz * 1000.0


def table(recs, wns_threshold):
    L = []
    L.append(f'{"f MHz":>7} {"period":>8} {"WNS ns":>9} {"LUT%":>7} {"DSP%":>6} '
             f'{"routed":>7} {"verdict":>9} {"ns/track":>10}  why')
    L.append('-' * 96)
    for r in sorted(recs, key=lambda r: r['mhz']):
        wns = f'{r["wns"]:+.3f}' if r.get('wns') is not None else '-'
        lut = f'{r["lut_pct"]:.2f}' if r.get('lut_pct') is not None else '-'
        dsp = f'{r["dsp_pct"]:.2f}' if r.get('dsp_pct') is not None else '-'
        routed = 'no' if r.get('reason') in ('route_unrouted', 'place_congestion') else (
            'yes' if r.get('lut_pct') is not None else '-')
        mark = '  <- shipped' if abs(r['mhz'] - SHIPPED_MHZ) < 1e-6 else ''
        why = (r.get('note') or r.get('reason') or '') + mark
        L.append(f'{r["mhz"]:7.0f} {1000.0 / r["mhz"]:8.3f} {wns:>9} {lut:>7} {dsp:>6} '
                 f'{routed:>7} {r["verdict"]:>9} {_nspt(r["mhz"]):10,.0f}  {why}')
    L.append('-' * 96)
    L.append(f'verdict bar: PASS = routed and WNS >= {wns_threshold:+.3f} ns; '
             f'MARGINAL = -0.100 <= WNS < bar; ns/track = {CSYNTH_CYCLES} cycles / f')
    return L


def write_results(recs, outdir: Path, args, elapsed):
    outdir.mkdir(parents=True, exist_ok=True)
    cols = ('mhz,period_ns,verdict,reason,wns,achieved_mhz,lut_used,lut_pct,reg_pct,'
            'bram_pct,dsp_used,dsp_pct,synth_lut_pct,unrouted,congestion,seconds,note')
    with (outdir / 'runs.csv').open('w') as fh:
        fh.write(cols + '\n')
        for r in sorted(recs, key=lambda r: r['mhz']):
            fh.write(','.join('' if r.get(k) is None else
                              str(r.get(k, '')).replace(',', ';')
                              for k in cols.split(',')) + '\n')

    passed = [r for r in recs if r['verdict'] in (R.PASS, R.MARGINAL)]
    best = max(passed, key=lambda r: r['mhz']) if passed else None
    lo, hi = boundary({r['mhz']: r['verdict'] for r in recs})

    L = ['# pl_fixed kernel-frequency sweep\n',
         'Generated by `freq_sweep/sweep_freq.py`. Every point re-runs HLS at the target',
         'period and then links at it, so this measures the design being *scheduled* for',
         'the frequency, not just re-timed at it.\n',
         f'- grid: {args.fmin:g}-{args.fmax:g} MHz, step {args.step:g}',
         f'- parallelism: -j {args.jobs}',
         f'- verdict bar: WNS >= {args.wns_threshold:+.3f} ns and routed',
         f'- wall clock: {hms(elapsed)}',
         f'- points built: {len([r for r in recs if r["mhz"] != SHIPPED_MHZ])}\n',
         '## Result\n']
    if best:
        gain = SHIPPED_MHZ and (best['mhz'] / SHIPPED_MHZ - 1) * 100
        L += [f'**Highest frequency that builds: {best["mhz"]:.0f} MHz** '
              f'(WNS {best["wns"]:+.3f} ns, LUT {best["lut_pct"]:.2f}%) '
              f'— {gain:+.0f}% on the shipped 150 MHz.\n',
              f'Fabric floor moves {_nspt(SHIPPED_MHZ):,.0f} -> {_nspt(best["mhz"]):,.0f} ns/track '
              f'(csynth {CSYNTH_CYCLES} cycles). The measured 114,418 ns/track at 150 MHz is '
              f'2.7x that floor, and this sweep does not change the 2.7x — only the floor.\n']
    else:
        L.append('No frequency above the shipped 150 MHz built successfully.\n')
    if lo is not None and hi is not None:
        L.append(f'Boundary bracketed: {lo:.0f} MHz builds, {hi:.0f} MHz does not.\n')
    L += ['## Points\n', '```'] + table(recs, args.wns_threshold) + ['```\n']
    L += ['## What this does not measure\n',
          '- Whether the faster bitstream is CORRECT on the board. It is the same RTL',
          '  semantics, but only a real run against the golden proves that.',
          '- Power, which rises with frequency and is not sampled here.',
          '- Seed variance. Place and route is heuristic: a single FAIL is evidence,',
          '  not proof. `--confirm` re-runs the boundary pair; without it, treat the',
          '  ceiling as approximate.\n']
    (outdir / 'freq_report.md').write_text('\n'.join(L))
    return outdir / 'freq_report.md'


# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--fmin', type=float, default=150.0)
    ap.add_argument('-j', '--jobs', type=int, default=1,
                    help='kept for preflight sizing; the ladder is serial')
    ap.add_argument('--fmax', type=float, default=250.0)
    ap.add_argument('--step', type=float, default=10.0)
    ap.add_argument('--root', default=str(DEFAULT_ROOT),
                    help='scratch root for build trees; must be outside the repo')
    ap.add_argument('--out', default=str(HERE / 'results'))
    ap.add_argument('--wns-threshold', type=float, default=0.0,
                    help='PASS bar. Slack is always recorded as measured; this only '
                         'chooses the word in the verdict column')
    ap.add_argument('--lut-warn', type=float, default=90.0)
    ap.add_argument('--timeout-hls', type=float, default=6 * 3600)
    ap.add_argument('--timeout-link', type=float, default=8 * 3600)
    ap.add_argument('--keep-build', action='store_true',
                    help='keep the ~3.5 GB Vivado tree per point')
    ap.add_argument('--dry-run', action='store_true')
    ap.add_argument('--mock', action='store_true',
                    help='fake vitis_hls/v++ -- rehearses the whole search in ~1 min')
    ap.add_argument('--check-isolation', action='store_true',
                    help='assert the repo was not written to')
    ap.add_argument('--yes', action='store_true',
                    help='required to actually build. Without it the run stops '
                         'after preflight, so a mistyped command cannot start '
                         'a four-hour csynth')
    ap.add_argument('--resume', action='store_true', default=True)
    ap.add_argument('--fresh', dest='resume', action='store_false')
    args = ap.parse_args()

    if args.mock:
        os.environ['PATH'] = f'{HERE / "mock_tools"}:{os.environ["PATH"]}'
        os.environ.setdefault('MOCK_DELAY_S', '0.2')

    outdir = Path(args.out)
    state_f = outdir / 'state.json'
    grid = []
    f = args.fmin
    while f <= args.fmax + 1e-9:
        grid.append(round(f, 6))
        f += args.step

    say(f'{C["b"]}pl_fixed kernel-frequency sweep{C["0"]}')
    say(f'  grid      {args.fmin:g}-{args.fmax:g} MHz step {args.step:g}  ({len(grid)} points)')
    say(f'  jobs      {args.jobs}')
    say(f'  root      {args.root}')
    say(f'  bar       WNS >= {args.wns_threshold:+.3f} ns, routed')
    say(f'  mode      {"MOCK" if args.mock else ("DRY-RUN" if args.dry_run else "REAL")}')
    say()

    bad = preflight(args)
    if bad:
        say(f'{C["r"]}preflight failed:{C["0"]}')
        for b in bad:
            say(f'  - {b}')
        return 2
    say(f'{C["g"]}preflight ok{C["0"]}\n')

    # Real builds only on request. Everything else here is safe to run by
    # accident; this is not, and a stray invocation costs hours.
    if not (args.dry_run or args.mock or args.yes):
        say(f'{C["y"]}stopping: this would start REAL builds '
            f'(~4 h each, serially).{C["0"]}')
        say('  rehearse it   : make mock')
        say('  see the plan  : make dryrun')
        say('  go ahead      : make sweep YES=1')
        return 0

    before = manifest(REPO / 'pl_fixed') if args.check_isolation else None

    recs: list[dict] = []
    if args.resume and state_f.is_file() and not args.dry_run:
        try:
            recs = json.loads(state_f.read_text())
            say(f'resuming: {len(recs)} point(s) already done '
                f'({", ".join(f"{r['mhz']:.0f}" for r in recs)})\n')
        except (OSError, ValueError):
            recs = []

    # The shipped build is a free data point: its reports are on disk.
    if not any(abs(r['mhz'] - SHIPPED_MHZ) < 1e-6 for r in recs):
        shipped = R.read_point(REPO / 'pl_fixed', SHIPPED_MHZ, args.wns_threshold)
        if shipped['verdict'] in (R.PASS, R.MARGINAL):
            shipped.update(mhz=SHIPPED_MHZ, period_ns=1000.0 / SHIPPED_MHZ,
                           seconds=0.0, note='from the shipped build already on disk')
            recs.append(shipped)
            say(f'seeded {SHIPPED_MHZ:.0f} MHz = {shipped["verdict"]} from the existing '
                f'build (WNS {shipped["wns"]:+.3f} ns, LUT {shipped["lut_pct"]:.2f}%)\n')

    logdir = outdir / 'logs'
    t_start = time.time()
    while True:
        known = {r['mhz']: r['verdict'] for r in recs}
        mhz = ladder(known, grid)
        if mhz is None:
            break
        say(f'{C["b"]}{mhz:g} MHz{C["0"]}  (period {1000.0 / mhz:.4f} ns)  '
            f'csynth ~2 h, then link ~2 h')
        if args.dry_run:
            build_point(mhz, args, logdir)
            harvest({'mhz': mhz, 'tree': f'{args.root}/f{mhz:g}/pl_fixed'},
                    outdir, True, args.keep_build)
            say('\n  (dry run: what comes next depends on this result, so the '
                'rest of the ladder cannot be shown)')
            return 0

        rec = build_point(mhz, args, logdir)
        col = {R.PASS: C['g'], R.MARGINAL: C['y']}.get(rec['verdict'], C['r'])
        say(f'  -> {col}{rec["verdict"]}{C["0"]} after {hms(rec["seconds"])} '
            f'at the {rec.get("stage", "?")} stage'
            f'{"  " + rec["note"] if rec.get("note") else ""}')
        harvest(rec, outdir, False, args.keep_build)
        recs.append(rec)
        state_f.parent.mkdir(parents=True, exist_ok=True)
        state_f.write_text(json.dumps(recs, indent=2, default=str))
        if rec['verdict'] == R.FAIL:
            say(f'\n  {mhz:g} MHz is the first failure. Stopping.')
        say()

    elapsed = time.time() - t_start
    say('\n'.join(table(recs, args.wns_threshold)))
    say()
    rpt = write_results(recs, outdir, args, elapsed)
    say(f'  -> {rpt}')
    say(f'  -> {outdir / "runs.csv"}')

    if args.check_isolation and before is not None:
        after = manifest(REPO / 'pl_fixed')
        changed = [k for k in set(before) | set(after) if before.get(k) != after.get(k)]
        if changed:
            say(f'\n{C["r"]}ISOLATION VIOLATED{C["0"]}: {len(changed)} file(s) under '
                f'pl_fixed/ changed:')
            for k in changed[:20]:
                say(f'  - {k}')
            return 3
        say(f'\n{C["g"]}isolation ok{C["0"]}: {len(before)} files under pl_fixed/ '
            f'unchanged (size+mtime)')

    passed = [r for r in recs if r['verdict'] in (R.PASS, R.MARGINAL)]
    if passed:
        best = max(passed, key=lambda r: r['mhz'])
        say(f'\n{C["b"]}highest frequency that builds: {best["mhz"]:.0f} MHz{C["0"]}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
