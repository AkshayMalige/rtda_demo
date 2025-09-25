#pragma once
#include <adf.h>
#include "nn_defs.h"

void split_stream_kernel(adf::input_stream<float>* __restrict in,
                         adf::output_stream<float>* __restrict out0,
                         adf::output_stream<float>* __restrict out1);
