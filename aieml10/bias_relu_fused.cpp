#include "bias_relu_fused.h"

void bias_add_leaky_relu_kernel(input_window<float>* __restrict in,
                                output_window<float>* __restrict out,
                                const float (&bias)[HIDDEN_SIZE]) {
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        float x = window_readincr(in);
        float y = x + bias[i];
        // Leaky ReLU
        float z = (y >= 0.0f) ? y : (LEAKY_SLOPE * y);
        window_writeincr(out, z);
    }
}

