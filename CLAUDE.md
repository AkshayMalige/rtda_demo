# CLAUDE.md

Guidance for Claude Code working in this repository.

## What this is

RTDA track-alignment MLP on an AMD/Xilinx Versal VEK280. One network,
**three implementations** plus a host-CPU baseline, compared against one
reference on one stimulus.

Network: embedding block (2 dense) → 3 chained solver blocks (4 dense each) =
**14 dense layers**, each with a fused bias + leaky-ReLU **slope 0.1**. A
roll-concat before each solver pairs every track with its predecessor. **50
tracks = 1 event**; the event's 128-wide mean goes through a 128→27 dense to
give **27 outputs per event**.

Read `README.md` for the design and the measured numbers, `RUNBOOK.md` for
commands, and `docs/aie_ml_batched_design.md` for how the AIE mapping works
(the mmul atom, cascades, weight packing, memtile tiling). This file is the
orientation for making changes.

## Two things that cause wrong answers here

**1. The roll convention.** The ONNX reference rolls *circularly* inside an
event (track 0 pairs with track 49); every hardware implementation *streams*
(each track pairs with whatever preceded it). They disagree on exactly tracks
0, 1, 2 by ~1e-1, while tracks 3..49 agree to ~4e-06. So:

- "WITHOUT warm-up" (tracks 3..49) measures **arithmetic**.
- "WITH warm-up" (all 50) measures the **convention**, ~7e-03 for everything.
  The reference disagrees with *itself* by 1.556e-02 between the two.

Never compare a run made with `warmup=3` against the all-50 reference. The
code does not guess: `run_info.txt` records the convention, and both notebooks
read it.

**2. `model/weights_fp32/` is the only weight directory.** Every flow reads it.
`archive/data/` was overwritten with random int16 by `gen_int16_data.py` in
Aug 2026 and is retained only for the archived design; `set_envs.sh` no longer
exports `DATA_DIR`.

## Layout

```
model/        mlp_fp32.onnx, weights_fp32/, rtda_ref.py, weights.py
              rtda_ref.py is THE numpy implementation -- roll='circular'|
              'streaming', quant='bf16'|fixed(W,I). There used to be four
              copies of this forward pass and they had drifted.
testdata/     stimulus + goldens (generated: `make golden`)
aie_batch/    AIE-ML aie::mmul design, PRECISION=fp32|bf16, + its XRT host
pl_fixed/     PL-only HLS ap_fixed design + a native bit-accurate model
cpu/          the host-CPU baseline: the SAME rtda_ref.forward, threaded.
              No XRT, no Vitis, no card -- `make -C cpu scan_host`, ~40 s.
gpu/          the NVIDIA baseline. rtda_torch.py is the ONE second copy of the
              forward pass; it is gated against rtda_ref at fp64 every run.
              Runs on another machine -- `make -C gpu tarball`.
analysis/     rtda_reference.ipynb (fp32 end to end), rtda_compare.ipynb (all three),
              rtda_scan.ipynb (latency scaling; section 8 is the CPU baseline)
results/      aie_fp32/ aie_bf16/ pl_fixed/, each {sim,hw_emu,hw}; cpu/native/
archive/      the retired 1-track GEMV design (aieml/, pl/, host/, dsp_lib/)
```

Stale duplicate trees (`aieml_float32/`, `aieml_int16/`, `aieml_batch_fp32/`,
`hls_projects*/`, `data_backup*/`, `tmp_bkp/`, `hw_out_*/`) are on disk and
gitignored **on purpose**. Their sources were verified byte-identical to what
is tracked. Do not build against them and do not delete them without asking.

## Commands

The root Makefile is a dispatcher; each flow owns its complete build.

```bash
source set_envs.sh                                    # required in every shell
make help

make golden TRACKS=50000                              # stimulus + reference

make fastsim  FLOW=aie_batch PRECISION=fp32 EVENTS=5  # x86simulator
make exactsim FLOW=aie_batch PRECISION=bf16 EVENTS=5  # aiesimulator (slow)
make fastsim  FLOW=pl_fixed EVENTS=1000               # native ap_fixed, ~95 s
make -C pl_fixed sweep                                # which ap_fixed format?
make -C pl_fixed csim                                 # Vitis csim vs the native model
make -C pl_fixed csynth                               # resources + timing

make system FLOW=aie_batch PRECISION=bf16 TARGET=hw
make run    FLOW=pl_fixed TARGET=hw_emu               # 5 events on QEMU

make fastsim   FLOW=cpu                               # CPU baseline correctness
make scan_host FLOW=cpu                               # 1..10000 events x 1..32 threads

make -C gpu selftest                                  # torch vs rtda_ref, NO GPU needed
make -C gpu tarball                                   # 1.4 MB bundle for the GPU server
make collect_scan FLOW=gpu FROM=<dir>                 # file what comes back

tools/sync_results.sh [SRC_TREE]                      # pull a build tree's artefacts
```

`FLOW=aie_batch|pl_fixed|cpu|gpu`, `TARGET=hw_emu|hw`, `PRECISION=fp32|bf16`
(aie_batch), `AP_W`/`AP_I`/`ALPHA125` (pl_fixed).

## Traps that have cost real time

- **`source set_envs.sh` puts PetaLinux's numpy-less python first on PATH.**
  Never run `./script.py`; go through the `make` target, which pins `$(PYTHON)`.
- **Run AIE simulations BEFORE `make system FLOW=aie_batch`.** The system build
  replaces `Work_<P>/` with the GMIO graph, which has no PLIO debug taps.
  `make link` refuses to link the wrong archive, but the workdir is still gone.
- **One AIE simulation at a time.** They share `aie_batch/data/`, the PLIO
  *inputs*; a lock refuses a second. Wait, do not work around. The *outputs* are
  per configuration -- `<sim>simulator_output_<P>_ev<N>/`, derived from the
  workdir by `run_sim.output_dir()`, which is the only place that name is
  spelled. They used to share one directory, and a bf16 run destroyed the fp32
  one.
- **Check `sd_stage/<P>/sysdata/config.txt` before flashing.** A mismatched
  xclbin/sysdata pair fails on the board with `parameter size 4096 bytes is
  inconsistent with ... 8192 bytes` (8192 = 2048×4 → fp32; 4096 = 2048×2 → bf16).
- **`sync` before `umount`** when copying results off the board.
- **Do not pass paths to HLS as `-DFOO="..."`.** The quotes do not survive Tcl
  plus the csim makefile Vitis generates, and the path arrives as bare
  identifiers. The testbench and `nnet_helpers` read `RTDA_STIMULUS`,
  `RTDA_TB_REFERENCE`, `RTDA_WEIGHTS_DIR` from the environment instead.
- **Tensor dimensions must be multiples of 16 elements** in the AIE graph or
  memtile buffer descriptors are exhausted (this is why `INPUT_DIM=16`).
- **bf16 tolerance is 5e-2, fp32 is 1e-4**, set from `RTDA_PRECISION` which only
  `make` exports. Invoking `crosscheck.py` by hand FAILs for the wrong reason.
- **The AIE II is the interval at the event tail, in steady state.** `make report`
  averaged all nine output ports until 2026-09-14 and read bf16 at 1033 ns; the
  tail runs at 1650 ns, set by `track_accum` (fp32: 4172 ns). Use
  `make exactsim EVENTS=10` then `make -C aie_batch report EVENTS=10` — a 7-iteration
  `crosscheck` is too short. Board scans from before then carry the old `ii_ns` in
  `us_modelled`: recompute it, do not read that column.

## Changing the PL number format

Everything resolves through `pl_fixed/pl/src/rtda_fixed.h`. Do not put
`ap_fixed<...>` literals back into the generated `firmware/*/defines.h`.

Order of operations: `make -C pl_fixed sweep` (numpy screening, ~1 min, ranks
formats and reports clipping) → `make fastsim FLOW=pl_fixed` (the real kernel
sources; this is the ground truth) → `make -C pl_fixed csynth` (does it still
fit and close timing?).

The numpy screening model is ~2× optimistic in absolute terms; it is for
ranking. `make -C pl_fixed validate` prints the gap.

The leaky slope is 0.1, computed as `2^-4 + 2^-5 + 2^-8 + 2^-9` in
`rtda_leaky.h` so it stays DSP-free — **verified: csynth gives 1057 DSP, the
same as the 0.125 design.** `ALPHA125=1` rebuilds the legacy variant for
comparison; it is 33× worse and should not be the default again.

**Open: LUT.** The realignment took the HLS estimate from 108% to 231% and the
design has not been placed and routed. `pl_fixed/RESOURCES.md` has the
breakdown and the two candidate fixes; the first (giving `rtda_weight_t` the
plain ap_fixed defaults, since weights are compile-time constants) looks free.
Do not promise the design fits until `make system FLOW=pl_fixed TARGET=hw`
has run.

Rounding and saturation modes are not free in this design. Keep them on the
activations, where the error is, and nowhere else — see the notes in
`rtda_fixed.h`.

## The CPU baseline

`cpu/` runs `model/rtda_ref.forward(roll='streaming')` -- **the** reference, not
a copy -- across a thread pool, so the accelerators have something other than
each other to be compared against. `cpu/README.md` has the reasoning; three
things matter when touching it:

- **Every thread count uses the same 50-event chunk.** Unchunked, 8 threads
  measured *superlinear* 9.6x. That was cache, not parallelism: the 1-thread run
  was streaming 20 MB activation arrays out of DRAM. Do not "optimise" the chunk
  size per thread count -- it makes the scaling number meaningless.
- **`scan_cpu.py` re-execs itself** to raise `MALLOC_MMAP_THRESHOLD_`. numpy's
  ~1.3 MB per-layer temporaries land above glibc's *dynamic* mmap threshold, so
  every reuse re-faults every page. Measured at 10000 events: 32 threads went
  16.1 -> 84.7 us/event and `sys` time 0.8 s -> 21 s, and it looked exactly like
  the CPU failing to scale past 16 threads. It is not reproducible run to run
  either, because the threshold adapts. The vars are read by glibc at process
  start, so `os.environ` alone is too late.
- **`forward(dtype=np.float32)`** is what makes it comparable to fp32 hardware.
  Passing float32 weights alone does nothing: `x`, `_pad_rows`'s zero-extension
  and `_roll_pair`'s zero head all default to float64 and drag the chain back
  up. `dtype=None` is the default and is the old behaviour exactly, so the
  goldens are untouched -- `make selftest` is the gate and must show
  `0.000e+00`.

Measured, 10000 events, fp32, on the EPYC 9354P: 305.9 us/event at 1 thread,
40.0 at 8, 15.9 at 32. AIE-ML fp32 is 30.1 and bf16 11.9, so **16 CPU threads
match the fp32 design and 32 do not reach bf16**; `pl_fixed` at 4733 us/event
is slower than a single CPU thread.

## The GPU baseline

`gpu/rtda_torch.py` is the **only second copy of the forward pass** in this
repo. `cpu/` has none -- it calls `R.forward` -- but torch cannot execute numpy
on a card. `rtda_ref.py` exists because four copies once drifted, so the defence
here is a gate, not care: every `--check` compares torch fp64 against rtda_ref
fp64 and must land at ~1e-15 (measured 1.4e-15). If you touch either file, that
number is what tells you whether they still agree.

Three traps, all handled in `scan_gpu.py`, all easy to reintroduce:

- **CUDA is asynchronous.** `perf_counter()` around a torch call times the
  *launch*. Every phase is bracketed by `torch.cuda.synchronize()` and the
  kernel phase is cross-checked with CUDA events.
- **TF32.** Torch can run "float32" matmuls at ~10-bit mantissa on this
  hardware -- ~1e-3 error where fp32 gives ~1e-6, worse than bf16, still
  labelled fp32. Both backend flags are set per variant and recorded;
  `variant=tf32` measures it deliberately.
- **A busy card.** The preflight refuses a GPU with memory in use. It protects
  the measurement and whoever else is on it.

`--allow-cpu` runs the sweep with no GPU to exercise the harness. Those rows are
stamped, refuse to be written to `results/gpu/native/`, and the notebook refuses
to plot them. Never use it for a number.

Only `mode=single` is comparable to the other flows. `fresh` and `graph` are
diagnostics, like `pl_fixed`'s `reuse` and `tpc`.

**Score the GPU on its best point, not its largest run.** It is the only
non-monotone curve here. Measured on an L40S, and tested rather than assumed:
fp32 and tf32 peak at 500 events, bf16 at 1000 -- all three at the SAME 12.8 MB
(n,128) activation, and bf16's turn point is exactly 2.0x fp32's because its
tensors are half the size. That is a cache effect, not a run-size effect: 96 MB
of L2, and each of the 14 layers reads and writes one of those tensors. By 10000
events it is 2.3x (fp32) to 3.0x (bf16) off its own best. `rtda_scan.ipynb` §8
takes the minimum across the sweep, which changes nothing for the others.

The small-batch floor is **device-side** per-kernel launch, not host dispatch --
cuda events put the GPU at 95% busy at one event, host ~25 us of ~558. `mode=graph`
takes it 558 -> 139 us. That prediction was wrong before it was measured, which is
why the control is in the sweep rather than in a comment.

## Running the notebooks without a build tree

`results/` is gitignored, so a fresh clone has no scan, power or csynth
artefacts and the notebooks quietly fall back instead of failing --
`_pl_fabric()` in particular reports a hardcoded constant. `tools/sync_results.sh`
copies the ~1.7 MB (plus the 63 MB scan stimulus) from a build tree. Run
`rtda_reference.ipynb` first: it writes `analysis/out/golden_onnx_50000.npz`,
which `rtda_compare.ipynb` requires and will not accept a stale copy of.

## Verifying a change

```bash
make selftest                                     # reference vs ONNX + goldens + PL weights
make fastsim FLOW=aie_batch PRECISION=fp32 EVENTS=5   # PASS ~6.2e-07
make -C pl_fixed check_weights                    # worst 5.0e-11
make -C pl_fixed csim EVENTS=3                    # PASS, worst 0.000e+00
make fastsim FLOW=cpu                             # chunk + threads bit-identical
make -C gpu selftest                              # torch vs rtda_ref, ~1.4e-15
```
Then Run All on `analysis/rtda_reference.ipynb`, then `rtda_compare.ipynb`.
`RUNBOOK.md` has the full expected-values table.
