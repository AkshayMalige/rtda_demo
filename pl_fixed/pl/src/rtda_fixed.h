#pragma once
// ===========================================================================
//  The fixed-point format, in one place.
//
//  Every activation, weight and accumulator type in this design resolves to
//  one of the typedefs below. The five firmware defines.h files were generated
//  by hls4ml with `ap_fixed<16,6>` hard-coded in ~40 places; they now include
//  this header instead, so the format is a build-time knob:
//
//      make csynth AP_W=18 AP_I=3
//      make sweep                     (runs the numpy model over a grid first)
//
//  WHY THE DEFAULTS ARE WHAT THEY ARE
//
//  ap_fixed<W,I> in Vitis counts I as integer bits INCLUDING the sign, so
//  ap_fixed<16,6> spans [-32, 32) with 10 fractional bits.
//
//  RTDA_I = 3  ->  [-4, 4), 13 fractional bits.
//      Every activation in the network fits in +-2.3 (measured across all 14
//      layers of the ONNX reference). The generated default of 6 integer bits
//      reserved room up to +-32 that nothing ever uses, and paid for it with
//      three bits of resolution -- on outputs whose full scale is 0.05.
//
//  RTDA_WEIGHT_I = 1  ->  [-1, 1), 15 fractional bits.
//      max |weight| = 0.688, max |bias| = 0.420, over all 30 tensors.
//
//  RTDA_ACC_* = <32,10>  ->  [-512, 512), 22 fractional bits.
//      NOT a lever, and worth saying so. The largest value any dense
//      accumulator reaches on this network is 3.22, so there is ~160x
//      headroom, and the fractional bits do not show up in the result:
//      <32,18> gives 1.09e-04, <32,10> gives 1.21e-04, <40,10> 1.36e-04 --
//      that spread is noise. An earlier version of this comment claimed the
//      generated <32,18> "threw away the low bits of every multiply"; the
//      measurement says it did not. `make sweep` prints this table.
//      Corollary: AP_SAT on the accumulator is DEAD LOGIC in the innermost
//      loop. See the TODO at the bottom of this file.
//
//  AP_RND_CONV + AP_SAT on the ACTIVATIONS, not the ap_fixed defaults
//  (AP_TRN + AP_WRP). Truncation costs half an LSB of *bias* -- not noise,
//      bias -- at each of 14 layers, and it does not cancel.
//
//  BUT: NO SINGLE ONE OF THESE CHANGES HELPS ON ITS OWN. Three of the four
//  make it worse. Measured, from the original <16,6> trn_wrp alpha=0.125:
//
//      original                       1.393e-02
//      alpha 0.1 alone                2.234e-02   WORSE
//      round+saturate alone           1.837e-02   WORSE
//      activation I=3 alone           1.332e-02
//      weight I=1 alone               1.666e-02   WORSE
//      alpha + rounding               1.208e-03
//        + activation I=3             9.305e-04
//        + weight I=1     (shipped)   1.085e-04
//
//  With alpha=0.125 the design computes a DIFFERENT FUNCTION from the
//  reference, so improving its precision just resolves the wrong answer more
//  sharply. alpha and rounding have to move together; only then do the
//  integer-bit choices pay. Do not "simplify" one of these back out.
//
//  For scale, same metric, same stimulus:  AIE bf16 6.0e-04,  AIE fp32 7.5e-07.
// ===========================================================================

#include "ap_fixed.h"
#include "ap_int.h"

// ---------------------------------------------------------------------------
//  Where csim/native runs find the weight text files.
//
//  hls4ml's nnet::load_weights_from_txt builds "WEIGHTS_DIR/<name>.txt", and
//  WEIGHTS_DIR is a macro that has to expand to something string-ish. Passing
//  it as -DWEIGHTS_DIR="..." does not survive: the quotes are eaten going
//  through Tcl, then again through the csim.mk Vitis generates, and the path
//  arrives as bare tokens ("use of undeclared identifier 'home'").
//
//  So resolve it at RUN time instead. No quoting round trip to lose.
//  Synthesis never sees this -- there the weights are compile-time arrays.
// ---------------------------------------------------------------------------
#ifndef __SYNTHESIS__
#include <cstdlib>
#include <string>
inline std::string rtda_weights_dir() {
    const char* e = std::getenv("RTDA_WEIGHTS_DIR");
    return (e && *e) ? std::string(e) : std::string("weights");
}
#ifndef WEIGHTS_DIR
#define WEIGHTS_DIR rtda_weights_dir()
#endif
#endif

#ifndef RTDA_W
#define RTDA_W 16          // total bits for activations
#endif
#ifndef RTDA_I
#define RTDA_I 3           // integer bits, sign included  -> [-4, 4)
#endif
#ifndef RTDA_WEIGHT_I
#define RTDA_WEIGHT_I 1    // weights and biases are all < 1 in magnitude
#endif
#ifndef RTDA_ACC_W
#define RTDA_ACC_W 32
#endif
#ifndef RTDA_ACC_I
#define RTDA_ACC_I 10
#endif

typedef ap_fixed<RTDA_W, RTDA_I, AP_RND_CONV, AP_SAT>          rtda_act_t;
typedef ap_fixed<RTDA_W, RTDA_WEIGHT_I, AP_RND_CONV, AP_SAT>   rtda_weight_t;
// The accumulator gets the ap_fixed DEFAULTS -- no rounding, no saturation --
// on purpose, and this is the one place in the design where that is right:
//
//   * AP_SAT would be dead logic. 160x headroom (max value 3.22 vs +-512)
//     means the comparators can never fire, and they would sit in the
//     innermost loop of all 14 dense layers -- the most expensive location
//     available.
//   * AP_RND_CONV buys nothing measurable here: <32,10> trn/wrp scores
//     1.137e-04 against 1.211e-04 for rnd/sat, which is noise. The rounding
//     that MATTERS is on the activations, where a truncation bias accumulates
//     across 14 layers; a 22-fractional-bit accumulator is already far below
//     the 13-bit activation grid it feeds.
//
// Making these AP_RND_CONV/AP_SAT was the first thing tried, and csynth then
// ran 3h20m without reaching a report (1.4M instructions, 5.8 GB).
typedef ap_fixed<RTDA_ACC_W, RTDA_ACC_I>                       rtda_accum_t;
// The 27 deliverables span +-0.05, so they get the narrow range too.
typedef ap_fixed<RTDA_W, RTDA_WEIGHT_I, AP_RND_CONV, AP_SAT>   rtda_out_t;
// Only referenced by hls4ml's table-based activations. Leaky ReLU is computed
// directly (see rtda_leaky.h), so nothing actually indexes a table here.
typedef ap_fixed<18, 8> rtda_table_t;

// ---------------------------------------------------------------------------
//  Leaky-ReLU slope
//
//  The RTDA network uses 0.1. The hls4ml export used 0.125 because 2^-3 is a
//  bare shift and costs no DSP -- a deliberate trade, documented in
//  punit/dsp_experiments/, but it makes the PL a different function from the
//  AIE and from the ONNX, which is most of the 1.35e-02 above.
//
//  0.1 is not representable, but its nearest value on a 13-fractional-bit grid,
//  0.099609375, is exactly 2^-4 + 2^-5 + 2^-8 + 2^-9 -- four shifts and three
//  adds, still no DSP. rtda_leaky.h uses that decomposition directly rather
//  than trusting the synthesiser to find it.
//
//  Define RTDA_ALPHA_125 to build the legacy 0.125 variant for comparison.
// ---------------------------------------------------------------------------
#ifdef RTDA_ALPHA_125
#define RTDA_ALPHA_VALUE 0.125
#else
#define RTDA_ALPHA_VALUE 0.099609375
#endif

// ---------------------------------------------------------------------------
//  Synthesis cost, learned the hard way
//
//  The first version of this header put AP_RND_CONV/AP_SAT on EVERY type,
//  including the 32-bit accumulator, and rtda_leaky.h built its shift-add in a
//  32-bit saturating accumulator too. csynth then ran 3h20m at 5.8 GB without
//  reaching a report (1.4M instructions), against a design that had
//  synthesised fine before.
//
//  Both were removable at no numerical cost -- see the notes above and in
//  rtda_leaky.h. The lesson is narrow but worth keeping: rounding and
//  saturation modes are not free, and the innermost loop of 14 dense layers is
//  the worst place to spend them. Put them where the error actually is (the
//  activations) and nowhere else.
// ---------------------------------------------------------------------------
