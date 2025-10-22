
#include "bias_relu_fused.h"

void bias_add_leaky_relu_kernel(input_window<float>* __restrict in,
                                output_window<float>* __restrict out,
                                const float (&bias)[HIDDEN_SIZE]) {
    const int N = window_size(in) / sizeof(float);   // exact elements in this window
    // If bias is only HIDDEN_SIZE long but N may be padded, clamp N to HIDDEN_SIZE
    const int M = (N < HIDDEN_SIZE) ? N : HIDDEN_SIZE;

    // Process the true data region
    for (int i = 0; i < M; ++i) {
        float x = window_readincr(in);
        float y = x + bias[i];
        float z = (y >= 0.0f) ? y : (LEAKY_SLOPE * y);
        window_writeincr(out, z);
    }

    // If N > HIDDEN_SIZE (padding), drain the remaining input and forward zeros (or copy through)
    for (int i = M; i < N; ++i) {
        (void)window_readincr(in);        // consume padding
        window_writeincr(out, 0.0f);      // or forward same padding policy as producer
    }
}