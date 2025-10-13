#pragma once
#include <adf.h>
#include "nn_defs10.h"
using namespace adf;

void leaky_relu_kernel(input_window<float>* __restrict in,
                       output_window<float>* __restrict out);

