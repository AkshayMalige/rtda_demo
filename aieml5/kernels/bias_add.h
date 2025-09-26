#pragma once

#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>

#include "nn_defs.h"

class BiasAddKernel {
  public:
    alignas(32) float bias[HIDDEN_SIZE];

    void run(input_stream<float>* restrict dense_output,
             output_stream<float>* restrict biased_output);
};
