#include "bias_add.h"
#include "nn_defs.h"

void bias_add_kernel(input_stream<float>* __restrict dense_output,
                     output_stream<float>* __restrict biased_output,
                     const float (&bias)[HIDDEN_SIZE])
{
    // Process HIDDEN_SIZE (128) elements one at a time
    for (int i = 0; i < HIDDEN_SIZE; i++) {
        const float dense_val = readincr(dense_output);
        const float result = dense_val + bias[i];
        writeincr(biased_output, result);
    }
}