# RTDA GPU baseline — run this on the GPU server

Self-contained. Nothing else from the RTDA repo is needed: no XRT, no Vitis,
no CUDA toolkit, no `nvcc`. Only a CUDA build of PyTorch.

`PROVENANCE.txt` records which commit this was built from.

## 0. What you need

```bash
python3 -c "import torch; print(torch.__version__, torch.version.cuda, torch.cuda.is_available())"
```

If that fails or prints `False`, install a CUDA build of torch. A CPU-only
wheel will never see a GPU no matter what you set:

```bash
python3 -m venv ~/rtda_venv && source ~/rtda_venv/bin/activate
pip install --upgrade pip
pip install torch numpy            # default index = CUDA build
```

The driver is 595.x / CUDA 13.2, which is newer than any wheel's bundled
runtime — that is fine and is the normal direction. If `pip install torch`
gives a CPU wheel, pick a CUDA index explicitly, e.g.
`pip install torch --index-url https://download.pytorch.org/whl/cu128`.

## 1. Pick an idle GPU

```bash
nvidia-smi --query-gpu=index,name,memory.used,utilization.gpu --format=csv
```

**Use a card with ~0 MiB used and 0% utilisation.** On the machine this was
written for that is **GPU 3**: GPUs 1 and 2 were running vLLM with ~40 GB each,
and GPU 0 carries the desktop. Measuring on a busy card ruins this number *and*
whatever else is on it, so `scan_gpu.py` refuses one and prints the table.
`--force` overrides and is recorded in the CSV.

## 2. Prove the numerics before timing anything

```bash
cd rtda_gpu
python gpu/scan_gpu.py --check --gpu 3
```

Read the output in this order:

| line | expected | if it is wrong |
|---|---|---|
| `float64 on CPU vs rtda_ref` | **~1e-15** | the network is mis-transcribed. Stop; nothing downstream means anything. |
| `fp32` on the GPU | **~1e-6** | **~1e-3 means TF32 leaked in** — "fp32" ran on tensor cores at ~10-bit mantissa |
| `bf16` on the GPU | ~1e-2 per-track, ~1e-3 on the 27 outputs | in line with the AIE-ML bf16 design's 8.0e-04 |
| `tf32` on the GPU | ~1e-3 | that is the point of measuring it |

It also regenerates the stimulus and asserts its sha256 against the committed
`testdata/embed_input_500000.txt`, so the GPU is scored on the identical
500,000 tracks the VEK280 and the CPU baseline used.

## 3. Run the sweep

```bash
python gpu/scan_gpu.py --gpu 3
```

~2 minutes. Writes `results/gpu/native/scan.csv` and `scan_meta.txt`.

Sweeps events `1, 10, 100, 1000, 10000` × 5 repeats × `fp32, bf16, tf32` ×
three call shapes:

- `single` — one host-to-device copy, one forward, one copy back, for the whole
  run. **This is the comparable one**, matching how AIE and `pl_fixed` are
  measured.
- `fresh` — one copy + forward + copy back per event. The batching
  decomposition, as `pl_fixed` measures it. Skipped above 1000 events.
- `graph` — identical maths with the ~50 kernel launches captured once and
  replayed as one. A diagnostic separating "the fixed cost is Python driving the
  card" from "the fixed cost is the hardware". On an L40S the answer was the
  hardware: the GPU is 95% busy even at one event.

Useful overrides: `--variants fp32`, `--modes single`, `--events 1,100,10000`,
`--reps 3`.

## 3b. Power (optional, ~3 min)

```bash
python gpu/scan_gpu.py --power --gpu 3
```

Writes `results/gpu/native/power.csv`. Each point runs a **sustained loop** for
5 s and samples `nvidia-smi` at 100 ms throughout, because one forward pass
(600 µs at one event) is far too short to measure.

It reports `dynamic_w = mean draw under load − mean draw at idle`. That
subtraction is the point: the VEK280 numbers it gets plotted against are
Vivado's *dynamic* power, which excludes a 9.55 W device static. Comparing the
L40S's raw draw, or its 350 W board limit, against that would be comparing two
different quantities.

It measures idle before and after, and warns if the baseline moved more than
5 W — that means the card was still cooling and the dynamic figure is
understated. If you see that, let it sit for a minute and re-run.

## 4. Send the results back

Small text files, ~100 KB total:

```bash
tar czf rtda_gpu_results.tar.gz results/gpu/native/
```

Then on the RTDA machine:

```bash
make collect_scan FLOW=gpu FROM=<unpacked>/results/gpu/native
```

and Run All on `analysis/rtda_scan.ipynb`.

## If something goes wrong

**`no CUDA device visible to torch`** — a CPU-only wheel, or
`CUDA_VISIBLE_DEVICES` hiding everything. `python -c "import torch;
print(torch.__version__)"`: a `+cpu` suffix is the answer.

**`capture failed` on `mode=graph`** — CUDA graph capture is the most
version-sensitive part of this. It is caught, reported and skipped; `single`
and `fresh` are unaffected and the comparison figure does not use `graph`. Or
just run `--modes single,fresh`.

**Out of memory at 10000 events** — 500,000 tracks needs a few GB. Either free
the card or pass `--events 1,10,100,1000`.

**Numbers look slow, or vary between repeats** — check `sm_clock_mhz` against
`sm_clock_max_mhz` in `scan_meta.txt`, and the power/temperature printed at the
end. A throttled or shared card shows up there.
