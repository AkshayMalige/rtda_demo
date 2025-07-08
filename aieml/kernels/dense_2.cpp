#include <adf.h>
#include "../kernels.h"

using namespace adf;

void dense_2(input_window<float>* in_data,
             input_window<float>* in_weights,
             output_window<float>* out) {

    // constexpr int VEC_WIDTH = 16;
    // static_assert(HIDDEN_SIZE % VEC_WIDTH == 0, "HIDDEN_SIZE must be divisible by VEC_WIDTH");

    // Load hidden-layer activations into a buffer
    aie::vector<float, VEC_WIDTH> data[HIDDEN_SIZE / VEC_WIDTH];
    for (int i = 0; i < HIDDEN_SIZE / VEC_WIDTH; i++) {
        // data[i] = aie::load_v<VEC_WIDTH>(in_data);
        data[i] = window_readincr_v<VEC_WIDTH>(in_data);
    }

    // Compute output using vectorized multiply-accumulate
    for (int o = 0; o < OUTPUT_SIZE; o++) {
        aie::accum<acc32, VEC_WIDTH> acc = aie::zeros<acc32, VEC_WIDTH>();

        for (int i = 0; i < HIDDEN_SIZE / VEC_WIDTH; i++) {
            // aie::vector<float, VEC_WIDTH> weights = aie::load_v<VEC_WIDTH>(in_weights);
            aie::vector<float, VEC_WIDTH> weights = window_readincr_v<VEC_WIDTH>(in_weights);
            acc = aie::mac(acc, data[i], weights);
        }
        // Sum all vector elements
        float result = aie::reduce_add(acc);
        window_writeincr(out, result);
    }
}

