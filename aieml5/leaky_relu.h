#pragma once
#include <adf.h>
#include "nn_defs.h"
using namespace adf;

void leaky_relu_kernel(adf::input_buffer<float>& __restrict in,
                        adf::output_buffer<float>& __restrict out) ;