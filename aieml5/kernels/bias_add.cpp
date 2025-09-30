#include "bias_add.h"
#include "nn_defs.h"

void bias_add_kernel(input_stream<float>* restrict dense_output,
                     input_stream<float>* restrict bias_stream,
                     output_stream<float>* restrict biased_output)
{
    v16float bias_vec = aie::zeros<float, 16>();
    v16float dense_vec = aie::zeros<float, 16>();
    v16float result_vec = aie::zeros<float, 16>();

    // Process HIDDEN_SIZE (128) elements in chunks of 16
    for (int i = 0; i < HIDDEN_SIZE; i += 16) {
        dense_vec = readincr_v16(dense_output);
        bias_vec = readincr_v16(bias_stream);

        result_vec = aie::add(dense_vec, bias_vec);

        writeincr(biased_output, result_vec);
    }
}