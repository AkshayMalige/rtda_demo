#pragma once
#include <adf.h>

void window_split_768_to_64x12(input_window<float>* __restrict in,
                               output_window<float>* __restrict out0,
                               output_window<float>* __restrict out1,
                               output_window<float>* __restrict out2,
                               output_window<float>* __restrict out3,
                               output_window<float>* __restrict out4,
                               output_window<float>* __restrict out5,
                               output_window<float>* __restrict out6,
                               output_window<float>* __restrict out7,
                               output_window<float>* __restrict out8,
                               output_window<float>* __restrict out9,
                               output_window<float>* __restrict out10,
                               output_window<float>* __restrict out11);
