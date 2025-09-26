#pragma once
#include <adf.h>
#include "nn_defs.h"
using namespace adf;

void leaky_relu_kernel(input_stream<float>* __restrict in,
                       output_stream<float>* __restrict out);

