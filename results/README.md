# Results

Every run's output, one directory per implementation.

```
aie_fp32/    sim/  hw_emu/  hw/      AIE-ML, float32
aie_bf16/    sim/  hw_emu/  hw/      AIE-ML, bfloat16
pl_fixed/    sim/  hw_emu/  hw/      PL only, ap_fixed<16,3>
legacy/                              pre-restructure runs, see below
```

All of it is gitignored -- regenerable by definition. The READMEs are not.

## The file formats, which are the same for every implementation

| file | what |
|---|---|
| `track_means_all.txt` | `"<n_events> 128"` header, then one row of 128 floats per event. **The primary output.** The analysis applies the 128->27 output dense itself, so every implementation is compared through one copy of that arithmetic. |
| `run_info.txt` | `key=value`. Always carries `events`, `tracks`, `warmup`; hardware runs add timing, the PL runs add the ap_fixed format. |
| `track_out_27.txt` | the last event through the on-chip output dense, for a standalone check |
| `sim_<sim>_<prec>_<N>ev_<T>tr.npz` | AIE simulation only: event means, the golden, the stimulus, and the per-track taps (`emb_out`, `s0_out`, `s1_out`, `s2_out`) that a warm-up-excluded number needs |

**`warmup` in `run_info.txt` is not decoration.** It says whether the mean is
over all 50 tracks or over tracks 3..49, and comparing the wrong one against
the reference reports the roll convention (1.5e-02) as if it were arithmetic
error (3e-04). The notebooks read it rather than assume. See README.md.

## The performance scan: `scan.csv` + `scan_meta.txt`

Written by `host_scan.exe` (one per flow, built with `make scan_host FLOW=...`)
and copied off the board by hand into `results/<impl>/{hw,hw_emu}/` — the
destinations are listed in PHASE 7 of `RUNBOOK.md`. **A scan run writes neither
`track_means_all.txt` nor `run_info.txt`**, so it cannot be mistaken for a result
run, and `make collect` refuses it because the files it wants are not there.

Copy `scan_meta.txt` alongside `scan.csv` every time: the CSV has no xclbin, no
revision and no once-paid costs in it, and without those it is a column of numbers
attributable to nothing.

`scan.csv` is one row per measured point, with a header. Every implementation
writes the same 28 columns; a column an implementation cannot measure is left
**empty**, which pandas reads as NaN. That is the whole convention — there are no
per-implementation variants of this file.

| column | meaning |
|---|---|
| `impl` | `aie_fp32` \| `aie_bf16` \| `pl_fixed`. The AIE host derives it from `sysdata/config.txt`, so one binary labels both precisions correctly. |
| `variant` | `fp32`/`bf16` for AIE, the `ap<W>_<I>` string for PL |
| `source` | `hw` \| `hw_emu`, from the xclbin name. An emulation run mislabelled as silicon is the failure this exists to prevent. |
| `events`, `tracks` | the size of the point. `events=0` marks a row that is not an event sweep at all (the PL `tracks_per_call` diagnostic). |
| `rep` | repeat index. Points are repeated so the notebook can show min/median/max instead of a single number. |
| `launches` | device invocations for this point: `graph.run()` calls (AIE), kernel calls (PL) |
| `tracks_per_call` | tracks per invocation |
| `us_stage` | **host-side** input preparation: slot padding, the bf16 conversion (AIE), the strided repack (PL). Not device time. |
| `us_h2d` | AIE: time to *issue* the async transfers, not the transfer. PL: `bo_in.sync` to device. |
| `us_kernel` | AIE: `graph.run` + `graph.wait`. PL: kernel enqueue + `run.wait`. |
| `us_d2h` | AIE: `out_run.wait()` *after* `graph.wait()` — the un-overlapped tail of the output DMA. PL: both output syncs. |
| `us_execute` | the three device phases together |
| `us_total` | wall clock for the whole point, staging and bookkeeping included |
| `us_call_min/med/p95/max` | per-invocation distribution. PL only — one call per event gives a series; an AIE launch covers many events, so there is nothing to summarise and these are empty. |
| `us_modelled`, `ii_ns` | AIE only: `ii_ns * iterations`, the array's own time. `us_execute - us_modelled` is the launch and DMA overhead. Empty for PL, whose fabric estimate is a csynth number the host has no access to — the notebook applies it from one place. |
| `macs_per_track` | 264192, so throughput can be expressed without a wall clock |
| `in_bytes`, `out_bytes` | total moved for the point |
| `mean_checksum` | sum of the last event's 128 means. **A smoke value, not an accuracy number** — it exists so "the kernel returned zeros" cannot read as a very fast run. Constant across repeats at a given event count. |
| `mode` | impl-specific: AIE `gmio`; PL `fresh` (a new `xrt::run` per call, what the shipped host does), `reuse` (one run object, `start`/`wait` only), `tpc` (the tracks-per-call diagnostic) |
| `notes` | free text; empty in a clean run |

**The AIE has no H2D/D2H split and this file does not pretend otherwise.** Input
DMA, compute and output DMA overlap by design, and waiting on the input transfer
before `graph.run()` deadlocks — nothing drains the shim DMA until the graph
runs. `us_h2d` is therefore an *issue* cost and `us_d2h` is a *tail*. The PL
design, which is memory-mapped and synchronous, does have real per-phase numbers.
Comparing the two columns across implementations is the one thing not to do with
this file.

`scan_meta.txt` is `key=value`, once per run: the costs paid once
(`us_xclbin_open` ~240 ms, `us_rtp_load` ~6 ms, `us_stimulus_read`) plus
`xclbin`, `stimulus`, `stimulus_tracks`, `events_list`, `reps`, `git_hash`,
`date_utc`, `uname`. Keeping them here rather than in every row is the point: in
the shipped `run_info.txt` the 240 ms xclbin open sits inside a 1143 ms total and
swamps the 31 ms that is actually the design.

`scan_calls_<events>.csv` appears only with `RTDA_DUMP_CALLS=1`: one row per
kernel call, for the distribution plot.

Read by `analysis/rtda_scan.ipynb`.

## legacy/

Runs from before the restructure: the pre-precision-tag `sim_*.npz` (which the
notebooks' discovery would have had to disambiguate by filename), the per-event
`sim_mean_128_*.txt` text dumps that duplicate what is already inside each npz,
and `embed_input_2events.txt`. Kept because a `sim_events` run on the
aiesimulator costs 25 minutes; nothing reads them.

---

## Reproducibility fix — 2026-08-10

Running the 10k-track test twice back to back originally gave PASS then FAIL, with
**only event 0** wrong (2.5e-3). Cause: `roll_concat_batch`'s one-row `carry` is a
static initialised at ELF LOAD, not at `graph.run()`. A second run on an already
downloaded xclbin (`[drm] xclbin already downloaded to slot=0`) starts with the
previous run's leftover carry, so event 0's first track pairs with stale state.
Events 1..N are unaffected -- their predecessor comes from their own run.

Fix: the host prepends one all-zero **flush event** and discards its result. Zero
input slots produce bias-determined activations independent of history, so the
roll state is deterministic before the first real track. Verified numerically:
an arbitrary warm carry vs a cold carry gives `max|diff| = 0.000e+00`. Costs 7 of
1407 iterations (0.5%). `RTDA_NO_FLUSH=1` restores the old behaviour.

**Confirmed on hardware:** two consecutive runs now both PASS.


## Hardware (VEK280, TARGET=hw) — 2026-08-09

Track-count sweep, all events in a single `graph.run()`:

| tracks | events | per track | total execute | modelled AIE time | overhead |
|---:|---:|---:|---:|---:|---:|
| 50 | 1 | 12.700 us | 635 us | 29.1 us | 95.4% |
| 500 | 10 | 1.800 us | 900 us | 291.3 us | 67.6% |
| 5000 | 100 | 0.696 us | 3480 us | 2912.8 us | 16.3% |
| 10000 | 200 | **0.658 us** | 6578 us | 5825.7 us | **11.4%** |

A least-squares fit over all four points gives

    total = 583.0 us (fixed) + 595.6 ns x tracks

and every point reproduces to within 3.5%. Two conclusions:

**1. The marginal cost is 595.6 ns/track against a cycle-accurate prediction of
582.6 ns/track -- 2.2% agreement.** aiesimulator, hw_emu and silicon all agree; the
AIE does exactly what the model said.

**2. The 12.7 us/track at 50 tracks was never the array.** It is 583 us of fixed
per-`graph.run()` cost (XRT/driver round-trip, GMIO arming) spread over too few
tracks. At 50 tracks the array is busy 4.6% of the time; at 10000 it is 89%.

Sustained throughput at 10,000 tracks: **803 GOP/s**.
Versus `aieml/` at 17,770 ns/track: **27x measured, 29.8x on the marginal rate.**

Nothing in the design caps the event count -- host buffers are linear and small
(10,000 tracks = 717 KB in, 720 KB out). The ceiling is the DDR allocation, not
the array, and per-track cost keeps improving asymptotically toward 595.6 ns.

The fixed cost is host-side and cannot be reduced by the AIE design. For a
latency-bound single-event workload it dominates and would need separate work
(persistent graph, GMIO ping-pong without re-arming, or a PL-side feeder).

Reproduce:

    RTDA_INPUT=sd_batch/testdata/embed_input_5000.txt ./host_batch.exe
    RTDA_INPUT=sd_batch/testdata/embed_input_10000.txt \
    RTDA_GOLDEN=sd_batch/testdata/golden_10000.txt ./host_batch.exe

## hw_emu — 2026-08-08

Captured from a full `TARGET=hw_emu AIE_DIR=aieml_batch` run on QEMU: AIE graph +
XRT host, no PL kernels.

    hw_emu_track_mean_128.txt   the 128-wide event mean straight out of the AIE
    hw_emu_track_out_27.txt     after the host-side output dense (128 -> 27)

## Validation

| comparison | max abs diff |
|---|---:|
| hw_emu vs the x86/aie **simulation** | **8.4e-07** |
| hw_emu vs `data_fp32/aieml10_output_aie.txt` (mean over 50) | 5.0e-03 |
| **simulation** vs the same reference | 5.0e-03 |

The last two being identical is the point: hardware emulation introduces nothing.
The 5.0e-03 is entirely the warm-up convention — tracks 0-2 use the zero-pad roll
rather than the circular one, and those three are inside the 50-track average
(3 x ~0.21 / 50 gives up to 1.3e-02, so 5.0e-03 sits inside it). On tracks 3..49
the AIE agrees with the reference to 7.4e-06.

`aieml/` does not perform the circular wrap either on a single 50-track run, so
closing this gap would make the batched design diverge from the reference rather
than converge on it.

## Run log highlights

    [host] loading 92 RTP ports...
    [host] RTP loaded: 1039 KB
    [host] running graph: 7 iterations x 8 tracks (50 real + 6 padding)
    [host] event mean in frame 6 of 7        <- 50 counted, 6 padding dropped
    [host] done

Reproduce:

    make system TARGET=hw_emu AIE_DIR=aieml_batch
    cd package.hw_emu && ./launch_hw_emu.sh
    # in the guest: sudo su; mount /dev/mmcblk0p1 /mnt; cd /mnt; ./host_batch.exe
