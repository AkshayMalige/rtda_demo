# aieml_batch — migration plan (LOCKED 2026-08-08)

Goal: `aieml_batch/` becomes an **independent** AIE-ML project — no aie4ml at build
time — that hosts the **full** RTDA model (including the track average and the 128->27
output layer), is buildable standalone, and can replace `aieml/` from the top Makefile.

Background: `GEMM_FEASIBILITY.md` (the study), `ARCHITECTURE_COMPARISON.md` (old vs new),
`README.md` (why batch 8, memory limits, GOPs).

---

## Where we are

**Measured and working**
- Full 14-layer model builds and runs batched: **465.8 ns/track** at `BATCH=8`,
  identical II to the 6-layer build. 65 compute + 14 memory tiles, 17 columns.
- vs `aieml/` float32 at 17,770 ns/track = **38x** (one confound left: 2024.2 vs 2025.2).
- Confound-free internal result: batching 1 -> 8 is **8.0x**.
- Graph is numerically correct for what it computes: all 4 stages ~1e-6 vs numpy.
- `data_fp32/aieml10_output_aie.txt` validated as a reference (1.103e-06, tracks 3..49).

**Known broken / missing**
- **Leaky ReLU** — aie4ml emits `aie::max(v, 0)`; the model needs `max(v, 0.1v)`.
  Sole cause of the 0.2937 mismatch vs `aieml/`. Phase 1.
- `BATCH=1` build fails (BD exhaustion, `buffer_emb_out`); `BATCH=32/56` fail
  (chess-backend `Constant range error ... spill size = 64`). Neither matters at BATCH=8.
- Not a drop-in: graph exposes `ifm[13]` / `ofm[8]`; `aieml/` is 1 GMIO in, 1 PLIO out.
- hw_emu unreachable: XRT uninstalled, and no PL/host/linker/package here.
- bf16 untested — 32 instructions vs float32's 284 for identical GEMM work.

---

## Decisions taken (do not relitigate)

1. **BATCH = 8**, not 50. `microtile_m = 4`, `outer_granularity = 2*M = 8`. Batch 4 and 8
   have *identical* II; 8 -> 16 gains 0.6%. Below 8 you compute padding.
2. **The track average moves into AIE as an accumulator, not a 50-wide batch.** 7
   iterations x 8 tracks, summing into a 128-float (512 B) accumulator, then x1/50.
   Same counter `track_average_pl` has today. This keeps BATCH=8 (which builds; 56 does
   not) and still gives a per-event mean.
3. **Placement: no coordinates.** Strip aie4ml's `col_placement`/`row_placement`; use a
   `runtime<ratio>` block like `aieml/graph_layout.hpp` and let the mapper solve. Tune
   ratios if it struggles, never hand-write `location<>`.
4. **Weights come from `data_fp32/`**, never `data/` (manually swapped to int16).
5. Leaky slope is **0.1** (`common/nn_defs10.h:40`). The 0.125 variant is HLS/PL only
   (`punit/mlp_hls.ipynb` etc.), a DSP-saving change, not used on AIE-ML.

---

## Phase 1 — Leaky ReLU  **[DONE 2026-08-08]**

Implemented in aie4ml (branch `aie-mmul`, commit `fc9b0d2`). Check [3] = **4.023e-06**
(was 0.2937). Costs **11.6%**: 465.8 -> 519.8 ns/track, because `aie::mul` returns an
accumulator needing a `to_vector`, and on bf16-emulated fp32 that conversion costs VCONV.


Five edits in aie4ml, then regenerate one last time:

| file | change |
|---|---|
| `templates/nnet_utils/dense_bias_relu/dense_bias_relu.cpp` :151, :415 | `aie::max(v, result_t(0))` -> `aie::max(v, v * alpha)` |
| `templates/firmware/variants/dense_bias_relu/parameters.h.jinja` | emit `LEAKY_ALPHA` beside `USE_RELU` |
| `passes/fuse_activation.py` :27 | accept `'leaky_relu'`, carry alpha in the trait |
| `frontends/onnx/lower.py` | lower ONNX `LeakyRelu` (has an `alpha` attribute) |
| `op_impls/families/matmul/dense.py` | thread alpha into template params |

**Exit criterion:** `make clean && SOLVERS=3 BATCH=8 make crosscheck` -> check [3]
drops from **2.937e-01** to **< 1e-4**. That is the proof the batched architecture
reproduces the RTDA network. Get this before cutting the aie4ml cord.

## Phase 2 — Vendor and cut aie4ml  **[DONE 2026-08-08]**

`src/`, `app.cpp`, `aie.cfg`, `aie_pipeline.json` are committed source. `aie_io.py`
replaces aie4ml's PLIO marshalling and was proven **byte-identical** against it
(`make verify_io`: all 13 input files and all 4 output tensors). Build + simulate +
crosscheck + report now run on an interpreter that cannot import aie4ml.
**Placement kept as generated** (per instruction) rather than swapped for `runtime<ratio>`.
Unused kernel templates (elementwise_add, layer_norm, matmul, softmax) pruned.

Original plan:

- Freeze the generated `src/` as committed, hand-editable source, leaky fix baked in.
- **Strip `col_placement`/`row_placement`; add `graph_layout.hpp` with `runtime<ratio>`.**
- Self-contained Makefile mirroring `aieml/Makefile` conventions (`TARGET`, `PRECISION`,
  `graph`, `sim`, `clean`, `help`). Drop the `Makefile.aie4ml` delegation and the
  reserved `all`/`x86com`/`x86sim`/`aiesim` names.
- **Replace `predict()`** — it currently does input tiling and output unpacking. Write a
  `graph.cpp` testbench in the style of `aieml/graph.cpp`: read `data_fp32/`, write
  `aieml10_output_aie.txt`. Same contract as `aieml/`, so `crosscheck.py` keeps working
  with no aie4ml import.
- Keep `make regen` as a clearly-marked escape hatch (needs aie4ml + envaie2).

## Phase 3 — Full model in AIE, drop-in interface

Reference tail, confirmed in `punit/onnx_no-residual/onnx_files/model_full.onnx`:
```
solver2 dense3 -> LeakyRelu -> ReduceMean(axes=[1], keepdims=0) -> Gemm(128->27) -> output
```
`ReduceMean` is over the **50-track axis**; the output Gemm (`output.weight` [27,128],
transB=1) runs once per event on the averaged vector.

Add three kernels:
1. **Batched roll_concat** — on an 8x128 block, rows 1..7 pair with 0..6 internally
   (free). Row 0 needs the previous block's row 7 (1-row carry). The event's first row
   pairs with its *last* track, so the deferred-emit / `wrap_pending` trick from
   `aieml/roll_concat.cpp` still applies, just on 8-row blocks.
2. **Accumulator** — sum 50 real rows, x1/50. **Count rows; do not rely on zero padding.**
   7x8 = 56 slots, 6 are padding, and a zero input still produces nonzero activations
   through the biases.
3. **Output dense** 128->27, **padded to 28** for the float mmul N=4 granularity.

Cost: ReduceMean ~6,400 adds/event, output Gemm 3,456 MACs/event, against 13.2M MACs per
event = **0.03% of the work**. Then match `aieml/`'s GMIO/PLIO names so the interface is
1 input -> 27 values per event.

## Phase 4 — Delete the PL path, rewrite the host

- AIE -> DDR via GMIO directly; no `track_average_pl`, no AIE->PL stream.
- Output bandwidth per event drops from 6,400 floats to 27 — **237x**.
- Host reads 27 values/event instead of 128-wide frames plus a host-side output dense.
- Top Makefile: add `AIE_DIR ?= aieml`, thread through aie/link/package targets so
  `make system TARGET=hw_emu AIE_DIR=aieml_batch` works. **hw_emu becomes reachable here**
  (needs XRT installed, and Phase 3 done).

## Phase 5 — Then

- **bf16** — the untested ~9x lever, now with no PL bottleneck masking it.
- End-to-end comparison: 50 tracks batched on AIE vs the `standAlone` PL track-by-track
  pipeline.

---

## Environment (verified)

- **`envaie2`** = `/home/synthara/miniforge3/envs/envaie2` — aie4ml `0.1.6.dev0+gf43147c98`,
  onnx 1.21.0, hls4ml 1.3.0, TF 2.15.1 / Keras 2.15.0, numpy 1.26.4.
  (`envaie` has no onnx; `hls4ml-tutorial` has only aie4ml 0.1.5.)
- **Vitis 2025.2** + `xilinx_vek280_base_202520_1` for this project. `aieml/` uses 2024.2.
- `aiesimulator` / `x86simulator` do **not** need XRT. Only hw/hw_emu do.
- `set_envs.sh` exports `DATA_DIR` and `PLATFORM`; make's `?=` inherits them, which
  silently points builds at `data/` (int16) and the 2024.2 platform. This project uses
  `WEIGHTS_DIR` / `AIE_PLAT` for that reason. **Keep names non-colliding.**

## Gotchas that cost time already

- `aie_model.write()` overwrites `Makefile`; `predict()`/`build()` shell out to
  `make all|x86com|x86sim|aiesim` **by name**. Both disappear after Phase 2.
- `aie_model.build()` does **not** raise on aiecompiler failure — it returns normally and
  the error resurfaces as a confusing `FileNotFoundError` from `collect_outputs`.
- aie4ml lowers only `Add, Gemm, LayerNormalization, MatMul, Relu, Softmax, Transpose`.
  `model_full.onnx` needs LeakyRelu/Slice/Concat/ReduceMean — which is why the ONNX here
  is hand-built and the roll is exposed as graph inputs. Phase 3 removes that need.
- aie4ml will not fuse `Relu(Add(...))` — blocks the W_curr/W_prev split.
- Tensor dimensions **must be multiples of 16 elements** or memtile buffer descriptors
  are exhausted (one BD per row for strided staging). This is why `INPUT_DIM=16`.
- Verifying against a self-written reference catches arithmetic bugs, not specification
  bugs. **Always cross-check against `data_fp32/aieml10_output_aie.txt`.** Two real bugs
  (plain-vs-leaky ReLU, and a missing ReLU after each solver's dense3) hid behind a
  self-consistent Keras reference that reported MSE 6e-13.
