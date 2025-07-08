#pragma once

#include <adf.h>
#include "aie_api/aie.hpp"
// #include "include.h"
// #include "system_settings.h"

using namespace adf;

// Dense layer 1: input_window -> output_window

void dense1( input_window<float>*  __restrict in,
    input_window<float>*  __restrict w1a,
    input_window<float>*  __restrict w1b,
    output_window<float>* __restrict out );

void dense2( input_window<float>*  __restrict in,   // 128 × float
        input_window<float>*  __restrict w2a,  // even weights
        input_window<float>*  __restrict w2b,  // odd  weights
        output_window<float>* __restrict out ); // 128 × float

void leaky_relu(input_window<float>*  __restrict in,
    output_window<float>* __restrict out);