#include "roll_concat.h"
#include <aie_api/aie.hpp>

using namespace adf;

void roll_concat_kernel(adf::input_buffer<float>& __restrict in,
                        adf::output_buffer<float>& __restrict out0,
                        adf::output_buffer<float>& __restrict out1) {
  constexpr int N = HIDDEN_SIZE;
  constexpr int K = ROLL_CONC_SUBSET_SIZE;

  // Read one input window (N floats) into a local buffer
  float buf[N];
  auto inIt = aie::begin(in);
  for (int i = 0; i < N; ++i) {
    buf[i] = *inIt++;
  }

  // Write K rolled views back-to-back as a single output buffer of size N*K
  auto outIt0 = aie::begin(out0);
  auto outIt1 = aie::begin(out1);
  for (int shift = 0; shift < K; ++shift) {
    for (int i = 0; i < N; ++i) {
      const int idx = (i + shift) % N;
      const float value = buf[idx];
      *outIt0++ = value;
      *outIt1++ = value;
    }
  }
}
