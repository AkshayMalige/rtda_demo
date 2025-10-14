#pragma once
#include <adf.h>
#include "nn_defs10.h"
using namespace adf;

// Fused bias add + leaky ReLU kernel
void bias_add_leaky_relu_kernel(input_window<float>* __restrict in,
                                output_window<float>* __restrict out,
                                const float (&bias)[HIDDEN_SIZE]);

