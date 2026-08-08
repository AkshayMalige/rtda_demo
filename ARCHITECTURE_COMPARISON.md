# `aieml/` vs `aieml_batch/` — two architectures for the same network

Same weights, same math, same VEK280. Two different ideas about how to map an MLP
onto an AIE-ML array.

- **`aieml/`** — hand-written graph, DSP-library **matrix-vector**, one track at a time.
- **`aieml_batch/`** — generated graph, `aie::mmul` **matrix-matrix**, 8 tracks at a time.

Measurements: `AIE_PERF_REPORT.md` (old) and `GEMM_FEASIBILITY.md` (new).

---

## 1. The one difference that matters

AIE-ML has **no matrix-vector instruction**. Its vector unit exposes `aie::mmul`,
which multiplies a fixed-size *block* of A by a block of B. For float32 that block is

```
M = 4,  K = 8,  N = 4          (aie_api/detail/mmul.hpp, AIE-ML row, float x float)
```

**`M` is the track dimension, and the hardware always computes 4 rows.** A
matrix-vector product is just this instruction with M = 1: you pay for 4 rows of
multiply and keep 1.

Everything below follows from that single fact.

| | `aieml/` | `aieml_batch/` |
|---|---|---|
| dense layer op | `W(128x128) x h(128x1)` | `H(Bx128) x W(128x128)` |
| tracks in flight | 1 | 8 |
| mmul M lanes used | 1 of 4 | 4 of 4 |
| **float32 ns/track** | **17,770** | **519.8** |

**Both figures are the same 14-layer model** (embed + 3 solvers), and both now compute the
same network (leaky ReLU, slope 0.1). Built at `SOLVERS=3, BATCH=8`:
**II = 4158.1 ns -> 519.8 ns/track**. Depth is not a confound — with plain ReLU the 6-layer
and 14-layer builds had *identical* II (3726.4 ns), exactly as a dataflow pipeline predicts:
II is set by the slowest *stage*, not the sum. **34.2x**.

> **Leaky ReLU costs 11.6%**: 465.8 -> 519.8 ns/track, a clean A/B with only the activation
> changed. `aie::mul(y, slope)` returns an accumulator needing a `to_vector` conversion, and
> on bf16-emulated fp32 that conversion costs `VCONV`. An earlier note here predicted it
> would be free; that was wrong.
>
> One confound remains: **toolchain**. 17,770 was measured on Vitis 2024.2, 519.8 on 2025.2.
> The fully confound-free number is internal to `aieml_batch/` — 1 track to 8 tracks is a
> measured **8.0x** within one toolchain and one model.

**Full-model resources:** 65 compute + 14 memory tiles across 17 columns, against
`aieml/`'s 60 compute + 3 memory. Compute is comparable; memory-tile use is ~4.7x
higher, which matters because every build failure in this work was memory-tile related.

---

## 2. Side by side

| | `aieml/` | `aieml_batch/` |
|---|---|---|
| **How the graph is written** | by hand: `graph.h`, `graph_layout.hpp`, 3 kernel sources | generated: ONNX -> `aie4ml` -> `src/`, `app.cpp` |
| **Dense implementation** | `xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul_graph` | custom `aie::mmul` kernels emitted by aie4ml |
| **Weight delivery** | RTP, resident per tile (`TP_USE_MATRIX_RELOAD=1`) | packed into the generated kernel's buffers |
| **Parallelism knob** | `TP_CASC_LEN` (cascade) | `cas_num` / `cas_length`, plus the batch axis |
| **Activation** | separate `bias_relu_fused` kernel per layer, leaky slope 0.1 | leaky ReLU fused into the dense kernel (`LEAKY_ALPHA`), same slope |
| **128->64 split** | explicit `window_split_128_to_64x2` kernel, 10 instances | none — the tiler handles it |
| **Cross-track history** | `roll_concat` kernel, 3 instances + 3 memory tiles + `static` state | *(see §4 — still a 256-wide input here)* |
| **Tiles (float32)** | 60 compute + 3 memory | 25 compute + 6 memory *(embed+solver-0)*; ~58 + ~14 projected for the full model |
| **Precision** | `float` or `int16` via `PRECISION=` | `float32` (bf16 available, untested) |
| **Toolchain** | Vitis 2024.2, `xilinx_vek280_base_202420_1` | Vitis 2025.2, `xilinx_vek280_base_202520_1` |
| **PL / host / hw_emu** | complete: `pl/`, `host/`, `linker_aieml.cfg`, package | **AIE only** — no PL, no host, no link/package |

---

## 3. What "batch" changes, and what it does not

**It does not change the layout.** Both designs are spatial pipelines: every dense
layer owns its own tiles, data flows stage to stage. `aieml_batch/` is not
"time-multiplexed" or "queued".

**It changes what flows.** Instead of a 128-element vector moving between stages, a
`8 x 128` block moves. Stage 1 processes all 8 tracks, hands the block on, and so on.

```
aieml/          1 track  --> [d0] --> [d1] --> ... --> out
aieml_batch/    8 tracks --> [d0] --> [d1] --> ... --> out
```

### Why 8 and not 50

Measured, embed + solver-0, float32:

| BATCH | II (ns) | ns/track |
|---:|---:|---:|
| 4 | **3726.4** | 931.6 |
| 8 | **3726.4** | **465.8** |
| 16 | 7405.6 | 462.9 |

**Batch 4 and batch 8 take identical time.** aie4ml pads the batch axis to
`outer_granularity = 2 * M = 8`; below that the padding rows are computed and
discarded. At 8 the block is exactly full. Above 8 nothing is wasted but nothing is
gained — 16 is 0.6% better, inside the measurement's own spread.

Batching to 8 buys a clean 8x. Batching to 50 buys nothing, costs latency and memory,
and currently does not build (BATCH=32/56 hit an AIE core-compiler spill-size bug).

---

## 4. `roll_concat` — what actually changes

In `aieml/`, `roll_concat` holds the previous track's activation in `static` buffers
and emits `[current, previous]` (256 wide) into solver dense0. Three instances, three
memory tiles.

It **looks** like a recurrence but is not. The source op is
`torch.cat([torch.roll(data, i, dims=1) for i in range(2)], dim=-1)`
(`punit/onnx_no-residual/mlp.py:96-102`) — a roll over the *track* axis. Output track
`i` depends only on input tracks `{i, i-1, i-2, i-3}`: a depth-4 FIR window, which is
why the reference notebooks use `WARMUP = 3`.

With a batch matrix `H` resident, the concat is a **row offset** — free. Splitting the
256x128 weight into `W_curr`/`W_prev` (a split `punit/mlp_hls.ipynb` cell 6 already
makes) gives

```
Y[i] = (H . W_currᵀ)[i] + (H . W_prevᵀ)[i-1]
```

two 128-wide GEMMs on the same `H` plus a row-shifted add. Identical MAC count,
deleting 3 kernels, 3 memory tiles and the 256-wide plumbing.

> **Not yet done.** `aieml_batch/` still uses a single `Dense(256->128)` fed by a
> 256-wide input, matching `aieml/`. The split is blocked by an aie4ml bug:
> `passes/fuse_activation.py` fuses ReLU only when `producer.op_type == 'dense'`, so
> `Relu(Add(...))` survives as a bare `activation` node and `passes/resolve.py:60`
> raises `NotImplementedError`. Fix that and the split becomes expressible.
>
> Note this is a **tile-count** saving, not the speedup. The 8x comes from batching alone.

---

## 5. Memory — never the constraint

| | value | limit |
|---|---:|---|
| AIE-ML compute tile data memory | — | **65,536 B** (`dsp_lib/L1/include/aie/device_defs.h:297`) |
| All weights, float32 | 264,192 params = 1.03 MB | ~18 KB/tile over ~58 tiles |
| Activations, BATCH=8 | 4 KB/layer | fine |
| Activations, BATCH=50 | 25.6 KB/layer | also fine |

What broke builds was **buffer descriptors**, the DMA instructions a memory tile uses
to move data, of which each tile has a small fixed pool. A misaligned tensor costs one
BD per row:

- embed input is **6** wide, aligned up to 16 -> strided copy -> one BD per batch row
  -> pool exhausted at BATCH>=16 (`[aiecompiler 77-4352] ... buffer_x`).
- solver input is **256** wide, already a multiple of 16 -> contiguous -> one BD. Never failed.

**Fix: present the input 16 wide** (`INPUT_DIM=16`). `io_route` in
{plio, direct, memtile} was tested and made no difference — alignment is the lever.

**Rule: keep every tensor dimension a multiple of 16 elements.**

---

## 5b. Hardware emulation — validated 2026-08-08

Full system run on QEMU (`TARGET=hw_emu AIE_DIR=aieml_batch`): AIE graph + XRT host,
**no PL kernels**.

| comparison | max abs diff |
|---|---:|
| hw_emu vs the x86/aie simulation | **8.4e-07** |
| hw_emu vs `data_fp32/aieml10_output_aie.txt` | 5.0e-03 |
| simulation vs the same reference | 5.0e-03 |

The last two matching is the result: hardware emulation adds nothing. The 5.0e-03
is the warm-up convention (tracks 0-2 use the zero-pad roll, and they are inside
the 50-track mean); on tracks 3..49 the AIE agrees to 7.4e-06.

Artifacts and the reproduce recipe: `aieml_batch/results/`.

---

## 6. What `aieml_batch/` cannot do yet

| capability | `aieml/` | `aieml_batch/` |
|---|---|---|
| x86 functional sim | yes | yes |
| cycle-accurate aiesimulator | yes | yes |
| **hw_emu** | yes | **yes** — validated 2026-08-08, see §5b. No PL kernels needed. |
| **hardware** | yes | not tried; hw_emu passes, so the flow exists (`TARGET=hw`) |
| int16 | yes | not built (aie4ml supports it; needs quantized weights) |
| full 14-layer model | yes | `SOLVERS=3` wired but see below |

---

## 7. Cross-checking against the old design

**The float32 reference `data_fp32/aieml10_output_aie.txt` is valid.** Verified by
rebuilding the whole 14-layer chain in numpy from `data_fp32/` weights and
`embed_input.txt` (50 tracks):

```
47 of 50 tracks match to  max|diff| = 1e-6
tracks 0, 1, 2 differ     (0.212, 0.168, 0.089)
```

Those three are exactly the `roll_concat` warm-up — the depth-4 receptive field means
the first 3 outputs are contaminated by the kernel's zero-initialised history. This is
`WARMUP = 3` from the reference notebooks, and it is expected, not a defect.

> **Comparison protocol: skip tracks 0-2, require max|diff| < 1e-6 on tracks 3-49.**

### Measured result (`make crosscheck`, SOLVERS=3, BATCH=8)

```
[1] reference file vs numpy golden        max|diff| = 1.103e-06   ok
[2] AIE vs numpy golden (plain-ReLU)
      emb_out                             max|diff| = 2.503e-06   ok
      s0_out                              max|diff| = 2.548e-06   ok
      s1_out                              max|diff| = 7.674e-06   ok
      s2_out                              max|diff| = 1.945e-06   ok
[3] AIE vs aieml10_output_aie.txt         max|diff| = 2.937e-01   FAIL
```

**The batched graph is numerically correct for the network it implements.** All four
stages of the full 14-layer model agree with numpy to ~1e-6.

> **RESOLVED 2026-08-08.** Leaky ReLU was added to aie4ml (ONNX `LeakyRelu` lowering + fused
> kernel `max(y, alpha*y)`). Check [3] now reads **4.023e-06 — PASS**, on both the x86 and the
> cycle-accurate simulator, bit-identical between them. Cost: **+11.6%**, 465.8 -> 519.8 ns/track.
>
> The original diagnosis, kept for the record:

**[3] failed for exactly one reason: the activation.** `aieml/` uses leaky ReLU with
slope 0.1 (`LEAKY_SLOPE`, `common/nn_defs10.h:40`); aie4ml emits plain ReLU —
`passes/fuse_activation.py` handles only `'relu'` and `'linear'`, and nothing in the
framework mentions leaky/negative_slope. The evidence is exact:

```
leaky-ReLU golden vs aieml reference   max|diff| = 1.103e-06   <- matches
plain-ReLU golden vs aieml reference   max|diff| = 2.937e-01
AIE (plain ReLU)  vs aieml reference   max|diff| = 2.937e-01   <- same number
```

The AIE result differs from the reference by precisely the plain-vs-leaky difference,
so the activation is the *only* remaining discrepancy.

> **`aieml_batch/` does not yet compute the RTDA network.** Adding leaky ReLU to
> aie4ml's `fuse_activation.py` and dense kernel template is the one change that would
> make [3] pass. Timing is unaffected — leaky vs plain is one extra vector op inside an
> already-fused kernel, with identical layer shapes and MAC counts.

The leaky-ReLU is `max(y, 0.1*y)` (`LEAKY_SLOPE = 0.1`, `common/nn_defs10.h:40`) and is
applied after **every** dense layer including each solver's dense3.

Because `aieml_batch/` takes the 256-wide solver input as a graph *input* rather than
deriving it internally, the host applies `assemble(a) = concat([a, roll(a,1,axis=0)])`
between stages — which is what `roll_concat` computes.

---

## 8. Which to use

Neither replaces the other today.

- **`aieml/` is the only one that runs on hardware.** It has the PL kernels, the host,
  the link and package flow. If you need a board result now, it is the design.
- **`aieml_batch/` is the faster architecture and the better answer for float32**, but
  it is AIE-only, simulation-only, and 6 of 14 layers.

The gap to close, in order: build `SOLVERS=3` and confirm II holds; try **bf16**
(measured 8.9x fewer instructions than float32 for identical GEMM work, and untested —
likely the largest remaining lever); then decide whether to port the PL/host flow over.

And regardless of either: `track_average_pl` synthesises at `II = 8` -> ~3.41 us/frame
at 300 MHz against 0.466 us/track here. **The PL is the system bottleneck by ~7x**, so
none of this speedup is visible end-to-end until that is reworked.
