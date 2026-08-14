# HANDOFF — `aie_batch`

Design detail lives in `README.md` (this directory). For the project as a
whole, read `../README.md` then `../RUNBOOK.md`.

This file used to be the project-wide handover. Most of it has moved:

| was here | now |
|---|---|
| what the project is, both flows, the numbers | `../README.md` |
| commands, expected values, troubleshooting | `../RUNBOOK.md` |
| the roll convention and the two goldens | `../README.md`, and `../model/rtda_ref.py` implements both |
| how to change things safely | `../CLAUDE.md` |

## Known issues

Resolved since the last handover:

- ~~`host_batch.cpp` never checks `ofstream` for write errors.~~ Still true
  **here**; `../pl_fixed/host/host_split.cpp` now does, and `host_batch.cpp`
  should be brought in line. A full SD partition once produced three 0-byte
  output files while the host reported success.
- ~~`rtda_reference.ipynb` §1 "link 2" SKIPS.~~ Fixed. It looked for
  `sysdata/` after that was split into `sysdata_fp32/` / `sysdata_bf16/`.
  Fixing it exposed a second staleness — the RTP manifest grew a dtype column
  when bf16 arrived — and the check now PASSES at 0.000e+00.
- ~~`package.hw` / `build_hw` not precision-suffixed, so a second
  `make system` overwrote the first.~~ Fixed: products are stamped
  `<precision>_<target>` under `build/` and `package/`.
- ~~x86simulator prints "Simulation completed successfully" even when it
  deadlocks.~~ `run_sim.py` treats `Detected deadlock` / `ERROR:` as failure.

Still open:

1. **`track_accum` counts SLOTS, not real tracks.** A track count that is not
   a multiple of 50 gives a wrong final event mean (measured 8.0e-02 for a
   20-track event). Host and tooling warn; a real fix needs the per-event
   count delivered to the kernel.
2. **bf16 resource usage never gathered** — `Map_Report.csv` / the mapper
   section of `log.bf16`. fp32 is 65 compute + 14 memory tiles, 17 columns.
3. **`host_batch.cpp` unchecked writes**, above.

## Next steps

1. **The bf16 decision** is a physics call, not an engineering one. The
   numbers are in `../analysis/rtda_compare.ipynb`: bf16 is 526× less exact
   than fp32 for 2.5× the speed, and the error reaches ~8% of the *narrowest*
   output's own spread across events. If the analysis weights all 27 outputs
   equally that probably rules it out; if it leans on the wide ones bf16 is
   close to free.
2. If bf16 is accepted: gather its resource numbers, and look at the event
   tail (`track_out`, 1629 ns) — it is now the slowest stage and was invisible
   at fp32 speed.
3. More speed beyond bf16: the remaining lever is the `W_curr`/`W_prev` split
   that removes `roll_concat` entirely — two 128-wide GEMMs plus a row-shifted
   add, same MAC count, 3 fewer kernels. Blocked by aie4ml not fusing
   `Relu(Add(...))`. **`../pl_fixed/` already computes it this way**, so the
   weight split is done and verified (`../pl_fixed/gen_weights.py`).
4. Push the branch — it is a long way ahead of `origin/quantized` and local
   only.

## Changes made to aie4ml (separate repo, `/home/synthara/VersalPrjs/aie4ml/aie4ml`)

Three fixes, all of which failed **silently** before:

1. `templates/nnet_utils/dense_bias_relu/dense_bias_relu.cpp` — the float/int
   branch tested `std::is_floating_point_v<result_t>`, which is **false** for
   `bfloat16` (a compiler builtin, not a std float type). Every bf16 build took
   the integer branch and tripped `static_assert(SHIFT > 0)`. Now
   `!std::is_integral_v`.
2. `passes/force_float_mode.py` — `AIEConfig.ComputeDtype` only rewrote
   `QuantIntent`. A float32 ONNX arrives as `FloatIntent`, so asking for
   bfloat16 **silently produced a float32 design**, no error. Now re-casts
   float tensors too.
3. `op_impls/families/matmul/common.py` — fp32→bf16 used `(u >> 16)`, i.e.
   **truncation**: double the error *and* a bias toward zero that does not
   cancel across 264k weights and 14 layers. Now round-half-to-even. **Worth
   8× end to end** (event mean 4.13e-03 → 5.06e-04).

`gen_graph.py` pins `cas_length` because bf16's smaller weights make the
resolver choose a different cascade split (emb_d1 2→1, s\*_d0 4→2), which would
change the graph structure and confound the comparison.
