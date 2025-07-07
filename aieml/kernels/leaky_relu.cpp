#include <adf.h>
#include "include.h"
#include "kernels.h"

using namespace adf;

void leaky_relu(input_window<float>* in, output_window<float>* out) {
    for (int i = 0; i < HIDDEN_SIZE; i++) {
        float v = window_readincr(in);
        float r = (v > 0.0f) ? v : (v * LEAKY_SLOPE);
        window_writeincr(out, r);
    }
}