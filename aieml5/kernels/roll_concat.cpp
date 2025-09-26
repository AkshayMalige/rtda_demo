#include "roll_concat.h"

#include <aie_api/aie.hpp>

namespace {
constexpr int kFrameSize = HIDDEN_SIZE;
constexpr int kNumShifts = ROLL_CONC_SUBSET_SIZE;
}  // namespace

using namespace adf;

void roll_concat_kernel(input_stream<float>* __restrict in,
                        output_stream<float>* __restrict out) {
  alignas(32) float buffer[kFrameSize];

  for (int i = 0; i < kFrameSize; ++i) {
    buffer[i] = readincr(in);
  }

  for (int shift = 0; shift < kNumShifts; ++shift) {
    for (int i = 0; i < kFrameSize; ++i) {
      const int idx = (i + shift) % kFrameSize;
      writeincr(out, buffer[idx]);
    }
  }
}
