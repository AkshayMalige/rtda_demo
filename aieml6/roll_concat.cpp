#include "roll_concat.h"
#include <aie_api/aie.hpp>

using namespace adf;

void roll_concat_kernel(input_window<float>* __restrict in,
                        output_window<float>* __restrict out) {
  constexpr int N = HIDDEN_SIZE;
  constexpr int K = ROLL_CONC_SUBSET_SIZE;

  // Read one input window (N floats) into a local buffer
  float buf[N];
  for (int i = 0; i < N; ++i) {
    buf[i] = window_readincr(in);
  }

  // Write K rolled views back-to-back as a single output window of size N*K
  for (int shift = 0; shift < K; ++shift) {
    for (int i = 0; i < N; ++i) {
      const int idx = (i + shift) % N;
      window_writeincr(out, buf[idx]);
    }
  }
}
