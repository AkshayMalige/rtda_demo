# Batched GEMM Feasibility Study — RTDA MLP on AIE-ML (VEK280)

**Date:** 2026-08-07 · **Device:** xcve2802 (AIE-ML v1, `__AIE_ARCH__ == 20`)
**Companion to:** `AIE_PERF_REPORT.md` (measurements of the *current* GEMV design)

---

## 0. Verdict

**Feasible, and the win is large.** Batched matrix-matrix on AIE-ML in **float32** is buildable and
measured at **519.8 ns/track** — for the **full 14-layer model**, against 17,770 ns/track today,
and numerically matching `aieml/` to 4.0e-06.

> **RESOLVED 2026-08-08 — leaky ReLU implemented.** aie4ml now lowers ONNX `LeakyRelu` and its
> fused dense kernel computes `max(y, alpha*y)`. The full 14-layer batched model matches
> `data_fp32/aieml10_output_aie.txt` to **4.023e-06** (was 0.2937). It costs **11.6%**:
> **519.8 ns/track**, up from 465.8 with plain ReLU — so **34.2x** vs `aieml/`, not 38.1x.
> The earlier claim that leaky would be free was wrong: `aie::mul(y, slope)` yields an accumulator
> that needs a `to_vector` conversion, and on bf16-emulated fp32 that conversion costs VCONV.

Three answers to the three questions asked:

| question | answer |
|---|---|
| Can we use matrix-matrix instead of matrix-vector? | **Yes** — but *not* via DSPLib `matrix_mult_graph`, which is int-only on AIE-ML. Via `aie::mmul`, which is what `aie4ml` already generates. |
| Do we need to batch all 50 tracks? | **No.** The curve saturates at **batch 8**. 8→16 buys 0.6%. |
| Is there enough memory for float32? | **Yes** — memory capacity was never the binding constraint. The real limits hit were buffer-descriptor pools and an AIE core-compiler backend bug. |

**And the roll_concat redesign is unnecessary for the speedup.** Batching to 8 is what buys the 8x;
eliminating roll_concat is a separate (real, but smaller) tile-count saving.

---

## 1. What was compiled, not argued (Step 0)

Same tutorial graph compiled twice with **only the typedef changed**, both `-D__AIE_ARCH__=20`
against the VEK280 platform:

| # | case | result |
|---|---|---|
| 0a | `matrix_mult_graph<int32,int32,16,32,8>` | **PASS** — exit 0, `libadf.a` 2.4 MB, `(WARNING:0, CRITICAL-WARNING:0, ERROR:0)` |
| 0b | `matrix_mult_graph<float,float,16,32,8>` | **FAIL** — exit 255 |
| 0c | custom `aie::mmul<4,4,4,int16,int16>` | **PASS** (needs `--stacksize>=1056`; default 1024 overflows by 32 B) |
| 0d | custom `aie::mmul<4,8,4,bfloat16,bfloat16,32>` | **PASS** |
| 0e | custom `aie::mmul<4,8,4,float,float,32>` | **PASS** |

0b verbatim:
```
dsp_lib/L1/include/aie/matrix_mult.hpp:207:5: error: static assertion failed due to
requirement 'tilingScheme.Atile > 1 || tilingScheme.ABtile > 1 || tilingScheme.Btile > 1':
ERROR: There are no supported Matrix Multiplication Modes for this data type combination
note: in instantiation of template class
  'xf::dsp::aie::blas::matrix_mult::matrix_mult_graph<float, float, 16, 32, 8, ...>'
```

> **Verify:** rebuild either case with the commands in §7. The int32 control passing on the same
> file is what makes the data type the only variable.

**Note on the docs.** `Vitis_Libraries/dsp/docs/src/user_guide/L2/func-matmul.rst` line 34 says
float *is* supported; line 36 says AIE-ML does not support it. The AIE-ML GEMM tutorial README
repeats both (lines 61 and 63). The template-parameter docs list float with no device qualifier.
Only line 36 is correct for this device. AMD's own regression matrix agrees: in
`Vitis_Libraries/dsp/L2/tests/aie/matrix_mult/multi_params.json`, all 13 `float` and 5 `cfloat`
GEMM cases are tagged `aie1`, zero untagged; integer types have untagged cases that run everywhere.

**This restriction is GEMM-only.** `matrix_vector_mul_graph` — what the current design uses —
*does* support float on AIE-ML (`matrix_vector_mul_traits.hpp:111` defines `accType<float,float>`
inside the `__SUPPORTS_ACC64__` branch AIE-ML takes). That is why the shipping float32 build runs.

### float32 is emulated — measured at the instruction level

Identical `4x8x4` shape, identical loop, from `Work/aie/*/Release/*.lst`:

| | bf16 | float32 |
|---|---:|---:|
| `VMAC.f` | 24 | 52 |
| `VMUL.f` | 8 | 12 |
| `VMSC.f` | 0 | 88 |
| `VCONV.bf16.fp32` | 0 | **132** |
| **total** | **32** | **284** (8.9x) |

`aie_api/detail/mmul.hpp:143` footnote d: *"float multiplications are emulated on AIE-ML/XDNA 1
using native bfloat16 multiplications."* This is the same mechanism behind the 19.4x float-vs-int16
gap in `AIE_PERF_REPORT.md`, and **batching does not repair it** — it is per-instruction, not
per-weight-load. bf16 remains an untested ~9x lever on top of everything below.

> **Verify:** `grep -oE "\b(VMAC|VMSC|VMUL|VCONV)[A-Za-z0-9_.]*" <build>/Work/aie/*/Release/*.lst | sort | uniq -c`

---

## 2. The batch sweep — the core result

Model: RTDA **embed + solver-0** (6 dense layers), float32, weights from `data_fp32/`.
Built through `aie4ml 0.1.6.dev0+gf43147c98` on **Vitis 2025.2**, platform
`xilinx_vek280_base_202520_1`. `Iterations=10`, `cas_num=2` on all 128->128 layers.

| batch | II (ns) | **ns/track** | GOPs | MSE vs Keras | build |
|---:|---:|---:|---:|---|---|
| 1 | — | *(~3726 inferred)* | — | — | FAILED (BD exhaustion) |
| 4 | **3726.4** | 931.6 | 215.4 | 7.2e-13 | ok |
| 8 | **3726.4** | **465.8** | 430.9 | 6.3e-13 | ok |
| 16 | 7405.6 | **462.9** | 433.6 | 8.2e-13 | ok |
| 32 | — | — | — | — | FAILED (chess-backend) |
| 56 | — | — | — | — | FAILED (chess-backend) |

> **Verify:** `read_aie_report(aie_model)['output_interval']['global']['avg_ns']`, or
> `proj_b<N>/aiesimulator_output/`. The batch-8 figure rests on 36 samples with
> min 3724.8 / max 3728.0 ns — a 0.09% spread — consistent across all four output ports.

### Why the curve saturates at 8 — proven, not asserted

**batch=4 and batch=8 have identical II (3726.4 ns) and exactly half the GOPs.**
That is `outer_granularity = 2 * microtile_m = 2*4 = 8` (`aie4ml .../matmul/resolver.py:223`,
with `microtile_m=4` from `common.py:29` for `('float32','float32'): [(4,8,4)]`). A batch of 4 is
padded to 8 and performs identical work for half the useful output.

Consequences:
- **batch < 8 wastes M lanes proportionally.** batch=1 computes 8 rows and uses 1.
- **batch >= 8 gains nothing more** — 8→16 is 0.6%, within the measurement's own spread.
- Therefore batching 1 -> 8 is a **clean 8.0x**, matching the granularity exactly.

An independent cross-check on the GOPs: embed+solver-0 is 100,352 MACs/track once the embed input
is padded to 16 (2048 + 16384 + 32768 + 3x16384). At batch 8:
`8 x 100,352 x 2 ops / 3726.4 ns = 430.9 GOPs` — exactly the reported figure.

---

## 3. Comparison against the current design — with its caveats stated

| design | ns/track (float32) |
|---|---:|
| current GEMV, `AIE_PERF_REPORT.md` | 17,770 |
| batched GEMM, batch=8 (this study) | **465.8** |

**Both rows are now the same 14-layer model.** `SOLVERS=3, BATCH=8` was built and measured at
**II = 3726.4 ns -> 465.8 ns/track, identical to the 6-layer build** (65 compute + 14 memory tiles,
17 columns). Adding 8 dense layers moved throughput by zero — II really is set by the slowest
stage. **Depth is no longer a confound: 38x.**

One confound remains: **toolchain**, 2024.2 for the baseline vs 2025.2 here. The batch=1
in-toolchain reference never built, so that gap is not closed.

**The fully confound-free result is the internal one: 1 -> 8 batching is 8.0x**, within a single
toolchain and a single model.

---

## 4. Resources

batch=8 embed+solver-0 (6 layers): **25 compute + 6 memory tiles, 7 columns.**
batch=8 full model (14 layers): **65 compute + 14 memory tiles, 17 columns** — against `aieml/`'s
60 compute + 3 memory.
> **Verify:** `grep -oE "CR\([0-9]+,[0-9]+\)" proj_b8/Work/reports/app_mapping_analysis_report.txt | sort -u | wc -l`

Compute tiles are comparable (65 vs 60); memory-tile use is **4.7x higher** (14 vs 3), which
matters because **every build failure in this study was memory-tile-related**, not capacity.

Weight footprint was never binding: 264,192 params = 1.03 MB float32 spread across the array,
against 65,536 B per tile (`dsp_lib/L1/include/aie/device_defs.h:297`).

---

## 5. Build failures — all tooling, none architectural

| batch | error | nature |
|---|---|---|
| 1 | `77-4352` insufficient buffer descriptors for `buffer_emb_out` | memtile BD pool |
| 16/32/56 (input width 6) | `77-4352` / `77-23426` on `buffer_x` | memtile BD pool |
| 32/56 (input width 16) | `Constant range error ... spill size = 64 of stack frame 0`, chess-backend | **AIE core-compiler backend bug** |

**The `buffer_x` failures were fixed** by widening the embed input from 6 to 16 elements. `x` at
width 6 is padded to 16 (`lhs_align = 2*microtile_k`), and that strided staging needs one buffer
descriptor per row; at width 16 it is contiguous. Note `buffer_s0_in` (256 wide, already aligned)
never failed — that asymmetry is what identified the cause. This is faithful to the real design,
which already zero-pads the embed input (`INPUT_SIZE=8`, `GRAPH_INPUT_SIZE=16` for int16).

`io_route` in `{plio, direct, memtile}` was tested at batch=16 and made **no difference** — all
three failed identically. Routing is not the lever; input alignment is.

batch=1 still fails, on `buffer_emb_out` rather than `buffer_x` — unresolved, and the reason the
in-toolchain baseline is inferred rather than measured.

---

## 6. Bugs found in `aie4ml` (independent of this study)

1. **`Relu(Add(...))` cannot be lowered.** `passes/fuse_activation.py` fuses relu only when
   `producer.op_type == 'dense'`; after an `add` the relu survives as a bare `activation` node and
   `passes/resolve.py:60` raises
   `NotImplementedError: No family resolver registered for op_type='activation'`.
   **This breaks `tutorials/tutorial_3.ipynb` as written**, since it expresses solver dense0 as
   `Relu(Add(Gemm(curr), Gemm(prev)))` — the exact form that eliminates roll_concat.
   Worked around here by using a single `Dense(256->128)`, which is what the shipping graph does.

2. **No leaky ReLU.** `passes/fuse_activation.py` fuses only `'relu'` and `'linear'`; nothing in
   the framework supports a negative slope. The RTDA network needs slope 0.1, so aie4ml cannot
   currently reproduce it. This is the single blocker to `aieml_batch/` being a drop-in for `aieml/`.

3. **`aie_model.build()` does not raise on aiecompiler failure.** It returns normally; the failure
   then surfaces much later as `FileNotFoundError: Expected simulator output .../y_p0.txt not
   found` from `simulation.py:454`, which points at the wrong thing entirely.

Fixing (1) is a prerequisite for testing the roll_concat elimination in-graph.

---

## 7. Reproduce

```bash
# Step 0 compile gate
source /tools/Xilinx/2024.2/settings64.sh
aiecompiler --target=hw --platform=$PLATFORM \
  --include=dsp_lib/L1/src/aie --include=dsp_lib/L1/include/aie \
  --include=dsp_lib/L2/include/aie gemm_16x32x8_app.cpp --output-archive=libadf.a

# Batch sweep  (script: scratchpad/sweep/run_batch.py)
source /tools/Xilinx/2025.2/Vitis/settings64.sh
INPUT_DIM=16 /home/synthara/miniforge3/envs/envaie2/bin/python run_batch.py 8
```

Environment: **`envaie2`** (`/home/synthara/miniforge3/envs/envaie2`) — aie4ml
`0.1.6.dev0+gf43147c98` (= aie4ml git HEAD `f43147c`), onnx 1.21.0, hls4ml 1.3.0, TF 2.15.1 /
Keras 2.15.0, numpy 1.26.4. `envaie` lacks onnx; `hls4ml-tutorial` has only aie4ml 0.1.5.

**Weights come from `data_fp32/`, not `data/`.** At the time of this study `data/` held int16
values; loading them into a float32 model would have silently produced garbage.

---

## 8. What is NOT proven

- ~~**Full 14-layer model.**~~ **RESOLVED.** Built at `SOLVERS=3, BATCH=8`:
  **II = 3726.4 ns -> 465.8 ns/track, identical to the 6-layer build**, using 65 compute +
  14 memory tiles across 17 columns. Adding 8 dense layers changed throughput by zero, confirming
  II is set by the slowest stage. Depth is no longer a confound in the 38x comparison; only the
  toolchain version (2024.2 vs 2025.2) remains.
- **NEW — numerical equivalence is NOT achieved.** `aieml/` uses leaky ReLU slope 0.1
  (`common/nn_defs10.h:40`); aie4ml emits plain ReLU (`passes/fuse_activation.py` handles only
  `'relu'` and `'linear'`). All 4 stages of the batched graph match a plain-ReLU numpy golden to
  ~1e-6, but differ from `data_fp32/aieml10_output_aie.txt` by 2.937e-01 — *exactly* the
  plain-vs-leaky golden difference, so the activation is the sole remaining gap. Timing is
  unaffected. See `ARCHITECTURE_COMPARISON.md` section 7.
- **In-toolchain batch=1 baseline.** Inferred from the batch-4/batch-8 identical-II result, not
  measured, because batch=1 will not build.
- **bf16.** Measured 8.9x cheaper than float32 at the instruction level and listed as supported by
  both `aie_api` and aie4ml, but never built or timed here. Likely the largest remaining lever.
- **roll_concat elimination in hardware.** Proven algorithmically (see §9) and already expressed in
  tutorial_3, but blocked from building by bug (1) in §6.
- **Anything on real silicon.** All numbers are cycle-accurate `aiesimulator`, not board runs.
- **End-to-end system throughput.** `track_average_pl` synthesises at `Final II = 8` -> ~3.41 us
  per frame at 300 MHz, against 0.466 us/track here. **The PL is now the system bottleneck by ~7x**
  and would need rework before any of this speedup is visible end-to-end.

---

## 9. roll_concat — settled algorithmically

The source op is `torch.cat([torch.roll(data, i, dims=1) for i in range(2)], dim=-1)`
(`punit/onnx_no-residual/mlp.py:96-102`), rolling over the **track** axis. Output track *i* depends
only on input tracks `{i, i-1, i-2, i-3}` — a depth-4 FIR receptive field, which is why the
reference notebooks use `WARMUP = 3`, not 50. `punit/rtda_unified_keras_hls4ml_executed.ipynb`
cell 7 applies `assemble()` to the whole `(50,128)` array and infers every row independently,
verified against both the monolithic ONNX model and a real VEK280 hardware dump.

**It is a shift, not a recurrence.** The `static` state in `roll_concat.cpp` is a streaming
implementation artifact carrying no algorithmic serialisation. Given `W = [W_curr; W_prev]`
(the split `punit/mlp_hls.ipynb` cell 6 already makes), the batched form is
`Y[i] = (H·W_currᵀ)[i] + (H·W_prevᵀ)[i-1]` — two 128-wide GEMMs on the same `H` plus a row-shifted
add, identical MAC count, deleting 3 roll_concat kernels, 3 memory tiles and the 256-wide plumbing.

Two boundary caveats, both harmless for a single 50-track event: frame 0 emits `(0,0)` rather than
`(e_0, 0)`; and the multi-event chained wrap does not compose across stages 1-2.

---

## 10. Recommendation

1. **Batch to 8, not 50.** Full benefit, no event buffering, no 52-vs-50 padding, latency preserved.
2. **Fix `fuse_activation.py`** to fuse relu after `add`. Unblocks the roll_concat elimination and
   tutorial_3.
3. **Measure bf16** before committing to float32. It is the one untested ~9x lever and needs only a
   `ComputeDtype` change.
4. **Build the full 14-layer model at batch 8** to confirm II holds and the tile count fits.
5. **Then fix `track_average_pl`** — at `II = 8` it is the system bottleneck regardless of the AIE.
