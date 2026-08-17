# RTDA — real-time track alignment on a VEK280

One neural network, implemented three ways on the same board, compared against
the same reference on the same data.

The network is a track-alignment MLP: an **embedding block** (2 dense layers)
feeding **3 chained solver blocks** (4 dense each) = **14 dense layers**, every
one followed by a fused bias + leaky-ReLU (slope 0.1). A roll-concat between
blocks pairs each track with its predecessor. **50 tracks make one event**, and
the event's 128-wide mean goes through a final 128→27 dense to give the
deliverable: **27 numbers per event**.

```
        6 ──► embed ──► 128 ──► solver0 ──► solver1 ──► solver2 ──► 128
              2 dense          4 dense     4 dense     4 dense
                            (each preceded by roll-concat to 256)

        50 tracks ──► mean(128) ──► dense 128→27 ──► 27 outputs / event
```

---

## The three implementations

| | `aie_batch/` fp32 | `aie_batch/` bf16 | `pl_fixed/` |
|---|---|---|---|
| where it runs | AIE-ML array | AIE-ML array | PL fabric only |
| arithmetic | float32 | bfloat16 | `ap_fixed<16,3>` |
| shape | matrix × matrix, 8 tracks/iteration | same | 1 track at a time |
| kernel | `aie::mmul` | `aie::mmul` | hls4ml `nnet::dense` |
| **ns/track, silicon** ³ | **615** | **245** | **114,538** |
| **error, 27 outputs** ¹ | **7.5e-07** | **3.96e-04** | **2.35e-04** |
| resources ² | 65 compute + 14 memory tiles | same | 80% DSP, 47% BRAM, **231% LUT (est.)** |

¹ max |implementation − ONNX| over the **same 5 events**, warm-up excluded.
Full scale (largest of the 27) is 0.0857. These are a max over events, so they
only compare at equal event counts — over its full 1000-event run the PL design
reads 3.54e-04, and the AIE numbers would rise similarly if per-track taps
existed at that scale. `analysis/rtda_compare.ipynb` takes the ratio over the
common count and prints which it used.

² HLS estimate, `make -C pl_fixed csynth`. **DSP is 1057 (80%), identical to the
design before the precision realignment — so leaky-ReLU at slope 0.1 really is
free**, which was the thing that had to be checked. LUT is not free: the
estimate went 563k (108%) → 1,206k (231%). For calibration the *old* design
estimated 108% and placed at 43%, i.e. the estimate ran ~2.5× pessimistic; 231%
scaled the same way is ~92%, which is not a margin to rely on. **This has not
been through place and route and may not fit.** See `pl_fixed/RESOURCES.md`.

³ All three from `results/*/hw/run_info.txt`, 1000 events on silicon. **The PL row
used to read "~40,000" here, which was wrong**: 42,000 ns/track is the *csynth
fabric estimate* (`TrackLoop` iteration latency 6335 cycles at the linked
150 MHz), not a measurement. The board reads 114,538. The 2.7× between them is
real and unattributed by this table — it sits inside a host timer that spans
kernel enqueue *and* `run.wait()`, so per-call driver cost and slow fabric are
indistinguishable in it. `analysis/rtda_scan.ipynb` separates them; see below.

**The headline result is the last two columns.** Both are 16 bits per
activation, and the fixed-point PL design lands **1.7× closer** to the reference
than bfloat16. That is not surprising once stated: bf16 spends 8 bits on an
exponent covering ~10³⁸, and every activation in this network lives between
−1.8 and +1.8. `ap_fixed<16,3>` spends 13 bits on the mantissa of a range that
was measured, and none on range it does not need. The cost is that a fixed-point
format has to be *matched* to the network — `make sweep FLOW=pl_fixed` reports
how much clipping margin is left (currently 2.2×).

The AIE is ~65× faster per track. That is the actual trade.

---

## One thing to understand before reading any number here

**There are two roll conventions and they disagree by 1.5e-02.**

The ONNX reference rolls *circularly* inside a 50-track event: track 0 pairs
with track 49. That is the physics definition, and it requires buffering all 50
tracks before computing the first one.

Every hardware implementation *streams*: each track pairs with whatever
physically preceded it. That is exactly what makes the batched AIE design fast.

The network's receptive field is 4 tracks deep, so **tracks 0, 1 and 2 of every
event differ** — by ~1e-1 — while tracks 3..49 agree to ~4e-06.

So every table in this repo has two columns:

- **WITHOUT warm-up** (tracks 3..49): measures *arithmetic*. This is the number
  that says whether an implementation is correct.
- **WITH warm-up** (all 50 tracks): measures the roll convention, ~7e-03 for
  everything. **Not an error.** The reference disagrees with *itself* by
  1.556e-02 between the two conventions.

Mixing them is the easiest way to get a confidently wrong answer here, so the
code does not guess: the PL kernel takes `warmup` as a runtime argument and
records it in `run_info.txt`, and the notebooks read that rather than assume.

---

## Layout

```
model/              THE SOURCE OF TRUTH
  mlp_fp32.onnx       the pinned reference network
  weights_fp32/       the 30 exported tensors; matches the ONNX to 7.5e-09
  rtda_ref.py         the ONE numpy implementation. roll='circular'|'streaming',
                      plus quant= for bf16 / ap_fixed experiments
  weights.py          loads the tensors in both packings the flows need

testdata/           stimulus + goldens, generated by `make golden`
aie_batch/          the AIE-ML design (PRECISION=fp32|bf16) + its XRT host
                      host/host_batch.cpp   the results host
                      host/host_scan.cpp    the performance-scan host
pl_fixed/           the PL-only design + its native bit-accurate model
                      host/host_split.cpp   the results host
                      host/host_scan.cpp    the performance-scan host
analysis/           the notebooks that compare them
results/            aie_fp32/ aie_bf16/ pl_fixed/, each {sim,hw_emu,hw}
archive/            the retired 1-track GEMV design and its docs
```

**Two hosts per flow, on purpose.** `host_batch.exe` / `host_split.exe` produce
the accuracy files every number above is quoted from. `host_scan.exe` produces
timing and *only* timing — it writes no `run_info.txt` and no
`track_means_all.txt`, so a performance run cannot be filed as a result run or
mistaken for one later. `make collect` and `make collect_scan` look for
different files and refuse each other's.

Every flow reads `model/weights_fp32/`. That is what makes the comparison
meaningful, and it is checked rather than assumed: `analysis/rtda_reference.ipynb`
re-verifies ONNX == weights == the 92 RTP payloads on every run, and
`pl_fixed/gen_weights.py --check` does the same for the PL side.

---

## Getting started

```bash
source set_envs.sh
make help

make golden TRACKS=50000                              # stimulus + reference

make fastsim FLOW=aie_batch PRECISION=fp32 EVENTS=5   # x86simulator, ~2 min
make fastsim FLOW=pl_fixed EVENTS=1000                # native ap_fixed, ~90 s

make system FLOW=aie_batch PRECISION=bf16 TARGET=hw   # SD image for the board
make run    FLOW=pl_fixed TARGET=hw_emu               # 5 events on QEMU
```

Then, in order:

```bash
jupyter lab analysis/rtda_reference.ipynb    # fp32 end to end; writes the ONNX golden
jupyter lab analysis/rtda_compare.ipynb      # all three implementations
```

## The performance scan

The accuracy notebooks say *whether* each implementation is right and quote one
speed each. The scan says **where the time goes and how it scales** — 1 / 10 / 100
/ 1000 / 10,000 events, repeated, with a per-phase breakdown.

```bash
make stimulus TRACKS=500000              # 10,000 events of stimulus, no golden
make scan_host FLOW=aie_batch            # host_scan.exe, seconds -- no xclbin rebuild
make scan_host FLOW=pl_fixed
#   ... run host_scan.exe on the board: RUNBOOK.md PHASE 7 ...
make collect_scan FROM=<dir> FLOW=pl_fixed TARGET=hw
jupyter lab analysis/rtda_scan.ipynb     # -> analysis/out/scan_report.md
```

It is built to settle three things the repo could not previously answer:

1. **The AIE fixed launch cost.** ~583 us is paid per `graph.run()` whatever its
   size, which is why one event costs 12.7 us/track and 10,000 tracks cost 0.658.
   The scan sweeps the launch count directly instead of inferring an intercept.
2. **The PL 2.7× gap** between 114,538 ns/track measured and the 42,000 ns/track
   csynth estimate. `n_tracks` is a runtime `s_axilite` argument, so one call can
   process 50 … 1000 tracks; fitting `us_call = fixed + marginal × tracks`
   separates per-call driver cost from fabric cost.
3. **Spread.** Every performance figure in this repo before the scan was a single
   run; these are repeated and reported as min / median / max.

One caveat that the schema, the notebook and `results/README.md` all repeat at the
point of use: **the AIE has no H2D/D2H split.** Input DMA, compute and output DMA
overlap by design there, and waiting on the input transfer before `graph.run()`
deadlocks because nothing drains the shim DMA until the graph runs. So `us_h2d`
is the cost of *issuing* the transfers and `us_d2h` is the un-overlapped *tail*.
Only the PL design, being memory-mapped and synchronous, has real per-phase
transfer numbers.

`RUNBOOK.md` is the copy-paste version, with expected values for every step.

**New to how the AIE design works?** Two documents, in this order:

1. **`docs/aie_tutorial.html`** — start here. Builds up from a single hardware
   multiply to the whole 14-layer design, one idea at a time, with diagrams and
   a worked example you can check on a calculator. No code until the last two
   sections.
2. **`docs/aie_ml_batched_design.md`** — the reference. The same material with
   the code excerpts, exact config values and the full per-layer table. Read it
   after the tutorial, not before.

## Where results go

**Simulation files itself under `results/<impl>/sim/`. Hardware does not** --
the host writes into its own working directory on the board, so those three
files have to be carried back, and which directory they belong in is not
recoverable from the files themselves.

**Copy `track_means_all.txt`, `track_out_27.txt` and `run_info.txt` off the
board into exactly one of:**

| the run | destination |
|---|---|
| AIE, `PRECISION=fp32`, board | `results/aie_fp32/hw/` |
| AIE, `PRECISION=bf16`, board | `results/aie_bf16/hw/` |
| PL, board | `results/pl_fixed/hw/` |
| any of the above under QEMU | the same, with `hw_emu/` instead of `hw/` |

```bash
make results                                    # what is on disk right now
make collect FROM=/mnt/usb FLOW=aie_batch PRECISION=fp32 TARGET=hw
make collect FROM=/mnt/usb FLOW=pl_fixed  TARGET=hw
```

`collect` refuses a partial copy and prints the destination, each file's size
and the run's own `run_info.txt`, because an fp32 run dropped into
`results/aie_bf16/hw/` produces a plausible table in which bf16 looks as
accurate as fp32. Full detail: "Where results go" in `RUNBOOK.md`.

---

## Where the numbers come from

- `615 ns/track` fp32, `245 ns/track` bf16, `114,538 ns/track` PL — measured on
  silicon over 50,000 tracks, `results/*/hw/run_info.txt`. The scan re-measures
  these across five run sizes with repeats; its 1000-event point must reproduce
  them to a few percent or the scan is measuring something else.
- `7.5e-07`, `3.96e-04`, `2.35e-04` — `analysis/rtda_compare.ipynb`, the same 5
  events, warm-up excluded, against `model/mlp_fp32.onnx`. Only simulation has
  the per-track taps a warm-up-excluded number needs, and the AIE sims are
  5-event builds; the PL run is 1000 events but the ratio is taken over the
  common 5.
- PL resources — post-route, `WNS +0.186 ns` at 150 MHz. The 108% LUT figure in
  the HLS *estimate* did not materialise.
- The PL 1000-event number comes from `pl_fixed/native/`, which compiles the
  same kernel sources with g++ and is verified bit-identical to Vitis csim
  (`make csim FLOW=pl_fixed` → 0.000e+00). hw_emu is ~2 ms/event of RTL
  simulation, which makes it a 5-event tool, not a 1000-event one.
