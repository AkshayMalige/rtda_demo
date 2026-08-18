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
| resources ² | 69 compute + 13 memory tiles ⁴ | 69 compute + 15 memory tiles ⁴ | **76% LUT, 56% REG, 32% BRAM, 22% DSP** (routed) |

¹ max |implementation − ONNX| over the **same 5 events**, warm-up excluded.
Full scale (largest of the 27) is 0.0857. These are a max over events, so they
only compare at equal event counts — over its full 1000-event run the PL design
reads 3.54e-04, and the AIE numbers would rise similarly if per-track taps
existed at that scale. `analysis/rtda_compare.ipynb` takes the ratio over the
common count and prints which it used.

² **Post-route, from the shipped `ap16_3` build** (`kernel_util_routed.rpt`):
LUT 394,548 (75.95%), REG 585,049 (56.28%), BRAM 191 (31.83%), DSP 289 (22.03%),
**all timing constraints met** at WNS **+0.050 ns**. The kernel clock is
**150 MHz** — verified in the routed timing summary, where `clkout2_primitive`
carries 1,319,470 endpoints against 3,236 on the 100 MHz control clock.

**It fits, comfortably, and this table said otherwise until 2026-08-17.** The old
entry quoted the HLS *estimate* — 80% DSP and 231% LUT — with the warning "this
has not been through place and route and may not fit". It has, and it does. The
estimate was pessimistic by **3.0× on LUT** (231% → 76%) and **3.7× on DSP**
(1057 → 289), against the ~2.4× `pl_fixed/RESOURCES.md` had calibrated from two
earlier points. Treat an HLS LUT estimate on this design as an upper bound with a
factor of three in it, and route before believing either number.

The thing that had to be checked still holds: leaky-ReLU at slope 0.1 is free.
It is computed as `2^-4 + 2^-5 + 2^-8 + 2^-9` in `rtda_leaky.h` precisely so it
costs no DSP, and the routed design uses 289 of 1312.

³ All three from `results/*/hw/run_info.txt`, 1000 events on silicon. **The PL row
used to read "~40,000" here, which was wrong**: 42,000 ns/track is the *csynth
fabric estimate* (`TrackLoop` iteration latency 6335 cycles at the linked
150 MHz), not a measurement. The board reads 114,538, and the performance scan has
since **attributed the 2.7×: it is the fabric, not the driver.** Sweeping
tracks-per-call (`n_tracks` is a runtime `s_axilite` argument) fits
`us_call = 42.4 us + 113.40 us/track` — the per-call cost is 0.7% of one call, and
reusing the `xrt::run` object instead of building a new one per event changes the
result by 0.1%. Batching events into one call would not help. See §6 of
`analysis/rtda_scan.ipynb`.

⁴ From each build's own `Work_<P>/reports/app_mapping_analysis_report.txt`, not
from prose. **69 compute tiles = 65 dense + 3 `roll_concat_batch` + 1
`track_accum`**, identical in both precisions because the cascade lengths are
pinned by hand so the two trees stay structurally the same. **This row read
"65 compute + 14 memory tiles, same" until 2026-08-18** — 65 is the *dense* count
and misses the four hand-written kernels, and the two builds do not use the same
number of memory tiles. Both map the same **18 `shared_buffer` objects**; the
mapper packs them into 13 memtiles for fp32 and 15 for bf16. That difference is a
packing heuristic, not a capacity effect — the largest shared buffer is 4 KB
against a memtile's 512 KB — so do not read anything into it.

**The headline result is the last two columns.** Both are 16 bits per
activation, and the fixed-point PL design lands **1.7× closer** to the reference
than bfloat16. That is not surprising once stated: bf16 spends 8 bits on an
exponent covering ~10³⁸, and every activation in this network lives between
−1.8 and +1.8. `ap_fixed<16,3>` spends 13 bits on the mantissa of a range that
was measured, and none on range it does not need. The cost is that a fixed-point
format has to be *matched* to the network — `make sweep FLOW=pl_fixed` reports
how much clipping margin is left (currently 2.2×).

The AIE is **190× faster per track in fp32 and 480× in bf16** (603 and 239 ns
against 114,418, all at 10,000 events). That is the actual trade.

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
mistaken for one later — `make collect` refuses a scan run outright, because the
files it wants are not there.

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
#   ... run ./host_scan.exe on the board, then copy scan.csv + scan_meta.txt
#       into results/<impl>/hw/          -- RUNBOOK.md PHASE 7
jupyter lab analysis/rtda_scan.ipynb     # -> analysis/out/scan_report.md
```

### What it found

Measured on silicon, 5 repeats per point, spread ≤ 0.2%. The 1000-event point
reproduces the shipped `run_info.txt` numbers to 0.13% (fp32), 0.33% (bf16) and
0.04% (PL), which is what says the scan measures the same thing they did.

| | AIE fp32 | AIE bf16 | PL |
|---|---|---|---|
| ns/track, 1 event | 10,803 | 5,632 | 115,654 |
| ns/track, 10,000 events | **603** | **239** | **114,418** |
| improvement over that range | 17.9× | 23.6× | **1.0×** |
| cycle-accurate floor | 582 | 145 | 42,230 (csynth) |
| non-array time at 10,000 events | **3.4%** | **39.4%** | — |

1. **The PL bottleneck is the fabric, not the driver.** Fitting the
   tracks-per-call sweep gives `us_call = 42.4 us + 113.40 us/track`: the
   per-call cost is 0.7% of one call, and `fresh` vs `reuse` of the `xrt::run`
   object differ by 0.1%. The fabric runs 2.7× slower than csynth's 6335 cycles
   predicts. **Batching would not help**; PL is flat at ~114 us/track from 1 event
   to 10,000, the only design here that does not amortise at all.
2. **fp32 on the AIE is essentially optimal** — 603 ns/track against a 582 ns
   floor, with only 3.4% of `us_execute` outside the array at 10,000 events.
   Optimal *as scheduled*: the floor is the array's own II, and finding 3 is about
   why that II is what it is. Nothing is left on the table around the array; the
   remaining fp32 headroom is inside it.
3. **fp32's array is 4× slower because AIE-ML has no fp32 multiplier.** This is
   architecture, not tuning. AM020: *"32-bit floating-point vector data path is
   not directly supported but can be emulated via decomposition into multiple
   multiplications of 16 × 16-bit."* One `aie::mmul<4,8,4,float,float>` expands
   into **nine** bfloat16 `mul_4x8_8x4` calls in the default `accuracy_safe` mode
   — counted in `$XILINX_VITIS/aietools/data/aie_ml/lib/me_vmult_float_emulated.h`
   — plus the split and double the operand bytes. Two supported modes trade
   accuracy for passes: `-DAIE_FP32_EMULATION_ACCURACY_FAST` is 6, `..._LOW` is 3.
   **This build sets neither and pays the full nine.** Trying FAST and measuring
   both II and error against the reference is the cheapest untaken experiment in
   this repo. Detail: `docs/aie_ml_batched_design.md` Part 1a.
4. **bf16 is not compute-bound, and this is new.** Its array is 4× faster than
   fp32's (ii 1033 vs 4161 ns) but it delivers 2.5×, and 39.4% of its time is
   outside the array — a fraction that does *not* fall between 1000 and 10,000
   events, so it is not launch overhead. The suspect is the output DMA: the 27
   outputs come back as **fp32 in both precisions**, so bf16 halves the input and
   changes the output not at all, and its output rate saturates at **300 MB/s**
   against the `output_gmio::create("gmio_track", 64, 256)` declaration of 256
   MB/s (fp32 sits at 119 MB/s and never approaches it). Not proven — the scan
   cannot see inside the shim DMA — but it is the reading the numbers support.
5. **The launch cost is now measured, not inferred**: 499 us per extra
   `graph.run()` for fp32, reproduced at both 10 and 100 events, against the
   583 us intercept the old four-point fit implied.

One caveat that the schema, the notebook and `results/README.md` all repeat at the
point of use: **the AIE has no H2D/D2H split.** Input DMA, compute and output DMA
overlap by design there, and waiting on the input transfer before `graph.run()`
deadlocks because nothing drains the shim DMA until the graph runs. So `us_h2d`
is the cost of *issuing* the transfers and `us_d2h` is the un-overlapped *tail*.
Only the PL design, being memory-mapped and synchronous, has real per-phase
transfer numbers.

`RUNBOOK.md` is the copy-paste version, with expected values for every step.

**New to how the AIE design works?** Two documents, in this order:

1. **`docs/aie_tutorial.html`** — start here. Thirteen steps from a single
   hardware instruction to the whole 14-layer design, one idea at a time, with
   diagrams and a worked example you can check on a calculator. Ends with a
   file-by-file map of `aie_batch/src_<P>/` and a hand-written skeleton for
   mapping your own model. No code until the last two sections.
2. **`docs/aie_ml_batched_design.md`** — the reference. The same material with
   the code excerpts, exact config values and the full per-layer table. Read it
   after the tutorial, not before.

Both were re-grounded on 2026-08-18 against **AM020** (the Versal AIE-ML
Architecture Manual), the `aie_api` and `me_vmult` headers in the Vitis install,
and each build's own mapping report — replacing several plausible-sounding
explanations that were not in any of them. The corrections that change how you
would design something:

- **fp32 is emulated in bf16, at 9 multiplies to 1** (see finding 3 above). The
  old text explained the fp32/bf16 gap as "narrower type, fewer bytes".
- **The atom is 4×8×4 because the vector unit does 128 bf16 MACs/cycle** and each
  operand is exactly one 512-bit register — not because of "four rows of
  multipliers". And 4×8×4 is the only shape AIE-ML issues natively for *either*
  precision; bf16's larger shapes are library-emulated.
- **A dense kernel's input buffer lives in the neighbouring tile**, not its own —
  `adf::bank(tileCol - 1, ...)` in `dense_bias_relu_graph.h`, because four banks
  are not enough for weights, outputs, stack and input at once.
- **`CAS_NUM` is capped at 2 by the memory tile's 6 MM2S channels**, not by
  cascade latency — which is why 4×1, the best arrangement on latency, is not
  used.

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
- AIE tile counts — `aie_batch/Work_<P>/reports/app_mapping_analysis_report.txt`,
  the compiler's own block and shared-buffer mapping tables. 69 `CR(x,y)` cores
  and 13 (fp32) / 15 (bf16) `MT(x,y)` memory tiles holding 18 shared buffers.
  Cross-checked against the 69 `PT` rows of `aie_batch/Map_Report.csv`.
- `ii 4161 ns` (fp32) and `1033 ns` (bf16) — `make -C aie_batch crosscheck`,
  tabulated in `RUNBOOK.md`. The 9× fp32 emulation factor behind the first number
  is counted in the Vitis headers, not measured here.
- PL resources — post-route, `WNS +0.186 ns` at 150 MHz. The 108% LUT figure in
  the HLS *estimate* did not materialise.
- The PL 1000-event number comes from `pl_fixed/native/`, which compiles the
  same kernel sources with g++ and is verified bit-identical to Vitis csim
  (`make csim FLOW=pl_fixed` → 0.000e+00). hw_emu is ~2 ms/event of RTL
  simulation, which makes it a 5-event tool, not a 1000-event one.
