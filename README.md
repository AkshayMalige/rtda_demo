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
| **ns/track, silicon** ³ | **615** | **245** | **94,793** |
| **error, 27 outputs** ¹ | **7.5e-07** | **3.96e-04** | **2.35e-04** |
| resources ² | 69 compute + 13 memory tiles ⁴ | 69 compute + 15 memory tiles ⁴ | **78% LUT, 60% REG, 33% BRAM, 22% DSP** (routed, 180 MHz) |

¹ max |implementation − ONNX| over the **same 5 events**, warm-up excluded.
Full scale (largest of the 27) is 0.0857. These are a max over events, so they
only compare at equal event counts — over its full 1000-event run the PL design
reads 3.54e-04, and the AIE numbers would rise similarly if per-track taps
existed at that scale. `analysis/rtda_compare.ipynb` takes the ratio over the
common count and prints which it used.

² **Post-route, from the shipped 180 MHz `ap16_3` build** (linked 2026-08-20;
`pl_fixed/_x/ap16_3_hw/reports/link/imp/impl_1_kernel_util_routed.rpt`):
LUT 407,628 (78.47%), REG 620,473 (59.69%), BRAM 200 (33.33%), DSP 289 (22.03%),
**all timing constraints met** at WNS **0.000 ns** — closed, with no slack to spare.
The kernel clock is **180 MHz** — verified in the routed timing summary, where
`clkout1_primitive_1` carries 1,384,153 endpoints against 3,236 on the 100 MHz
control clock, `clkout1_primitive`.

**This row described the 150 MHz build until 2026-09-14:** LUT 394,548 (75.95%),
REG 585,049 (56.28%), BRAM 191 (31.83%), DSP 289 (22.03%) at WNS +0.050 ns. The
two builds differ in more than the clock — the 180 MHz one is also the first with
the kernel's event loop (`d257669`) — so the +13,080 LUT and +35,424 registers are
not the frequency alone. The first frequency sweep separates them roughly: the old
kernel at 180 MHz routed at 79.10% LUT, so the clock cost ~3 points of LUT and the
event loop gave back ~0.6. No DSP either way.

**It fits, comfortably, and this table said otherwise until 2026-08-17.** The old
entry quoted the HLS *estimate* — 80% DSP and 231% LUT — with the warning "this
has not been through place and route and may not fit". It has, and it does. The
estimate was pessimistic by **3.0× on LUT** (231% → 76%) and **3.7× on DSP**
(1057 → 289), against the ~2.4× `pl_fixed/RESOURCES.md` had calibrated from two
earlier points. At 180 MHz the same comparison reads: csynth estimates LUT 852,474
(163%) against 407,628 routed — pessimistic by **2.1×** — and DSP 289, exactly the
routed count, while its FF estimate (428,614) is *below* the 620,473 registers
Vivado ends up placing. Treat an HLS LUT estimate on this design as an upper bound
with a factor of two to three in it, and route before believing it.

The thing that had to be checked still holds: leaky-ReLU at slope 0.1 is free.
It is computed as `2^-4 + 2^-5 + 2^-8 + 2^-9` in `rtda_leaky.h` precisely so it
costs no DSP, and the routed design uses 289 of 1312.

³ All three from `results/*/hw/run_info.txt`, 1000 events on silicon. **The PL entry
has been wrong twice.** It read "~40,000" until 2026-08-17 — the csynth estimate of
an older kernel, quoted as silicon — and then 114,538, a 150 MHz build measured on the
board, set against a 6335-cycle csynth report that predated the kernel's event loop
and presented as a "2.7× slower fabric". The shipped kernel is scheduled and linked
at **180 MHz** and reads **94,793 ns/track**, and it matches its models: RTL
co-simulation measures 851,956 cycles per event (4.733 ms), the board's single-call
kernel time is 4.733 ms (0.002% apart), and csynth's worst case is 17,078 cycles per
track. Sweeping tracks-per-call (`n_tracks` is a runtime `s_axilite` argument) fits
`us_call = 43.0 us + 94.59 us/track` — the per-call cost is 0.9% of one call, and
reusing the `xrt::run` object instead of building a new one per event changes the
result by 0.2%. Batching events into one call would not help. See §6 of
`analysis/rtda_scan.ipynb` and §5 of `analysis/rtda_timing.ipynb`.

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

The AIE is **157× faster per track in fp32 and 397× in bf16** (603 and 239 ns
against 94,661, all at 10,000 events). That is the actual trade.

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
reproduces the shipped `run_info.txt` numbers to 0.27% (fp32), 0.38% (bf16) and
0.14% (PL), which is what says the scan measures the same thing they did.

| | AIE fp32 | AIE bf16 | PL |
|---|---|---|---|
| ns/track, 1 event | 11,001 | 5,699 | 95,662 |
| ns/track, 10,000 events | **603** | **239** | **94,661** |
| improvement over that range | 18.2× | 23.9× | **1.0×** |
| cycle-accurate floor | 584 (aiesim) | 231 (aiesim) | 94,663 (RTL cosim) |
| non-array time at 10,000 events | **3.1%** | **3.2%** | 0.0% |

1. **The PL bottleneck is the fabric, and the fabric does what its models say.**
   Fitting the tracks-per-call sweep gives `us_call = 43.0 us + 94.59 us/track`: the
   per-call cost is 0.9% of one call, and `fresh` vs `reuse` of the `xrt::run`
   object differ by 0.2%. RTL co-simulation measures 851,956 cycles per event at
   180 MHz — 94,663 ns/track, 0.002% from the board. **Batching would not help**; PL
   is flat at ~95 us/track from 1 event to 10,000, the only design here that does not
   amortise at all, because it is not pipelined: its latency and its II are one
   number. *(Until 2026-09-14 this said the fabric ran 2.7× slower than csynth. That
   set a 150 MHz board run against a csynth report of an older kernel.)*
2. **fp32 on the AIE is essentially optimal** — 603 ns/track against a 584 ns
   floor, with only 3.1% of `us_execute` outside the array at 10,000 events.
   Optimal *as scheduled*: the floor is the array's own II, and finding 3 is about
   why that II is what it is. Nothing is left on the table around the array; the
   remaining fp32 headroom is inside it.
3. **fp32's array is 2.5× slower because AIE-ML has no fp32 multiplier** — and
   would be further behind if bf16's own tail did not cap it (finding 4). This is
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
4. **bf16 is limited by one small kernel, not by its dense layers or the DMA.**
   Its dense layers would run at ~925 ns per iteration, but `track_accum` — the
   float kernel that accumulates the 50-track mean — takes ~1.6–1.75 µs per call,
   so the graph's II at the event tail is **1650 ns** (aiesimulator, 10 events, VCD
   and kernel profile). 7 × 1650 ns = 11.55 us per event against 11.92 on silicon:
   only **3.2%** of `us_execute` is outside the array at 10,000 events, the same as
   fp32, and silicon's fp32/bf16 ratio (2.53×) equals the II ratio. Speeding up
   `track_accum` is the next bf16 optimisation; it should move the II toward the
   dense layers' ~925 ns — a prediction, not a measurement. *(Until 2026-09-14 this
   said bf16 was DMA-limited with 39.4% of its time outside the array. That rested
   on an II of 1033 ns, which `make report` produced by averaging all nine output
   ports; see `analysis/rtda_timing.ipynb` §2–4.)*
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

- `615 ns/track` fp32, `245 ns/track` bf16, `94,793 ns/track` PL — measured on
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
- `ii 4172 ns` (fp32) and `1650 ns` (bf16) — the steady-state interval at the event
  tail: `make exactsim EVENTS=10`, then `make -C aie_batch report EVENTS=10`,
  tabulated in `RUNBOOK.md` and derived in `analysis/rtda_timing.ipynb`. The 9× fp32
  emulation factor behind the first number is counted in the Vitis headers, not
  measured here.
- PL resources — post-route, from the shipped 180 MHz build's
  `impl_1_kernel_util_routed.rpt` and routed timing summary (WNS 0.000 ns, all
  constraints met). The HLS *estimate* of 163% LUT did not materialise: 78.47%
  routed. `freq_sweep/tests/test_reports.py` re-reads the same figures from the
  report text on every `make -C freq_sweep test`.
- The PL 1000-event number comes from `pl_fixed/native/`, which compiles the
  same kernel sources with g++ and is verified bit-identical to Vitis csim
  (`make csim FLOW=pl_fixed` → 0.000e+00). hw_emu is ~2 ms/event of RTL
  simulation, which makes it a 5-event tool, not a 1000-event one.
