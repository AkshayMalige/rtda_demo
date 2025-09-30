#pragma once
#include <adf.h>
using namespace adf;

void window_split_512_to_256x2(input_window<float>* __restrict in,
                               output_window<float>* __restrict out0,
                               output_window<float>* __restrict out1);
