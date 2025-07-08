#pragma once

#include <adf.h>
#include "aie_api/aie.hpp"
#include "include.h"
#include "system_settings.h"

using namespace adf;

// Dense layer 1: input_window -> output_window

void dense1(
    input_window<float>  *in_win,
    input_window<float>  *w1_win,
    input_window<float>  *w2_win,
    output_window<float> *out_win
)
// Leaky ReLU: input_window -> output_window
void leaky_relu(input_window<float>* in,
                output_window<float>* out);

// Dense layer 2 with weight streaming: two inputs + output
void dense_2(input_window<float>* in_data,
             input_window<float>* in_weights,
             output_window<float>* out);