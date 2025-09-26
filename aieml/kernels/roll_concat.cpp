#include "roll_concat.h"
#include <aie_api/aie.hpp>

void roll_concat_kernel(
    adf::input_buffer<float> &__restrict in,
    adf::output_buffer<float> &__restrict out) {
    float buffer[HIDDEN_SIZE];

    auto in_ptr = aie::begin(in);
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
        buffer[i] = *in_ptr++;
    }

    auto out_ptr = aie::begin(out);
    for (int shift = 0; shift < ROLL_CONC_SUBSET_SIZE; ++shift) {
        for (int i = 0; i < HIDDEN_SIZE; ++i) {
            int idx = i + shift;
            if (idx >= HIDDEN_SIZE) {
                idx -= HIDDEN_SIZE;
            }
            *out_ptr++ = buffer[idx];
        }
    }
}
