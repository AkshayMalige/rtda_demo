#include "kernel.hpp"
#include <cmath>

#define DENSE1_INPUT_SIZE 6
#define DENSE1_OUTPUT_SIZE 128
#define DENSE2_OUTPUT_SIZE 128
#define LEAKY_SLOPE 0.1f

// Dummy weights and biases for demonstration
float dense1_weights[DENSE1_OUTPUT_SIZE][DENSE1_INPUT_SIZE] = {{0}};
float dense1_biases[DENSE1_OUTPUT_SIZE] = {0};
float dense2_weights[DENSE2_OUTPUT_SIZE][DENSE1_OUTPUT_SIZE] = {{0}};
float dense2_biases[DENSE2_OUTPUT_SIZE] = {0};

void dense_1(input_window<float>* in, output_window<float>* out) {
    float input[DENSE1_INPUT_SIZE];
    window_readin(in, input);

    for (int i = 0; i < DENSE1_OUTPUT_SIZE; ++i) {
        float acc = dense1_biases[i];
        for (int j = 0; j < DENSE1_INPUT_SIZE; ++j)
            acc += dense1_weights[i][j] * input[j];
        window_write(out, acc);
    }
}

void leaky_relu(input_window<float>* in, output_window<float>* out) {
    for (int i = 0; i < DENSE1_OUTPUT_SIZE; ++i) {
        float val = window_readincr(in);
        window_write(out, val > 0 ? val : LEAKY_SLOPE * val);
    }
}

void dense_2(input_window<float>* in, output_window<float>* out) {
    float input[DENSE1_OUTPUT_SIZE];
    window_readin(in, input);

    for (int i = 0; i < DENSE2_OUTPUT_SIZE; ++i) {
        float acc = dense2_biases[i];
        for (int j = 0; j < DENSE1_OUTPUT_SIZE; ++j)
            acc += dense2_weights[i][j] * input[j];
        window_write(out, acc);
    }
}
