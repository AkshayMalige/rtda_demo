# The GPU baseline

The same network as `aie_batch`, `pl_fixed` and `cpu`, on an NVIDIA card.

```bash
make -C gpu selftest    # float64 vs rtda_ref -- NO GPU NEEDED    (~5 s)
make -C gpu tarball     # ~1.4 MB bundle for the GPU server
```

The GPU is normally on **another machine**, so this flow is built to travel.
`gpu/BUNDLE.md` is the instruction sheet that ships inside the tarball; it is
what you follow on the GPU server.

## What it runs, and the one compromise

`gpu/rtda_torch.py` — a torch transcription of `model/rtda_ref.py`. This is the
**only second copy of the forward pass** in the repo. `cpu/` deliberately has
none (it calls `R.forward` directly), but torch cannot execute numpy on a GPU,
so here there was no alternative.

`rtda_ref.py`'s docstring records that four copies of this forward pass once
drifted. The defence here is not care, it is a gate: **every `--check` compares
torch at float64 against `rtda_ref` at float64**, and it must land at ~1e-15.
Measured: **1.4e-15**. A transcription error cannot survive that, and it runs
before every scan.

Five details in that transcription are load-bearing and documented in the file:
the input must be exactly `(n, 6)`; the concat order is `[cur, prev]`; the
streaming head is a zero row; every one of the 14 denses is followed by exactly
one activation (the reference defers d3's to after the loop, which reads like an
exception and is not one); and leaky-ReLU is `max(a, 0.1a)`, not the `where`
form `F.leaky_relu` uses.

## Three ways to get a wrong GPU number

All three are handled in `scan_gpu.py`, and all three are easy to hit.

**CUDA is asynchronous.** `perf_counter()` around a torch call measures the
*launch*, not the work. Every phase is bracketed by `torch.cuda.synchronize()`,
and the kernel phase is measured a second time with CUDA events so a
disagreement shows up in the `notes` column instead of being invisible.

**TF32.** On Ada/Ampere hardware torch can run "float32" matmuls on tensor cores
at ~10 bits of mantissa — a ~1e-3 error where real fp32 gives ~1e-6, which is
worse than bf16, while still being labelled fp32. Both backend flags are set
explicitly per variant and recorded. `variant=tf32` measures that mode
deliberately.

**A busy card.** The preflight refuses a GPU that already has memory in use or
non-zero utilisation, and prints the `nvidia-smi` table. This protects the
measurement *and* whoever else is on the card. `--force` overrides and is
recorded in `notes`.

## What is measured

| mode | shape | role |
|---|---|---|
| `single` | one H2D, one forward, one D2H for the whole run | **the comparable row** |
| `fresh` | one H2D + forward + D2H per event | batching decomposition, as `pl_fixed` measures it |
| `graph` | same maths, ~50 launches replayed as one | dispatch-cost diagnostic |

Why `graph` exists: one forward pass is a **fixed** ~50 kernel launches — three
per dense × 14, plus the roll-concat's slice and join × 3 — and that count does
not grow with batch size, while each launch costs the host a few microseconds.
At one event the arithmetic is ~1 µs and the launches are ~250, so a plain
reading says "the GPU is bad at small batches" when the card is actually idle
waiting for Python. `graph` makes that a measurement rather than a caption.

Only `single` is plotted beside the other implementations, for the same reason
`primary()` excludes `pl_fixed`'s `reuse` and `tpc`.

## The stimulus is regenerated, not shipped

`testdata/embed_input_500000.txt` is 63 MB and takes minutes to parse.
`synth_tracks(seed=1234)` reproduces it **byte for byte** — verified against the
committed file, `sha256 ea2f5446…a3dd572e` — in about 2 seconds, and
`scan_gpu.py` asserts that digest rather than trusting it. A numpy whose PCG64
stream ever changed would fail loudly instead of handing the GPU a
different-but-plausible stimulus. This is why `embed_input.txt` is in the
bundle: `synth_tracks` derives the distribution from it.

## Testing without a GPU

`scan_gpu.py --allow-cpu --outdir <somewhere>` runs the whole sweep on the host
so the harness can be exercised on a machine with no card. Every row is stamped
`SMOKE TEST ON HOST CPU -- NOT A GPU MEASUREMENT`, it refuses to write to
`results/gpu/native/`, and the notebook refuses to plot such rows. It is for
finding bugs in the harness, never for producing a number.
