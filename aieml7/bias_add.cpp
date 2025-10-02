#include "bias_add.h"
#include <aie_api/aie.hpp>

void bias_add_kernel(input_window<float>* __restrict dense_window,
                    input_buffer<float>& __restrict bias_window,
                    output_window<float>* __restrict biased_window)
{
    auto bias_ptr = aie::begin(bias_window);
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        const float x = window_readincr(dense_window);
        const float y = x + bias_ptr[i];
        window_writeincr(biased_window, y);
    }
}
                     