# `aieml_batch/` — the batched RTDA MLP on AIE-ML

A second implementation of the same network as `aieml/`, built on a different idea:
process **8 tracks per graph iteration** as a matrix-matrix multiply instead of one
track at a time as a matrix-vector multiply. The whole model lives in the AIE array —
including the roll-concat, the 50-track average and the event tail — so the design has
**no PL kernels at all**.

Measured on silicon (VEK280, `TARGET=hw`, 10,000 tracks):

| | `aieml/` (GEMV) | `aieml_batch/` (GEMM) |
|---|---:|---:|
| per real track | 17,770 ns | **657.8 ns** (marginal **595.6 ns**) |
| sustained throughput | ~30 GOP/s | **803 GOP/s** |
| PL kernels | 1 (`track_average_pl`) | **0** |
| host-side work per event | output dense 128→27 | output dense 128→27 |

Cycle-accurate model: **II = 4161 ns / iteration**, 7 iterations per 50-track event
→ **582.6 ns per real track**. Silicon's marginal rate agrees to 2.2%.

```bash
make x86        # x86 compile + crosscheck            (~2 min)
make sim        # hw compile + aiesimulator + crosscheck + report
make help       # everything else
```

**This project is self-contained.** The graph, its kernels, its packed weights and its
ADF testbench (`app.cpp`) are committed sources. Building and simulating needs only
Vitis and numpy — no aie4ml, no ONNX, no Keras. The default `PYTHON` is an interpreter
that *cannot* import aie4ml, so a green `make sim` proves it. Regenerating from ONNX
(`make regen`) is optional and is the only step that needs aie4ml.

---

## Contents

1. [The idea](#1-the-idea)
2. [How the code is layered](#2-how-the-code-is-layered)
3. [Configuration and parameters](#3-configuration-and-parameters)
4. [The graph: topology and time structure](#4-the-graph-topology-and-time-structure)
5. [Weights and biases: from the model to 92 RTP ports](#5-weights-and-biases-from-the-model-to-92-rtp-ports)
6. [Padding — every place it happens](#6-padding--every-place-it-happens)
7. [The host (`host_batch/`)](#7-the-host-host_batch)
8. [Verification: what is checked against what](#8-verification-what-is-checked-against-what)
9. [Commands — build, run, clean](#9-commands--build-run-clean)
10. [Performance](#10-performance)
11. [Precision — fp32 and bf16](#11-precision--fp32-and-bf16)
12. [Gotchas that already cost time](#12-gotchas-that-already-cost-time)

---

## 1. The idea

### What `aieml/` does

The network is laid out **spatially**: each of the 14 dense layers owns its own AIE
tiles, wired like an assembly line. One track enters, one track leaves. Every dense
layer is a **matrix × vector**:

```
   W (128x128)  ×  h (128x1)  =  y (128x1)          one track
```

Weights sit resident in each tile's memory (delivered once by RTP). Cross-track history
— the roll-concat — is held in `static` buffers inside a kernel.

This is a perfectly sensible design. Its problem is not the layout; it is the shape of
the multiply.

### What this folder does

Same spatial layout — each layer still owns its tiles, still a pipeline. The one change
is that each layer processes **B tracks at once**, as a **matrix × matrix**:

```
   H (Bx128)  ×  W (128x128)  =  Y (Bx128)          B tracks
```

That is the entire philosophical change. Everything else follows from it.

### Why it matters: the hardware multiplies matrices, not vectors

AIE-ML's vector unit has no "multiply a matrix by a vector" instruction. It has
`aie::mmul`, which multiplies a small **block** of A by a small block of B. For float32
on this device the block shape is fixed at **M=4, K=8, N=4** — `src_fp32/parameters.h` states
it literally:

```c
static constexpr int M = 4, K = 8, N = 4;
```

`M = 4` is the **track** dimension. The hardware computes **4 rows of output every
time**, whether or not you have 4 tracks to give it. So matrix-vector on this chip is
matrix-matrix with M=1 — you pay for 4 rows and use 1. Three quarters of every multiply
is discarded.

Batching does not make the hardware faster. It stops throwing away work it was already
doing.

### Why 8, and not 50

Measured (embed + solver-0, float32, before the leaky-ReLU fix):

| BATCH | II (ns) | ns / slot |
|---:|---:|---:|
| 4 | **3726.4** | 931.6 |
| 8 | **3726.4** | **465.8** |
| 16 | 7405.6 | 462.9 |

Read the II column first. **Batch 4 and batch 8 take exactly the same time** — 3726.4 ns,
to the decimal. Batch 4 does not run faster; it runs *identically* and delivers half as
many tracks.

Because the mmul block is `M = 4`, and aie4ml sizes the batch axis to
`outer_granularity = 2 * M = 8` (`resolver.py:223`, for double buffering). Anything below
8 is padded up to 8 and the padding rows are computed and thrown away.

- **BATCH=1** — computes 8 rows, uses 1. Wastes 7/8.
- **BATCH=4** — computes 8 rows, uses 4. Wastes 1/2.
- **BATCH=8** — computes 8 rows, uses 8. **Nothing wasted.**
- **BATCH=16** — two full blocks. Nothing wasted, nothing gained: 0.6%.

> A bus with 8 seats. Going from 1 rider to 8 riders per trip is 8× better per rider.
> Going to 50 riders means 7 trips — the same efficiency per rider, just more trips.
> It was never about the number 50.

Batching to 8 buys a clean **8×**; batching to 50 buys nothing more while costing
latency, memory, and buildability (**BATCH=32 and 56 do not compile** — an AIE
core-compiler bug, `Constant range error ... spill size = 64 of stack frame 0`).

**Memory was never the binding constraint.** All weights are 264,192 floats = 1.03 MB
spread across ~58 tiles ≈ 18 KB/tile, against 65,536 B per tile
(`dsp_lib/L1/include/aie/device_defs.h:297`). Activations at BATCH=8 are 4 KB per layer;
even BATCH=50 (25.6 KB) would fit. What actually broke builds was **buffer descriptors**
— see [§6](#6-padding--every-place-it-happens).

---

## 2. How the code is layered

There are two flows through this directory. The **generation** flow runs once (or when
the topology changes) and needs aie4ml. The **build** flow is what you use day to day and
needs only Vitis.

```
  ┌─ GENERATION (make regen, needs aie4ml + envaie2) ───────────────────────┐
  │                                                                         │
  │  data_fp32/*.txt          gen_graph.py                                  │
  │   (exported weights)  ──►  build_onnx()   ──►  ONNX proto               │
  │                                                    │                    │
  │                            make_config()  ─────────┤                    │
  │                            BatchSize, Iterations,  │                    │
  │                            LayerDirectives         ▼                    │
  │                                            aie4ml.frontends.onnx        │
  │                                              from_onnx().write()        │
  │                                                    │                    │
  └────────────────────────────────────────────────────┼────────────────────┘
                                                       ▼
  ┌─ COMMITTED SOURCES (in git; never regenerated to build) ────────────────┐
  │                                                                         │
  │   src_<P>/parameters.h  L1Cfg..L14Cfg: shapes, cascade split, mmul      │
  │                         microtile, leaky alpha, placement, N_ITER       │
  │   src_<P>/graph_plan.h  buffers, tiling descriptors, kernel wiring      │
  │   src_<P>/top_graph.h   the `dut` subgraph: 14 dense blocks + tail      │
  │   src_<P>/weights/*.h   29 headers of mmul-packed weights and biases    │
  │   src_<P>/kernels/      dense_bias_relu/  (generated, hand-patched)     │
  │                         roll_concat_batch/ (hand-written)               │
  │                         track_accum/       (hand-written)               │
  │   app.cpp               ADF testbench + PLIO/GMIO wiring + main()       │
  │   aie.cfg               aiecompiler options                             │
  │   aie_pipeline_<P>.json the PLIO layout aie_io.py reads                 │
  │   io_extra.json         hand-added ports (track_out) merged on top      │
  │                                                                         │
  └────────────────────────────────┬────────────────────────────────────────┘
                                   │
        ┌──────────────────────────┴──────────────────────────┐
        ▼                                                     ▼
  SIMULATION build (default)                          SYSTEM build (-DSYSTEM_BUILD)
  PLIO in/out, main() = testbench                     GMIO in/out, main() = nothing
        │                                                     │
        ├─ make graph  → libadf.a      (aiesimulator)         ├─ make system_graph → libadf.a
        ├─ make x86com → libadf_x86.a  (x86simulator)         ├─ make rtp → sysdata/rtp/*.bin
        ▼                                                     ▼
  run_sim.py / aie_io.py write data/ifm_c*.txt,        v++ --link (common/linker_batch.cfg,
  run the simulator, read y_p*.txt back               no PL kernels) → system_hw.xsa
        ▼                                             v++ --package → sd_batch/ + xclbin
  crosscheck.py  → numpy golden + data_fp32 ref               ▼
  report.py      → II, ns/track, GOP/s                 host_batch/host_batch.cpp (XRT)
  compare_hw.py  → a hardware run vs every reference
```

### File-by-file

**AIE sources (committed, hand-editable):**

| file | what |
|---|---|
| `app.cpp` | The ADF top level. Declares `dut_graph`, wires PLIO (simulation) or GMIO (`SYSTEM_BUILD`), declares all 92 RTP ports, and `main()` pushes the 28 weight/bias arrays with `dut.update()` before `run()`. |
| `aie.cfg` | `kernel-linting`, `xlopt=1`, `pl-freq=312.5`, `Xmapper=BufferOptLevel8`. |
| `src_<P>/parameters.h` | 14 `L<N>Cfg` structs — one per dense layer. Shapes, `CAS_LENGTH`/`CAS_NUM`, `LEAKY_ALPHA`, mmul `M,K,N`, placement, padded extents. Plus `#define N_ITER 7`. |
| `src_<P>/graph_plan.h` | Buffer declarations and ADF tiling descriptors; how each tensor is sliced across kernels. |
| `src_<P>/top_graph.h` | The `dut` subgraph — instantiates the 14 `dense_bias_relu_graph`s, the 3 `roll_concat_batch` kernels and `track_accum`, and connects them. |
| `src_<P>/weights/*.h` | 29 headers: `weights_<layer>_aie.h`, `bias_<layer>_aie.h`, `output_dense_aie.h`. Arrays are already in `aie::mmul` tile order — see [§5](#5-weights-and-biases-from-the-model-to-92-rtp-ports). |
| `src_<P>/kernels/dense_bias_relu/` | The GEMM kernel aie4ml emits, plus the leaky-ReLU patch. Templated on `L<N>Cfg`. |
| `src_<P>/kernels/roll_concat_batch/` | Hand-written. Turns a `[8][128]` block into `[8][256]` = `[cur, prev]`, with a 128-float `static carry` for row 0. |
| `src_<P>/kernels/track_accum/` | Hand-written. Counts 50 real tracks, emits the 128-wide mean, resets. Optionally applies the 128→27 output dense (`TA_OUTPUT_DENSE`, off by default). |
| `aie_pipeline.json` | aie4ml's `physical.plan.buffers`. `aie_io.py` reads it to know which PLIO file feeds which slice of which tensor. |
| `io_extra.json` | Hand-maintained supplement for ports added after generation (`track_out`). Merged by `aie_io.load_ports()`. Keep in step with `src_<P>/graph_plan.h`. |

**Python tooling (numpy only, unless noted):**

| file | what | needs aie4ml? |
|---|---|---|
| `aie_io.py` | PLIO marshalling. Reads `aie_pipeline.json` + `io_extra.json`, maps logical tensors ↔ `data/ifm_c<p>.txt` / `<sim>simulator_output/data/y_p<p>.txt`. Handles the slicing when a tensor is wider than one port. | no |
| `run_sim.py` | Writes inputs, invokes `aiesimulator`/`x86simulator`, reads outputs. `run_sim.py ports` prints the layout. | no |
| `crosscheck.py` | The numerical authority. Rebuilds the full 14-layer chain in numpy from `data_fp32/`, compares golden↔`aieml/` reference and golden↔simulation. Also exports `L()`, `P()`, `lrelu()`, `golden()` that the other scripts import. | no |
| `report.py` | Parses `T <ns>` timestamps out of the PLIO output files → TLAST-to-TLAST II, ns/track, GOP/s. | no |
| `compare_hw.py` | Compares one hardware `track_mean_128.txt` against **all** references at once, spelling out which differences are convention and which are error. | no |
| `make_golden.py` | Generates an N-track stimulus **and** the exact golden, simulated over the *slot* sequence the hardware actually sees (padding slots, roll carry across events, flush event). | no |
| `verify_run.py` | Diffs a multi-event run's `track_mean_128_ev*.txt` against a `golden_*.npz`. | no |
| `extract_rtp.py` | Dumps the 92 RTP payloads to little-endian `.bin` + a manifest, for the XRT host. Port names come from `Work/ps/c_rts/aie_control_config.json`, not from a naming rule. | no |
| `sim_events.py` | Multi-event simulation driver (`make x86_events` / `make sim_events`): builds an N-event stimulus, runs the simulator, checks every event mean, and dumps the per-track PLIO taps. | no |
| `notebooks/rtda_reference.ipynb` | The analysis. Builds an independent reference from the project's ONNX, verifies the weight chain end to end, and splits the warm-up convention out of the arithmetic error. See below. | no |
| `gen_graph.py` | Rebuilds `src_<P>/` from ONNX (`make regen PRECISION=<P>`). Also holds the Keras reference and the ONNX construction. | **yes** |
| `verify_io.py` | Proves `aie_io.py` still reproduces aie4ml's marshalling byte-for-byte. The gate that justified cutting the dependency. | **yes** |

### `notebooks/rtda_reference.ipynb`

The numerical case that this design computes the right function. It does not reuse
`crosscheck.py`'s golden as its authority — a reference written alongside a design can be
wrong in the same way the design is wrong, which has happened twice here (plain-vs-leaky
ReLU, and a missing ReLU after each solver's `dense3`, both hidden behind a
self-consistent Keras reference reporting MSE 6e-13). Instead it takes the physics side's
own ONNX, `punit/onnx_no-residual/onnx_files_narrow/mlp_fp32.onnx`, and verifies an
unbroken chain:

```
   the ONNX model  ==  data_fp32/*.txt  ==  the 92 mmul-packed RTP payloads the AIE runs
        7.451e-09 (fp32 round-trip)              0.000e+00 (bit-exact)
```

then builds a 50,000-track reference from it and compares the simulations against it,
separating the roll-convention difference (tracks 0–2) from the arithmetic difference
(tracks 3–49).

Needs `numpy onnx onnxruntime matplotlib` and nothing else — no aie4ml. `envaie2` is
missing two of them (`pip install onnxruntime matplotlib`); `o2v` has all four already.

**Outside this directory:**

| path | what |
|---|---|
| `../host_batch/host_batch.cpp` | The XRT host. See [§7](#7-the-host-host_batch). |
| `../common/linker_batch.cfg` | Empty `[connectivity]` — no PL kernels to wire. |
| `../data_fp32/` | The float32 weight export. **Never `../data/`**, which is manually swapped to int16. |
| `../testdata/` | Multi-event stimuli (`embed_input_{100,500,1000,5000,10000}.txt`) and goldens. Gitignored except the README. |
| `results/` | Captured hw_emu and hardware results with their validation. |
| `PLAN.md` | The migration plan, phases 1–4, with the bugs found in each. |
| `../GEMM_FEASIBILITY.md` | The study that justified all of this. |

---

## 3. Configuration and parameters

### 3.1 Makefile knobs (`make vars` prints all of them)

| variable | default | meaning |
|---|---|---|
| `BATCH` | `8` | Tracks per graph iteration. See [§1](#why-8-and-not-50). Changing it requires `make regen`. |
| `SOLVERS` | `3` | Solver blocks. Regen knob. |
| `INPUT_DIM` | `16` | Width presented to the first dense layer. **Not 6 or 8** — see [§6](#6-padding--every-place-it-happens). Regen knob. |
| `ITERS` | `7` | Iterations per event; must equal `N_ITER` in `src_<P>/parameters.h`. 7 × 8 = 56 ≥ 50. |
| `WEIGHTS_DIR` | `../data_fp32` | Where the weight text files come from. |
| `AIE_VITIS` | `/tools/Xilinx/2025.2/Vitis` | Toolchain for **standalone** builds. The top-level Makefile overrides this to 2024.2 for system builds. |
| `AIE_PLAT_NAME` | `xilinx_vek280_base_202520_1` | |
| `AIE_PLAT` | derived | Full `.xpfm` path. The top-level Makefile overrides it. |
| `PYTHON` | `miniforge3/bin/python` | numpy only. **Deliberately cannot import aie4ml** — that is the independence proof. |
| `AIE4ML_PY` | `envaie2/bin/python` | Only `regen` and `verify_io` use this. |
| `MEAN` | `results/hw_emu_track_mean_128.txt` | Which file `make compare` examines. |

> **Naming matters.** `../set_envs.sh` exports `DATA_DIR` and `PLATFORM`, and make's `?=`
> inherits from the environment. If these were called `DATA_DIR`/`PLATFORM`, sourcing
> `set_envs.sh` would silently point this build at `data/` (int16 weights!) and the 2024.2
> platform. Hence `WEIGHTS_DIR` / `AIE_PLAT`. **Keep new names non-colliding.**

### 3.2 Generated per-layer config — `src_<P>/parameters.h`

One struct per dense layer, in graph order: `L1Cfg`=emb_d0, `L2Cfg`=emb_d1, then
`L3..L6`=s0_d0..d3, `L7..L10`=s1, `L11..L14`=s2.

```c
struct L2Cfg {                                     // emb_d1: Dense(128 -> 128)
  using data_t = float; using weight_t = float;
  using result_t = float; using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  static constexpr float LEAKY_ALPHA = 0.1f;       // 0.0 => plain ReLU
  static constexpr int SHIFT = 0;                  // integer types only
  static constexpr int M = 4, K = 8, N = 4;        // the aie::mmul microtile
  static constexpr int col_placement = 7;
  static constexpr int row_placement = 1;
  static constexpr int padded_independent_extent = 8;   // the batch axis
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 128;        // per cascade chain
  static constexpr int OUT_FEAT_SLICE = 128;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
};
```

The two that drive everything else:

- **`CAS_LENGTH`** — how many kernels the **contracted** (input) axis is split across.
  They form a cascade chain, each adding its partial product to the next.
- **`CAS_NUM`** — how many *independent* chains the **output** axis is split into.
  Total kernels for a layer = `CAS_LENGTH × CAS_NUM`.

| layer | shape | `CAS_LENGTH` | `CAS_NUM` | kernels |
|---|---|---:|---:|---:|
| `emb_d0` | 16 → 128 | 1 | 1 | 1 |
| `emb_d1` | 128 → 128 | 2 | 2 | 4 |
| `s*_d0` | 256 → 128 | 4 | 2 | 8 |
| `s*_d1/d2/d3` | 128 → 128 | 2 | 2 | 4 |

`CAS_NUM` is capped at 2 by `gen_graph.py:make_config()`. The default of 4 saturates the
6 MM2S DMA channels of a memory tile.

### 3.3 Kernel compile-time constants

`src_<P>/kernels/track_accum/track_accum.h`:

| constant | default | meaning |
|---|---:|---|
| `TA_TRACKS` | 8 | Must equal `BATCH`. |
| `TA_FEAT` | 128 | `HIDDEN_SIZE`. |
| `TA_EVENT` | 50 | `TRACK_AVERAGE_THRESHOLD` (`common/nn_defs10.h:41`). |
| `TA_OUTPUT_DENSE` | **0** | Apply 128→27 in AIE (1) or on the host (0). Off because it is an M=1 GEMV — exactly the shape this project exists to avoid. 3,456 MACs (0.03% of an event) but measured **15–19 µs**, against 4.2 µs for the whole 14-layer pipeline. Free on the host. |

`src_<P>/kernels/roll_concat_batch/roll_concat_batch.h`: `RCB_TRACKS` (8), `RCB_FEAT` (128).

### 3.4 Host environment variables

Set on the board, no rebuild needed:

| variable | effect |
|---|---|
| `RTDA_INPUT=<file>` | Input stimulus instead of `data_fp32/embed_input.txt`. Any number of tracks; the host derives the event count. |
| `RTDA_GOLDEN=<file>` | Verify on-board against a golden (`n_events n_cols` header, then one 128-float row per event). Avoids copying hundreds of result files off the card. |
| `RTDA_DUMP_EVENTS=1` | Write `track_mean_128_ev<N>.txt` per event (otherwise only the last). |
| `RTDA_NO_FLUSH=1` | Disable the leading flush event. **Only correct from a cold start** — see [§8](#the-flush-event). |

Positional args also work: `./host_batch.exe [xclbin] [data_dir] [sysdata_dir] [out_file]`.

---

## 4. The graph: topology and time structure

### Layer chain

```
x [8 x 16]
  │
  ├─ emb_d0    Dense(16 -> 128)   + bias + leakyReLU(0.1)
  ├─ emb_d1    Dense(128 -> 128)  + bias + leakyReLU(0.1)   -> emb_out [8 x 128]
  │
  ├─ roll_concat_batch  [8 x 128] -> [8 x 256]   = [cur, prev]
  ├─ s0_d0     Dense(256 -> 128)  + bias + leakyReLU
  ├─ s0_d1     Dense(128 -> 128)  + bias + leakyReLU
  ├─ s0_d2     Dense(128 -> 128)  + bias + leakyReLU
  ├─ s0_d3     Dense(128 -> 128)  + bias + leakyReLU        -> s0_out [8 x 128]
  │
  ├─ (solver 1: roll_concat_batch + 4 dense)                -> s1_out
  ├─ (solver 2: roll_concat_batch + 4 dense)                -> s2_out
  │
  └─ track_accum   count to 50, sum, x 1/50                 -> track_out [128]
```

14 dense layers, **264,192 MACs per track** = 528,384 ops
(`16·128 + 128·128 + 3·(256·128 + 3·128·128)`).

### The roll-concat, batched

`aieml/roll_concat.cpp` does this one track at a time with a static history buffer.
Here a whole block of 8 tracks is resident, so "the previous track" is simply the row
above — a register-level offset, not data movement. Only row 0 needs anything remembered:
the last row of the previous block, held in a 128-float `static carry`.

```
out[t][  0 .. 127] = in[t]            current track
out[t][128 .. 255] = in[t-1]          previous track  (t==0 -> carry)
```

**Deliberate difference from the reference:** the model's roll is *circular* over a
50-track event — track 0 pairs with track 49. A streaming graph cannot do that without
buffering the whole event, so track 0 pairs with the carry instead. That perturbs only
tracks 0–2, which the reference already excludes as `WARMUP = 3` (the network's receptive
field is 4 tracks deep). `aieml/` does not perform the circular wrap on a single 50-track
run either, so "fixing" it would make this design diverge from the reference, not converge.

### The event tail

`track_accum` replaces `pl/track_average_pl`. It **counts** real tracks and stops at 50 —
it does not rely on padding slots being zero, because every dense layer has a bias, so a
zero input still produces a sizeable activation (measured `|max| 0.13` against `0.49` for
a real track). Summing all 56 slots and dividing by 50 would shift every element of the
mean by ~6.6% of signal.

ADF buffer rates are static — a kernel wired to an output **must** write every iteration.
So `track_accum` emits **zeros** until the event completes, and the mean on the completing
iteration. The consumer can therefore sum all frames, or take the non-zero one, and stays
correct if `N_ITER` changes.

### Time structure

```
  1 iteration  = 8 slots           II = 4161 ns   (520 ns / slot)
  1 event      = 7 iterations = 56 slots = 50 real tracks + 6 padding
               = 29.13 us          -> 582.6 ns per real track
  1 run        = (n_events + 1) x 7 iterations     (+1 = the flush event)
```

The event mean appears on iteration 6, 13, 20, … The host finds them by scanning for
non-zero frames rather than assuming the stride.

---

## 5. Weights and biases: from the model to 92 RTP ports

### 5.1 Source files

Weights come from `../data_fp32/` — flat text, one value per line, row-major, already
transposed to `[in_features][out_features]` (i.e. `y = x @ W`, ONNX `transB=0`). Large
matrices are split across `_partN.txt` files that concatenate in order.

| logical weight | files | shape after reshape |
|---|---|---|
| `emb_d0` W / b | `embed_dense_0_weights.txt` / `_bias.txt` | `[8][128]` → padded `[16][128]` / `[128]` |
| `emb_d1` W / b | `embed_dense_1_weights_part{0,1}.txt` | `[128][128]` / `[128]` |
| `s<N>_d0` W / b | `solver_<N>_dense_0_weights_part{0..3}.txt` | `[256][128]` / `[128]` |
| `s<N>_d{1,2,3}` W / b | `solver_<N>_dense_<D>_weights_part{0,1}.txt` | `[128][128]` / `[128]` |
| output dense W / b | `output_weights.txt` / `output_bias.txt` | `[128][27]` / `[27]` — **host side** |

The 256-row solver `d0` matrix is exactly the roll-concat structure: rows 0–127 act on
the current track, rows 128–255 on the previous one. (`punit/mlp_hls.ipynb` cell 6 makes
the same split as `*_d0_curr` / `*_d0_prev`.)

`gen_graph.py:load_weights()` reads these, zero-pads `emb_d0` from 8 to 16 rows, and hands
them to ONNX as `Gemm` initialisers with `transB=0`.

### 5.2 The `aie::mmul` packing

A GEMM kernel does not want `W` in row-major order. It wants a stream of
`microtile_k × microtile_n` blocks in the order it will consume them. aie4ml does this in
`op_impls/families/matmul/common.py:pack_mmul_rhs_matrix()`. The permutation is:

```
K_slice = padded_IN_FEAT  / CAS_LENGTH        rows per cascade stage
N_slice = padded_OUT_FEAT / CAS_NUM           columns per chain
tiles_per_k = K_slice / microtile_k   (= K_slice / 8)
tiles_per_n = N_slice / microtile_n   (= N_slice / 4)

for chain in 0 .. CAS_NUM-1:              # independent output-column groups
  n_base = chain * N_slice
  for cas in 0 .. CAS_LENGTH-1:           # cascade stage == kernel kk[chain*CAS_LENGTH+cas]
    for k_tile in 0 .. tiles_per_k-1:     # OUTER loop is k
      gk = cas * K_slice + k_tile * 8
      for n_tile in 0 .. tiles_per_n-1:   # INNER loop is n
        gn = n_base + n_tile * 4
        emit W[gk:gk+8, gn:gn+4] flattened row-major (k-major, 32 floats)
```

Out-of-range rows/columns are zero-filled, which is how the `emb_d0` 8→16 pad is absorbed.

**This is verified, not assumed.** Re-implementing the loop above in numpy from
`data_fp32/` and diffing against the extracted RTP binaries gives:

```
emb_d1 kk[0] (chain 0, cas 0): max|diff| = 0.000e+00
emb_d1 kk[1] (chain 0, cas 1): max|diff| = 0.000e+00
emb_d1 kk[2] (chain 1, cas 0): max|diff| = 0.000e+00
emb_d1 kk[3] (chain 1, cas 1): max|diff| = 0.000e+00
emb_d0 kk[0]                 : max|diff| = 0.000e+00
s0_d0  all 8 kernels         : max|diff| = 0.000e+00
```

So `kk[i]` maps to `(chain, cas) = divmod(i, CAS_LENGTH)` — chain-major, which is what
`extract_rtp.py:92` relies on.

### 5.3 Bias packing

Biases are only split along the output axis (`pack_vector_by_n_slice`): chain `c` gets
`b[c*N_slice : (c+1)*N_slice]`. Verified `max|diff| = 0.0` for `emb_d0` and both `emb_d1`
chains.

The bias is delivered to the **last kernel of each cascade chain** — the one where the
accumulation completes. Its port index is **not uniform**:

- `CAS_LENGTH == 1` → `kk[c].in[2]`
- `CAS_LENGTH > 1` → `kk[(c+1)*CAS_LENGTH - 1].in[3]`

which is why `extract_rtp.py` reads the port names out of
`Work/ps/c_rts/aie_control_config.json` instead of deriving them. Deriving that by hand is
exactly the sort of thing that silently loads the wrong weights.

### 5.4 RTP inventory

```
92 ports, 265,984 floats = 1,039 KB

  weights  65 ports :  1 x 2048   (emb_d0)
                      64 x 4096   (all other layers, every kernel)
  biases   27 ports :  1 x  128   (emb_d0, CAS_NUM=1)
                      26 x   64   (13 layers x CAS_NUM=2)

  264,192 weight floats  (== MACs per track, exactly)
  +  1,792 bias floats   (14 layers x 128)
  = 265,984
```

Two consumers of the same headers:

- **Simulation** — `app.cpp:main()` calls `dut.update()` on all 28 arrays directly from
  `src_<P>/weights/*.h`.
- **System** — `make rtp` runs `extract_rtp.py`, which parses those same headers into
  `sysdata/rtp/<sanitised-port>.bin` plus `sysdata/rtp_manifest.txt`
  (`<port> <n_floats> <path>`), and `host_batch.cpp` pushes them with `xrt::graph::update`.

`extract_rtp.py` cross-checks every payload length against `number_of_bytes` in the graph
metadata and fails loudly on a mismatch, and asserts it wrote exactly as many payloads as
the graph has RTP ports.

---

## 6. Padding — every place it happens

There are four independent paddings. None of them is decorative.

### 6.1 Input features: 6 real → 8 in the file → 16 presented

The physics gives **6** meaningful features; `embed_input.txt` stores **8** per track
(columns 6–7 are zero). The graph is built for **16**.

aie4ml aligns the contracted axis to `lhs_align = 2 × microtile_k = 16`. At width 6 or 8
the staging copy is **strided**, which needs **one memory-tile buffer descriptor per batch
row**. The BD pool is small and fixed, and at `BATCH ≥ 16` it is exhausted:

```
[aiecompiler 77-4352] Failed to allocate buffer descriptors for buffer_x
```

At width 16 the copy is **contiguous** — one BD total. The solver input (256 wide, already
a multiple of 16) never failed, and that asymmetry is what identified the cause.
`io_route` ∈ {plio, direct, memtile} was tested and made no difference; **alignment is the
lever, not routing.**

> **Rule of thumb: keep every tensor dimension a multiple of 16 elements** and the DMA
> stays cheap.

This is faithful to the real design, which already pads the embed input
(`INPUT_SIZE=8`, `GRAPH_INPUT_SIZE=16` for int16). `W_e0` is zero-padded from `[8][128]`
to `[16][128]` and the extra input columns are zeros, so the padding contributes nothing.

### 6.2 Batch axis: any B → a multiple of 8

`outer_granularity = 2 × microtile_m = 8`. Anything below 8 is computed and discarded.
This is why `BATCH=8` and not 4.

### 6.3 Event slots: 50 tracks → 56 slots

`ceil(50/8) = 7` iterations × 8 = 56. Six slots per event carry zeros.

**These are not neutral.** A zero input track still produces `|max| ≈ 0.13` at the output
because every dense layer has a bias (against `0.49` for a real track). `track_accum`
drops them by **counting to 50**, never by testing for zero. The host pads each event
**individually** for the same reason — concatenating events and padding once at the end
would let one event's tail swallow the next event's head.

### 6.4 Output width: 27 → 32, only if `TA_OUTPUT_DENSE=1`

The float mmul has `N=4`, so 27 would round to 28 (or 32 for a full vector). Moot at the
default, where the output dense runs on the host.

---

## 7. The host (`host_batch/`)

`host_batch/host_batch.cpp`, ~450 lines, cross-compiled for aarch64. Differences from
`host/host.cpp` (the `aieml/` host):

- **No PL kernel.** `track_average_pl` is gone, so there is nothing to `xrt::kernel` and
  no stream to drain.
- **One GMIO in, one GMIO out** (`dut.gmio_x`, `dut.gmio_track`).
- **92 RTP ports** instead of 47, loaded from the manifest.

### Geometry constants (must match the compiled graph)

```c
constexpr int BATCH            = 8;      // src_<P>/parameters.h, track_accum.h
constexpr int ITER_PER_EVENT   = 7;      // N_ITER
constexpr int TRACKS_PER_EVENT = 50;     // TA_EVENT
constexpr int SLOTS_PER_EVENT  = 56;
constexpr int IN_DIM           = 16;     // padded embed input
constexpr int HIDDEN           = 128;
constexpr int OUT_DIM          = 27;
constexpr int RAW_IN           = 8;      // values per track in embed_input.txt
constexpr long MACS_PER_TRACK  = 264192;
```

### Flow

1. `xrt::device(0)`, `load_xclbin`, `xrt::graph(device, uuid, "dut")`.
2. Read `sysdata/rtp_manifest.txt`; for each line read the `.bin` and `graph.update(port, …)`.
3. Read the input file, derive `n_events = ceil(tracks / 50)`, lay tracks into
   `(n_events + 1) × 56` slots (the `+1` is the flush event).
4. `in_bo.async("dut.gmio_x", GMIO_TO_AIE, …)` and
   `out_bo.async("dut.gmio_track", AIE_TO_GMIO, …)`, then `graph.run(n_iter)`,
   `graph.wait()`, `out_run.wait()`.
5. Scan the `n_iter × 128` output for non-zero frames → one per event. Drop the first
   (the flush).
6. Apply the output dense on the host: `y[j] = B[j] + Σ_k mean[k]·W[k*27+j]` — the
   `[128][27]` row-major convention of `host/host.cpp:394`.
7. Write `track_out_27.txt`, `track_mean_128.txt`, optional per-event files; optionally
   verify against `RTDA_GOLDEN`; print the size and timing report.

### Two things worth knowing

**`aligned_array`, not `std::vector`.** `xrt::graph::update()` forwards `sizeof(arg)` to
its private `update_port()`. A `std::vector` would send 24 bytes — the vector header.
Hence:

```c
template<typename T, std::size_t N>
struct alignas(64) aligned_array { T elems[N]; };
```

and a 4-way dispatch on the only payload sizes the graph has: 64, 128, 2048, 4096 floats.
An unexpected size throws rather than silently truncating.

**Input DMA, compute and output DMA are timed as one phase.** They overlap by design —
the graph consumes `x` as it arrives. Waiting on the input transfer before `graph.run()`
would **deadlock**: nothing drains the shim DMA until the graph is running.

---

## 8. Verification: what is checked against what

### The reference chain

| level | what it is | tolerance |
|---|---|---|
| **numpy golden** (`crosscheck.py`) | The full 14-layer chain rebuilt from `data_fp32/` with `max(y, 0.1y)` after every dense and `assemble(a) = concat([a, roll(a,1,axis=0)])`. | — |
| **`data_fp32/aieml10_output_aie.txt`** | A real `aieml/` VEK280 hardware dump, 50 tracks × 128. Validated against the golden to **1.10e-06** (tracks 3..49). | 1e-5 |
| **x86 / aie simulation** | This graph. Agrees with the golden to ~1e-6 on all four stage taps. | 1e-5 |
| **hw_emu** | Reproduces the simulation to **8.4e-07**. | 1e-5 |
| **hardware** | Verified against a 200-event golden over 10,000 tracks. | 1e-4 |

> **Verifying against a self-written reference catches arithmetic bugs, not specification
> bugs.** Two real bugs (plain-vs-leaky ReLU, and a missing ReLU after each solver's
> `dense3`) hid behind a self-consistent Keras reference reporting MSE 6e-13. Always
> cross-check against `data_fp32/aieml10_output_aie.txt` too.

### Averaging conventions — read this before calling a difference an error

Three references, three conventions. `compare_hw.py` prints all of them side by side:

| | convention | expect |
|---|---|---|
| **[A]** `data_fp32/aieml10_output_aie.txt`, `mean(axis=0)` | all 50 tracks | **the apples-to-apples one.** ~5.0e-03 — entirely the warm-up convention |
| **[B]** `mlp_hls.ipynb`'s `aie_27` | `aie_s2[3:].mean(0) @ out_W + out_B` | larger, definitionally |
| **[C]** numpy golden | all 50 | as [A] |
| **[D]** this design's own simulation | all 50 | **~1e-6. If this disagrees, it is a real problem.** |

The 5.0e-03 in [A] is tracks 0–2 sitting inside a 50-track mean while using the zero-pad
roll instead of the circular one (3 × ~0.21 / 50 ≈ 1.3e-02, so 5.0e-03 sits inside it).
On tracks 3..49 the AIE agrees with the reference to **7.4e-06**.

### The flush event

Running the 10k test twice back to back originally gave PASS then FAIL, with **only event
0** wrong (2.5e-03).

`roll_concat_batch`'s `carry` is a `static` initialised at **ELF load**, not at
`graph.run()`. A second run on an already-downloaded xclbin
(`[drm] xclbin already downloaded to slot=0`) starts with the previous run's leftover carry,
so event 0's first track pairs with stale state. Events 1..N are unaffected — their
predecessor comes from their own run.

**Fix:** the host prepends one all-zero flush event and discards its result. Zero input
slots produce bias-determined activations independent of history, so the roll state is
deterministic before the first real track. Verified numerically: an arbitrary warm carry
vs a cold carry gives `max|diff| = 0.000e+00`. Costs 7 of 1407 iterations (0.5%).
`RTDA_NO_FLUSH=1` restores the old behaviour. **Confirmed on hardware: two consecutive
runs now both PASS.**

`make_golden.py` models the flush event too, which is why its goldens match bit-for-bit
rather than approximately.

---

## 9. Commands — build, run, clean

### 9.1 Standalone (simulation only — no XRT, no board)

```bash
cd aieml_batch

make x86                  # x86 compile + crosscheck            (~2 min)
make sim                  # hw compile + aiesimulator + crosscheck + report
make graph                # just compile for hw -> libadf.a
make crosscheck           # compare vs numpy golden + the aieml/ reference
make crosscheck_ref       # validate the reference file only, no build
make report               # II / ns-per-track / GOP/s of the last aie run
make ports                # show the PLIO layout
make analyze              # open Vitis Analyzer on the last aie run
make vars                 # print every config variable and its source
make help
```

Knobs: `make sim BATCH=8 SOLVERS=3 ITERS=7 WEIGHTS_DIR=... AIE_VITIS=...`
(changing `BATCH`/`SOLVERS`/`INPUT_DIM` needs `make regen` first).

Equivalence with `aieml/`, which is driven from the repo root:

| `aieml/` | here | runs |
|---|---|---|
| `make aie_x86sim` | `make x86com` | compile only, x86 |
| `make aie_hw` | `make graph` | compile only, hw |
| `make aie_sim_x86` | `make x86` | x86simulator |
| `make aie_sim_hw` | `make sim` | aiesimulator |

**VCD and profiling are off by default here.** `aieml/Makefile:116` always passes
`--profile --dump-vcd=foo --output-time-stamp=no`; this project passes none of it,
because VCD dumping is slow and the file grows with the iteration count — which bites
on a 50-event run. Turn it on per run:

```bash
make sim VCD=1                              # -> foo.vcd, open with `make analyze`
make sim PROFILE=1                          # -> profile_funct_*.txt, per-kernel cycles/duty
make sim VCD=1 PROFILE=1
make sim VCD=mine                           # -> mine.vcd
make sim AIESIM_ARGS="--dump-vcd=foo --profile --online"    # anything else
make x86_events EVENTS=10 VCD=1             # works on the multi-event targets too
```

> `--output-time-stamp=no` is deliberately **not** included, even though `aieml/` passes
> it. `report.py` reads the `T <ns>` markers out of the PLIO output files to compute the
> II, and that flag suppresses them — `make report` would go blank.

### 9.2 Simulating more than one event

`make sim` / `make x86` / `make crosscheck` run **exactly one** 50-track event: the graph
is compiled with `N_ITER` fixed at 7, and the reference is a single event. That leaves
event-*boundary* behaviour untested — the roll carry chaining across events, and the
accumulator resetting — which is precisely where the hardware reproducibility bug lived.

`EVENTS=N` builds a second graph with `N_ITER = ITERS × (N + FLUSH)` into **its own**
archive and workdir, so the single-event build and `make crosscheck` are untouched.

```bash
make x86_events EVENTS=1      #  14 iterations,  ~14 s of simulation
make x86_events EVENTS=10     #  77 iterations,  ~50 s
make x86_events EVENTS=50     # 357 iterations,  ~4 min

make sim_events EVENTS=2      # aiesimulator instead: cycle-accurate, much slower
```

| knob | default | meaning |
|---|---|---|
| `EVENTS` | 2 | Real events to simulate. |
| `FLUSH` | 1 | Prepend the discarded flush event, mirroring the host. `FLUSH=0` drops it — exact in simulation (a simulator is always cold) and 7 iterations cheaper, but no longer matches a board. |
| `EV_TRACKS` | `EVENTS × 50` | Real track count. **Keep it a multiple of 50** — see the warning below. Named `EV_TRACKS`, not `TRACKS`: that one belongs to `make golden` and is defaulted, so reusing it here forced `--tracks` onto every simulation run. |
| `EV_OUT` | `results/sim_events` | Where results are written. |

Each run writes, per configuration:

```
sim_mean_128_x86_<N>ev_<T>tr_ev<K>.txt    one 128-wide event mean per event
sim_input_x86_<N>ev_<T>tr.txt             the stimulus that produced them
sim_x86_<N>ev_<T>tr.npz                   measured, golden, tracks, frames, n_events
```

so the numbers can be checked elsewhere (a notebook) rather than only by the built-in
comparison:

```python
d = np.load('results/sim_events/sim_x86_50ev_2500tr.npz')
d['measured'].shape        # (50, 128)
```

Measured, all against the `make_golden.py` model:

| events | tracks | iterations | worst max\|diff\| |
|---:|---:|---:|---:|
| 1 | 50 | 14 | 6.247e-07 |
| 10 | 500 | 77 | 6.485e-07 |
| 50 | 2,500 | 357 | 1.010e-06 |

> **Every event must carry exactly 50 real tracks.** `track_accum` counts **slots
> consumed**, not real tracks — it cannot tell them apart, because a zero-input slot
> still carries a bias-determined activation by the time it reaches the accumulator. The
> count only means "real tracks" because the host fills the first 50 slots of a full
> event with real ones. A short final event averages padding activations in with its few
> real tracks: **measured 8.03e-02 wrong** for a 20-track event — large, but
> plausible-looking rather than obviously broken. The host, `sim_events.py` and
> `make_golden.py` all warn when the track count is not a multiple of 50. Fixing it
> needs the real count delivered per event (an RTP, or a sentinel slot), which is a
> design change rather than a tweak.

The equivalent on **hw_emu and hw needs no rebuild at all** — there the XRT host owns the
iteration count and derives it from the input file. See [§9.5](#95-on-the-board).

### 9.3 Regenerate from ONNX (only to change topology / batch / precision)

```bash
cd aieml_batch
make regen PRECISION=fp32 # OVERWRITES src_fp32/ and aie_pipeline_fp32.json
make verify_io            # prove aie_io.py still matches aie4ml byte-for-byte
make x86                  # then rebuild and re-check
```

Needs `envaie2` (aie4ml + onnx + keras). **`make regen` discards hand-edits to `src_<P>/`** —
notably the leaky-ReLU patch lives in aie4ml (branch `aie-mmul`), not here, so regenerating
with a stock aie4ml would silently reintroduce plain ReLU.

### 9.4 Full system build (from the repo root)

```bash
source set_envs.sh                       # XRT + Vitis 2024.2 + sysroot

# hardware emulation
make system TARGET=hw_emu AIE_DIR=aieml_batch
cd package.hw_emu && ./launch_hw_emu.sh
#   in the guest:  sudo su; mount /dev/mmcblk0p1 /mnt; cd /mnt; ./host_batch.exe

# real hardware
make system TARGET=hw AIE_DIR=aieml_batch
#   write sd_card.img to the SD card, boot the VEK280
```

Individual stages (all take `TARGET=` and `AIE_DIR=aieml_batch`):

```bash
make aie        AIE_DIR=aieml_batch TARGET=hw   # -> aieml_batch/libadf.a  (SYSTEM_BUILD, GMIO)
make host       AIE_DIR=aieml_batch TARGET=hw   # -> host_batch.exe + sysdata/rtp/*.bin
make link       AIE_DIR=aieml_batch TARGET=hw   # -> build_hw/system_hw.xsa
make package    AIE_DIR=aieml_batch TARGET=hw   # -> sd_batch/ staged, then the image
make repackage  AIE_DIR=aieml_batch TARGET=hw   # force a repackage after changing sd_batch contents
make print_vars AIE_DIR=aieml_batch TARGET=hw
```

`AIE_DIR=aieml_batch` switches the top-level Makefile to `common/linker_batch.cfg`
(no PL kernels), `HLS_KERNELS :=` (empty), `aieml_batch/libadf.a` (project root, not
inside `Work/`), `host_batch/`, and `SD_STAGE := ./sd_batch`. It also forces the graph
onto the **system** toolchain (2024.2) — a 2025.2 `libadf.a` will not link against a
2024.2 XSA.

`sd_stage` copies `data_fp32/`, `aieml_batch/sysdata/` and `testdata/` onto the card.
Note `--package.sd_dir` copies the *directory*, so on the card they land under
`sd_batch/`; the host probes both layouts.

### 9.5 On the board

```bash
sudo su
mount /dev/mmcblk0p1 /mnt
cd /mnt

./host_batch.exe                                          # 50 tracks, 1 event
RTDA_INPUT=sd_batch/testdata/embed_input_5000.txt ./host_batch.exe
RTDA_INPUT=sd_batch/testdata/embed_input_10000.txt \
RTDA_GOLDEN=sd_batch/testdata/golden_10000.txt ./host_batch.exe    # verifies on-board
RTDA_DUMP_EVENTS=1 ./host_batch.exe                       # per-event result files
```

### 9.6 Generating a golden

```bash
cd aieml_batch
make golden TRACKS=50000
#   -> ../testdata/embed_input_50000.txt   stimulus, 1000 events
#   -> ../testdata/golden_50000.npz        event means (128-wide) + the 27-dim projection
#   -> ../testdata/golden_50000.txt        the same, for the board's RTDA_GOLDEN=
```

`./make_golden.py --tracks 50000 --out ../testdata` does the same thing, **but only in a shell
where `python` has numpy.** After `source ../set_envs.sh`, PetaLinux's python comes first on PATH
and has no numpy, so both `./make_golden.py` and `python make_golden.py` fail there with
`ModuleNotFoundError`. `make golden` uses `$(PYTHON)` and works either way.

Keep `TRACKS` a **multiple of 50** — see the warning in [§9.2](#92-simulating-more-than-one-event).

Only 50 real tracks exist in the repo, so anything larger is synthesised: 6 Gaussian
features matched to the real per-column mean and std, columns 6–7 zero. That is fine for
an end-to-end numerical check — the question is whether the AIE computes the same
function as the reference, not whether the input is physically meaningful. The first 50
tracks are the real ones verbatim, so event 0 stays comparable.

Comparing results after the fact:

```bash
./verify_run.py --golden ../testdata/golden_10000.npz --means <dir-with-track_mean_128_ev*.txt>
make compare MEAN=results/hw_emu_track_mean_128.txt
```

### 9.7 Full run — clean build to notebook data, either precision

Everything the notebooks need, from scratch. Replace `fp32` with `bf16` throughout for the
other precision; the two never share a build product, so both can be done back to back.

```bash
cd /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo
source set_envs.sh
P=fp32                                    # or bf16

# 1. clean (follows AIE_DIR; leaves src_*/ alone)
make clean_all AIE_DIR=aieml_batch

# 2. reference data - stimulus + streaming golden, precision-independent
cd aieml_batch
make golden TRACKS=50000

# 3. simulations. Run BOTH before the system build: `make system` rebuilds
#    Work_<P>/ as the GMIO SYSTEM_BUILD and the PLIO taps disappear.
make x86_events PRECISION=$P EVENTS=5     # x86simulator      ~2 min
make sim_events PRECISION=$P EVENTS=5     # aiesimulator      ~25 min
make graph      PRECISION=$P              # hw graph, for the II/resource report
make crosscheck PRECISION=$P
make report     PRECISION=$P              # <- II, ns/track, GOP/s
cd ..

# 4. hardware
make system TARGET=hw AIE_DIR=aieml_batch PRECISION=$P
#    check before flashing:
cat sd_batch/sysdata/config.txt           # must say precision=$P
#    then write package.hw/sd_card.img to the SD card and boot
```

On the board:

```bash
sudo su; mount /dev/mmcblk0p1 /mnt; mount -o remount,rw /mnt; cd /mnt
RTDA_INPUT=sd_batch/testdata/embed_input_50000.txt ./host_batch.exe
#    first line must read: [host] graph input dtype: float32   (or bfloat16)
mkdir -p /mnt/usb && mount /dev/sda1 /mnt/usb
cp track_means_all.txt run_info.txt /mnt/usb/ && sync && umount /mnt/usb
```

Copy those two files to `aieml_batch/results/hw_<P>/`, then run the notebook.

**What ends up where** — this is the full input set for the notebooks:

| path | from | holds |
|---|---|---|
| `../testdata/embed_input_50000.txt` | step 2 | the stimulus everything is driven by |
| `../testdata/golden_50000.{npz,txt}` | step 2 | streaming-roll golden (the board's own check) |
| `results/sim_events/sim_x86_<P>_5ev_250tr.npz` | step 3 | x86 event means **and** per-track taps |
| `results/sim_events/sim_aie_<P>_5ev_250tr.npz` | step 3 | same, cycle-accurate |
| `results/hw_<P>/track_means_all.txt` | board | all 1000 event means, one file |
| `results/hw_<P>/run_info.txt` | board | timing/size, key=value |
| `notebooks/out/golden_onnx_50000.npz` | the notebook | the ONNX reference (built on first run) |

The `make report` output is not written to a file — copy the II / ns-per-track / GOP-per-second
lines into the notebook's performance section by hand, or keep `log.<P>`.

### 9.8 Clean

```bash
cd aieml_batch
make clean       # build products only: Work/, libadf*.a, simulator output, logs, data/
make clean_all   # + throughput_info.json, AIECompiler.log, AIESimulator.log
```

**`make clean` does not touch `src_fp32/`, `src_bf16/`, `app.cpp`, `aie.cfg` or the
`aie_pipeline_*.json` files** —
those are committed sources, not build products. Use `make regen` to rebuild them.

From the repo root, `make clean` / `make clean_all` handle the PL and system artifacts.

---

## 10. Performance

### Cycle-accurate (aiesimulator, Vitis 2025.2)

```
II                 = 4161 ns / iteration  (8 slots)
per slot           =  520.1 ns
per real track     =  582.6 ns    (7 iterations / 50 real tracks)
GOP/s              =  8 x 528,384 ops / 4161 ns = 1,016 GOP/s at the array
```

vs `aieml/` float32 at 17,770 ns/track → **30.5×**. (One residual confound: `aieml/`
was measured on 2024.2. The confound-free internal result is that batching 1→8 is
exactly 8.0×.)

### Silicon (VEK280, `TARGET=hw`)

All events in a single `graph.run()`:

| tracks | events | total execute | per track |
|---:|---:|---:|---:|
| 50 | 1 | 635 µs | 12,700 ns |
| 500 | 10 | 900 µs | 1,800 ns |
| 5,000 | 100 | 3,480 µs | 696 ns |
| 10,000 | 200 | 6,578 µs | **657.8 ns** |

Least-squares fit over all four points:

```
total = 583.0 us (fixed)  +  595.6 ns x tracks        all four within 3.5%
```

Two conclusions:

**1. The marginal cost is 595.6 ns/track against a cycle-accurate prediction of
582.6 ns/track — 2.2% agreement.** aiesimulator, hw_emu and silicon all agree; the array
does exactly what the model said.

**2. The 12.7 µs/track at 50 tracks was never the array.** It is 583 µs of fixed
per-`graph.run()` cost (XRT/driver round-trip, GMIO arming, xclbin already loaded) spread
over too few tracks:

| tracks | modelled AIE time | measured | launch/DMA overhead |
|---:|---:|---:|---:|
| 50 | 29.1 µs | 635 µs | 95.4% |
| 500 | 291.3 µs | 900 µs | 67.6% |
| 5,000 | 2,912.8 µs | 3,480 µs | 16.3% |
| 10,000 | 5,825.7 µs | 6,578 µs | **11.4%** |

Sustained throughput at 10,000 tracks: **803 GOP/s**.
Versus `aieml/` at 17,770 ns/track: **27× measured, 29.8× on the marginal rate.**

The fixed cost is host-side and cannot be reduced by the AIE design. For a latency-bound
single-event workload it dominates and would need separate work — a persistent graph,
GMIO ping-pong without re-arming, or a PL-side feeder.

**How far can this scale?** Nothing in the design caps the event count: the host allocates
`(n_events+1) × 56 × 16` floats in and `(n_events+1) × 7 × 128` floats out, both linear
and both small (10,000 tracks = 717 KB in, 720 KB out). The practical ceiling is the DDR
buffer the board can allocate, not the array. Per-track cost keeps improving
asymptotically toward 595.6 ns.

### Where the remaining time goes

- **float32 is emulated on AIE-ML.** There is no fp32 multiplier; it is synthesised on the
  bfloat16 datapath. For an identical 4×8×4 GEMM: bf16 emits **32** instructions, float32
  emits **284** (132 of them `VCONV.bf16.fp32`).
- **Leaky ReLU costs 11.6%** (465.8 → 519.8 ns/slot) because `aie::mul` returns an
  accumulator needing a `to_vector`, and on bf16-emulated fp32 that conversion costs VCONV.
  On native bf16 it should mostly disappear.

---

## 11. Precision — fp32 and bf16

**Both are built and measured.** `PRECISION` selects a whole generated source tree:

```bash
make x86        PRECISION=bf16      # or fp32 (the default)
make graph      PRECISION=bf16
make x86_events PRECISION=bf16 EVENTS=5
make crosscheck PRECISION=bf16
make report     PRECISION=bf16
```

`src_fp32/` and `src_bf16/` each carry their own `parameters.h`, kernels and **weights
already emitted in that dtype**, so switching precision switches the data with it — there
is nothing else to keep in step. Every build product is precision-suffixed
(`Work_bf16/`, `libadf_bf16.a`, `sysdata_bf16/`), so both coexist and switching never
forces a rebuild of the other.

### Measured

| | fp32 | bf16 | |
|---|---:|---:|---|
| II per iteration | 4161 ns | **1033 ns** | **4.03× faster** |
| per real track | 582.6 ns | **144.6 ns** | 4.03× |
| GOP/s (array) | 1,016 | **3,654** | 3.6× |
| RTP weights | 1039 KB | **523 KB** | half |
| 27 outputs vs the ONNX golden, warm-up excluded | 7.5e-07 | 3.96e-04 | 526× worse |
| the same, as % of full scale (max \|value\| = 0.0914) | 0.001% | **0.43%** | |

4× rather than the theoretical 9× (32 vs 284 instructions per 4×8×4 GEMM) because the
design is partly data-movement bound. The per-port breakdown from `make report` shows it:
the dense stages settle at ~925 ns while `track_out` sits at 1629 ns, so **the event tail
is now the slowest stage in the graph** — it was not at fp32 speeds.

On accuracy, judge it per output rather than against full scale. The 27 outputs have very
different spreads (std 0.00052 .. 0.01523 across events), so the same 3.96e-04 is ~2.6% of
the widest output's own variation and ~76% of the narrowest one's. bf16 is comfortable for
the wide outputs and marginal for the narrow ones.

### What it took

Four things, and the last three were not obvious:

1. **`apply_activation` could not compile for bf16.** It branched on
   `std::is_floating_point_v<result_t>`, which is **false** for `bfloat16` (it is a
   compiler builtin, not a std floating-point type), so every bf16 build took the integer
   branch and tripped `static_assert(SHIFT > 0)`. Fixed in aie4ml to `!std::is_integral_v`.
2. **`AIEConfig.ComputeDtype` was a no-op for ONNX input.** `passes/force_float_mode.py`
   only rewrote `QuantIntent`; a float32 ONNX arrives as `FloatIntent`, so asking for
   bfloat16 silently produced a float32 design — same dtypes, same weights, **no error**.
   Fixed to re-cast float tensors as well.
3. **aie4ml truncated fp32 → bf16 instead of rounding.** `(f32.view(uint32) >> 16)` is
   round-toward-zero: double the worst-case error *and* a bias toward zero, which does not
   cancel across 264,192 weights and 14 layers. Round-half-to-even instead. **This was
   worth 8× end-to-end** — the event mean went from 4.13e-03 to 5.06e-04.
4. **The resolver picks a different cascade split for bf16** (emb_d1 2→1, solver d0 4→2)
   because the weights are half the size. That changes the kernel count, the graph
   structure and the RTP port count. `gen_graph.py` now pins `cas_length` so the two trees
   are structurally identical and precision is the only variable.

Weights are stored as `uint16_t` bit patterns (C++ has no bfloat16 literal) and reinterpret
to `bfloat16` at the RTP port — `as_weights<Cfg>()` in `app.cpp`. It is genuinely a
bf16 × bf16 multiply; verified by decoding the stored values back to float.

**Biases and the accumulator stay float32 in both builds.** `bias_t` is float, and
`track_accum` widens bf16 → float on load and emits float: summing 50 values in 8 mantissa
bits would lose precision for no gain (that kernel is 0.03% of the work), and it keeps the
host path, `io_extra.json` and the notebooks identical across precisions. Verified — the
tail matches its own `s2_out` mean to 4.05e-09.

### Regenerating a tree (needs aie4ml)

```bash
make regen PRECISION=bf16        # -> src_bf16/, aie_pipeline_bf16.json
```

`gen_graph.py --precision bf16 --out <dir>` generates into a scratch directory. Note the
generator does **not** emit the Phase 3 additions (roll-concat, accumulator, output taps) —
those are hand-wiring in `graph_plan.h` / `top_graph.h`. `src_bf16/` was assembled by taking
the fp32 tree (which has them) and replacing `parameters.h`, `weights/` and
`kernels/dense_bias_relu/` from the generated bf16 output, then retyping the two
hand-written kernels. Redo that if you regenerate from scratch.

## 12. Gotchas that already cost time

**Build / environment**

- `../set_envs.sh` exports `DATA_DIR` and `PLATFORM`; make's `?=` inherits them. This
  project uses `WEIGHTS_DIR`/`AIE_PLAT` for that reason. **Keep names non-colliding.**
- **Weights come from `data_fp32/`, never `data/`** — the latter is manually swapped
  between fp32 and int16 payloads, and loading int16 text into a float32 model silently
  yields integer-valued weights and meaningless results.
- Standalone builds default to **Vitis 2025.2**; system builds are forced to **2024.2** by
  the top-level Makefile. A 2025.2 `libadf.a` does not link against a 2024.2 XSA.
- `HLS_KERNELS :=` for the batch design must be set *after* the unconditional
  `HLS_KERNELS := track_average` and *before* `PL_XOS`, or `track_average_pl` still gets
  linked → `CFGEN 83-2284 No stream resources`.
- The SD staging directory's **contents are not prerequisites of the xclbin**. Changing
  what goes on the card does not trigger a repackage — use `make repackage`.
- `./launch_hw_emu.sh -run-app <exe>` auto-runs the app; killing it exits QEMU. Launch
  without `-run-app` and run the host by hand inside the guest.

**Graph**

- **Dangling outputs deadlock the graph, they do not just warn.** Leaving `ofm[0..7]`
  unconnected in `SYSTEM_BUILD` still created the shared buffers with 3 readers and still
  wrote them every iteration — nothing drained two of them, so the producing stage blocked
  forever (a 26-minute hang). The 43 `No terminal or net` warnings were the signal and were
  initially dismissed as harmless. Fixed with `N_STAGE_RD`/`EXTRA_RD`/`TAIL_OFM`;
  warnings went 43 → 0. **Treat any non-zero count of those warnings as a build failure.**
- **Kernels must not be templates.** aiecompiler emits its own wrapper that explicitly
  instantiates the kernel, which collides with an explicit instantiation in your source
  ("duplicate explicit instantiation"). `roll_concat_batch` is a plain function with
  `constexpr` config for that reason.
- **AIE kernel statics initialise at ELF load, not `graph.run()`.** See
  [the flush event](#the-flush-event).
- Wiring order matters: referencing `buffer_emb_out.out[2]` before the buffer is created
  gives `Out of bounds access to adf::vector using index:2, vector size:0`.
- `main()` cannot take `argc`/`argv` — the ADF frontend rejects it. Use environment
  variables.

**Host**

- `xrt::graph::update()` forwards `sizeof(arg)` — a `std::vector` sends 24 bytes. Use
  `aligned_array`.
- `xrt::aie::bo::sync()`/`async()` take the **port name**, not just a direction.
- Do not wait on the input DMA before `graph.run()` — nothing drains the shim DMA until
  the graph is running, so it deadlocks.

**aie4ml (only relevant to `make regen`)**

- `aie_model.write()` overwrites `Makefile`. `gen_graph.py:cmd_gen()` saves and restores
  ours, parking theirs as `Makefile.aie4ml`.
- `aie_model.build()` does **not** raise on aiecompiler failure — it returns normally and
  the error resurfaces as a confusing `FileNotFoundError` from `collect_outputs`.
- aie4ml lowers only `Add, Gemm, LayerNormalization, MatMul, Relu, LeakyRelu, Softmax,
  Transpose`. `model_full.onnx` needs Slice/Concat/ReduceMean, which is why the ONNX here
  is hand-built and the roll is a custom kernel.
- aie4ml will not fuse `Relu(Add(...))` — `fuse_activation.py` fuses only into a `dense`
  producer. That blocks the `W_curr`/`W_prev` split which would remove `roll_concat`
  entirely (two 128-wide GEMMs on the same `H` plus a row-shifted add — identical MAC
  count, but it deletes 3 kernels and turns a 4-way 256-wide cascade into a 2-way
  128-wide one).
