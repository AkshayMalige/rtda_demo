#include <adf.h>
#include "../kernels.h"
#include "../include.h"

static float weights[DENSE2_OUTPUT_SIZE][DENSE1_OUTPUT_SIZE];
static float bias[DENSE2_OUTPUT_SIZE];

__attribute__((constructor))
void init_dense2_weights() {
    for (int i = 0; i < DENSE2_OUTPUT_SIZE; i++) {
        bias[i] = 0.2f;
        for (int j = 0; j < DENSE1_OUTPUT_SIZE; j++) {
            weights[i][j] = 0.005f * (i - j); // dummy pattern
        }
    }
}

void dense_layer_2(input_window<float>* in, output_window<float>* out) {
    float input[DENSE1_OUTPUT_SIZE];
    window_readin(in, input, DENSE1_OUTPUT_SIZE);

    float output[DENSE2_OUTPUT_SIZE] = {0};

    for (int i = 0; i < DENSE2_OUTPUT_SIZE; i++) {
        float acc = bias[i];
        for (int j = 0; j < DENSE1_OUTPUT_SIZE; j++) {
            acc += input[j] * weights[i][j];
        }
        window_writein(out, acc);
    }
}