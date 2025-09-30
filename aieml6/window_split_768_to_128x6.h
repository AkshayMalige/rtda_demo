#pragma once
#include <adf.h>
using namespace adf;

void window_split_768_to_128x6(input_window<float>* __restrict in,
    output_window<float>* __restrict out0,
    output_window<float>* __restrict out1,
    output_window<float>* __restrict out2,
    output_window<float>* __restrict out3,
    output_window<float>* __restrict out4,
    output_window<float>* __restrict out5);