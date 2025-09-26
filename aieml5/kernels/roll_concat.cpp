#include "roll_concat.h"

#include <aie_api/aie.hpp>

using namespace adf;

void roll_concat_kernel(input_stream<float>* __restrict in,
                        output_stream<float>* __restrict out) {
  float buffer[HIDDEN_SIZE];

  for (int i = 0; i < HIDDEN_SIZE; ++i) {
    buffer[i] = readincr(in);
  }

  for (int shift = 0; shift < ROLL_CONC_SUBSET_SIZE; ++shift) {
    for (int i = 0; i < HIDDEN_SIZE; ++i) {
      const int idx = (i + shift) % HIDDEN_SIZE;
      writeincr(out, buffer[idx]);
    }
  }
}
