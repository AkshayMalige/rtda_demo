#!/usr/bin/env python
"""The same event-count scan the XRT hosts and cpu/ run, on an NVIDIA GPU.

    scan_gpu.py --check          prove the numerics first, ~30 s
    scan_gpu.py                  the 1..10000 event sweep, ~2 min

WHAT IT RUNS
    gpu/rtda_torch.py, which is a transcription of model/rtda_ref.py checked
    against it at float64 on every --check (expect ~1e-15). Timing means
    nothing until that passes, so --check runs it for you before the sweep.

WHAT IS MEASURED, and why it matches the other flows
    Every flow in this repo reports ONE comparable row -- a single call
    covering the whole run -- and keeps its own overhead decomposition as
    diagnostics that the notebook's primary() filters out. AIE issues one
    graph.run() and measures launch cost separately; pl_fixed uses mode=single
    and keeps fresh/reuse/tpc aside. This does the same:

      mode=single   one H2D, one forward, one D2H for all N events.  PRIMARY.
      mode=fresh    one H2D + forward + D2H per event.  The batching
                    decomposition, exactly as pl_fixed measures it.
      mode=graph    identical maths, but the ~50 kernel launches are captured
                    once with a CUDA graph and replayed as one.  DIAGNOSTIC.

    Why mode=graph has to exist: one forward pass is ~50 kernels (3 per dense
    x 14, plus the roll-concat's slice and join x 3). That count is FIXED -- it
    does not grow with batch size -- so it is a floor per call.

    MEASURED ON AN L40S, and it overruled the guess. The floor was expected to
    be the host issuing those launches. It is not: the cuda-event column puts
    the GPU at 95% busy even at ONE event, with the host contributing ~25 us out
    of ~558. The cost is DEVICE-side per-kernel launch latency across 50 tiny
    kernels. mode=graph replays them as one and takes 558 -> 139 us. Same fix,
    different cause -- which is exactly why the control is measured rather than
    reasoned about. It is NOT plotted on the comparison figure, because no other
    implementation got a tuned variant there either.

    THE OTHER MEASURED SURPRISE: this GPU is fastest at 1000 events, not 10000.
    An L40S has 96 MB of L2 and one (n,128) fp32 activation is 25.6 MB at 1000
    events but 256 MB at 10000, so all 14 layers fall out of cache into GDDR6.
    fp32 degrades 2.2x, bf16 3.0x. Score this flow on its BEST point, not its
    largest run, or the number reported is a cache cliff.

THREE WAYS TO GET A WRONG GPU NUMBER, all handled here

    1. CUDA is ASYNCHRONOUS. perf_counter() around a torch call measures the
       launch, not the work. Every phase here is bracketed by
       torch.cuda.synchronize(), and the kernel phase is ALSO measured with
       cuda events so a disagreement between the two is visible in the CSV
       rather than silent.

    2. TF32. On this hardware torch can run "float32" matmuls on tensor cores
       at ~10 bits of mantissa. That is a ~1e-3 error where real fp32 gives
       ~1e-6 -- worse than bf16 -- while still being labelled fp32. Both
       backend flags are set explicitly per variant and recorded in
       scan_meta.txt. variant=tf32 is that mode, measured deliberately.

    3. A busy GPU. Someone else's job on the same card corrupts the number and
       your job corrupts theirs. The preflight refuses a device that is already
       in use; --force overrides it and is recorded in the notes column.

Results land in results/gpu/native/ in the same 28-column schema as every other
scan.csv, and are read by analysis/rtda_scan.ipynb section 8.
"""
from __future__ import annotations

import os
import sys as _sys

# Host-side BLAS pin: the staging path is numpy, and a BLAS that grabs every
# core adds noise to a measurement that is about a GPU. Before numpy/torch.
for _v in ('OPENBLAS_NUM_THREADS', 'OMP_NUM_THREADS', 'MKL_NUM_THREADS'):
    os.environ.setdefault(_v, '1')

# CUDA_VISIBLE_DEVICES is read when torch initialises CUDA, so --gpu has to be
# honoured BEFORE the import. Peeking at argv is uglier than argparse but it is
# the only thing that works without re-execing.
_gpu = None
for _i, _a in enumerate(_sys.argv):
    if _a == '--gpu' and _i + 1 < len(_sys.argv):
        _gpu = _sys.argv[_i + 1]
    elif _a.startswith('--gpu='):
        _gpu = _a.split('=', 1)[1]
if _gpu is None:
    _gpu = os.environ.get('RTDA_GPU', '3')
if _gpu != 'all':
    os.environ['CUDA_VISIBLE_DEVICES'] = str(_gpu)
os.environ.setdefault('PYTORCH_CUDA_ALLOC_CONF', 'expandable_segments:True')

import argparse                                            # noqa: E402
import hashlib                                             # noqa: E402
import platform                                            # noqa: E402
import subprocess                                          # noqa: E402
import sys                                                 # noqa: E402
import time                                                # noqa: E402
from datetime import datetime, timezone                    # noqa: E402
from pathlib import Path                                   # noqa: E402

import numpy as np                                         # noqa: E402
import torch                                               # noqa: E402

HERE = Path(__file__).resolve().parent
REPO = HERE.parent
if str(REPO) not in sys.path:
    sys.path.insert(0, str(REPO))

from model import rtda_ref as R                            # noqa: E402
from model import weights as MW                            # noqa: E402
import rtda_torch as T                                     # noqa: E402

TRACKS_PER_EVENT = R.TRACKS_PER_EVENT      # 50
H = R.H                                    # 128
OUT_DIM = R.OUT_DIM                        # 27
IN_FEATURES = R.IN_FEATURES                # 6
STRIDE = R.IN_PADDED                       # 8 columns in the stimulus, 6 real
MACS_PER_TRACK = 264192

# testdata/embed_input_500000.txt, which every other scan in this repo used.
# synth_tracks(seed=1234) reproduces it byte for byte -- verified against the
# committed file -- so the GPU server regenerates it in ~2 s instead of taking
# a 63 MB copy and a ten-minute text parse. The digest is asserted, not
# assumed: a numpy whose PCG64 stream ever changed would otherwise hand this
# flow a different-but-plausible stimulus and nothing would say so.
STIM_TRACKS = 500000
STIM_NAME = f'embed_input_{STIM_TRACKS}.txt'
STIM_SHA256 = 'ea2f544676c3a5089bb3a13541399c9889b8fafb55ec73b594ea1678a3dd572e'


# ---------------------------------------------------------------------------
#  Output
# ---------------------------------------------------------------------------

def write_text(path: Path, text: str) -> None:
    """Write or exit. A silent 0-byte result once cost an hour here."""
    try:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)
        if path.stat().st_size == 0 and text:
            raise IOError('wrote 0 bytes')
    except Exception as exc:                               # noqa: BLE001
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


def stats(xs):
    if not xs:
        return None, None, None, None
    a = np.sort(np.asarray(xs, dtype=np.float64))
    p95 = a[min(len(a) - 1, int(0.95 * len(a)))]
    return float(a[0]), float(np.median(a)), float(p95), float(a[-1])


# ---------------------------------------------------------------------------
#  The device, and refusing to share it
# ---------------------------------------------------------------------------

def smi(query, extra=()):
    try:
        out = subprocess.run(
            ['nvidia-smi', f'--query-gpu={query}',
             '--format=csv,noheader,nounits', *extra],
            capture_output=True, text=True, timeout=20)
        return [l.strip() for l in out.stdout.strip().splitlines() if l.strip()]
    except Exception:                                      # noqa: BLE001
        return []


def gpu_info():
    """Everything about the card that makes the number reproducible."""
    q = ('index,name,driver_version,memory.used,memory.total,utilization.gpu,'
         'clocks.sm,clocks.max.sm,power.limit,power.draw,temperature.gpu')
    rows = smi(q)
    # CUDA_VISIBLE_DEVICES remaps indices for torch but NOT for nvidia-smi, so
    # row 0 of this listing is the physical device only when it was not set.
    vis = os.environ.get('CUDA_VISIBLE_DEVICES')
    want = vis.split(',')[0] if vis else '0'
    for r in rows:
        f = [c.strip() for c in r.split(',')]
        if f and f[0] == want:
            return dict(zip(q.split(','), f))
    return {}


def preflight(force=False):
    """Refuse a card someone else is using. Both directions matter."""
    info = gpu_info()
    if not info:
        print('  NOTE: nvidia-smi gave nothing; skipping the busy-device check.')
        return {}, 'nvidia-smi unavailable'
    used = float(info.get('memory.used', 0) or 0)
    util = float(info.get('utilization.gpu', 0) or 0)
    print(f"  gpu {info.get('index')}: {info.get('name')}  "
          f"driver {info.get('driver_version')}  "
          f"{used:.0f}/{info.get('memory.total')} MiB used, {util:.0f}% busy, "
          f"{info.get('clocks.sm')}/{info.get('clocks.max.sm')} MHz, "
          f"{info.get('power.draw')}/{info.get('power.limit')} W, "
          f"{info.get('temperature.gpu')} C")
    busy = used > 500 or util > 0
    if busy and not force:
        print(f'\nERROR: GPU {info.get("index")} is already in use '
              f'({used:.0f} MiB, {util:.0f}%).\n'
              '  Measuring on a shared card corrupts this number AND whatever\n'
              '  else is running. Pick an idle one:  --gpu <n>\n'
              '  Current state:', file=sys.stderr)
        for r in smi('index,name,memory.used,utilization.gpu'):
            print('   ', r, file=sys.stderr)
        print('  Override only if you know it is yours:  --force', file=sys.stderr)
        sys.exit(1)
    return info, ('device shared, --force used' if busy else '')


# ---------------------------------------------------------------------------
#  Stimulus
# ---------------------------------------------------------------------------

def stimulus(cache_dir: Path, verify=True):
    """(n_tracks, 8) float64, identical to testdata/embed_input_500000.txt.

    Prefers the real file if it is beside the repo; otherwise regenerates and
    checks the digest. Caches .npy either way -- parsing the text costs minutes
    and this is not what the scan is measuring.
    """
    npy = cache_dir / f'{STIM_NAME}.npy'
    if npy.exists():
        t0 = time.perf_counter()
        a = np.load(npy)
        return a, (time.perf_counter() - t0) * 1e6, 'cached .npy'

    txt = REPO / 'testdata' / STIM_NAME
    if txt.exists():
        t0 = time.perf_counter()
        flat = np.fromfile(str(txt), dtype=np.float64, sep=' ')
        us = (time.perf_counter() - t0) * 1e6
        a = flat.reshape(-1, STRIDE)
        src = str(txt)
    else:
        t0 = time.perf_counter()
        a = R.synth_tracks(STIM_TRACKS, seed=1234)
        us = (time.perf_counter() - t0) * 1e6
        src = 'synth_tracks(seed=1234)'
        if verify:
            h = hashlib.sha256()
            flat = a.ravel()
            for i in range(0, flat.size, 1 << 16):
                h.update(''.join(f'{v:.9e}\n' for v in flat[i:i + (1 << 16)]).encode())
            got = h.hexdigest()
            if got != STIM_SHA256:
                print(f'ERROR: regenerated stimulus does not match the committed one.\n'
                      f'  expected {STIM_SHA256}\n  got      {got}\n'
                      '  The numpy PCG64 stream or model/weights_fp32/embed_input.txt\n'
                      '  differs here. Copy testdata/embed_input_500000.txt across\n'
                      '  instead of regenerating -- do not proceed with this one.',
                      file=sys.stderr)
                sys.exit(1)
            print(f'  stimulus regenerated and sha256 verified ({got[:16]}...)')
    try:
        cache_dir.mkdir(parents=True, exist_ok=True)
        np.save(npy, a)
    except OSError:
        pass
    return a, us, src


def stage(raw, n_events, dtype):
    """The strided (n,8) -> contiguous (n,6) repack, pinned for fast H2D.

    Exactly 6 columns: rtda_ref widens the WEIGHT to the input width rather
    than narrowing the input, so a padded input would change the summation
    length. See rtda_torch.py, detail 1.
    """
    n = n_events * TRACKS_PER_EVENT
    host = torch.from_numpy(
        np.ascontiguousarray(raw[:n, :IN_FEATURES], dtype=np.float32))
    host = host.to(dtype) if dtype != torch.float32 else host
    try:
        return host.pin_memory()
    except RuntimeError:
        return host


# ---------------------------------------------------------------------------
#  The measured path
# ---------------------------------------------------------------------------

def set_tf32(variant):
    """Explicit, both flags, every time. Never inherited from a torch default."""
    on = (variant == 'tf32')
    torch.backends.cuda.matmul.allow_tf32 = on
    torch.backends.cudnn.allow_tf32 = on
    if hasattr(torch, 'set_float32_matmul_precision'):
        torch.set_float32_matmul_precision('high' if on else 'highest')
    return on


ON_CUDA = False          # set once in main(); the timing path branches on it


def _sync():
    """Barrier. On CUDA this is what makes the timing real -- kernels are
    launched asynchronously, so perf_counter() without it measures the launch
    and not the work. On CPU it is a no-op and exists only so the harness can
    be smoke-tested without a card."""
    if ON_CUDA:
        torch.cuda.synchronize()


def _events():
    """A pair of cuda events, or (None, None) off-device."""
    if not ON_CUDA:
        return None, None
    return torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)


def _elapsed_us(e0, e1):
    return None if e0 is None else e0.elapsed_time(e1) * 1e3


def run_single(host, W, B, warmup, dev):
    """One H2D, one forward, one D2H. Returns (means_cpu, phase us, event ms)."""
    ev0, ev1 = _events()
    _sync(); t0 = time.perf_counter()
    x = host.to(dev, non_blocking=True)
    _sync(); t1 = time.perf_counter()
    if ev0 is not None:
        ev0.record()
    with torch.no_grad():
        means = T.event_means(x, W, B, warmup=warmup)
    if ev1 is not None:
        ev1.record()
    _sync(); t2 = time.perf_counter()
    out = means.to('cpu')
    _sync(); t3 = time.perf_counter()
    us = ((t1 - t0) * 1e6, (t2 - t1) * 1e6, (t3 - t2) * 1e6)
    return out, us, _elapsed_us(ev0, ev1)


def run_fresh(host, W, B, warmup, dev, n_events):
    """One H2D + forward + D2H per event -- the shape pl_fixed used to have."""
    h2d = ker = d2h = 0.0
    calls = []
    last = None
    for e in range(n_events):
        sl = host[e * TRACKS_PER_EVENT:(e + 1) * TRACKS_PER_EVENT]
        _sync(); t0 = time.perf_counter()
        x = sl.to(dev, non_blocking=True)
        _sync(); t1 = time.perf_counter()
        with torch.no_grad():
            m = T.event_means(x, W, B, warmup=warmup)
        _sync(); t2 = time.perf_counter()
        last = m.to('cpu')
        _sync(); t3 = time.perf_counter()
        h2d += (t1 - t0) * 1e6; ker += (t2 - t1) * 1e6; d2h += (t3 - t2) * 1e6
        calls.append((t2 - t1) * 1e6)
    return last, (h2d, ker, d2h), calls


class Graphed:
    """The ~50 launches of one forward, captured once and replayed as one.

    Capture needs static shapes and its own memory pool, so there is one of
    these per (variant, event count). Warm-up happens on a side stream first --
    capturing a cold cuBLAS handle fails or bakes in the wrong kernels.
    """

    def __init__(self, host, W, B, warmup, dev):
        self.static_in = torch.empty(host.shape, dtype=host.dtype, device=dev)
        self.static_in.copy_(host)
        s = torch.cuda.Stream()
        s.wait_stream(torch.cuda.current_stream())
        with torch.cuda.stream(s):
            with torch.no_grad():
                for _ in range(3):
                    T.event_means(self.static_in, W, B, warmup=warmup)
        torch.cuda.current_stream().wait_stream(s)
        _sync()
        self.g = torch.cuda.CUDAGraph()
        with torch.no_grad():
            with torch.cuda.graph(self.g):
                self.static_out = T.event_means(self.static_in, W, B, warmup=warmup)
        _sync()

    def __call__(self, host):
        ev0, ev1 = _events()
        _sync(); t0 = time.perf_counter()
        self.static_in.copy_(host, non_blocking=True)
        _sync(); t1 = time.perf_counter()
        ev0.record()
        self.g.replay()
        ev1.record()
        _sync(); t2 = time.perf_counter()
        out = self.static_out.to('cpu')
        _sync(); t3 = time.perf_counter()
        return out, ((t1 - t0) * 1e6, (t2 - t1) * 1e6, (t3 - t2) * 1e6), \
            _elapsed_us(ev0, ev1)


# ---------------------------------------------------------------------------
#  --check
# ---------------------------------------------------------------------------

def check(args, dev):
    print('\n--- 1. transcription: torch float64 on CPU vs model/rtda_ref.py ---')
    print('    (this is the gate. ~1e-15 means the network is transcribed')
    print('     correctly; anything larger is a bug, not a precision effect)\n')
    if T.self_test(args.check_events, 'cpu', 'fp64', args.weights, args.warmup):
        return 1
    if dev == 'cpu':
        print('\n(no CUDA device; stopping after the transcription gate)')
        return 0
    for v in args.variants:
        on = set_tf32(v)
        print(f'\n--- 2. {v} on {torch.cuda.get_device_name(0)} '
              f'(tf32 matmul={on}) ---\n')
        if T.self_test(args.check_events, 'cuda', v, args.weights, args.warmup):
            return 1
    print('\nfp32 should land near 1e-6. If it is nearer 1e-3, TF32 leaked in.')
    return 0


# ---------------------------------------------------------------------------

def main():
    ap = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('--gpu', default=os.environ.get('RTDA_GPU', '3'),
                    help='physical GPU index (default 3). Handled before torch imports.')
    ap.add_argument('--outdir', default=str(REPO / 'results' / 'gpu' / 'native'))
    ap.add_argument('--cache', default=str(HERE / '.cache'))
    ap.add_argument('--events', default=os.environ.get('RTDA_SCAN_EVENTS',
                                                       '1,10,100,1000,10000'))
    ap.add_argument('--reps', type=int, default=int(os.environ.get('RTDA_SCAN_REPS', '5')))
    ap.add_argument('--variants', default=os.environ.get('RTDA_GPU_VARIANTS',
                                                         'fp32,bf16,tf32'))
    ap.add_argument('--modes', default=os.environ.get('RTDA_SCAN_MODES',
                                                      'single,fresh,graph'))
    ap.add_argument('--warmup', type=int, default=int(os.environ.get('RTDA_WARMUP', '3')))
    ap.add_argument('--weights', default=None)
    ap.add_argument('--fresh-max-events', type=int, default=1000,
                    help='mode=fresh is O(events) launches; above this it is skipped')
    ap.add_argument('--force', action='store_true', help='use a busy GPU anyway')
    ap.add_argument('--allow-cpu', action='store_true',
                    help='run the sweep with no GPU. A HARNESS SMOKE TEST ONLY: '
                         'every row is stamped as such and --outdir is required, '
                         'so it can never be mistaken for a GPU measurement.')
    ap.add_argument('--check', action='store_true')
    ap.add_argument('--check-events', type=int, default=40)
    a = ap.parse_args()
    a.variants = [v.strip() for v in a.variants.split(',') if v.strip()]
    a.modes = [m.strip() for m in a.modes.split(',') if m.strip()]

    global ON_CUDA
    have_cuda = torch.cuda.is_available()
    ON_CUDA = have_cuda
    print(f'torch {torch.__version__}  cuda {torch.version.cuda}  '
          f'available={have_cuda}')
    if not have_cuda and a.allow_cpu and not a.check:
        # Deliberately awkward: the point of this path is to exercise the code,
        # and a CPU number filed as a GPU number would be worse than no number.
        if a.outdir == str(REPO / 'results' / 'gpu' / 'native'):
            print('ERROR: --allow-cpu refuses to write results/gpu/native/.\n'
                  '  Pass an explicit --outdir; this is not a GPU measurement.',
                  file=sys.stderr)
            return 1
        print('  *** SMOKE TEST: no GPU. Timings below are the host CPU. ***')
    elif not have_cuda:
        print('ERROR: no CUDA device visible to torch.\n'
              f'  CUDA_VISIBLE_DEVICES={os.environ.get("CUDA_VISIBLE_DEVICES")}\n'
              '  Check `nvidia-smi`, and that this torch is a CUDA build\n'
              '  (a +cpu wheel will never see a GPU).', file=sys.stderr)
        if not a.check:
            return 1
    info, note = ({}, '') if not have_cuda else preflight(a.force)
    dev = 'cuda' if have_cuda else 'cpu'
    if not have_cuda:
        note = 'SMOKE TEST ON HOST CPU -- NOT A GPU MEASUREMENT'

    if a.check:
        return check(a, dev)

    raw, us_read, src = stimulus(Path(a.cache))
    avail = raw.shape[0] // TRACKS_PER_EVENT
    print(f'  stimulus: {src}  {raw.shape[0]} tracks = {avail} events')

    events = sorted({min(int(e), avail) for e in a.events.split(',') if e.strip()})
    outdir = Path(a.outdir)

    # scan_meta BEFORE the first measurement, so an interrupted run is still
    # attributable. Same discipline as both XRT hosts.
    write_text(outdir / 'scan_meta.txt', '\n'.join([
        'impl=gpu',
        f'variant={",".join(a.variants)}',
        'source=native',
        'kernel=gpu/rtda_torch.py forward(roll=streaming)',
        f'stimulus={STIM_NAME}',
        f'stimulus_tracks={raw.shape[0]}',
        f'stimulus_events={avail}',
        f'stimulus_source={src}',
        f'stimulus_sha256={STIM_SHA256}',
        f'us_stimulus_read={us_read:.2f}',
        f'warmup={a.warmup}',
        f'reps={a.reps}',
        'warmup_run=1',
        f'events_list={",".join(str(e) for e in events)}',
        f'modes={",".join(a.modes)}',
        f'variants_list={",".join(a.variants)}',
        f'fresh_max_events={a.fresh_max_events}',
        f'macs_per_track={MACS_PER_TRACK}',
        f'gpu_model={info.get("name", "?")}',
        f'gpu_index={info.get("index", "?")}',
        f'driver={info.get("driver_version", "?")}',
        f'cuda={torch.version.cuda}',
        f'torch={torch.__version__}',
        f'sm_clock_mhz={info.get("clocks.sm", "?")}',
        f'sm_clock_max_mhz={info.get("clocks.max.sm", "?")}',
        f'power_limit_w={info.get("power.limit", "?")}',
        f'power_draw_idle_w={info.get("power.draw", "?")}',
        f'temp_idle_c={info.get("temperature.gpu", "?")}',
        f'host_cpu={platform.processor() or "?"}',
        f'python={platform.python_version()}',
        f'numpy={np.__version__}',
        f'git_hash={_git_hash()}',
        f'date_utc={datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")}',
        f'uname={platform.platform()}',
    ]) + '\n')

    rows = []
    print(f'\n  {"variant":>8} {"mode":>7} {"events":>7} {"us/event":>10} '
          f'{"h2d%":>6} {"ker%":>6} {"d2h%":>6}')

    for variant in a.variants:
        tf32 = set_tf32(variant)
        dt = T.TORCH_DTYPE[variant]
        W, B = T.load_weights(a.weights, device=dev, dtype=dt)

        for ev in events:
            host = stage(raw, ev, dt)
            for mode in a.modes:
                if mode == 'fresh' and ev > a.fresh_max_events:
                    continue
                graphed = None
                if mode == 'graph':
                    if not ON_CUDA:
                        print(f'  {variant:>8} {mode:>7} {ev:>7}   '
                              'cuda graphs need a GPU; skipped')
                        continue
                    try:
                        graphed = Graphed(host, W, B, a.warmup, dev)
                    except Exception as exc:               # noqa: BLE001
                        print(f'  {variant:>8} {mode:>7} {ev:>7}   '
                              f'capture failed: {type(exc).__name__}; skipped')
                        if ON_CUDA:
                            torch.cuda.empty_cache()
                        continue

                def once():
                    if mode == 'single':
                        m, us, kev = run_single(host, W, B, a.warmup, dev)
                        return m, us, [us[1]], kev
                    if mode == 'graph':
                        m, us, kev = graphed(host)
                        return m, us, [us[1]], kev
                    m, us, calls = run_fresh(host, W, B, a.warmup, dev, ev)
                    return m, us, calls, None

                once()                                     # untimed warm-up
                for rep in range(a.reps):
                    t_all = time.perf_counter()
                    means, (h2d, ker, d2h), calls, kev = once()
                    us_total = (time.perf_counter() - t_all) * 1e6
                    us_exec = h2d + ker + d2h
                    lo, med, p95, hi = stats(calls)
                    chk = float(means[-1].to(torch.float64).sum())
                    n_launch = ev if mode == 'fresh' else 1
                    notes = [note] if note else []
                    if mode == 'graph':
                        notes.append('cuda graph: ~50 launches replayed as 1')
                    if kev is not None:
                        notes.append(f'cuda_event_us={kev:.1f}')
                    rows.append((
                        'gpu', variant, 'native', '', STIM_NAME,
                        ev, ev * TRACKS_PER_EVENT, rep, n_launch,
                        (ev * TRACKS_PER_EVENT) // n_launch,
                        0.0, round(h2d, 3), round(ker, 3), round(d2h, 3),
                        round(us_exec, 3), round(us_total, 3),
                        lo, med, p95, hi,
                        None, None, MACS_PER_TRACK,
                        ev * TRACKS_PER_EVENT * IN_FEATURES * host.element_size(),
                        ev * H * 4 + OUT_DIM * 4,
                        f'{chk:.8f}',
                        mode,
                        '; '.join(notes),
                    ))
                    write_csv(outdir / 'scan.csv', rows)
                print(f'  {variant:>8} {mode:>7} {ev:>7} {us_exec / ev:>10.2f} '
                      f'{100 * h2d / us_exec:>6.1f} {100 * ker / us_exec:>6.1f} '
                      f'{100 * d2h / us_exec:>6.1f}')
                del graphed
                if ON_CUDA:
                    torch.cuda.empty_cache()

    print(f'\n[gpu] {len(rows)} rows -> {outdir / "scan.csv"}')
    after = gpu_info()
    if after:
        print(f'  after: {after.get("clocks.sm")} MHz, '
              f'{after.get("power.draw")} W, {after.get("temperature.gpu")} C '
              '(compare sm_clock_max_mhz in scan_meta -- a throttled run shows here)')
    return 0


def _git_hash():
    try:
        return subprocess.run(['git', '-C', str(REPO), 'rev-parse', '--short', 'HEAD'],
                              capture_output=True, text=True, timeout=10).stdout.strip() or '?'
    except Exception:                                      # noqa: BLE001
        return '?'


if __name__ == '__main__':
    sys.exit(main())
