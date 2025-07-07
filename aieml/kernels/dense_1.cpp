#include <adf.h>
#include "../include.h"
#include "../kernels.h"

using namespace adf;

void dense_1(input_window<float>* in, output_window<float>* out) {
    // Read full input vector
    float data[INPUT_SIZE];
    for (int i = 0; i < INPUT_SIZE; i++) {
        data[i] = window_readincr(in);
    }

    // Simple statically initialized weights & bias (for functional test)
    // In practice, replace with your trained values.
    static float weights[HIDDEN_SIZE][INPUT_SIZE];
    static float bias[HIDDEN_SIZE];
    // Initialize on first call (could be moved to constructor)
    for (int o = 0; o < HIDDEN_SIZE; o++) {
        bias[o] = 0.1f;
        for (int i = 0; i < INPUT_SIZE; i++) {
            weights[o][i] = 0.01f * (o + i);
        }
    }

    // Compute output = W * data + b
    for (int o = 0; o < HIDDEN_SIZE; o++) {
        float acc = bias[o];
        for (int i = 0; i < INPUT_SIZE; i++) {
            acc += data[i] * weights[o][i];
        }
        window_writeincr(out, acc);
    }
}