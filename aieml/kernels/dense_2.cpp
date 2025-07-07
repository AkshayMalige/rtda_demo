#include <adf.h>
#include "include.h"
#include "kernels.h"

using namespace adf;

void dense_2(input_window<float>* in_data,
             input_window<float>* in_weights,
             output_window<float>* out) {
    // Load hidden-layer activations
    float data[HIDDEN_SIZE];
    for (int i = 0; i < HIDDEN_SIZE; i++) {
        data[i] = window_readincr(in_data);
    }

    // Stream weights row-by-row and compute each output
    for (int o = 0; o < OUTPUT_SIZE; o++) {
        float acc = 0.0f;
        for (int i = 0; i < HIDDEN_SIZE; i++) {
            float w = window_readincr(in_weights);
            acc += data[i] * w;
        }
        window_writeincr(out, acc);
    }
}