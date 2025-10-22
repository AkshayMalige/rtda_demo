#include "roll_concat.h"
#include <aie_api/aie.hpp>

using namespace adf;

void roll_concat_kernel(adf::input_buffer<float>& __restrict in,
                        adf::output_buffer<float>& __restrict out0) {
  constexpr int N = HIDDEN_SIZE;
  constexpr int K = ROLL_CONC_SUBSET_SIZE; // 2

  float buf[N];
  auto inIt = aie::begin(in);
  for (int i = 0; i < N; ++i) {
    buf[i] = *inIt++;
  }

  auto outIt0 = aie::begin(out0);
  for (int shift = 0; shift < K; ++shift) {
    for (int i = 0; i < N; ++i) {
      const int idx = (i + shift) % N;
      const float value = buf[idx];
      *outIt0++ = value;
    }
  }
}

