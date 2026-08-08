# `aieml_batch/` — the batched RTDA MLP on AIE-ML

A second implementation of the same network as `aieml/`, built on a different idea.
This file explains that idea. For the measurements that justify it, see
`../GEMM_FEASIBILITY.md`.

```bash
make gen        # build ONNX from ../data_fp32 and emit the AIE project
make sim_x86    # functional check vs a Keras reference   (~1 min)
make sim        # cycle-accurate aiesimulator + verify + report  (~5 min)
make help       # everything else
```

---

## 1. The philosophy change

### What `aieml/` does

The network is laid out **spatially**: each of the 14 dense layers owns its own AIE
tiles, wired together like an assembly line. One track enters, one track leaves.
Every dense layer is a **matrix × vector**:

```
   W (128x128)  ×  h (128x1)  =  y (128x1)          one track
```

Weights sit resident in each tile's memory (delivered once by RTP). Cross-track
history — the roll-concat — is held in `static` buffers inside a kernel.

This is a perfectly sensible design. Its problem is not the layout; it is the shape
of the multiply.

### What this folder does

Same spatial layout — each layer still owns its tiles, still a pipeline. The one
change is that each layer now processes **B tracks at once**, as a
**matrix × matrix**:

```
   H (Bx128)  ×  W (128x128)  =  Y (Bx128)          B tracks
```

That is the entire philosophical change. Everything else follows from it.

### Why it matters: the hardware multiplies matrices, not vectors

AIE-ML's vector unit does not have a "multiply a matrix by a vector" instruction.
It has `aie::mmul`, which multiplies a small **block** of A by a small block of B.
For float32 on this device the block shape is fixed at **M=4, K=8, N=4**
(`src/parameters.h` after `make gen` states this literally):

```c
static constexpr int M = 4, K = 8, N = 4;
```

The `M = 4` is the **track** dimension. The hardware computes **4 rows of output
every time**, whether or not you have 4 tracks to give it.

So matrix-vector on this chip is matrix-matrix with M=1 — you pay for 4 rows and
use 1. Three quarters of every multiply is discarded. That, and not the layer
count or the memory layout, is where the current design's time goes.

Batching does not make the hardware faster. It stops throwing away work it was
already doing.

---

## 2. What "batch" means here

**Batch = how many tracks are in flight through the array in one graph iteration.**

It is *not* a queue, and it is *not* about doing several inferences back to back.
The B tracks become the **rows of a matrix** that flows through the pipeline
together. Layer 1 processes all B, hands the whole `B x 128` block to layer 2, and
so on. The array holds one block, not one track.

```
aieml/          track ---> [d0] ---> [d1] ---> ... ---> out     1 track in flight
aieml_batch/   8 tracks --> [d0] ---> [d1] ---> ... ---> out     8 tracks in flight
```

Set it with `make sim BATCH=8`.

---

## 3. Why 8, and not 50

Measured (embed + solver-0, float32):

| BATCH | II (ns) | ns / track |
|---:|---:|---:|
| 4 | **3726.4** | 931.6 |
| 8 | **3726.4** | **465.8** |
| 16 | 7405.6 | 462.9 |

Read the II column first. **Batch 4 and batch 8 take exactly the same time** —
3726.4 ns, to the decimal. Batch 4 does not run faster than batch 8; it runs
*identically* and delivers half as many tracks.

Because: the mmul block is `M = 4`, and aie4ml sizes the batch axis to
`outer_granularity = 2 * M = 8` (`resolver.py:223`, for double buffering). Anything
below 8 is **padded up to 8** and the padding rows are computed and thrown away.

- **BATCH=1** — computes 8 rows, uses 1. Wastes 7/8.
- **BATCH=4** — computes 8 rows, uses 4. Wastes 1/2.
- **BATCH=8** — computes 8 rows, uses 8. **Nothing wasted.**
- **BATCH=16** — two full blocks. Nothing wasted, but nothing gained either: 0.6%.

Once the block is full, it is full. More tracks just means running the same
already-saturated instruction more times, so total time rises in proportion and
**ns/track stops improving**.

> A bus with 8 seats. Going from 1 rider to 8 riders per trip is 8x better per
> rider. Going to 50 riders means 7 trips — the same efficiency per rider, just
> more trips. It was never about the number 50.

So batching to 8 buys a clean **8x**, and batching to 50 buys nothing more while
costing latency (you must wait for 50 tracks), memory, and — right now —
buildability: **BATCH=32 and 56 do not compile**, hitting an AIE core-compiler bug
(`Constant range error ... spill size = 64 of stack frame 0`).

**This is the single most useful result in the study.** The original plan assumed
batching 50 tracks was the goal, which brought in event buffering, a 50->52 padding
problem, and a latency penalty. None of that is needed.

---

## 4. Memory limits

Memory was **never** the binding constraint. The numbers, for the full 14-layer model:

| what | size | limit |
|---|---:|---|
| AIE-ML compute tile data memory | — | **65,536 B/tile** (`dsp_lib/L1/include/aie/device_defs.h:297`) |
| All weights, float32 | 264,192 params = **1.03 MB** | spread across ~58 tiles => ~18 KB/tile |
| Activations at BATCH=8 | 8 x 128 x 4 B = **4 KB** | per layer |
| Activations at BATCH=50 | 50 x 128 x 4 B = **25.6 KB** | per layer — also fits |

Even batching all 50 tracks in float32 fits comfortably. The "can we hold that many
float32 values" worry does not bite.

**What actually broke builds was buffer descriptors (BDs)**, not capacity. A BD is a
DMA instruction describing how to move a block of data; each memory tile has a small
fixed pool of them. A *misaligned* tensor needs one BD per row:

- The embed input is 6 wide. aie4ml aligns the contracted axis to
  `2 * microtile_k = 16`, so 6 -> 16 is a **strided** copy: one BD per batch row.
  At BATCH>=16 the pool is exhausted:
  `[aiecompiler 77-4352] Failed to allocate buffer descriptors for buffer_x`.
- The solver input is 256 wide — already a multiple of 16, so it is a **contiguous**
  copy: one BD total. It never failed.

That asymmetry is what identified the cause. **Fix: present the input as 16 wide**
(`INPUT_DIM=16`, the default here), zero-filling the unused features. Faithful to the
real design, which already pads the embed input (`INPUT_SIZE=8`, `GRAPH_INPUT_SIZE=16`
for int16). `io_route` in {plio, direct, memtile} was tested and made no difference —
alignment is the lever, not routing.

Rule of thumb: **keep every tensor dimension a multiple of 16 elements** and the DMA
stays cheap.

---

## 5. What "GOPs" means

**GOPs = Giga-OPerations per second** — billions of arithmetic operations per second.
A throughput measure: how much arithmetic the array actually gets done.

One **MAC** (multiply-accumulate, `a*b + c`) counts as **2 operations** — one multiply,
one add. That is the standard convention.

Worked through for this project, which `make gen` prints:

```
dense layers : 6                      embed(2) + solver-0(4)
MACs / track : 100,352                16x128 + 128x128 + 256x128 + 3x(128x128)
ops  / track : 200,704                = 2 x MACs
```

At BATCH=8, one iteration takes II = 3726.4 ns and produces 8 tracks:

```
8 tracks x 200,704 ops = 1,605,632 ops per 3726.4 ns
1,605,632 / 3726.4e-9  = 4.309e14 ops/s = 430.9 GOPs
```

which is exactly what `make report` prints. That agreement is a useful **cross-check**:
it confirms the MAC count, the II, and the batch size are all mutually consistent. If
your hand-computed GOPs disagrees with the reported one, one of the three is wrong.

GOPs is most useful **relatively** — comparing configurations of the same model. Here
BATCH=4 gives 215.4 GOPs and BATCH=8 gives 430.9, exactly double, which is the padding
waste stated as a rate.

---

## 6. Things to know before trusting this further

- **float32 is emulated on AIE-ML.** There is no fp32 multiplier; it is synthesised on
  the bfloat16 datapath. For an identical 4x8x4 GEMM: bf16 emits **32** instructions,
  float32 emits **284** (132 of them `VCONV.bf16.fp32`). **bf16 is a ~9x lever that
  has not been tried** and needs only a `ComputeDtype` change.
- **Only embed + solver-0 is built here** (`SOLVERS=1`). `SOLVERS=3` is wired up but
  unbuilt. II is set by the slowest pipeline stage, so it should hold — untested.
- **roll_concat is not eliminated in this graph.** Solver dense0 is a single
  `Dense(256->128)` fed by a 256-wide input, matching `aieml/`. The `W_curr`/`W_prev`
  split that removes roll_concat is blocked by an aie4ml bug: `fuse_activation.py`
  fuses ReLU only into a `dense` producer, so `Relu(Add(...))` fails at
  `resolve.py:60`. Fix that and the split becomes expressible.
- **This targets Vitis 2025.2**, not the 2024.2 used by `aieml/`. Cross-version
  comparisons of absolute timings are not apples-to-apples; the 8x batching result is
  internal to one toolchain and does not have that problem.
- **`../track_average_pl` is now the system bottleneck.** It synthesises at `II = 8`
  => ~3.41 us/frame at 300 MHz, against 0.466 us/track here — about 7x off. None of
  this speedup is visible end-to-end until that is reworked.
- Everything here is `aiesimulator`, **not silicon**.

---

## 7. Files

| file | what |
|---|---|
| `Makefile` | the flow. Targets `all`/`x86com`/`x86sim`/`aiesim` are **reserved** — aie4ml shells out to them by name; do not rename. |
| `gen_graph.py` | builds the ONNX from `../data_fp32`, runs aie4ml, verifies vs Keras, reports |
| `Makefile.aie4ml` | the Makefile aie4ml generates; ours delegates to it |
| `src/`, `app.cpp`, `aie.cfg` | generated — `make clean_all` removes them |
