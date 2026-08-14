# HANDOFF — `aieml_batch`, state as of 2026-08-13

Context for a fresh session. Read this, then `RUNBOOK.md` for commands and `README.md` for
the design. Branch `aie-mmul`, 40 commits ahead of `origin/quantized` (**unpushed**).

---

## What this project is

RTDA track-alignment MLP on a VEK280 (AIE-ML, `xcve2802`). The network: an embedding block
(2 dense) feeding 3 chained solver blocks (4 dense each) = **14 dense layers**, each with a
fused bias + leaky-ReLU (slope 0.1). A roll-concat between blocks pairs each track with its
predecessor. 50 tracks make one **event**; the event's 128-wide mean goes through a
128→27 dense to give the deliverable, **27 outputs per event**.

Two implementations exist:

| | `aieml/` | `aieml_batch/` (this work) |
|---|---|---|
| shape | matrix × **vector**, 1 track per iteration | matrix × **matrix**, 8 tracks per iteration |
| kernel | DSPLib `matrix_vector_mul_graph` | `aie::mmul` via aie4ml-generated kernels |
| track average | PL kernel (`track_average_pl`) | in the AIE (`track_accum`) |
| PL kernels | 1 | **0** |
| measured | 17,770 ns/track | **615 ns/track fp32, 245 ns/track bf16** |

The whole point: AIE-ML's `aie::mmul` computes **M=4 rows per instruction**. Matrix-vector
uses 1 of those 4, so ¾ of every multiply is discarded. Batching to 8 (= `2 × microtile_m`,
the double-buffering granularity) wastes nothing. Batch 4 and 8 have *identical* II — that
measurement is the core result. Batching to 50 buys nothing further and does not compile.

---

## Where things stand — everything below is measured, not estimated

### fp32, silicon, 50,000 tracks
- **615.4 ns/track, 859 GOP/s**, 5.3% launch/DMA overhead
- fit over 5 track counts: `582.9 µs + 603 ns × tracks`, 3.7% from the cycle-accurate 582.5
- **28.9×** vs `aieml/`
- accuracy vs the ONNX golden, warm-up excluded: **7.5e-07**
- x86simulator ≡ aiesimulator **bit-identical** (0.000e+00); hardware differs from both by 9.2e-07

### bf16, silicon, 50,000 tracks
- **244.5 ns/track, 2161 GOP/s** — **2.52×** faster than fp32
- II 1033 ns vs fp32's 4161 → the array alone is **4.03×** faster
- the gap (4.03 vs 2.52) is data movement: DMA and per-`graph.run()` host cost do not scale
  with precision. The event tail (`track_out`, 1629 ns) is now the slowest stage.
- weights 523 KB vs 1039 KB; input DMA halved
- accuracy vs the golden, warm-up excluded: **3.96e-04** (526× worse than fp32)
- **fp32 vs bf16 directly on hardware**, 1000 events: worst 8.005e-04, median 3.363e-04.
  That is the pure precision cost — same stimulus, weights, roll, accumulator.

### The accuracy question, stated properly
- 0.93% of **full scale** (largest of the 27 outputs = 0.0914) — but that flatters bf16
- the 27 outputs have std 0.00052 … 0.01523 across events, a **29× range**
- the bf16 error is **~7.6% of the narrowest output's own spread**, ~2.6% of the widest

**This is the one open decision and it is a physics call, not an engineering one:** if the
analysis weights all 27 outputs equally, 7.6% on the narrow ones probably rules bf16 out;
if it leans on the wide ones, bf16 is close to free for a 2.5× speedup.

---

## Two conventions that look like bugs and are not

**1. The roll-concat differs from the reference, always, in both precisions.**
The ONNX rolls *circularly* inside a 50-track event (track 0 pairs with track 49). Doing
that requires buffering all 50 tracks before starting — the exact thing that makes the
batched design fast. The array *streams*, so track 0 pairs with whatever preceded it.
The network's receptive field is 4 tracks deep, so **exactly tracks 0, 1, 2 of every event
differ**, by ~1e-1, while tracks 3..49 agree to ~4e-06.

Consequences you will see:
- "27 outputs **with** warm-up" is ~7e-03 for every implementation. **Not an error.** The
  reference disagrees with *itself* by 1.556e-02 between the two conventions.
- Only the "**without** warm-up" number measures precision.
- Hardware can only produce the *with* number — the system build has no per-track PLIO
  taps, so the contamination cannot be removed after the fact. Simulation has the taps.

**2. Two goldens exist and they are not interchangeable.**
- `testdata/golden_50000.{npz,txt}` — models the **streaming** roll, i.e. what the hardware
  does. Used by the board's own `RTDA_GOLDEN=` self-check, which passes at ~1.5e-06.
- `notebooks/out/golden_onnx_50000.npz` — from `mlp_fp32.onnx`, **circular** roll. The
  physics truth, and what both notebooks compare against.

Do not pass `RTDA_GOLDEN=` on a **bf16** board run: the on-board tolerance is hard-coded to
1e-4 and bf16 lands near 5e-4, producing a false FAIL.

---

## Layout

```
aieml_batch/
  RUNBOOK.md          <- commands, clean build to notebooks, both precisions
  README.md           <- design: batching, padding, weights, host, precision (§11)
  HANDOFF.md          <- this file
  src_fp32/  src_bf16/    committed generated sources; weights ALREADY in that dtype
  aie_pipeline_fp32.json  aie_pipeline_bf16.json    PLIO layout per precision
  app.cpp  aie.cfg        shared between precisions
  *.py                    tooling, numpy-only (no aie4ml at build time)
  notebooks/
    rtda_reference.ipynb      fp32 end to end; §3 writes the ONNX reference
    rtda_bf16_vs_fp32.ipynb   both precisions; needs the above run first
    out/                      generated npz + png (gitignored)
  results/
    sim_events/   sim_<sim>_<precision>_<N>ev_<T>tr.npz
    hw/           fp32 board run     (track_means_all.txt, run_info.txt)
    hw_bf16/      bf16 board run
host_batch/host_batch.cpp   XRT host, ONE binary serves both precisions
```

`PRECISION=fp32|bf16` selects everything: `src_<P>/`, `Work_<P>/`, `libadf_<P>.a`,
`sysdata_<P>/`, `log.<P>`. Both coexist; switching never rebuilds the other.

**`package.hw` and `build_hw` are NOT precision-suffixed** — a second `make system`
overwrites the first. Rename them (`package.hw_fp32`, `package.hw_bf16`) between builds.
Both current images exist and are verified correct; tell them apart with
`cat package.hw_<P>/sd_card/sd_batch/sysdata/config.txt`.

---

## Changes made to aie4ml (separate repo, `/home/synthara/VersalPrjs/aie4ml/aie4ml`)

Three fixes, **all of which failed silently** before:

1. `templates/nnet_utils/dense_bias_relu/dense_bias_relu.cpp` — the float/int branch tested
   `std::is_floating_point_v<result_t>`, which is **false** for `bfloat16` (a compiler
   builtin, not a std float type). Every bf16 build took the integer branch and tripped
   `static_assert(SHIFT > 0)`. Now `!std::is_integral_v`.
2. `passes/force_float_mode.py` — `AIEConfig.ComputeDtype` only rewrote `QuantIntent`. A
   float32 ONNX arrives as `FloatIntent`, so asking for bfloat16 **silently produced a
   float32 design**, no error. Now re-casts float tensors too.
3. `op_impls/families/matmul/common.py` — fp32→bf16 used `(u >> 16)`, i.e. **truncation**:
   double the error *and* a bias toward zero that does not cancel across 264k weights and
   14 layers. Now round-half-to-even. **Worth 8× end to end** (event mean 4.13e-03 → 5.06e-04).

Also `gen_graph.py` pins `cas_length`: bf16's smaller weights make the resolver choose a
different cascade split (emb_d1 2→1, s\*_d0 4→2), which would change the graph structure and
confound the comparison.

---

## Known issues, in priority order

1. **`host_batch.cpp` never checks `ofstream` for write errors.** A full SD partition
   produced three 0-byte output files while the host reported success. Cost an hour of
   confusion. Should verify and fail loudly.
2. **`rtda_reference.ipynb` §1 "link 2" SKIPS.** It looks for `aieml_batch/sysdata/`, which
   was split into `sysdata_fp32/` / `sysdata_bf16/`. The check (`data_fp32` == the 92 RTP
   payloads) last passed at 0.000e+00. One-line fix.
3. **`package.hw` / `build_hw` not precision-suffixed** — see above.
4. **`track_accum` counts SLOTS, not real tracks.** A track count that is not a multiple of
   50 gives a wrong final event mean (measured 8.0e-02 for a 20-track event). Host and
   tooling warn; a real fix needs the per-event count delivered to the kernel.
5. **bf16 resource usage never gathered** — `Map_Report.csv` / the mapper section of
   `log.bf16`. fp32 is 65 compute + 14 memory tiles, 17 columns.
6. `x86simulator` prints "Simulation completed successfully" **even when it deadlocks**.
   `run_sim.py` now treats `Detected deadlock` / `ERROR:` as failure regardless.

---

## Traps that cost real time (do not rediscover these)

- **`source set_envs.sh` puts PetaLinux's numpy-less python first on PATH.** Never run
  `./script.py`; always go through the `make` target, which pins `$(PYTHON)`.
- **Run simulations BEFORE `make system`.** The system build replaces `Work_<P>/` with the
  GMIO `SYSTEM_BUILD`, which has no PLIO debug taps.
- **One simulation at a time.** All runs share `data/` and `<sim>simulator_output/`; a lock
  in `run_sim.py` refuses a second one.
- **Check `sd_batch/sysdata/config.txt` before flashing.** A mismatched xclbin/sysdata pair
  fails on the board with `parameter size 4096 bytes is inconsistent with ... 8192 bytes`
  (8192 = 2048×4 → fp32 port; 4096 = 2048×2 → bf16 payload).
- **`sync` before `umount`** when copying off the board, and check sizes before unmounting.
- Weights come from `data_fp32/`, **never** `data/` — the latter is swapped by hand to int16.
- Tensor dimensions must be **multiples of 16 elements** or memtile buffer descriptors are
  exhausted (this is why `INPUT_DIM=16`).

---

## Suggested next steps

1. **Decide on bf16** using the per-output numbers above. Everything else waits on that.
2. Fix issues 1 and 2 (both small, both affect trust in results).
3. If bf16 is accepted: gather its resource numbers, and consider whether the event tail
   (now the slowest stage at 1629 ns) is worth optimising — it was invisible at fp32 speed.
4. If more speed is wanted beyond bf16: the remaining lever is the `W_curr`/`W_prev` split
   that removes `roll_concat` entirely (two 128-wide GEMMs plus a row-shifted add, same MAC
   count, 3 fewer kernels). Blocked by aie4ml not fusing `Relu(Add(...))`.
5. Push the branch — 40 commits are local only.

---

## Verifying the state you inherited

```bash
cd /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo
git log --oneline -1                      # e052b24
ls aieml_batch/results/hw/ aieml_batch/results/hw_bf16/     # 4 files each, ~1.7 MB means
ls aieml_batch/results/sim_events/*.npz                     # both precisions, x86 + aie
jupyter lab aieml_batch/notebooks/rtda_reference.ipynb      # Run All, ~6 s, 0 errors
```

Expected headline numbers are tabulated in `RUNBOOK.md` under "Expected values". If a
number is far off, that table says what it should have been.
