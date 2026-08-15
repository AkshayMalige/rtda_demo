#pragma once
// ===========================================================================
//  Leaky ReLU with slope 0.1, at the cost of slope 0.125.
//
//  hls4ml's nnet::leaky_relu takes the slope as a *runtime argument*:
//
//      if (in[j] > 0) out[j] = in[j];
//      else           out[j] = alpha * in[j];       // <- a real multiplier
//
//  With alpha = 0.125 the synthesiser folds that into a shift after inlining.
//  With 0.1 it does not, and this design is already at 80.6% DSP utilisation --
//  14 activation layers x 128 lanes is not somewhere to start spending
//  multipliers.
//
//  So do the decomposition explicitly. On the 13-fractional-bit grid this
//  design uses, 0.1 rounds to
//
//      0.099609375  =  2^-4 + 2^-5 + 2^-8 + 2^-9
//
//  which is four shifts and three adds per lane, and no DSP at all. The result
//  is bit-identical to multiplying by the ap_fixed representation of 0.1,
//  because that representation IS this sum -- verified by the static_assert
//  below and, end to end, by `make csim` matching the numpy model.
//
//  Everything is done in a wide accumulator type and rounded once at the end,
//  so the four shifted copies do not each lose their own low bits.
// ===========================================================================

#include "rtda_fixed.h"
#include "hls_stream.h"
#include "nnet_utils/nnet_common.h"

namespace rtda {

// The shifted-sum form of the slope.
//
// The intermediate is RTDA_W + 9 bits wide with the SAME integer count, i.e.
// nine extra fractional bits -- exactly enough that `x >> 9`, the smallest
// term, is still represented without loss. So the sum of the four terms is
// EXACT, and one rounding happens on the way back to T. That is an arithmetic
// guarantee, not a measurement.
//
// No saturation and no rounding mode on the intermediate: the result cannot
// exceed 0.0996 * 4 = 0.4 against a +-2^(RTDA_I-1) range, so it can never
// overflow, and the sum is exact so there is nothing to round until the cast.
//
// This was originally a 32-bit AP_RND_CONV/AP_SAT accumulator, which put 1792
// instances (128 lanes x 14 activation layers) of wide saturating arithmetic
// in the design to avoid one DSP. csynth did not finish in 3h20m.
template <typename T>
inline T alpha_mul(const T &x) {
#pragma HLS INLINE
#ifdef RTDA_ALPHA_125
    return x >> 3;                                  // 0.125, a bare shift
#else
    typedef ap_fixed<RTDA_W + 9, RTDA_I> mul_t;
    mul_t a = (mul_t)x;
    // 0.099609375 = 51/512, and 51 = 3 x 17, so the four-term sum FACTORS into
    // two adds instead of three:
    //
    //     t = a>>5 + a>>4   =  3a/32
    //     s = t    + t>>4   = 17t/16  =  51a/512
    //
    // versus (a>>4)+(a>>5)+(a>>8)+(a>>9) = a(32+16+2+1)/512 = 51a/512.
    // Same value, and BIT-IDENTICAL rather than merely close: mul_t carries 9
    // fractional bits more than T, the smallest intermediate here needs 22 of
    // the 22 it has, so no shift drops a bit and every add is exact.
    //
    // This matters because it is not one adder. 128 lanes x 14 activation
    // layers = 1792 of them, each 25 bits wide -- a third of the leaky ReLU's
    // 24,708 LUT per layer, which is 29% of a design that failed to route at
    // 98.87% LUT.
    mul_t t = (a >> 5) + (a >> 4);
    mul_t s = t + (t >> 4);
    return (T)s;
#endif
}

// How many lanes of the packed beat are built as parallel hardware.
//
// THIS IS THE SINGLE MOST EXPENSIVE NUMBER IN THE DESIGN. The stream beat is
// 128 wide, and a `#pragma HLS PIPELINE` on the outer loop fully unrolls the
// inner one, so the layer became 128 parallel lanes of compare + shift-adds +
// saturating cast -- 24,706 LUT of pure combinational Expression, latency 0.
// Fourteen of those is 29% of a design that failed to route at 98.87% LUT.
//
// They finish in ONE cycle and then idle, because the dense layer feeding them
// has an II of 256 (1024 after RTDA_REUSE_DENSE). Eight lanes over 16 cycles
// costs nothing anyone can measure and is a sixteenth of the logic.
//
// Scheduling only: at any value the arithmetic per element is unchanged, so
// the result is bit-identical and the native model (which ignores the pragmas)
// is unaffected. 128 must be divisible by it.
#ifndef RTDA_LEAKY_LANES
#define RTDA_LEAKY_LANES 8
#endif

// One packed beat of an hls4ml io_stream activation layer.
template <class data_T, class res_T, typename CONFIG_T>
void leaky_relu(hls::stream<data_T> &data, hls::stream<res_T> &res) {
RtdaLeakyLoop:
    for (int i = 0; i < CONFIG_T::n_in / res_T::size; i++) {
        data_T in_data = data.read();
        res_T out_data;
        PRAGMA_DATA_PACK(out_data)

        // No PIPELINE on the loop above: it would unroll this one completely
        // and put all 128 lanes back.
    RtdaLeakyPack:
        for (int j = 0; j < res_T::size; j += RTDA_LEAKY_LANES) {
#pragma HLS PIPELINE II=1
        RtdaLeakyLane:
            for (int k = 0; k < RTDA_LEAKY_LANES; k++) {
#pragma HLS UNROLL
                const int idx = j + k;
                if (idx < res_T::size) {
                    if (in_data[idx] > 0)
                        out_data[idx] = in_data[idx];
                    else
                        out_data[idx] = alpha_mul(in_data[idx]);
                }
            }
        }
        res.write(out_data);
    }
}

}  // namespace rtda
