#pragma once
#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
#include "nn_defs.h"
using namespace aie;
void bias_add_kernel(input_stream<float>* __restrict dense_output,
                     output_stream<float>* __restrict biased_output,
                     const float (&bias)[HIDDEN_SIZE]);

