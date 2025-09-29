#include "bias_add.h"
#include "nn_defs.h"

void bias_add_kernel(input_stream<float>* __restrict dense_output,
                     const float* __restrict bias,
                     output_stream<float>* __restrict biased_output)
{
    v16float bias_vec = aie::zeros<float, 16>();
    v16float dense_vec = aie::zeros<float, 16>();
    v16float result_vec = aie::zeros<float, 16>();

    // Process HIDDEN_SIZE (128) elements in chunks of 16
    for (int i = 0; i < HIDDEN_SIZE; i += 16) {
        dense_vec = readincr_v16(dense_output);
        bias_vec = aie::load_v<16>(&bias[i]);

        result_vec = aie::add(dense_vec, bias_vec);

        writeincr(biased_output, result_vec);
    }
}
