# Resources — where the precision realignment landed

`make csynth`, Vitis HLS 2024.2, `xcve2802-vsvh1760-2MP-e-S`, 150 MHz.
These are **HLS estimates**, not place-and-route results. Read the calibration
note at the bottom before believing any of them.

## Current design — ap_fixed<16,3>, alpha 0.1

| block | BRAM | DSP | FF | LUT |
|---|---|---|---|---|
| `embed_run` | 37 (3%) | 68 (5%) | 31,209 (2%) | 130,480 (25%) |
| `solver0_run` | 162 (13%) | 320 (24%) | 105,941 (10%) | 343,814 (66%) |
| `solver1_run` | 162 (13%) | 320 (24%) | 105,942 (10%) | 343,814 (66%) |
| `solver2_run` | 162 (13%) | 320 (24%) | 105,944 (10%) | 343,814 (66%) |
| `output_run` | 19 (1%) | 27 (2%) | 14,889 (1%) | 15,882 (3%) |
| **top** | **572 (47%)** | **1057 (80%)** | **393,720 (37%)** | **1,206,105 (231%)** |

## Against the design before the realignment

| | before | after | |
|---|---|---|---|
| BRAM | 539 (44%) | 572 (47%) | +6% |
| **DSP** | **1057 (80%)** | **1057 (80%)** | **unchanged** |
| FF | 308,922 (29%) | 393,720 (37%) | +27% |
| LUT | 563,386 (108%) | 1,206,105 (231%) | **+114%** |

**The DSP row is the one that had to be checked and it is clean.** Leaky ReLU
at slope 0.1 is computed as `2^-4 + 2^-5 + 2^-8 + 2^-9` (see `pl/src/rtda_leaky.h`),
and it costs exactly as many multipliers as the 0.125 shift it replaced: none.

**The LUT row is the open problem.** The realignment roughly doubled it.

## Where the LUTs went, and the obvious next lever

The report is full of modules like

    cast_ap_fixed_16_3_4_0_0_ap_fixed_16_1_4_0_0_config2_s     116 LUT each

That is a rounding-and-saturating conversion between the ACTIVATION type
`ap_fixed<16,3,AP_RND_CONV,AP_SAT>` and the WEIGHT type
`ap_fixed<16,1,AP_RND_CONV,AP_SAT>`, instantiated per lane, per dense layer.
Activations and weights deliberately use *different* fixed-point formats -- that
is what buys the accuracy -- and every operand pair therefore needs a converting
cast.

Two ways out, not yet tried, in order of how free they look:

1. **Give `rtda_weight_t` the plain ap_fixed defaults.** The weights are
   compile-time constants; saturation on them is meaningless and rounding
   happens once at build time in `gen_weights.py`, not in hardware. The
   mode only affects the cast on read. This may remove most of the cast logic
   at zero accuracy cost. Pre-round the literals in `gen_weights.py` so AP_TRN
   does not shift them.
2. **Make the weights `<16,3>` as well**, removing the format mismatch outright.
   Costs accuracy: the ablation in `make sweep` puts weight `I=1` at 8.6x
   (9.305e-04 -> 1.085e-04), which would take the design back to roughly bf16
   parity. A real trade, not an obvious win.

## Calibration — how much to trust an HLS LUT estimate here

The design *before* the realignment estimated **108% LUT** and placed and routed
at **43%**, with `WNS +0.186 ns` at 150 MHz. So on this design the HLS estimate
ran about **2.5x pessimistic**.

231% scaled by that same factor is ~92%. That is not a margin anyone should
plan around. **Place and route is the only way to know, and it has not been
run.** Do that before promising the design fits:

    make system FLOW=pl_fixed TARGET=hw

## Reproducing

    make -C pl_fixed csynth          # ~5 h; see the note below

Synthesis is slow: 'Checking Synthesizability' alone takes ~100 min and the
whole run took 4h54m at ~3.5 GB. An earlier version with AP_RND_CONV/AP_SAT on
the accumulator and a 32-bit saturating temp in the leaky helper was far worse
-- 1,376,823 instructions at 'HW Transforms' against 584,157 now, 'Standard
Transforms' 384 s against 45 s, peak RSS 5.8 GB against 3.5 GB -- and did not
finish in 3h20m. See the notes in `pl/src/rtda_fixed.h`.
