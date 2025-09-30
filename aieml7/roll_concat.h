#pragma once
#include <adf.h>
#include "nn_defs.h"

using namespace adf;

// Reads one window of HIDDEN_SIZE floats and emits
// ROLL_CONC_SUBSET_SIZE consecutive rolled windows (flattened as one window).
void roll_concat_kernel(input_window<float>* __restrict in,
                        output_window<float>* __restrict out);
