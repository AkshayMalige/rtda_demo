# RTDA AIE-ML — float32 vs int16 performance report

Post-fix measurements (commit `caeb995`), **50 input tracks in both runs**.

- Sources: `aieml_float32/` and `aieml_int16/` (fresh `make aie_sim_hw` runs, `--target=hw` + `aiesimulator`)
- Clock: **800 ps/cycle (1.25 GHz)** — confirmed against total sim time in both runs
- Both snapshots verified to carry the committed kernels (`roll_concat.cpp` and `bias_relu_fused.cpp` byte-identical to `HEAD`)
- Both emit 6400 samples = 50 × 128 → aggregate numbers are directly comparable

---

## 0. How to reproduce / verify

```bash
source set_envs.sh

# Open the run in Vitis Analyzer (Summary + Profile views)
vitis_analyzer aieml_int16/aiesimulator_output/default.aierun_summary

# Convert the VCD to a waveform database for the trace view
vcdanalyze --pkg-dir aieml_int16/Work --vcd aieml_int16/foo.vcd --wdb
#   -> writes ./trdata.aiesim/
```

**Three things to know before cross-referencing:**

| | |
|---|---|
| **Coordinate systems differ.** | Profile files are named in **CR (mapping-report) coords**: `profile_funct_<col>_<row>.txt`. The VCD and waveform use `array.tile_<col>_<row+3>`. **VCD row = CR row + 3.** Verified: `profile_funct_31_0.txt` internally names `array.tile_31_3`. |
| **Placement differs per build.** | The output PLIO DMA is on a *different tile* in each build. Always re-read `Work/reports/graph_mapping_analysis_report.txt` and `Work/reports/DMA_report.txt` for the run you are looking at — do not carry a tile number across builds. |
| **`default.aierun_summary` holds absolute paths.** | The copies in `aieml_*/` still point at `aieml/aiesimulator_output/...`. Opening a copy may silently resolve to whatever is currently in `aieml/`. If the numbers look wrong, that is the first thing to check. |

Tile locations for these two runs (derived from each build's own reports):

| | float32 | int16 |
|---|---|---|
| Input buffer `buf0` | `MG(2,0)` → **`tile_2_3`** | `MG(2,1)` → **`tile_2_4`** |
| Output buffer `buf63` → PLIO | `MG(31,0)` → **`tile_31_3`** | `MG(32,2)` → **`tile_32_5`** |
| Output DMA | `mm2s_state0`, ch 0, lockID 1 | `mm2s_state0`, ch 0, lockID 2 |

---

## 1. Headline

| | float32 | int16 | ratio |
|---|---:|---:|---:|
| **Time per track (II)** | **17.770 µs** (22,212 cyc) | **0.918 µs** (1,147 cyc) | **19.4×** |
| **Track rate** | 56.3 k/s | **1,089.8 k/s** | 19.4× |
| **Full run, 50 tracks** | **1,152.53 µs** | **76.88 µs** | **15.0×** |
| PLIO throughput (simulator) | 29.386 MBps | 283.377 MBps | 9.6× |
| II jitter (min–max) | 22,202–22,522 cyc | 1,125–1,469 cyc | — |
| Wall-clock simulation time | 5,474 s | 471 s | — |

> **Verify:** total sim time and PLIO MBps — `tail aieml_<p>/AIESimulator.log` (the `Total Simulation time` line and the `| plio | embed_output | OUT |` table), or the **Summary** page in Vitis Analyzer; also `aieml_<p>/throughput_info.json`.

**Why the full-run ratio (15.0×) is smaller than the per-track ratio (19.4×):** pipeline fill is a larger share of the int16 run — 32.4% of 76.88 µs vs 23.8% of 1,152.53 µs.

**Independent cross-check of II** (my II vs the simulator's own throughput number):

| | bytes/track | II | implied | simulator says |
|---|---:|---:|---:|---:|
| float32 | 512 | 17.770 µs | **28.81 MB/s** | 29.386 MBps |
| int16 | 256 | 0.9176 µs | **279.0 MB/s** | 283.377 MBps |

> **Verify:** the small gap is expected — the simulator averages over the first-to-last-sample window, this report measures steady-state II. Both differ in the same direction and by the same ~2%, which is what validates the method.

---

## 2. Latency

| | float32 | int16 | ratio |
|---|---:|---:|---:|
| **Fill latency** (track 1 in → out) | **274.86 µs** (343,575 cyc) | **24.93 µs** (31,162 cyc) | 11.0× |
| in→out latency, mean over 50 tracks | 420.55 µs | 30.83 µs | 13.6× |
| in→out latency, min / max | 274.86 / 441.09 µs | 24.93 / 32.68 µs | — |
| Input vector accepted every | 14.378 µs (17,972 cyc) | 0.759 µs (949 cyc) | 18.9× |
| First output at | 277.23 µs | 27.46 µs | — |
| Last output at | 1,147.96 µs | 72.42 µs | — |

> **Verify:** these come from the VCD only — rising edges of `array.<outtile>.mm.dma.mm2s_state0.finished_bd` (50 events) and `array.<intile>.mm.dma.s2mm_state0.finished_bd` (50 events). In the waveform, add those two signals and measure edge-to-edge; the first output edge should land at 27.46 µs (int16) / 277.23 µs (float32).

The in→out mean exceeds the fill latency in both because inputs arrive faster than tracks drain (input period < II), so later tracks queue behind the pipeline. **Neither run is input-limited.**

---

## 3. Stalls

Core `cm.proc.core_status.*` integrated over all 60 kernel cores:

| stall class | float32 (cyc/track) | int16 (cyc/track) | ratio |
|---|---:|---:|---:|
| **lock** | **765,372** | **35,549** | 21.5× |
| cascade (`acc_stream_stall_MCD/SCD`) | 17,327 | 286 | 60.6× |
| memory (bank conflict) | 113 | 87 | — |
| stream (`MS0`/`SS0`) | **0** | **0** | — |
| **total** | **782,811** | **35,922** | **21.8×** |

> **Verify:** VCD signals `array.tile_C_R.cm.proc.core_status.{lock_stall_N/S/E/W, memory_stall_*, stream_stall_MS0/SS0, acc_stream_stall_MCD/SCD}`. In the waveform after `vcdanalyze --wdb`, the per-core **Active** track encodes these as `66=mem stall, 67=lock stall, 68=stream stall, 6a=acc stream stall` (see the enum table in `system.wcfg`).

DMA-level, summed over all tiles:

| | float32 (cyc/track) | int16 (cyc/track) |
|---|---:|---:|
| stream_starvation | 346,010 | 24,148 |
| stalled_lock_acquire | 214,890 | 17,188 |
| stream_backpressure | 41,228 | 564 |
| memory_starvation | 24 | 28 |

> **Verify:** `array.tile_C_R.mm.dma.{mm2s,s2mm}_state{0,1}.{stream_starvation, stalled_lock_acquire, stream_backpressure, memory_starvation}`.

**float32 stalls 21.8× more per track.** ~98% of it is lock stall — stages idling on the slow stage, not contention. Zero stream stall and ~100 cycles of bank conflict in both means **there is no routing or memory pathology in either build**.

> **Reading note:** a stall is a symptom, not the disease. In a dataflow pipeline exactly one stage can be ~100% busy; every other stage stalls by exactly `II − its own work`. A *solid* trace means "this is the bottleneck", not "this is efficient".

---

## 4. Duty cycle per stage — what to fix

Duty = kernel body cycles ÷ II.

### float32 — II 22,212 cyc

| stage | n | cyc/call (med) | duty | stall % of enabled |
|---|---:|---:|---:|---:|
| **matvec** | 33 | **22,172** | **99.8%** ← bottleneck | 15.9% |
| bias_relu | 14 | 1,161 | 5.2% | 95.2% |
| window_split | 10 | 545 | 2.5% | 97.7% |
| roll_concat | 3 | 349 | 1.6% | 98.5% |

Array utilisation: **55.3% busy / 44.7% idle**

### int16 — II 1,147 cyc

| stage | n | cyc/call (med) | duty | stall % of enabled |
|---|---:|---:|---:|---:|
| **matvec** | 33 | **1,082** | **94.3%** ← bottleneck | 22.7% |
| **window_split** | 10 | **937** | **81.7%** ← next | 31.8% |
| roll_concat | 3 | 195 | 17.0% | 81.7% |
| bias_relu | 14 | 134 | 11.7% | 86.8% |

Array utilisation: **68.0% busy / 32.0% idle**

> **Verify:** cycles/call come from `aieml_<p>/aiesimulator_output/profile_funct_<col>_<row>.txt` — the **`Calls`** column must read 50, and **`Cycles avg (func)`** is the number quoted. Same data drives the **Profile** view in Vitis Analyzer, so it should match exactly. Map a stage name to its tile via `Work/reports/graph_mapping_analysis_report.txt` (the `CR(x,y)` column).

---

## 5. Confirming the fixes landed in both builds

| kernel | float32 before → now | int16 before → now |
|---|---|---|
| `roll_concat` | 1,944 → **349** (5.6×) | 3,730 → **195** (19.1×) |
| `bias_relu` | 1,284 → **1,161** (1.11×) | 960 → **134** (7.2×) |
| `window_split` (untouched) | 545 → 545 | 937 → 937 |
| matvec (untouched) | 22,161 → 22,172 | ~1,197 → ~1,082 |

> **Verify:** same `profile_funct_*.txt` files. Pick any `bias_add_leaky_relu_kernel` tile — the `Cycles avg (func)` should be 134 (int16) / 1,161 (float32).

**float32 II is unchanged** (17.765 → 17.770 µs), exactly as predicted: the fixes freed slack on stages that were already 95–98% idle, while the fp32-emulated matvec still sets the II. Its one real gain is fill latency, **304.86 → 274.86 µs (−10%)**.

**int16 went 3.050 → 0.918 µs/track (3.32×)**, and `roll_concat` dropped from bottleneck (97.8% duty) to 17%.

### Why float32 is ~20× slower on the matvec

AIE-ML has no native fp32 MAC. From the disassembly (`Work/aie/<CR>/Release/<CR>.lst`), the fp32 `matVecMul` body contains `VCONV.bf16.fp32` ×48 paired with `VMSC.f` ×32 / `VMAC.f` ×32 — fp32 emulated on the bf16 MAC datapath. The int16 body has plain `VMAC` ×64, no conversions. The compile line even carries `-DAIE2_FP32_EMULATION_ACCURACY_FAST`.

Per cascade tile, both do 8,192 MACs: float 22,161 cyc = **0.37 MAC/cycle**; int16 1,077 cyc = **7.61 MAC/cycle**.

> **Verify:** `grep -c "VCONV.bf16.fp32" aieml_float32/Work/aie/<CR>/Release/<CR>.lst` on any matvec tile, and the same grep on the int16 build (returns 0).

---

## 6. Next levers, in order

1. **int16: `window_split` at 81.7% duty.** 937 cycles for a pure 128 → 64+64 copy with no arithmetic, in 10 instances — the same 16-bit scalar-loop problem `roll_concat` had. Vectorising it, or deleting the kernel by feeding both consumers from offset sub-buffers, takes II toward the matvec floor. Direct II gain is now modest (1,147 → ~1,100, ~4%) because matvec is already at 94.3%, but it frees 10 tiles and 10 stages of fill latency.
2. **int16: the real ceiling is the matvec at 1,082 cyc** (7.61 MAC/cycle). Closing on the AIE-ML int16 peak means revisiting cascade lengths / DSPLIB parameters, not the copy kernels.
3. **float32: nothing below bfloat16 will move it.** 99.8% of the II is the emulated fp32 matvec.
4. **`track_average_pl` is likely the system bottleneck for int16.** After the HLS fix it synthesises with `Final II = 8`, so 128 elements × 8 cycles = 1,024 cycles ≈ **3.41 µs/frame at 300 MHz** — versus the AIE now delivering a track every **0.918 µs**. That is ~3.7× too slow and would backpressure the AIE. It was invisible with float32 (17.77 µs/track gave 5× headroom). *This is an implication of the reported II, not an end-to-end measurement — worth confirming in hw_emu.*

---

## Appendix — measurement method

Numbers in §1–§3 were extracted by streaming the raw VCD (`aieml_float32/foo.vcd` 15.0 GB, `aieml_int16/foo.vcd` 1.73 GB) and integrating signal high-time / collecting edge timestamps:

- **II and latency**: rising edges of `mm.dma.mm2s_state0.finished_bd` (output tile) and `mm.dma.s2mm_state0.finished_bd` (input tile). Exactly 50 events each in both runs.
- **Stalls**: total high-time of each `cm.proc.core_status.*` and `mm.dma.*` signal, divided by 50 tracks.
- **Cycles/call**: `profile_funct_*.txt`, `Cycles avg (func)` for the kernel function, `Calls` = 50.

§4 duty cycles are `cycles/call ÷ II` and are therefore derived, not independently measured — they should be checked against the two inputs rather than looked for as a tool output.
