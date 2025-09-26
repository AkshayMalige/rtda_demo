#include "bias_add.h"

using namespace aie;

void BiasAddKernel::run(input_stream<float>* restrict dense_output,
                        output_stream<float>* restrict biased_output) {
    v16float dense_vec = aie::zeros<float, 16>();
    v16float bias_vec = aie::zeros<float, 16>();

    for (int idx = 0; idx < HIDDEN_SIZE; idx += 16) {
        dense_vec = readincr_v16(dense_output);
        bias_vec = aie::load_v<16>(&bias[idx]);
        writeincr(biased_output, aie::add(dense_vec, bias_vec));
    }
}
