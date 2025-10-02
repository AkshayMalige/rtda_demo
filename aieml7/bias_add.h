#pragma once
#include <adf.h>
#include "nn_defs.h"
using namespace adf;

void bias_add_kernel(input_window<float>* __restrict dense_window,
                     output_window<float>* __restrict biased_window,
                     input_buffer<float>& __restrict bias_buffer);
