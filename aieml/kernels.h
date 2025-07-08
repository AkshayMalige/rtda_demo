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
);

void dense2(
    input_window<float>  *in_win,
    input_window<float>  *w_win,
    output_window<float> *out_win
);

void leaky_relu(
    input_window<float>  *in_win,
    output_window<float> *out_win
);