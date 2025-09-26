#pragma once

#include <adf.h>

#include "nn_defs.h"

void roll_concat_kernel(
    adf::input_buffer<float> &__restrict in,
    adf::output_buffer<float> &__restrict out);
