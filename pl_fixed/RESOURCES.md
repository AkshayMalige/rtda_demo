# Resources — why the design stopped fitting, and the leaky ReLU

## The two builds

| | **May 2026** | **Aug 14 2026** |
|---|---|---|
| activation type | `ap_fixed<16,6>` plain | `ap_fixed<16,3,AP_RND_CONV,AP_SAT>` |
| weight type | `ap_fixed<16,6>` plain | `ap_fixed<16,1,AP_RND_CONV,AP_SAT>` |
| leaky slope | 0.125 | 0.099609375 |
| **LUT** | **224,344 (43.08%)** | **513,603 (98.87%)** |
| DSP | 80.56% | 80.56% |
| **accuracy, 27 outputs** | **2.413e-02 (26.4% FS)** | **3.540e-04 (0.39% FS)** |
| outcome | routed, ran on hardware | **failed to route** |

Identical DSP, so the multipliers never changed. The glue grew by 289,259 LUT.

The August build placed fine and met timing (WNS +0.213 ns). It died in routing:
congestion level 6, 469,480 unrouted signals. At 98.87% LUT there is no fabric
left to run wires through.

The accuracy column is why the change was made and why going back is not the
answer. May's design was 68x further from the trained network — it had a 25%
error in the slope at all 14 layers *and* 10 fractional bits instead of 13.

## The leaky ReLU

The activation after every dense layer:

    if (x > 0)  out = x
    else        out = alpha * x

**Why 0.125 was chosen.** hls4ml takes alpha as a runtime argument, so
`alpha * x` is a real multiplier — 128 lanes x 14 layers. With 0.125 the
synthesiser sees a power of two and turns it into `x >> 3`, which is free: a
shift is wiring, not gates. At 80% DSP that was a sound call.

Its cost is accuracy. 0.125 is 25% off the trained slope, applied 14 times.

### Getting 0.1 without a DSP

0.1 is not representable in binary. On this design's 13-fractional-bit grid the
nearest value is

    0.099609375 = 51/512

Split that into a multiply and a divide:

    / 512   =  shift right 9        FREE
    x 51    =  the only real work

and 51 is a sum of powers of two, so the multiply is adds:

    51 = 32 + 16 + 2 + 1
    x*51 = (x<<5) + (x<<4) + (x<<1) + x        3 adds, no DSP

`alpha_mul()` in `pl/src/rtda_leaky.h` writes this with the /512 folded into the
shifts. **Zero DSPs, same as the 0.125 shift it replaced** — confirmed, DSP was
80.56% before and after.

This is not an approximation of multiplying by 0.1. It is exactly what
multiplying by the `ap_fixed` representation of 0.1 does, because that
representation *is* this sum.

### The bug: shifts are free, adds are not

    for (int i = 0; i < CONFIG_T::n_in / res_T::size; i++) {
    #pragma HLS PIPELINE                      // <-- forces the inner loop
        ...                                   //     to unroll COMPLETELY
        for (int j = 0; j < res_T::size; j++) {
    #pragma HLS UNROLL

`res_T::size` is 128. So every activation was built as **128 parallel copies**
of compare + three 25-bit adds + a saturating convergent-rounding cast:

    24,706 LUT, all of it Expression, latency 0 — pure combinational

Fourteen of those is 29% of the device.

The waste is the shape of it. Those 128 lanes finish in **one cycle** and then
sit idle for the **256** the dense layer feeding them takes. The design paid for
128 lanes of hardware to do 1/256th of the work.

In May the same 128 copies existed. They cost nothing, because each one was a
wire.

### The fix

Two changes, both in `pl/src/rtda_leaky.h`.

**1. Build 8 lanes, not 128.** Run them 16 times. Sixteen cycles is invisible
next to the dense layer's 256.

    for (int j = 0; j < res_T::size; j += RTDA_LEAKY_LANES) {
    #pragma HLS PIPELINE II=1
        for (int k = 0; k < RTDA_LEAKY_LANES; k++) {
    #pragma HLS UNROLL

The outer `PIPELINE` had to go — it was what forced the full unroll.

**2. Two adders instead of three.** 51 = 3 x 17, so multiply in two stages
rather than summing four terms:

    t = x + (x<<1)      // x3     1 add
    r = t + (t<<4)      // x17    1 add        3 x 17 = 51

Bit-identical, not merely close: `mul_t` carries 9 spare fractional bits, so the
integer code is `X*512` and both forms reduce to exactly `51X` with no shift
dropping a bit and no overflow.

### Measured

| | before | after |
|---|---|---|
| **leaky ReLU, per layer** | 24,708 LUT | **1,068 LUT** |
| top-level LUT estimate | 1,206,105 | **818,887** |
| DSP | 1,057 | **289** |
| HLS runtime | 4 h 54 m | 3 h 12 m |

23x on the activation — better than the 16x the lane count alone predicts,
because the saturating casts got shared across cycles too.

**The slope is still 0.099609375.** These are scheduling changes; the arithmetic
per element is untouched. `make fastsim FLOW=pl_fixed EVENTS=1000` produces
`track_means_all.txt` byte-for-byte identical to the pre-change run, and the
accuracy stays at 3.540e-04.

## Reuse factor — measured, and mostly a red herring

`RTDA_REUSE_DENSE` in `pl/src/rtda_fixed.h` sets how many cycles a dense layer
is spread over, so it sets how many multipliers exist. One 128x128 layer
synthesised standalone at each setting:

| RF | DSP | LUT | II |
|---|---|---|---|
| 256 | 64 | 192,647 | 256 |
| 512 | 32 | 176,102 | 512 |
| 1024 | **16** | 168,239 | 1024 |

DSP tracks `block_factor = n_in*n_out/RF` exactly, so the knob unquestionably
works. But **LUT falls only 12.7% for a 4x cut in multipliers** — the
multipliers were never the LUT cost. `Instance` and `Multiplexer` dominate and
are flat in the multiplier count.

The same thing shows in the shipped design: the 6->128 layer has 16x fewer
multipliers than a 128x128 one and costs only 24% less.

Worth roughly 38k LUT, ~7 points of the device. Kept because the latency it
spends is free here — 4x an II on a design that exists as a numerical comparison
point puts 50,000 tracks at about 2 s.

## How much to trust an HLS LUT estimate

Two calibration points, both from real place-and-route on this design:

| estimate | placed | ratio |
|---|---|---|
| 108% | 43.08% | 2.5x |
| 231% | 98.87% | 2.34x |

Consistent, so the estimate runs about **2.4x pessimistic** here. 818,887 (157%)
scaled by that is **63-67%**.

**That is a prediction, not a result.** Place and route is the only way to know.

## It routed — 2026-08-15, ap16_3

`reference_hw_aug15/kernel_util_routed.rpt`, from the build that is flashed and
whose board results match the native model to 0.000e+00:

| | routed | of | % | HLS estimate | estimate was |
|---|---:|---:|---:|---:|---|
| LUT | 394,548 | 520,704 | **75.95%** | 231% | **3.0x** pessimistic |
| REG | 585,049 | 1,041,408 | 56.28% | — | |
| BRAM | 191 | 600 | 31.83% | 47% | 1.5x |
| DSP | 289 | 1,312 | **22.03%** | 1057 (80%) | **3.7x** pessimistic |

**All timing constraints met, WNS +0.050 ns.** The kernel clock is **150 MHz**:
in `route_report_timing_summary_0.rpt`, `clkout2_primitive` (150.000 MHz) carries
1,319,470 endpoints while `clkout1_primitive` (100 MHz) carries 3,236 — the
kernel is on the fast one, the control path on the slow one.

So the 2.4x calibration above was itself optimistic: LUT came in at 3.0x, DSP at
3.7x. The rule from three points is that an HLS estimate here is an upper bound
with a factor of **2.4-3.7** in it — too wide a band to plan with. It tells you
whether to worry, not whether it fits.

**The DSP number matters for a claim made elsewhere.** README cited 1057 (80%)
DSP from csynth as evidence that leaky-ReLU at slope 0.1 costs nothing. The
conclusion survives — 289 of 1312 routed — but the number quoted for it was the
estimate, not the result.

**And the 150 MHz matters for the performance scan.**
`analysis/rtda_scan.ipynb` compares measured kernel time against csynth's 6335
cycles per track, which is 42.23 us/track *only if* the clock really is 150 MHz.
It is. So the measured 113.40 us/track is a genuine 2.7x on the fabric, not a
clock-frequency artefact.

## Don't wait for route_design to find out

The failed build was already doomed at 21:46, when Vivado finished synthesising
the kernel and wrote a utilization report saying 99.68%. Nobody read it and the
build churned until 00:41.

Post-synthesis LUT tracks post-placement closely (99.68% -> 98.87%), so that
report is a sound early verdict, and it lands about an hour after HLS finishes —
roughly a third of the way through.

    make system FLOW=pl_fixed TARGET=hw        # one terminal
    tools/watch_pl_build.sh pl_fixed 80        # another

The watcher polls for that report and prints the number. Over threshold, kill
the make: you lose the HLS hours, not the night.

## Reference

`reference_may2026/` holds the May build's utilization reports. `make clean`
deletes `_x/`, and that was the project's only known-good place-and-route.
