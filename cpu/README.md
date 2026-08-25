# The CPU baseline

The same 14-dense network as `aie_batch/` and `pl_fixed/`, run on the host, so
the two accelerators have something other than each other to be compared
against.

```bash
make -C cpu check       # correctness + what fp32 costs   (~10 s)
make -C cpu scan_host   # the 1..10000 event sweep        (~40 s)
```

No XRT, no Vitis, no card. It runs in a bare shell.

## What it runs

`model/rtda_ref.forward(roll='streaming')` — **the** reference, not a copy of
it. `rtda_ref.py` exists because there used to be four forward passes in this
repo and they drifted; this flow does not add a fifth.

`forward()` is already fully vectorised: 14 `np.matmul` calls regardless of
track count. That makes it a real BLAS-bound baseline rather than an
interpreter benchmark — but only via `roll='streaming'`.
`event_means(roll='circular')` Python-loops per event, which at 10,000 events
is 140,000 small GEMMs, and timing that would measure Python.

## Two things that make the number honest

Both are asserted by `make -C cpu check`, not assumed.

**Every thread count uses the same 50-event chunk.** Run unchunked, 8 threads
measured *superlinear* 9.6× — which is not parallelism, it is cache. The
1-thread run was streaming 20 MB activation arrays out of DRAM while each
8-thread worker fitted in L2. Fixing the chunk size across all thread counts
makes the comparison about threads. It costs the 1-thread number nothing:
chunked single-thread is *faster* than unchunked, for the same reason.

**Chunk boundaries are exact.** The receptive field is exactly 4 tracks deep —
embed is per-track, then one roll-concat per solver — so a chunk that starts 3
tracks early and discards them reproduces the uninterrupted run bit for bit.
`check` verifies this with `np.array_equal` against both a single un-split
`forward()` and the 1-thread result. `forward()` also accepts an explicit
`carry=`, which would be exact too, but it serialises the chunks and defeats
the point.

BLAS is pinned to one thread **before numpy is imported**, so all parallelism
is this flow's own. That is load-bearing: the notebook environment's OpenBLAS
is capped at `MAX_THREADS=2` at build time and would otherwise silently cap
the scan at 2 threads.

## fp32, not the reference's fp64

The comparison is against fp32 and bf16 hardware, and fp64 GEMM runs at half
the SIMD width — measured 2.24× slower here. `forward(dtype=np.float32)` is
what makes it comparable.

Passing float32 *weights* alone does not work. `x`, the `_pad_rows`
zero-extension and the `_roll_pair` zero head all default to float64 and drag
the chain straight back up; all four move together or none do. That is what the
`dtype=` argument added to `rtda_ref.forward()` is for. `dtype=None` is the
default and is exactly the old behaviour, so every golden still reproduces bit
for bit — `make selftest` is the gate.

Measured cost of fp32: **6.9e-07** relative on the event means, against bf16's
2.9e-04 and `ap_fixed<16,3>`'s 3.2e-05. It is free at this scale.

## What the number does and does not include

Included: the strided (n,8)→(n,6) stage, the forward pass, and the per-event
mean — the mean because AIE does it on-chip in `track_accum` and the PL kernel
does it too.

Excluded: parsing the text stimulus, exactly as both XRT hosts exclude it
(`us_stimulus_read` is recorded separately in `scan_meta.txt`).

Not applicable: `us_h2d` and `us_d2h` are 0. There is no device. Host and
compute are the same silicon, which is a real advantage the CPU has and the
plot should not pretend away — the accelerator numbers include XRT buffer syncs
and kernel launches driven by the VEK280's quad-A72 PS, while this runs on a
32-core EPYC at up to 3.8 GHz. That asymmetry is the point of the comparison,
not a flaw in it, but it has to be stated.

## Output

`results/cpu/native/scan.csv` — the identical 28-column header both XRT scan
hosts emit, so it drops into the existing notebook machinery.

- `impl=cpu`, `source=native`, `mode=single` (true: one call covers every event)
- `variant=fp32_t1 … fp32_t32` — the thread count rides in `variant`, which
  leaves `mode` meaning what it means for the other flows so `primary()` in
  `rtda_scan.ipynb` keeps working unchanged
- `us_call_*` is the per-chunk distribution

Read by `analysis/rtda_scan.ipynb` §9.

## The shape of the result, and one artefact worth knowing

At 10,000 events: **305 µs/event at 1 thread, 40.4 at 8, 16.7 at 32.**

Below 100 events the thread count stops mattering, and that is the chunk size
showing through, not the CPU: 100 events is 2 chunks, so nothing beyond 2
threads has anything to do. 10 events is a single chunk. The accelerators have
their own version of this — it is the fixed-cost region at the left of every
scan plot — but the cause here is different and should not be read as the CPU
failing to scale.
