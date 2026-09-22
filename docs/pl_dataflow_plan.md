# PL dataflow pipelining — execution plan

> ## OUTCOME — done, 2026-09-22. Everything below is the plan as written on
> 2026-09-21; this block is what actually happened.
>
> **Shipped, on silicon, at 180 MHz.** Commits `fb85eab` (the restructuring) and
> `666eba8` (FIFO depths).
>
> | | sequential | dataflow | |
> |---|---|---|---|
> | board, µs/event @10k | 4,733.02 | **286.42** | **16.52×** |
> | ns/track, board | 94,662 | **5,728** | |
> | csynth interval | 17,078 cyc/track | **1,031** | `Pipeline Type: dataflow` |
> | cosim, 1 / 10 events | 852,035 / 8,519,639 | **68,981 / 532,949** | |
> | routed LUT | 407,628 (78.47%) | **391,213 (75.32%)** | smaller |
> | routed REG | 620,473 (59.69%) | **538,160 (51.77%)** | smaller |
> | routed BRAM | 200 (33.33%) | **183 (30.50%)** | smaller |
> | routed DSP | 289 (22.03%) | 308 (23.48%) | +19, addressing |
> | WNS | 0.000 ns | **+0.027 ns** | more slack |
> | dynamic power | 15.429 W | **13.744 W** | −10.9% |
> | energy | 73.03 mJ/event | **3.94 mJ/event** | **18.6×** |
> | accuracy, 27 outputs | 3.539e-04 | 3.539e-04 | unchanged |
>
> **Correctness: the board output is bit-identical to the sequential design's.**
> `max|diff| = 0.000e+00` over all 128,000 numbers, against both the native model
> and the archived pre-dataflow board run (`results/pl_fixed/hw_old/`).
> `rtda_timing.ipynb` reports 7/7, including cosim-vs-board at 286.4 vs 286.4.
>
> ### What was built, and how it differs from the plan
>
> Variant B (layer level), but **not** via §2's "DATAFLOW in the TrackLoop body".
> That shape needs state shared between concurrently running tasks. Instead every
> layer is a persistent process looping over all tracks of the call:
> `feed_tracks -> embed_stage -> solver0..2 -> event_mean -> output_stage ->
> write_result`, with a nested DATAFLOW region inside the embedding and each
> solver. `pl_fixed/pl/src/rtda_stage.h` holds the macros that build them.
>
> The roll moved INTO each solver, because solver k needs the previous track's
> copy of **its own input**. So the delay never crosses a channel, the graph is a
> feed-forward DAG, and it cannot deadlock at any FIFO depth. That also made
> plan changes #4 (warm-up masking) and #5 (event-boundary side-band flag)
> unnecessary: every process counts events with its own `(ev, j)` loop.
>
> Plan change #7 was **wrong**: `depth=2`, not 4. Above two, HLS stops using shift
> registers and spends 50 BRAM_18K on an 8,192-bit channel. Eleven channels at
> depth 4 cost +550 BRAM_18K for zero throughput, because the design already runs
> at the interval of one 128×128 dense at RF 1024.
>
> ### The one thing that cost a day
>
> **cosim generation takes ~1 h on a dataflow top, before the simulator starts.**
> The cause is RTL hierarchy size: hls4ml's `nnet::cast` is emitted as its own
> module instance 128× per dense layer — 2,203 of 2,369 nodes. Harmless while the
> top was sequential (it carried 2,296 of them); the testbench generator goes
> superlinear on a dataflow top. Module *count* is linear and is NOT the problem
> (97 modules 53 s, 181 91 s, 281 162 s). **There is nothing to fix — wait.** It
> was killed twice at 55 min in the belief it had hung; the 1-event run completes
> at 65 min and the 10-event at 95 min. Moving the DATAFLOW pragma down a level
> does not help (HLS propagates `ap_ctrl_chain` up anyway; tested).
>
> ### Still open
>
> * `freq_sweep/` results all predate this kernel and describe a different design.
> * Adding the AIE's axis on top — N tracks per beat as well as pipelined — is
>   untried. DSP is at 23%, so the headroom is there; LUT at 75% routed is the
>   binding constraint, so N=2 is probably the ceiling.


Written 2026-09-21. Every "measured" number below was read out of the shipped build's own
reports on this machine; every "target" number is an estimate derived from them and is not a
result until a build produces it.

**Goal.** The PL kernel runs one track through all 14 dense layers, then starts the next track.
Thirteen of the fourteen dense engines are idle at any instant. Overlapping tracks
(`#pragma HLS DATAFLOW`) makes them all work at once. No arithmetic changes, so **every output
must stay bit-identical**. That invariant is what makes this plan cheap to verify.

---

## 0. Baseline — what the design does today

`pl_fixed/rtda_split_hls/solution1/syn/report/rtda_split_top_csynth.rpt`, at 180 MHz:

| item | cycles | µs | Pipeline Type |
|---|---|---|---|
| one dense instance (128×128, RF 1024) | 1,027 | 5.71 | no |
| `embed_run` (2 dense) | 1,615 | 8.97 | no |
| `solver0/1/2_run` (5 dense each) | 4,968 | 27.6 | no |
| `output_run` | 453 | 2.52 | no |
| **TrackLoop, one track** | **16,931–17,078** | **94.9** | **Pipelined: no** |
| EventLoop, one update | 847,458–854,946 | 4,744 | no |

RTL co-simulation: 852,035 cycles for 1 event, 8,519,639 for 10 → 851,956 cycles/event =
**4,733.1 µs**, 17,039 cycles/track. Board, 10,000 events: **4,733 µs/update** — cosim and
silicon agree to 0.00 %.

Routed at 180 MHz: **LUT 78.5 %, FF 59.7 %, BRAM 33.3 %, DSP 22.0 % (289/1312), WNS 0.000 ns.**

### Targets

| variant | tasks | interval/track | throughput | update latency | vs now |
|---|---|---|---|---|---|
| now (measured) | 1 | 94.9 µs | 4,733 µs | 4,733 µs | — |
| **A** block-level | 5 | 27.6 µs | 1,380 µs | 1,448 µs | 3.4× |
| **B** layer-level | ~19 | ~6.1 µs | ~306 µs | ~390 µs | ~15× |

For scale, unchanged by this work: AIE-ML `fp32` 29.2 µs/update and 113.4 µs latency, `bf16`
11.6 µs and 31.2 µs (idle). Even variant B leaves the PL ~10× behind `fp32` and ~26× behind
`bf16` on throughput. **This work does not change the paper's conclusion; it removes an obvious
reviewer question about why the PL build is serial.**

---

## 1. Preconditions — do these before editing anything

1. **Stop or finish the frequency sweep first.** `freq_sweep/sweep_freq.py` rsyncs
   `pl_fixed/**` out of the repo *at the moment it provisions a point*. Editing these sources
   while a sweep is running silently changes what the next point builds, and the stamp will
   record the edited sources as if they were the shipped ones.
   ```bash
   pgrep -af 'sweep_freq|vitis_hls|v\+\+'      # must be empty, or wait
   ```
2. **Archive the baseline.** These are the files every later comparison is made against:
   ```bash
   cd ~/VersalPrjs/LDRD/final_rtda/rtda_demo
   D=results/pl_fixed/baseline_$(date +%Y%m%d); mkdir -p $D
   cp -r results/pl_fixed/hw results/pl_fixed/sim $D/
   cp pl_fixed/rtda_split_hls/solution1/syn/report/rtda_split_top_csynth.rpt $D/
   cp -r results/pl_fixed/cosim_ev1 results/pl_fixed/cosim_ev10 $D/ 2>/dev/null
   cp pl_fixed/build/ap16_3_hw/reports/*/imp/impl_1_kernel_util_routed.rpt $D/ 2>/dev/null
   ```
3. **Copy the files you will edit** (the top level for A, the proxies for B), so a diff is always available:
   ```bash
   cp pl_fixed/pl/src/rtda_split_top.cpp $D/rtda_split_top.cpp.orig
   cp -r pl_fixed/pl/src/*_proxy.cpp $D/
   ```
4. **Work in the tree you build in.** No git sync is assumed by this plan; whichever tree runs
   the builds must hold the edits.

---

## 2. Step 1 — variant A, block-level dataflow

Edit **`pl_fixed/pl/src/rtda_split_top.cpp` only**. The five hls4ml blocks and everything under
`pl_fixed/pl/firmware/` stay untouched.

### 2.1 What has to change, and why

| # | change | reason |
|---|---|---|
| 1 | Delete the blocking reads: `hidden_t emb_out = emb_out_s.read();` and the three like it. Wire each block's output stream into the next block's input. | A blocking read is a hard sequence point; HLS cannot start the next track while it waits. |
| 2 | Put `#pragma HLS DATAFLOW` in the `TrackLoop` **body**. | Turns the five calls into concurrent processes fed by FIFOs. |
| 3 | Replace the shared statics `emb_prev/s0_prev/s1_prev` + the `Shift` loop with a **per-stage one-token delay**: a small task in front of each solver that holds the vector it received last time and emits (current, previous). | Concurrent stages cannot share one array updated after all of them have run. The dependency is satisfiable: stage *k* needs stage *k−1*'s output for tracks *j* and *j−1*, and *j−1* was produced one interval earlier. |
| 4 | Make `Accumulate` **unconditional** and mask it: `acc[k] += keep ? (float)s2_out.data[k] : 0.0f`, with `keep = (j >= warmup)` computed upstream and carried with the token. | A conditionally executed task breaks the canonical form a dataflow region requires. |
| 5 | Carry the **event boundary** as a side-band flag with each track (`first_of_event`), and reset the delay registers when a flagged token arrives, instead of the global `if (reset)` before `TrackLoop`. | With several tracks in flight, two events can be inside the pipeline at once; a global reset would corrupt the trailing one. |
| 6 | Keep `EventLoop`, `InitAcc`, `Mean`, `output_run` and `Result` **outside** the dataflow region. | They run once per update, not per track; leaving them out keeps the region canonical. |
| 7 | Set explicit stream depths (`#pragma HLS STREAM depth=2`) on the inter-stage channels. | Depth 2 is ping-pong; deeper only if the report shows a stage starving. |

### 2.2 Gate A1 — bit-exactness (must pass before anything else)

C simulation compares the kernel against `pl_fixed/native/`, the bit-accurate model, which this
change does **not** touch. So the model is still the truth and the answer must not move at all.

```bash
source set_envs.sh
make -C pl_fixed csim EVENTS=3 WARMUP=3      # ~3 min   expect: PASS, worst 0.000e+00
make -C pl_fixed csim EVENTS=3 WARMUP=0      #          expect: PASS, worst 0.000e+00
```

`EVENTS=3` is the minimum that exercises two event boundaries — the part of this change most
likely to be wrong. **Anything other than `0.000e+00` means stop and fix; do not proceed to
synthesis.** If the two warm-up settings disagree, the fault is in change #4; if only the second
and third events are wrong, it is #5.

### 2.3 Gate A2 — synthesis

```bash
make -C pl_fixed csynth                      # ~5 h (measured 4h54m for the shipped design)
```

Read `rtda_split_hls/solution1/syn/report/rtda_split_top_csynth.rpt` and record:

- `TrackLoop` → **`Pipelined` must now say `dataflow`**, with an `Initiation Interval` near
  **4,968 cycles**. If it still says `no`, the region was not accepted — look for the
  "canonical form" warnings in `vitis_hls.log` and fix before spending a night on a link.
- DSP must stay **289**. Any increase means arithmetic was accidentally duplicated.
- LUT/FF/BRAM estimates: note them. The estimate for the shipped design is 163 % LUT against
  78.5 % routed, so treat it as a **relative** indicator only — compare it against the baseline
  estimate, not against 100 %.

### 2.4 Gate A3 — RTL co-simulation

Run **both** event counts: `rtda_timing.ipynb` uses the pair to separate the per-event cost from
the fixed per-call cost (today: 851,956 cycles/event and 79 cycles/call).

```bash
make -C pl_fixed cosim EVENTS=1  2>&1 | tee /tmp/cosim_ev1.log
make -C pl_fixed cosim EVENTS=10 2>&1 | tee /tmp/cosim_ev10.log
```

The notebook does **not** read the HLS project directory — it reads
`results/pl_fixed/cosim_ev<N>/`, which is assembled by hand and has no make target. File each
run exactly like the existing ones:

```bash
for N in 1 10; do
  D=results/pl_fixed/cosim_ev$N; mkdir -p $D
  cp pl_fixed/rtda_split_hls/solution1/sim/report/rtda_split_top_cosim.rpt $D/
  cp /tmp/cosim_ev$N.log $D/cosim_ev$N.log
done
```

Each log must carry its `tb events : <N>` line and `finished: PASS`; the notebook checks both and
raises if the count does not match the directory name.

Expected for variant A: about **248,000 cycles/event** (50 × 4,968 plus the tail), against
852,035 today. Record the exact numbers.

---

## 3. Step 2 — variant B, layer-level dataflow (only after A is green)

Do this as a **separate step with its own csim/csynth/cosim gates**, so that if it does not
route you still have a working A.

Edit `embed_proxy.cpp`, `solver0/1/2_proxy.cpp`, `output_proxy.cpp`:

1. Add `#pragma HLS DATAFLOW` inside each `*_run`.
2. Wrap the inline entry and exit copy loops (`for (i...) li.data[i] = ci.data[i];`) into small
   functions so the region is canonical.
3. The internal `hls::stream` channels between `nnet::dense` and `rtda::leaky_relu` already
   exist — hls4ml generated these blocks with `io_stream` — so no new plumbing is needed.

Same gates: `csim` must read `0.000e+00`; csynth must show each block as `dataflow` with an
interval near **1,030 cycles**; DSP still 289; cosim about **55,000 cycles/event**, filed into
`results/pl_fixed/cosim_ev{1,10}/` the same way.

---

## 4. Step 3 — hardware build

```bash
make system FLOW=pl_fixed TARGET=hw          # ~6-7 h
make check_image FLOW=pl_fixed TARGET=hw     # before flashing, always
```

Then check the routed reports before flashing anything:

```bash
grep -A5 'Slack' pl_fixed/build/ap16_3_hw/reports/*/imp/*timing_summary_routed.rpt | head
cat pl_fixed/build/ap16_3_hw/reports/*/imp/impl_1_kernel_util_routed.rpt
```

Record LUT / FF / BRAM / DSP and WNS against the baseline 78.5 / 59.7 / 33.3 / 22.0 % and
WNS 0.000 ns. **The shipped design closes with exactly zero slack**, so if timing fails, the
fallback is to drop `KERNEL_FREQ` (160 or 170 MHz) and rebuild — the pipelining gain is far
larger than the clock loss. Record which clock the shipped result used.

---

## 5. Step 4 — board run and scans

Flash `pl_fixed/package/ap16_3_hw/sd_card.img`, boot, then **on the board**:

```bash
sudo su
mount /dev/mmcblk0p1 /mnt && mount -o remount,rw /mnt && cd /mnt

RTDA_WARMUP=3 ./host_split.exe               # correctness: 1000 events, the three output files
./host_scan.exe                              # the performance scan
sync
```

The scan's knobs, all environment variables read by `host_scan.exe`:

| variable | default | what it sweeps |
|---|---|---|
| `RTDA_SCAN_EVENTS` | `1,10,100,1000,10000` | updates per call |
| `RTDA_SCAN_REPS` | `5` | repeats per point |
| `RTDA_SCAN_MODES` | `fresh,reuse,single` | buffer handling |
| `RTDA_SCAN_TPC` | `50,100,500,1000` | **tracks per call — the batch-size axis** |
| `RTDA_SCAN_TPC_CALLS` | `20` | calls per tracks-per-call point |

Run the defaults so the new scan is directly comparable to the archived one. The pipelined
design should show its gain in `us_kernel` at 10,000 events, and the tracks-per-call sweep is
where a pipeline that only fills up on long calls would reveal itself — with 19 stages the first
18 tracks of every call are fill, so **short calls will gain less than long ones**. That effect
is worth a figure.

Copy back to the build machine:

```bash
# on the build machine
make collect      FROM=/mnt/usb FLOW=pl_fixed TARGET=hw    # track_means_all, track_out_27, run_info
make collect_scan FROM=/mnt/usb FLOW=pl_fixed TARGET=hw    # scan.csv, scan_meta.txt
```

Correctness gate on silicon: the new `results/pl_fixed/hw/track_means_all.txt` must match the
archived baseline to float round-off, and `make fastsim FLOW=pl_fixed EVENTS=1000` (the native
model, untouched) remains the reference for both.

---

## 6. Step 5 — reproduce the whole analysis

The AIE-ML builds are not touched, so their results stay valid; only the PL numbers move.

```bash
source set_envs.sh

# 1. the reference and the native model (unchanged, but re-run so nothing is stale)
make golden TRACKS=50000
make selftest
make -C pl_fixed sweep   EVENTS=20                  # ~1 min  -> results/pl_fixed/sweep.npz
make fastsim FLOW=pl_fixed EVENTS=1000              # ~95 s   -> results/pl_fixed/sim/

# 2. notebooks, in this order
#    rtda_reference.ipynb  writes analysis/out/golden_onnx_50000.npz, needed by the next one
#    rtda_compare.ipynb    accuracy, three builds        (unchanged numbers expected)
#    rtda_scan.ipynb       latency/throughput scaling    (PL numbers change)
#    rtda_timing.ipynb     II, latency, cosim vs board   (PL numbers change)
#    rtda_quant_profile.ipynb  number-format study       (unchanged; no arithmetic changed)
cd analysis
for nb in rtda_reference rtda_compare rtda_scan rtda_timing rtda_quant_profile; do
  python3 -m jupyter nbconvert --to notebook --execute --inplace $nb.ipynb
done
```

`rtda_timing.ipynb` reads the **fresh** `rtda_split_top_csynth.rpt` out of `pl_fixed/` and the
cosim reports out of `results/pl_fixed/cosim_ev{1,10}/`, so run its cross-checks last and expect the PL line to move from
`17,039 cycles/track` to the new value. Its self-check must still print **7/7 passed** — in
particular `pl_fixed: cosim per event vs board us_kernel/event`, which is the gate that says the
RTL model and the silicon still agree.

### Files that must exist at the end

```
results/pl_fixed/baseline_<date>/          the archived "before"
results/pl_fixed/sim/{track_means_all.txt,track_out_27.txt,run_info.txt}
results/pl_fixed/hw/{track_means_all.txt,track_out_27.txt,run_info.txt}
results/pl_fixed/hw/{scan.csv,scan_meta.txt,scan_calls_10000.csv}
results/pl_fixed/hw/power_routed.rpt        re-exported from the new build
results/pl_fixed/sweep.npz
pl_fixed/rtda_split_hls/solution1/syn/report/rtda_split_top_csynth.rpt
results/pl_fixed/cosim_ev1/{rtda_split_top_cosim.rpt,cosim_ev1.log}
results/pl_fixed/cosim_ev10/{rtda_split_top_cosim.rpt,cosim_ev10.log}
pl_fixed/build/ap16_3_hw/reports/*/imp/impl_1_kernel_util_routed.rpt
pl_fixed/build/ap16_3_hw/reports/*/imp/*timing_summary_routed.rpt
analysis/out/*.png + analysis/out/timing_report.md
```

`tools/sync_results.sh <SRC_TREE>` moves this set between working trees.

### Numbers to update once the results are in

- `README.md` resource and timing tables, and the 94,663 ns/track cycle-accurate floor.
- `docs/paper_review.md` number audit.
- `freq_sweep/README.md` — the fabric floor and the "94,793 ns/track" headline change, and **any
  frequency-sweep point built before this change describes a different kernel**.
- `CLAUDE.md` — the PL paragraph, if the per-track figure moves.
- The paper: Sec. `sec:impl:pl` (the "one track at a time" sentence), the Results
  latency/throughput table, the energy figure, and the scaling figure's "+1.38 ms per block".

---

## 7. Risk register

| risk | how it shows | response |
|---|---|---|
| Dataflow region rejected (non-canonical) | `vitis_hls.log` warnings; `TrackLoop` still `Pipelined: no` in csynth | fix the form; do not link |
| Event-boundary flag wrong | csim fails on events 2–3 only | change #5 |
| Warm-up masking wrong | csim passes at `WARMUP=0`, fails at `3` | change #4 |
| Deadlock from stream depth | cosim hangs | raise `STREAM depth`; check single-producer/single-consumer |
| Timing fails at 180 MHz | WNS < 0 in the routed report | rebuild at 170 or 160 MHz; record it |
| Routing congestion | link fails; congestion level in the report | fall back to variant A, or lower the clock |
| Power up, energy gain smaller than hoped | new `power_routed.rpt` | report it as measured; the energy claim is an estimate until then |

**Rollback** is always: restore `rtda_split_top.cpp` (and the proxies) from
`results/pl_fixed/baseline_<date>/`, and rebuild. The archived results and reports make the old
numbers reproducible without a build.

---

## 8. Time budget

| step | cost |
|---|---|
| edit variant A | half a day to a day |
| csim ×2 | ~6 min |
| csynth | ~5 h |
| cosim | hours; measure it once |
| edit variant B | half a day |
| csim/csynth/cosim for B | ~5 h + cosim |
| `make system TARGET=hw` | 6–7 h |
| board run + scans | ~1 h |
| notebooks + writing up | half a day |

Two synthesis nights for A, two more for B, one build night for the bitstream.
