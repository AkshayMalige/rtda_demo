#pragma once

#include <adf.h>

#include "nn_defs.h"

using namespace adf;

void roll_concat_kernel(input_stream<float>* __restrict in,
                        output_stream<float>* __restrict out);
