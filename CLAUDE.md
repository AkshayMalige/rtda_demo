# CLAUDE.md

Guidance for Claude Code working in this repository.

## What this is

RTDA track-alignment MLP on an AMD/Xilinx Versal VEK280. One network,
**three implementations**, compared against one reference on one stimulus.

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
analysis/     rtda_reference.ipynb (fp32 end to end), rtda_compare.ipynb (all three)
results/      aie_fp32/ aie_bf16/ pl_fixed/, each {sim,hw_emu,hw}
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
```

`FLOW=aie_batch|pl_fixed`, `TARGET=hw_emu|hw`, `PRECISION=fp32|bf16`
(aie_batch), `AP_W`/`AP_I`/`ALPHA125` (pl_fixed).

## Traps that have cost real time

- **`source set_envs.sh` puts PetaLinux's numpy-less python first on PATH.**
  Never run `./script.py`; go through the `make` target, which pins `$(PYTHON)`.
- **Run AIE simulations BEFORE `make system FLOW=aie_batch`.** The system build
  replaces `Work_<P>/` with the GMIO graph, which has no PLIO debug taps.
  `make link` refuses to link the wrong archive, but the workdir is still gone.
- **One AIE simulation at a time.** They share `aie_batch/data/` and
  `<sim>simulator_output/`; a lock refuses a second. Wait, do not work around.
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

## Verifying a change

```bash
make selftest                                     # reference vs ONNX + goldens + PL weights
make fastsim FLOW=aie_batch PRECISION=fp32 EVENTS=5   # PASS ~6.2e-07
make -C pl_fixed check_weights                    # worst 5.0e-11
make -C pl_fixed csim EVENTS=3                    # PASS, worst 0.000e+00
```
Then Run All on `analysis/rtda_reference.ipynb`, then `rtda_compare.ipynb`.
`RUNBOOK.md` has the full expected-values table.
