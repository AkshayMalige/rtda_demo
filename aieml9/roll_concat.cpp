#include "roll_concat.h"
#include <aie_api/aie.hpp>

using namespace adf;

void roll_concat_kernel(adf::input_buffer<float>& __restrict in,
                        adf::output_buffer<float>& __restrict out) {
  constexpr int N = HIDDEN_SIZE;
  constexpr int K = ROLL_CONC_SUBSET_SIZE;

  // Read one input window (N floats) into a local buffer
  float buf[N];
  auto inIt = aie::begin(in);
  for (int i = 0; i < N; ++i) {
    buf[i] = *inIt++;
  }

  // Write K rolled views back-to-back as a single output buffer of size N*K
  auto outIt = aie::begin(out);
  for (int shift = 0; shift < K; ++shift) {
    for (int i = 0; i < N; ++i) {
      const int idx = (i + shift) % N;
      *outIt++ = buf[idx];
    }
  }
}
