#include "leaky_relu.h"
#include <aie_api/aie.hpp>

using namespace adf;

void leaky_relu_kernel(input_window<float>* __restrict in,
                       output_window<float>* __restrict out) {
    // Process one window of HIDDEN_SIZE elements using configured slope
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        float x = window_readincr(in);
        float y = (x >= 0.0f) ? x : (LEAKY_SLOPE * x);
        window_writeincr(out, y);
    }
}
