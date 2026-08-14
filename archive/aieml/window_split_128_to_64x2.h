#pragma once
#include <adf.h>
#include "data_types.h"
#include "nn_defs10.h"

void window_split_128_to_64x2(input_window<DATA_TYPE>* __restrict in,
                              output_window<DATA_TYPE>* __restrict out0,
                              output_window<DATA_TYPE>* __restrict out1);
