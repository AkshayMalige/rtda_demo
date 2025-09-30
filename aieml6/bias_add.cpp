#include "bias_add.h"

void bias_add_kernel(input_window<float>* __restrict dense_window,
                    output_window<float>* __restrict biased_window,
                    const float (&bias)[HIDDEN_SIZE])
{
    // Process one window of HIDDEN_SIZE floats
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        float x = window_readincr(dense_window);
        float y = x + bias[i];
        window_writeincr(biased_window, y);
    }
}
                     