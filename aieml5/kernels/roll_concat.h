#pragma once

#include <adf.h>

#include "nn_defs.h"

/**
 * @brief Rolls a hidden activation vector and concatenates shifted copies.
 *
 * The kernel consumes @c HIDDEN_SIZE activations and emits
 * @c ROLL_CONC_SUBSET_SIZE cyclically shifted versions concatenated
 * sequentially (total of @c HIDDEN_SIZE * @c ROLL_CONC_SUBSET_SIZE samples).
 */
void roll_concat_kernel(input_stream<float>* in,
                        output_stream<float>* out);
