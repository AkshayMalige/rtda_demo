#pragma once
#include <adf.h>
#include "nn_defs10.h"

using namespace adf;

void window_split_128_to_64x2(input_window<float>* __restrict in,
                              output_window<float>* __restrict out0,
                              output_window<float>* __restrict out1);
