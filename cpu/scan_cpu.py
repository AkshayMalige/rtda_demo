#!/usr/bin/env python
"""The same event-count scan the two XRT hosts run, on the CPU.

WHAT THIS IS FOR
    aie_batch/host/host_scan.cpp and pl_fixed/host/host_scan.cpp sweep 1..10000
    events on the card and write results/<impl>/<target>/scan.csv. Nothing
    answered the obvious question next to them -- what does the same network
    cost on a CPU? -- so the accelerators were only ever compared to each other.
    This writes a byte-compatible scan.csv so the answer lands on the same axes.

WHAT IT RUNS
    model/rtda_ref.forward(roll='streaming'), which IS the reference. There is
    no fourth copy of the forward pass here; rtda_ref.py's own docstring exists
    because there used to be four and they drifted. forward() is already fully
    vectorised -- 14 np.matmul calls regardless of track count -- so this is a
    genuine BLAS-bound baseline, not a Python loop being timed.

    roll='streaming' matters. event_means(roll='circular') Python-loops per
    event, which at 10000 events is 140000 small GEMMs and would measure the
    interpreter rather than the machine.

TWO THINGS THAT MAKE THE NUMBER HONEST, both measured rather than assumed

    1. Every thread count uses the SAME chunk size. Run unchunked, 8 threads
       came out *superlinear* (9.6x) -- not parallelism, just cache: the
       1-thread run was streaming 20 MB activation arrays out of DRAM while
       each 8-thread worker fitted in L2. With a fixed CHUNK_EVENTS for all
       thread counts the scaling is an honest ~7.7x.

    2. Chunk boundaries are exact, not approximately exact. The receptive field
       is exactly 4 tracks deep -- embed is per-track, then one roll per solver
       -- so a chunk that starts WARMUP_TRACKS=3 tracks early and discards them
       reproduces the uninterrupted run bit for bit. --check asserts that with
       np.array_equal, not a tolerance. (forward() also takes an explicit
       carry=, but that would serialise the chunks, which is the whole point of
       not using it.)

BLAS threading is pinned to 1 before numpy is imported, so all parallelism is
this file's and the measurement does not depend on how the local BLAS happened
to be built. That matters here: the notebook env's OpenBLAS is capped at
MAX_THREADS=2 at build time, which would otherwise silently cap the scan.

    cpu/scan_cpu.py --stimulus testdata/embed_input_500000.txt --outdir results/cpu/native
    cpu/scan_cpu.py --check --events 20        # fp32 vs fp64, and the chunk proof

Go through `make`, not directly: set_envs.sh puts PetaLinux's numpy-less
python first on PATH.
"""
from __future__ import annotations

# Before numpy. Every one of these, because which is honoured depends on how
# the BLAS was built (the pthread build reads OPENBLAS_NUM_THREADS, the OpenMP
# build reads OMP_NUM_THREADS, and MKL ignores both).
import os
import sys as _sys
for _v in ('OPENBLAS_NUM_THREADS', 'OMP_NUM_THREADS', 'MKL_NUM_THREADS',
           'NUMEXPR_NUM_THREADS', 'VECLIB_MAXIMUM_THREADS'):
    os.environ[_v] = '1'

# ---------------------------------------------------------------------------
# glibc's allocator, and why this re-execs itself.
#
# forward() allocates a ~1.3 MB temporary per layer per chunk. glibc serves
# blocks above its mmap threshold with mmap and returns them with munmap, so
# every reuse re-faults every page -- and the threshold is DYNAMIC, so it
# adapts differently from run to run and the same scan is not reproducible.
#
# Measured, 10000 events, same code, same machine, minutes apart:
#
#            default          threshold raised
#     1T     442.9 us/ev      305.7 us/ev
#     8T      70.1             40.0
#    32T      84.7             16.1        <- 5.3x, and it looked like the CPU
#    sys      21.4 s            0.76 s        failing to scale past 16 threads
#
# Raising the threshold keeps those buffers on the heap where numpy reuses
# them. It is a host allocator setting, not a thumb on the scale: without it
# the plot reports glibc's fragmentation policy rather than what the network
# costs.
#
# These are read by glibc at process start, so setting os.environ here is too
# late -- hence the exec. Doing it in the Makefile instead would mean the
# number silently changed when someone ran the script directly.
# ---------------------------------------------------------------------------
MALLOC_ENV = {'MALLOC_MMAP_THRESHOLD_': '1073741824',
              'MALLOC_TRIM_THRESHOLD_': '1073741824'}
if os.environ.get('RTDA_CPU_MALLOC') != '1':
    os.environ.update(MALLOC_ENV)
    os.environ['RTDA_CPU_MALLOC'] = '1'
    try:
        os.execv(_sys.executable, [_sys.executable] + _sys.argv)
    except OSError as _e:                          # noqa: BLE001
        print(f'WARNING: could not re-exec to set the allocator ({_e});\n'
              '         timings will be noisy and up to 5x pessimistic.',
              file=_sys.stderr)

import argparse
import platform
import subprocess
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime, timezone
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
REPO = HERE.parent
sys.path.insert(0, str(REPO))
from model import rtda_ref as R          # noqa: E402
from model import weights as MW          # noqa: E402

TRACKS_PER_EVENT = R.TRACKS_PER_EVENT     # 50
H = R.H                                   # 128
OUT_DIM = R.OUT_DIM                       # 27
IN_FEATURES = R.IN_FEATURES               # 6
STRIDE = R.IN_PADDED                      # 8 columns on disk, 6 are real
WARMUP_TRACKS = R.WARMUP                  # 3 -- the receptive field, minus one

MACS_PER_TRACK = 264192                   # the convention every scan reports
CHUNK_EVENTS = 50                         # see "TWO THINGS", point 1

DTYPES = {'fp32': np.float32, 'fp64': np.float64}


# ---------------------------------------------------------------------------
#  Output, which is allowed to fail loudly and not otherwise
# ---------------------------------------------------------------------------

def write_text(path: Path, text: str) -> None:
    """Write or exit.

    pl_fixed/native/run_model.cpp carries the note about a full SD partition
    producing three 0-byte files while the host reported success. Same rule.
    """
    try:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)
        if path.stat().st_size == 0 and text:
            raise IOError('wrote 0 bytes')
    except Exception as exc:                       # noqa: BLE001
        print(f'ERROR: cannot write {path}: {exc}', file=sys.stderr)
        sys.exit(1)


COLUMNS = ('impl,variant,source,xclbin,stimulus,events,tracks,rep,launches,'
           'tracks_per_call,us_stage,us_h2d,us_kernel,us_d2h,us_execute,'
           'us_total,us_call_min,us_call_med,us_call_p95,us_call_max,'
           'us_modelled,ii_ns,macs_per_track,in_bytes,out_bytes,'
           'mean_checksum,mode,notes')


def fmt(v):
    if v is None:
        return ''
    if isinstance(v, float):
        return f'{v:.6g}'
    return str(v)


def write_csv(path: Path, rows) -> None:
    body = [COLUMNS]
    body += [','.join(fmt(v) for v in r) for r in rows]
    write_text(path, '\n'.join(body) + '\n')


# ---------------------------------------------------------------------------
#  The measured path
# ---------------------------------------------------------------------------

def stage(raw: np.ndarray, n_events: int, dtype, buf=None) -> np.ndarray:
    """The strided (n,8) -> contiguous (n,6) repack, in the run's dtype.

    The analogue of the XRT hosts' staging loop: both walk the stimulus with
    STRIDE 8 and write the 6 real features into the buffer the device reads.
    Timed the same way, and like them it excludes parsing the text file.

    `buf` is that buffer. Passing one is not an optimisation -- measured
    interleaved against fresh allocation it is worth nothing either way. It is
    here because both XRT hosts allocate their BOs ONCE, sized for the largest
    run, and re-stage into them, and the baseline should have the same shape.
    """
    n_tracks = n_events * TRACKS_PER_EVENT
    if buf is None:
        return np.ascontiguousarray(raw[:n_tracks, :IN_FEATURES], dtype=dtype)
    out = buf[:n_tracks]
    out[:] = raw[:n_tracks, :IN_FEATURES]
    return out


def alloc_stage(max_events: int, dtype) -> np.ndarray:
    """The staging buffer, allocated once and first-touched before any timing."""
    buf = np.empty((max_events * TRACKS_PER_EVENT, IN_FEATURES), dtype=dtype)
    buf[:] = 0                      # fault the pages in now, not mid-measurement
    return buf


def run_chunked(x, Wq, Bq, dtype, warmup, n_events, pool, chunk_events):
    """Event means for n_events, split across `pool`, with per-chunk times.

    Returns (means (n_events,128), [us per chunk]).
    """
    bounds = [(lo, min(lo + chunk_events, n_events))
              for lo in range(0, n_events, chunk_events)]
    times = [0.0] * len(bounds)

    def work(i):
        lo, hi = bounds[i]
        pre = WARMUP_TRACKS if lo > 0 else 0    # exact: see module docstring
        t0 = time.perf_counter()
        s2 = R.forward(x[lo * TRACKS_PER_EVENT - pre: hi * TRACKS_PER_EVENT],
                       roll='streaming', W=Wq, B=Bq, dtype=dtype)['s2']
        if pre:
            s2 = s2[pre:]
        per = s2.reshape(hi - lo, TRACKS_PER_EVENT, H)
        out = per[:, warmup:, :].mean(axis=1)
        times[i] = (time.perf_counter() - t0) * 1e6
        return out

    parts = list(pool.map(work, range(len(bounds))))
    return np.vstack(parts), times


def stats(xs):
    if not xs:
        return None, None, None, None
    a = np.sort(np.asarray(xs, dtype=np.float64))
    p95 = a[min(len(a) - 1, int(0.95 * len(a)))]
    return float(a[0]), float(np.median(a)), float(p95), float(a[-1])


# ---------------------------------------------------------------------------
#  Environment, recorded so the number is reproducible
# ---------------------------------------------------------------------------

def cpu_model() -> str:
    try:
        for line in Path('/proc/cpuinfo').read_text().splitlines():
            if line.startswith('model name'):
                return line.split(':', 1)[1].strip()
    except OSError:
        pass
    return platform.processor() or 'unknown'


def blas_name() -> str:
    try:
        cfg = np.__config__.show(mode='dicts')
        b = cfg.get('Build Dependencies', {}).get('blas', {})
        return f"{b.get('name', '?')} {b.get('version', '?')}"
    except Exception:                              # noqa: BLE001
        return 'unknown'


def git_hash() -> str:
    try:
        return subprocess.run(['git', '-C', str(REPO), 'rev-parse', '--short', 'HEAD'],
                              capture_output=True, text=True, timeout=10).stdout.strip() or '?'
    except Exception:                              # noqa: BLE001
        return '?'


def read_stimulus(path: Path):
    """Parse the text stimulus to (n_tracks, 8) float64. Timed but not scored."""
    t0 = time.perf_counter()
    flat = np.fromfile(str(path), dtype=np.float64, sep=' ')
    us = (time.perf_counter() - t0) * 1e6
    if flat.size % STRIDE:
        print(f'ERROR: {path} holds {flat.size} values, not a multiple of {STRIDE}',
              file=sys.stderr)
        sys.exit(1)
    return flat.reshape(-1, STRIDE), us


# ---------------------------------------------------------------------------
#  --check
# ---------------------------------------------------------------------------

def check(raw, n_events, warmup):
    """Prove the two properties the baseline rests on, and price fp32."""
    W, B = MW.load()
    print(f'  {n_events} events, warmup={warmup}\n')

    x64 = stage(raw, n_events, np.float64)
    ref = R.event_means(x64, roll='streaming', warmup=warmup, W=W, B=B)[0]

    ok = True
    with ThreadPoolExecutor(1) as p1:
        one, _ = run_chunked(x64, W, B, np.float64, warmup, n_events, p1, CHUNK_EVENTS)
    same = np.array_equal(one, ref)
    print(f'  chunked vs one un-split forward            '
          f'{"bit-identical" if same else "DIFFERS"}')
    ok &= same

    for n in (2, 4, 8):
        if n_events <= CHUNK_EVENTS:
            continue
        with ThreadPoolExecutor(n) as p:
            got, _ = run_chunked(x64, W, B, np.float64, warmup, n_events, p, CHUNK_EVENTS)
        same = np.array_equal(got, one)
        print(f'  {n} threads vs 1 thread                      '
              f'{"bit-identical" if same else "DIFFERS"}')
        ok &= same
    if n_events <= CHUNK_EVENTS:
        print(f'  (thread comparison needs > {CHUNK_EVENTS} events to split)')

    x32 = stage(raw, n_events, np.float32)
    with ThreadPoolExecutor(1) as p:
        m32, _ = run_chunked(x32, W, B, np.float32, warmup, n_events, p, CHUNK_EVENTS)
    d = np.abs(m32.astype(np.float64) - ref)
    scale = np.abs(ref).max()
    print(f'\n  fp32 vs fp64 event means   max|diff| {d.max():.3e}'
          f'   rel {d.max() / scale:.3e}')
    y32 = R.out27(m32, W, B, dtype=np.float32)
    y64 = R.out27(ref, W, B)
    dy = np.abs(y32.astype(np.float64) - y64)
    print(f'  fp32 vs fp64 27 outputs    max|diff| {dy.max():.3e}'
          f'   rel {dy.max() / np.abs(y64).max():.3e}')

    print(f'\n  {"PASS" if ok else "FAIL"}')
    return 0 if ok else 1


# ---------------------------------------------------------------------------

def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--stimulus', default=str(REPO / 'testdata' / 'embed_input_500000.txt'))
    ap.add_argument('--outdir', default=str(REPO / 'results' / 'cpu' / 'native'))
    ap.add_argument('--events', default=os.environ.get('RTDA_SCAN_EVENTS', '1,10,100,1000,10000'))
    ap.add_argument('--reps', type=int, default=int(os.environ.get('RTDA_SCAN_REPS', '5')))
    ap.add_argument('--threads', default=os.environ.get('RTDA_SCAN_THREADS', '1,2,4,8,16,32'))
    ap.add_argument('--dtype', default=os.environ.get('RTDA_CPU_DTYPE', 'fp32'), choices=list(DTYPES))
    ap.add_argument('--warmup', type=int, default=int(os.environ.get('RTDA_WARMUP', '3')))
    ap.add_argument('--chunk-events', type=int, default=CHUNK_EVENTS)
    ap.add_argument('--check', action='store_true')
    ap.add_argument('--check-events', type=int,
                    default=int(os.environ.get('RTDA_CHECK_EVENTS', '200')))
    a = ap.parse_args()

    stim = Path(a.stimulus)
    if not stim.exists():
        print(f'ERROR: stimulus not found: {stim}\n'
              f'       generate it with:  make stimulus TRACKS=500000', file=sys.stderr)
        return 1

    raw, us_read = read_stimulus(stim)
    avail = raw.shape[0] // TRACKS_PER_EVENT
    print(f'[cpu] {stim.name}: {raw.shape[0]} tracks = {avail} events '
          f'(parsed in {us_read / 1e6:.1f} s)')

    if a.check:
        return check(raw, min(a.check_events, avail), a.warmup)

    events = sorted({min(int(e), avail) for e in a.events.split(',') if e.strip()})
    threads = sorted({int(t) for t in a.threads.split(',') if t.strip()})
    dtype = DTYPES[a.dtype]
    outdir = Path(a.outdir)

    W, B = MW.load()
    Wq = {k: np.asarray(v, dtype=dtype) for k, v in W.items()}
    Bq = {k: np.asarray(v, dtype=dtype) for k, v in B.items()}

    write_text(outdir / 'scan_meta.txt', '\n'.join([
        'impl=cpu',
        f'variant={a.dtype}',
        'source=native',
        'kernel=model/rtda_ref.py forward(roll=streaming)',
        f'stimulus={stim.name}',
        f'stimulus_tracks={raw.shape[0]}',
        f'stimulus_events={avail}',
        f'us_stimulus_read={us_read:.2f}',
        f'dtype={a.dtype}',
        f'warmup={a.warmup}',
        f'chunk_events={a.chunk_events}',
        f'reps={a.reps}',
        'warmup_run=1',   # one untimed run per (threads, events) before the reps
        f'events_list={",".join(str(e) for e in events)}',
        f'threads_list={",".join(str(t) for t in threads)}',
        f'macs_per_track={MACS_PER_TRACK}',
        f'cpu_model={cpu_model()}',
        f'cores={os.cpu_count()}',
        f'python={platform.python_version()}',
        f'numpy={np.__version__}',
        f'blas={blas_name()}',
        'blas_threads=1',
        f'malloc_mmap_threshold={os.environ.get("MALLOC_MMAP_THRESHOLD_", "default")}',
        f'git_hash={git_hash()}',
        f'date_utc={datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")}',
        f'uname={platform.platform()}',
    ]) + '\n')

    # One buffer for the whole sweep, sized for the largest run -- see stage().
    stage_buf = alloc_stage(max(events), dtype)

    rows = []
    print(f'[cpu] dtype={a.dtype} warmup={a.warmup} chunk={a.chunk_events} '
          f'reps={a.reps}\n')
    print(f'  {"threads":>7} {"events":>7} {"us/event":>11} {"chunks":>7}')

    for nthr in threads:
        with ThreadPoolExecutor(nthr) as pool:
            # Touch the pool and the BLAS once so the first timed point is not
            # paying for thread creation and lazy allocation.
            warm = min(avail, a.chunk_events)
            run_chunked(stage(raw, warm, dtype, stage_buf), Wq, Bq,
                        dtype, a.warmup, warm, pool, a.chunk_events)
            for ev in events:
                n_chunks = (ev + a.chunk_events - 1) // a.chunk_events
                # One untimed run AT THIS SIZE before the timed repeats.
                # Without it the first repeat costs ~70 us/event against a
                # settled 40 at 8 threads / 10000 events, and that 70% outlier
                # became a 44% min..max "spread" that described the harness
                # rather than the machine. It is not the staging buffer --
                # shared and freshly-allocated were measured interleaved and
                # are identical -- it is the working set at that size.
                run_chunked(stage(raw, ev, dtype, stage_buf), Wq, Bq, dtype,
                            a.warmup, ev, pool, a.chunk_events)
                for rep in range(a.reps):
                    t_all = time.perf_counter()
                    ts0 = time.perf_counter()
                    x = stage(raw, ev, dtype, stage_buf)
                    us_stage = (time.perf_counter() - ts0) * 1e6

                    tk = time.perf_counter()
                    means, call_us = run_chunked(x, Wq, Bq, dtype, a.warmup,
                                                 ev, pool, a.chunk_events)
                    us_kernel = (time.perf_counter() - tk) * 1e6

                    us_total = (time.perf_counter() - t_all) * 1e6
                    lo, med, p95, hi = stats(call_us)
                    rows.append((
                        'cpu', f'{a.dtype}_t{nthr}', 'native', '', stim.name,
                        ev, ev * TRACKS_PER_EVENT, rep, 1, ev * TRACKS_PER_EVENT,
                        round(us_stage, 3), 0.0, round(us_kernel, 3), 0.0,
                        round(us_kernel, 3), round(us_total, 3),
                        lo, med, p95, hi,
                        None, None, MACS_PER_TRACK,
                        ev * TRACKS_PER_EVENT * IN_FEATURES * np.dtype(dtype).itemsize,
                        ev * H * np.dtype(dtype).itemsize + OUT_DIM * np.dtype(dtype).itemsize,
                        f'{float(means[-1].sum()):.8f}',
                        'single',
                        'no host-to-device transfer: host and compute are the same silicon',
                    ))
                    # Rewritten after every point, like both XRT hosts: a scan
                    # that dies at 10000 events still leaves the rest usable.
                    write_csv(outdir / 'scan.csv', rows)
                print(f'  {nthr:>7} {ev:>7} {us_kernel / ev:>11.2f} {n_chunks:>7}')

    print(f'\n[cpu] {len(rows)} rows -> {outdir / "scan.csv"}')
    return 0


if __name__ == '__main__':
    sys.exit(main())
