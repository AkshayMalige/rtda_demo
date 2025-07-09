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

void dense2( input_window<float>*  __restrict in_act,
    input_window<float>* __restrict w_even,
    input_window<float>* __restrict w_odd,
    output_window<float>* __restrict out_act );

void leaky_relu(input_window<float>*  __restrict in,
    output_window<float>* __restrict out);