#include <adf.h>
#include "../kernels.h"
#include "../include.h"

static float weights[DENSE1_OUTPUT_SIZE][DENSE1_INPUT_SIZE];
static float bias[DENSE1_OUTPUT_SIZE];

// You can later load real weights here if needed
__attribute__((constructor))
void init_dense1_weights() {
    for (int i = 0; i < DENSE1_OUTPUT_SIZE; i++) {
        bias[i] = 0.1f;
        for (int j = 0; j < DENSE1_INPUT_SIZE; j++) {
            weights[i][j] = 0.01f * (i + j); // dummy pattern
        }
    }
}

void dense_layer_1(input_window<float>* in, output_window<float>* out) {
    float input[DENSE1_INPUT_SIZE];
    window_readin(in, input, DENSE1_INPUT_SIZE);

    float output[DENSE1_OUTPUT_SIZE] = {0};

    for (int i = 0; i < DENSE1_OUTPUT_SIZE; i++) {
        float acc = bias[i];
        for (int j = 0; j < DENSE1_INPUT_SIZE; j++) {
            acc += input[j] * weights[i][j];
        }
        window_writein(out, acc);
    }
}