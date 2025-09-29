#pragma once
#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
using namespace aie;
void bias_add_kernel(input_stream<float>* __restrict dense_output,
                     const float* __restrict bias,
                     output_stream<float>* __restrict biased_output);

