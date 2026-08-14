# RUNBOOK — from a clean tree to the comparison plots

Copy-paste, top to bottom. Both AIE precisions and the PL design are written
out; nothing is left as "repeat for the other one". **~3 h**, most of it
unattended, and Phase 6 alone if you only want the analysis.

```
REPO = /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo
```

Four rules. Breaking any of them is what has gone wrong before:

1. **`source set_envs.sh` in every new shell** before any `make`.
2. **AIE simulations BEFORE `make system FLOW=aie_batch`.** The system build
   replaces `Work_<P>/` with the GMIO graph, which has no PLIO debug taps.
   (`make link` now refuses if the archive is the wrong one, but the workdir is
   still gone.)
3. **One AIE simulation at a time.** Every run in `aie_batch/` shares `data/`
   for PLIO input and `<sim>simulator_output/` for output; a lock refuses a
   second one. Do not work around it, wait.
4. **Never run `./script.py` directly.** `set_envs.sh` puts PetaLinux's
   numpy-less python first on PATH. The `make` targets pin an interpreter that
   has numpy.

---

# PHASE 0 — clean

```bash
cd $REPO && source set_envs.sh
make clean_all
```
**~1 min.** Removes `Work_*/`, `libadf*.a`, logs, simulator output, `build/`,
`package/`, `sd_stage/`, the HLS project and the native binaries.

**Keeps** deliberately: `model/`, `aie_batch/src_*/`, `pl_fixed/pl/`,
`testdata/`, `results/`, `analysis/`. Nothing you need is destroyed.

A *total* reset including gathered results:
```bash
rm -rf results/*/sim results/*/hw results/*/hw_emu analysis/out
```

---

# PHASE 1 — reference data (once, shared by everything)

```bash
make golden TRACKS=50000
```
**~2 min.** Writes to `testdata/`:

```
embed_input_50000.txt     6.4 MB   the stimulus EVERYTHING is driven by
golden_50000.npz          1.2 MB   streaming-roll golden, 1000 event means
golden_50000.txt          2.0 MB   the same, for the board's RTDA_GOLDEN= check
```

**Checkpoint:**
```bash
make selftest
```
Expect `numpy vs ONNX 3.9e-08 ok`, `tracks 3..49 circular vs streaming 0.0 ok`,
`PASS`, then every `golden_*.npz` reproducing at `0.000e+00`, then the 36 PL
weight tensors at `5.0e-11`.

(Run it through `make`, not as `python model/rtda_ref.py` — rule 4.)

---

# PHASE 2 — AIE fp32

```bash
cd $REPO
make fastsim  FLOW=aie_batch PRECISION=fp32 EVENTS=5     # ~2 min  PASS ~6.2e-07
make exactsim FLOW=aie_batch PRECISION=fp32 EVENTS=5     # ~25 min PASS, same magnitude
```
→ `results/aie_fp32/sim/sim_{x86,aie}_fp32_5ev_250tr.npz`

The timing number:
```bash
cd aie_batch
make graph PRECISION=fp32 && make crosscheck PRECISION=fp32 && make report PRECISION=fp32
```
**~12 min.** Prints **II ≈ 4161 ns, 582.5 ns/track, ~1016 GOP/s**.

> Write those down. They are not saved to a file, and
> `analysis/rtda_compare.ipynb` carries them as the constant `II_NS`.

---

# PHASE 3 — AIE bf16

Same commands, `PRECISION=bf16`. Nothing from Phase 2 is disturbed — every
product is precision-suffixed and both coexist.

```bash
cd $REPO
make fastsim  FLOW=aie_batch PRECISION=bf16 EVENTS=5     # ~2 min,  worst ~5.1e-04
make exactsim FLOW=aie_batch PRECISION=bf16 EVENTS=5     # ~20 min
cd aie_batch && make graph PRECISION=bf16 && make crosscheck PRECISION=bf16 && make report PRECISION=bf16
```
Expect **II ≈ 1033 ns, 144.6 ns/track, ~3654 GOP/s**.

The bf16 tolerance auto-relaxes to 5e-2 — that is a property of the arithmetic,
not of the design. Set by `RTDA_PRECISION`, which only `make` exports, so
invoking `crosscheck.py` by hand FAILs at ~5e-03 for the wrong reason.

**Checkpoint — four npz, two per precision:**
```bash
ls -la results/aie_*/sim/*.npz
```

---

# PHASE 4 — the PL-only ap_fixed design

No board and no Vitis needed for the numbers.

```bash
cd $REPO
make -C pl_fixed sweep   EVENTS=20     # ~1 min   which format? (numpy screening)
make fastsim FLOW=pl_fixed EVENTS=1000 # ~95 s    the real kernel sources, 50,000 tracks
```
→ `results/pl_fixed/sim/{track_means_all.txt,track_out_27.txt,run_info.txt}`

Expect **3.539e-04** on the 27 outputs (0.413% of full scale), **0.38× the bf16
error** over the same 1000 events. The sweep prints the clipping margin;
`<16,3>` should show `0.0000%`.

> That 0.34× compares against bf16 *modelled* over the same 1000 events.
> `analysis/rtda_compare.ipynb` quotes 1.7×, comparing against the *measured*
> AIE bf16 run, which only has the per-track taps a warm-up-excluded number
> needs for 5 events. Different comparators, both like-for-like; neither is a
> 1000-event measured bf16, because no such thing exists (the AIE system build
> has no per-track taps).

Verify the toolchain agrees with that, and check resources:
```bash
make -C pl_fixed csim   EVENTS=3       # ~3 min   PASS, worst 0.000e+00
make -C pl_fixed csynth                # ~5 h!    DSP must not exceed 1057
```
`csynth` is slow -- 'Checking Synthesizability' alone is ~100 min. Results and
the comparison against the pre-realignment design are in `pl_fixed/RESOURCES.md`.
**DSP comes out at 1057 (80%), unchanged, so alpha=0.1 is free. LUT does not:
the estimate went 108% -> 231%, and the design has not been through place and
route.** Read RESOURCES.md before assuming it fits.
`csim` compares against the native model — same sources, different compiler —
so it should be **bit-identical**, and a difference means the HLS front end
changed the semantics of the C++.

Other formats, without editing anything:
```bash
make fastsim FLOW=pl_fixed AP_W=18 AP_I=3      # wider word
make fastsim FLOW=pl_fixed ALPHA125=1          # the legacy 0.125 leaky slope
```
Each variant files its results under its own tag, so they cannot overwrite each
other.

---

# PHASE 5 — hardware

### 5a. AIE, per precision

```bash
cd $REPO
make system FLOW=aie_batch PRECISION=fp32 TARGET=hw     # ~1 h
```

**Before flashing, check the two halves match:**
```bash
cat aie_batch/sd_stage/fp32/sysdata/config.txt      # MUST read: precision=fp32
ls -la aie_batch/libadf_fp32.a
```
A mismatched pair fails on the board with
`adf::graph::update parameter size 4096 bytes is inconsistent with ... 8192 bytes`
(8192 = 2048×4 → an fp32 port; 4096 = 2048×2 → a bf16 payload).

Write `aie_batch/package/fp32_hw/sd_card.img` to the SD card and boot. Then:
```bash
sudo su
mount /dev/mmcblk0p1 /mnt && mount -o remount,rw /mnt && cd /mnt

RTDA_INPUT=sd_batch/testdata/embed_input_50000.txt \
RTDA_GOLDEN=sd_batch/testdata/golden_50000.txt \
./host_batch.exe
```
First line must read `[host] graph input dtype: float32`. Expect the on-board
check to **PASS at ~1.5e-06**.

> **No `RTDA_GOLDEN=` for bf16.** That check is hard-coded to 1e-4 and bf16
> lands near 5e-4, so it reports a FAIL that is only the tolerance. The
> notebook does that comparison properly.

Copy off:
```bash
mkdir -p /mnt/usb && mount /dev/sda1 /mnt/usb
cp track_means_all.txt run_info.txt /mnt/usb/
sync && umount /mnt/usb      # sync is NOT optional -- without it you get a truncated file
poweroff
```
Land them in **`results/aie_fp32/hw/`** (bf16 → `results/aie_bf16/hw/`).
Do not mix them.

Repeat with `PRECISION=bf16`. The build products are stamped
`<precision>_<target>`, so the second build cannot overwrite the first.

### 5b. PL

```bash
make system FLOW=pl_fixed TARGET=hw        # ~1.5 h (synthesis + place & route)
```
Flash `pl_fixed/package/ap16_3_hw/sd_card.img`, boot, then:
```bash
RTDA_INPUT=embed_input_50000.txt RTDA_WARMUP=3 ./host_split.exe system.xclbin
```
→ `results/pl_fixed/hw/`. It should match `results/pl_fixed/sim/` to float
round-off; that is the point of the native model.

**hw_emu is a 5-event tool.** ~2 ms/event of RTL simulation makes 1000 events
impractical, which is why the native model exists:
```bash
make run FLOW=pl_fixed TARGET=hw_emu EVENTS=5
```

---

# PHASE 6 — the notebooks

### Environment, once
Needs `numpy onnx onnxruntime matplotlib`:
```bash
/home/synthara/miniforge3/envs/envaie2/bin/pip install onnxruntime matplotlib
```
Both notebooks are set to the generic `python3` kernel, so whichever
interpreter runs Jupyter is the one they use.

### Run, in this order
```bash
cd $REPO
jupyter lab analysis/rtda_reference.ipynb
```
**Run All, ~2 min.** This one MUST go first — its §3 writes
`analysis/out/golden_onnx_50000.npz`, the ONNX reference the second notebook
loads. It analyses fp32 end to end and closes the weight chain.

```bash
jupyter lab analysis/rtda_compare.ipynb
```
**Run All, ~1 min.** All three implementations against that reference.

Neither needs editing. They discover runs from `results/` and read each run's
own `run_info.txt` for its warm-up convention.

---

# Where results go, and what you have to copy yourself

**Simulation files itself. Hardware does not.** Everything the notebooks read
lives under `results/<impl>/`, and the rule is simply whether the run happened
on this machine.

| command | writes | automatic? |
|---|---|---|
| `make fastsim FLOW=aie_batch PRECISION=<P>` | `results/aie_<P>/sim/sim_x86_*.npz` | **yes** |
| `make exactsim FLOW=aie_batch PRECISION=<P>` | `results/aie_<P>/sim/sim_aie_*.npz` | **yes** |
| `make fastsim FLOW=pl_fixed` | `results/pl_fixed/sim/{track_means_all,track_out_27,run_info}.txt` | **yes** |
| `make -C pl_fixed sweep` | `results/pl_fixed/sweep.npz` | **yes** |
| `make golden TRACKS=N` | `testdata/embed_input_N.txt`, `golden_N.{npz,txt}` | **yes** |
| `make -C aie_batch crosscheck` / `report` / `x86` | nothing — prints to the terminal | n/a |
| `make -C pl_fixed csim` / `csynth` | nothing under `results/` (HLS reports stay in `pl_fixed/rtda_split_hls/`) | n/a |
| **any board or hw_emu run** | the host writes into its own working directory | **NO — copy it** |

## Copying a hardware run

Both hosts write the same three files into the directory they are run from
(the PL host takes `RTDA_OUTDIR=` to change that):

    track_means_all.txt    the 1000 event means -- this is the one that matters
    track_out_27.txt       the last event through the on-chip output dense
    run_info.txt           timing, sizes, and the warm-up convention used

They must land in **exactly one** of these, and which one is not guessable from
the files:

    results/aie_fp32/hw/        AIE, PRECISION=fp32, on the board
    results/aie_bf16/hw/        AIE, PRECISION=bf16, on the board
    results/pl_fixed/hw/        PL, on the board
    results/aie_fp32/hw_emu/    the same three, from QEMU
    results/pl_fixed/hw_emu/

**Getting this wrong is silent.** An fp32 run dropped into `results/aie_bf16/hw/`
produces a plausible table in which bf16 looks as accurate as fp32. Use the
helper rather than `cp`:

```bash
make collect FROM=/mnt/usb FLOW=aie_batch PRECISION=fp32 TARGET=hw
make collect FROM=/mnt/usb FLOW=pl_fixed  TARGET=hw
```

It refuses if the three files are not all present, and prints the destination
and each file's size so a truncated copy is visible immediately. (`sync` before
`umount` on the board -- without it the copy can sit in cache.)

To do it by hand:

```bash
mkdir -p results/aie_fp32/hw
cp /mnt/usb/{track_means_all.txt,track_out_27.txt,run_info.txt} results/aie_fp32/hw/
```

## Checking what you have

```bash
make results        # every run currently on disk, with its event count and warm-up
```


---

# Expected values

| check | AIE fp32 | AIE bf16 | PL ap_fixed |
|---|---|---|---|
| ONNX == `model/weights_fp32` | 7.451e-09 | same reference | same reference |
| `weights_fp32` == the 92 RTP payloads | 0.000e+00 | — | n/a (compiled in) |
| PL weights vs the model | — | — | 5.0e-11 |
| ONNX == numpy reference, 50 tracks | 8.831e-07 | same | same |
| x86 / aiesim, event mean vs golden | ~6e-07 | ~5e-04 | — |
| **27 outputs, warm-up EXCLUDED** | **7.5e-07** | **4.0e-04** | **3.5e-04** |
| 27 outputs, with warm-up | ~7e-03 | ~7e-03 | n/a |
| csim vs the native model | — | — | 0.000e+00 |
| II (aiesimulator) | 4161 ns | 1033 ns | n/a |
| ns/track, cycle-accurate | 582.5 | 144.6 | — |
| ns/track, silicon (50k tracks) | 614.3 | 249.3 | ~40,000 |
| GOP/s, silicon | 860 | 2120 | — |
| RTP weights | 1039 KB | 523 KB | n/a |
| on-board `RTDA_GOLDEN` check | PASS ~1.5e-06 | do not use | n/a |

**The ~7e-03 "with warm-up" row is not an error.** It is the roll-concat
convention: the reference wraps circularly inside an event, the array streams.
The reference disagrees with *itself* by 1.556e-02 between the two. Only the
without-warm-up row measures precision. See README.md.

---

# When it goes wrong

| symptom | cause and fix |
|---|---|
| `ModuleNotFoundError: numpy` from a script | you ran `./script.py` after `source set_envs.sh`. Use the `make` target. |
| `another simulation is already running` | `ps -ef \| grep -E "x86simulator\|aie2simmsm"`. Wait, or remove `aie_batch/.sim.lock` if nothing is alive. |
| `make link` says the archive is the PLIO sim graph | you ran a simulation after `make system`. Re-run `make system FLOW=aie_batch PRECISION=<P>`. |
| board: `parameter size N inconsistent with RTP port size M` | xclbin and sysdata are different precisions. `cat aie_batch/sd_stage/<P>/sysdata/config.txt`. |
| board: `cannot locate sysdata` | packaged without staging: `make -C aie_batch repackage TARGET=hw PRECISION=<P>`. |
| bf16 `crosscheck` FAILs at ~5e-03 | you invoked `crosscheck.py` directly; the tolerance comes from `RTDA_PRECISION`, which only `make` sets. |
| `x86simulator` says "completed successfully" but outputs are empty | it prints that even after a deadlock. `run_sim.py` catches it; read the lines above. |
| notebook: `golden_onnx_50000.npz missing` | run `rtda_reference.ipynb` first. |
| notebook: `NoSuchKernel` | the kernelspec is `python3`; run Jupyter from an env that has one. |
| PL csim: `use of undeclared identifier 'home'` | a string `-D` lost its quotes. Paths go through the environment now (`RTDA_STIMULUS`, `RTDA_WEIGHTS_DIR`); do not reintroduce `-DWEIGHTS_DIR="..."`. |
| PL numbers look 50x worse than this table | check `run_info.txt`: `leaky_alpha` should be 0.0996094 and `ap_i` 3. `ALPHA125=1` or a stale `pl/weights/` gives the old design. |

Logs are per target and per precision: `aie_batch/log.<P>`, `log.x86_<P>`,
`log.aie_ev<N>`; `pl_fixed/vitis_hls.log`.

---

# Minimum path

Analysis only, no board, no Vitis: **Phases 0, 1, 2 (fastsim only), 3 (fastsim
only), 4 (sweep + fastsim), 6**. About **20 minutes**, and it produces every
accuracy number in the table above. The notebooks omit hardware rows cleanly
when there is no board data.
