#pragma once
#include <adf.h>
#include "nn_defs.h"

using namespace adf;

// Reads one buffer of HIDDEN_SIZE floats and emits
// ROLL_CONC_SUBSET_SIZE consecutive rolled windows (flattened as one buffer).
void roll_concat_kernel(adf::input_buffer<float>& __restrict in,
                        adf::output_buffer<float>& __restrict out);
