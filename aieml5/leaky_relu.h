#pragma once
#include <adf.h>
#include "nn_defs.h"
using namespace adf;

void leaky_relu_kernel(adf::input_stream<float>* __restrict in,
                       adf::output_stream<float>* __restrict out);