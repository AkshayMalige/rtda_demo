#pragma once
#include <adf.h>
#include "nn_defs10.h"
#include "data_types.h"
using namespace adf;

// Fused bias add + leaky ReLU kernel
#ifndef LEAKY_SLOPE
#define LEAKY_SLOPE 0.1f
#endif
void bias_add_leaky_relu_kernel(input_window<DATA_TYPE>* __restrict in,
                                output_window<DATA_TYPE>* __restrict out,
                                const DATA_TYPE (&bias)[HIDDEN_SIZE]);
