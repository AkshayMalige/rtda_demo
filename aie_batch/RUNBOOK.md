# RUNBOOK — clean build, run and analyse, fp32 and bf16

Copy-paste, top to bottom. Nothing is left as "repeat with the other precision"; both are
written out. Total: **~3 h of build/run**, most of it unattended.

```
REPO = /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo
```

Three rules. Breaking any of them is what has gone wrong before:

1. **`source set_envs.sh` in every new shell** before any `make`.
2. **Simulations BEFORE the system build.** `make system` rebuilds `Work_<P>/` as the GMIO
   `SYSTEM_BUILD`, which has no PLIO debug taps; after it, `crosscheck` / `x86_events` /
   `sim_events` cannot run until the graph is rebuilt.
3. **One simulation at a time.** Every run in `aieml_batch/` shares `data/` for PLIO input
   and `<sim>simulator_output/` for output. A lock refuses a second one — do not work
   around it, wait.

---

# PHASE 0 — clean

```bash
cd /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo
source set_envs.sh
make clean_all AIE_DIR=aieml_batch
```
**~1 min.**

Deletes `Work_*/`, `libadf*.a`, `log*`, simulator output, `data/`, `sd_batch/`,
`package.*`, `build_*`, `host_batch/*.o`.

**Keeps** (deliberately): `src_fp32/`, `src_bf16/`, `aie_pipeline_*.json`, `app.cpp`,
`../testdata/`, `results/`, `notebooks/`. Nothing you need is destroyed.

If you want a *total* reset including previously gathered results:
```bash
rm -rf aieml_batch/results/sim_events aieml_batch/results/hw aieml_batch/results/hw_bf16
rm -rf aieml_batch/notebooks/out
```

---

# PHASE 1 — reference data (once, precision-independent)

```bash
cd /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo/aieml_batch
make golden TRACKS=50000
```
**~2 min.** Writes to `REPO/testdata/`:

```
embed_input_50000.txt     6.4 MB   the stimulus EVERYTHING is driven by
golden_50000.npz          1.2 MB   streaming-roll golden, 1000 event means
golden_50000.txt          2.0 MB   same, for the board's RTDA_GOLDEN= self-check
```

**Checkpoint:**
```bash
ls -la ../testdata/embed_input_50000.txt ../testdata/golden_50000.*
```

---

# PHASE 2 — fp32 simulations

```bash
cd /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo/aieml_batch
```

### 2.1 x86simulator — 5 events
```bash
make x86_events PRECISION=fp32 EVENTS=5
```
**~2 min.** Expect `PASS`, worst ~6.2e-07.
→ `results/sim_events/sim_x86_fp32_5ev_250tr.npz`

### 2.2 aiesimulator — 5 events, cycle-accurate
```bash
make sim_events PRECISION=fp32 EVENTS=5
```
**~25 min** (8 min compile, 16 min simulate). Expect `PASS`, same magnitude.
→ `results/sim_events/sim_aie_fp32_5ev_250tr.npz`

### 2.3 The timing number
```bash
make graph      PRECISION=fp32
make crosscheck PRECISION=fp32
make report     PRECISION=fp32
```
**~12 min.** `make report` prints **II ≈ 4161 ns, 582.5 ns/track, ~1016 GOP/s**.

> Copy those three numbers down. They are not written to a file, and
> `rtda_bf16_vs_fp32.ipynb` has them as the constant `II_NS` in its performance cell.

---

# PHASE 3 — bf16 simulations

Same directory. Nothing from Phase 2 is disturbed — every product is precision-suffixed.

### 3.1 x86simulator — 5 events
```bash
make x86_events PRECISION=bf16 EVENTS=5
```
**~2 min.** Expect `PASS`, worst ~5.1e-04 (tolerance auto-relaxes to 5e-2 for bf16).
→ `results/sim_events/sim_x86_bf16_5ev_250tr.npz`

### 3.2 aiesimulator — 5 events
```bash
make sim_events PRECISION=bf16 EVENTS=5
```
**~20 min.** → `results/sim_events/sim_aie_bf16_5ev_250tr.npz`

### 3.3 The timing number
```bash
make graph      PRECISION=bf16
make crosscheck PRECISION=bf16
make report     PRECISION=bf16
```
**~10 min.** Expect **II ≈ 1033 ns, 144.6 ns/track, ~3654 GOP/s**.

**Checkpoint — four npz files, two per precision:**
```bash
ls -la results/sim_events/*.npz
```

---

# PHASE 4 — fp32 on hardware

```bash
cd /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo
source set_envs.sh
make system TARGET=hw AIE_DIR=aieml_batch PRECISION=fp32
```
**~1 h.**

### Before flashing — check the two halves match
```bash
cat sd_batch/sysdata/config.txt      # MUST read: precision=fp32
ls -la aieml_batch/libadf_fp32.a     # must exist, recent
```
If `config.txt` names the other precision, **stop** and re-run `make system`. A mismatched
pair fails on the board with
`adf::graph::update parameter size 4096 bytes is inconsistent with ... size 8192 bytes`
(8192 = 2048x4 → an fp32 port; 4096 = 2048x2 → a bf16 payload).

Write `package.hw/sd_card.img` to the SD card, boot the VEK280.

### On the board
```bash
sudo su
mount /dev/mmcblk0p1 /mnt
mount -o remount,rw /mnt
cd /mnt

RTDA_INPUT=sd_batch/testdata/embed_input_50000.txt \
RTDA_GOLDEN=sd_batch/testdata/golden_50000.txt \
./host_batch.exe
```
First line must read `[host] graph input dtype: float32`.
Expect the on-board check to **PASS** at ~1.5e-06.

### Off the board
```bash
mkdir -p /mnt/usb && mount /dev/sda1 /mnt/usb
cp track_means_all.txt run_info.txt /mnt/usb/
sync && umount /mnt/usb
poweroff
```
`sync` is not optional — without it the copy can sit in cache and you get a truncated file.
If `/dev/sda1` is wrong, run `lsblk` after plugging the stick in.

### Where the files go — EXACT path
```bash
mkdir -p /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo/aieml_batch/results/hw
cp <wherever-you-mounted-the-stick>/track_means_all.txt \
   <wherever-you-mounted-the-stick>/run_info.txt \
   /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo/aieml_batch/results/hw/
```

---

# PHASE 5 — bf16 on hardware

```bash
cd /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo
source set_envs.sh
make system TARGET=hw AIE_DIR=aieml_batch PRECISION=bf16
```
**~1 h.**

```bash
cat sd_batch/sysdata/config.txt      # MUST read: precision=bf16
ls -la aieml_batch/libadf_bf16.a
```

Flash, boot, then on the board:
```bash
sudo su
mount /dev/mmcblk0p1 /mnt
mount -o remount,rw /mnt
cd /mnt

RTDA_INPUT=sd_batch/testdata/embed_input_50000.txt ./host_batch.exe
```
First line must read `[host] graph input dtype: bfloat16`.

> **No `RTDA_GOLDEN=` for bf16.** The on-board check is hard-coded to 1e-4 and bf16 lands
> near 5e-4, so it reports a FAIL that is only the tolerance. The notebook does that
> comparison properly.

```bash
mkdir -p /mnt/usb && mount /dev/sda1 /mnt/usb
cp track_means_all.txt run_info.txt /mnt/usb/
sync && umount /mnt/usb
poweroff
```

### Where the files go — EXACT path
```bash
mkdir -p /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo/aieml_batch/results/hw_bf16
cp <stick>/track_means_all.txt <stick>/run_info.txt \
   /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo/aieml_batch/results/hw_bf16/
```

**fp32 → `results/hw/`. bf16 → `results/hw_bf16/`. Do not mix them.**

---

# PHASE 6 — the notebooks

### Environment (once)
Needs `numpy onnx onnxruntime matplotlib`. Either:

```bash
# A: add two packages to envaie2 (numpy stays 1.26.4; aie4ml/TF unaffected)
/home/synthara/miniforge3/envs/envaie2/bin/pip install onnxruntime matplotlib

# B: use o2v, which already has all four
/home/synthara/.conda/envs/o2v/bin/python -m ipykernel install --user --name o2v
```

### Run, in this order
```bash
cd /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo
jupyter lab aieml_batch/notebooks/rtda_reference.ipynb
```
**Run All (~1 min).** This one MUST go first — its §3 writes
`aieml_batch/notebooks/out/golden_onnx_50000.npz`, the ONNX reference the second notebook
loads. It analyses **fp32** end to end.

```bash
jupyter lab aieml_batch/notebooks/rtda_bf16_vs_fp32.ipynb
```
**Run All (~1 min).** Compares **both** precisions against that reference.

Neither needs editing. They discover the runs by reading the `precision` field inside each
`.npz`, so a clean rebuild, a legacy file, or a mix all work.

If you used option B, set the kernel: **Kernel → Change Kernel → o2v**.

---

# The complete file map

Everything the notebooks read. If a file is missing they say so rather than guessing.

```
REPO = /home/synthara/VersalPrjs/LDRD/quant_rtda/rtda_demo

REPO/testdata/
    embed_input_50000.txt                       Phase 1   the stimulus
    golden_50000.npz  golden_50000.txt          Phase 1   streaming golden

REPO/aieml_batch/results/sim_events/
    sim_x86_fp32_5ev_250tr.npz                  Phase 2.1
    sim_aie_fp32_5ev_250tr.npz                  Phase 2.2
    sim_x86_bf16_5ev_250tr.npz                  Phase 3.1
    sim_aie_bf16_5ev_250tr.npz                  Phase 3.2

REPO/aieml_batch/results/hw/                    <- fp32 board run
    track_means_all.txt                         Phase 4   1000 event means
    run_info.txt                                Phase 4   timing + sizes

REPO/aieml_batch/results/hw_bf16/               <- bf16 board run
    track_means_all.txt                         Phase 5
    run_info.txt                                Phase 5

REPO/aieml_batch/notebooks/out/                 <- WRITTEN BY the notebooks
    golden_onnx_50000.npz                       the ONNX reference (25 MB)
    out27_comparison.png  out27_event0.png
    warmup_per_track.png  hw_50k.png  hw_performance.png
    bf16_accuracy_per_output.png  bf16_hw_accuracy.png  bf16_performance.png
```

All of `results/` and `notebooks/out/` is gitignored — regenerable, never committed.

---

# Expected values

| check | fp32 | bf16 |
|---|---|---|
| ONNX weights == `data_fp32` | 7.451e-09 | same reference |
| `data_fp32` == the 92 RTP payloads | 0.000e+00 | — |
| ONNX == numpy golden, 50 tracks | 3.278e-07 | same reference |
| x86 / aiesim, event mean vs golden | ~6e-07 | ~5e-04 |
| 27 outputs vs golden, **warm-up excluded** | 7.5e-07 | 4.0e-04 |
| 27 outputs vs golden, with warm-up | ~7e-03 | ~7e-03 |
| II (aiesimulator) | 4161 ns | 1033 ns |
| ns/track, cycle-accurate | 582.5 | 144.6 |
| ns/track, silicon (50k tracks) | 614.3 | 249.3 |
| GOP/s, silicon | 860 | 2120 |
| RTP weights | 1039 KB | 523 KB |
| on-board `RTDA_GOLDEN` check | PASS ~1.5e-06 | do not use |

**The ~7e-03 "with warm-up" row is not an error.** It is the roll-concat convention: the
reference wraps circularly inside an event, the array streams. The reference disagrees with
*itself* by 1.556e-02 between the two conventions. Only the without-warm-up row measures
precision.

---

# When it goes wrong

| symptom | cause and fix |
|---|---|
| `ModuleNotFoundError: numpy` from a script | you ran `./script.py` after `source set_envs.sh` — PetaLinux's python is first on PATH. Use the `make` target. |
| `another simulation is already running` | one is still alive: `ps -ef \| grep -E "x86simulator\|aie2simmsm"`. Wait or kill it. |
| board: `parameter size N inconsistent with RTP port size M` | xclbin and `sysdata` are different precisions. `cat sd_batch/sysdata/config.txt`, re-run `make system` with the right `PRECISION=`. |
| board: `cannot locate sysdata` | the SD image was packaged without staging. `make repackage TARGET=hw AIE_DIR=aieml_batch PRECISION=<P>`. |
| bf16 `crosscheck` FAILs at ~5e-03 | you invoked `crosscheck.py` directly; the tolerance comes from `RTDA_PRECISION`, which only `make` sets. Use `make crosscheck PRECISION=bf16`. |
| `x86simulator` says "completed successfully" but outputs are empty | it prints that even after a deadlock. `run_sim.py` catches it now; read the lines above the success message. |
| notebook: `golden_onnx_50000.npz missing` | run `rtda_reference.ipynb` first. |
| notebook shows `aie -- missing` | that `sim_events` run was not done. Phase 2.2 / 3.2. |
| `make report` crashes or prints nothing | no aiesimulator output for that precision yet — `make crosscheck PRECISION=<P>` first. |

Logs are per target and per precision, and contain **both** the compiler output and the
Python step: `log.<P>`, `log.x86_<P>`, `log.x86_ev<N>`, `log.aie_ev<N>`.

---

# Minimum path

If you only want the analysis working and do not need fresh hardware numbers, Phases 0-3
plus 6 are enough — the notebooks handle missing hardware data and simply omit those rows.
That is **~1 h 15 min**, all unattended, no board.
