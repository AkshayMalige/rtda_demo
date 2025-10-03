#pragma once

#include <adf.h>
#include "nn_defs.h"

void split_dense_weights(adf::input_window<float>* __restrict in,
                         adf::output_window<float>* __restrict dense0_out,
                         adf::output_window<float>* __restrict remainder_out);
