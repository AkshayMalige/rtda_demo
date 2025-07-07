#include <adf.h>
#include "../kernels.h"
#include "../include.h"

constexpr float NEGATIVE_SLOPE = 0.1f;

void leaky_relu(input_window<float>* in, output_window<float>* out) {
    for (int i = 0; i < DENSE1_OUTPUT_SIZE; i++) {
        float x = 0;
        window_readincr(in, x);
        float y = (x >= 0) ? x : NEGATIVE_SLOPE * x;
        window_writeincr(out, y);
    }
}