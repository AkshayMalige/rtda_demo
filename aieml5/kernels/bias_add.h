#pragma once

#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>

using namespace aie;

void bias_add_kernel(input_stream<float>* restrict dense_output,
                     input_stream<float>* restrict bias_stream,
                     output_stream<float>* restrict biased_output);