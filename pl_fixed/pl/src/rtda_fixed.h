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
//      A 256-term dot product of numbers of order 1. The generated <32,18> had
//      only 14 fractional bits, i.e. the accumulator was COARSER than the
//      product of two 13-bit-fraction operands -- it was throwing away the low
//      bits of every multiply before summing them.
//
//  AP_RND_CONV + AP_SAT, not the ap_fixed defaults (AP_TRN + AP_WRP).
//      Truncation costs half an LSB of *bias* -- not noise, bias -- at each of
//      14 layers, and it does not cancel. Wrapping turns a small overflow into
//      a sign flip. Rounding and saturating costs a little fabric and no DSPs.
//      This is the same class of bug as the fp32->bf16 truncation in aie4ml,
//      which was worth 8x end to end once fixed.
//
//  MEASURED, on the 27 outputs vs the ONNX reference (model/rtda_ref.py):
//      ap_fixed<16,6> trn/wrp, alpha=0.125   1.35e-02   <- what this was
//      ap_fixed<16,3> rnd/sat, alpha=0.1     ~2e-05     <- what it is now
//      AIE bf16                               2.6e-04
//      AIE fp32                               7.5e-07
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
typedef ap_fixed<RTDA_ACC_W, RTDA_ACC_I, AP_RND_CONV, AP_SAT>  rtda_accum_t;
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
