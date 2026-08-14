#pragma once
#include <adf.h>
#include "nn_defs10.h"
#include "data_types.h"

using namespace adf;

// Reads one buffer of HIDDEN_SIZE floats and emits
// ROLL_CONC_SUBSET_SIZE consecutive rolled windows (flattened as one buffer)
// on a single output buffer. Total output = HIDDEN_SIZE * ROLL_CONC_SUBSET_SIZE (256).
//
// Each solver instance needs its own function so that the static state
// (frame history) is separate in x86sim (same address space for all kernels).
void roll_concat_kernel(input_window<DATA_TYPE>* __restrict in,
                        output_window<DATA_TYPE>* __restrict out0);
void roll_concat_kernel_1(input_window<DATA_TYPE>* __restrict in,
                          output_window<DATA_TYPE>* __restrict out0);
void roll_concat_kernel_2(input_window<DATA_TYPE>* __restrict in,
                          output_window<DATA_TYPE>* __restrict out0);
