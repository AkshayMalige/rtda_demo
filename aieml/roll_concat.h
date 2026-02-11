#pragma once
#include <adf.h>
#include "nn_defs10.h"
#include "data_types.h"

using namespace adf;

// Reads one buffer of HIDDEN_SIZE floats and emits
// ROLL_CONC_SUBSET_SIZE consecutive rolled windows (flattened as one buffer)
// on a single output buffer. Total output = HIDDEN_SIZE * ROLL_CONC_SUBSET_SIZE (256).
void roll_concat_kernel(input_window<DATA_TYPE>* __restrict in,
                        output_window<DATA_TYPE>* __restrict out0);
