#include <adf.h>
#include "include.h"
#include "kernels.h"

using namespace adf;

void leaky_relu(input_window<float>* in, output_window<float>* out) {
    // constexpr int VEC_WIDTH = 16;
    // static_assert(HIDDEN_SIZE % VEC_WIDTH == 0, "HIDDEN_SIZE must be divisible by VEC_WIDTH");

    for (int i = 0; i < HIDDEN_SIZE / VEC_WIDTH; i++) {
        aie::vector<float, VEC_WIDTH> vin = window_readincr_v<VEC_WIDTH>(in);
        aie::mask<VEC_WIDTH> pos_mask = vin > aie::broadcast<float, VEC_WIDTH>(0.0f);
        aie::vector<float, VEC_WIDTH> vout = aie::select(vin * LEAKY_SLOPE, vin, pos_mask);
        window_writeincr_v(out, vout);
    }
}