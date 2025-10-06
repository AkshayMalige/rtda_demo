#include <adf/window/types.h>
#include "window_split_768_to_64x12.h"

void window_split_768_to_64x12(input_window<float>* __restrict in,
                               output_window<float>* __restrict out0,
                               output_window<float>* __restrict out1,
                               output_window<float>* __restrict out2,
                               output_window<float>* __restrict out3,
                               output_window<float>* __restrict out4,
                               output_window<float>* __restrict out5,
                               output_window<float>* __restrict out6,
                               output_window<float>* __restrict out7,
                               output_window<float>* __restrict out8,
                               output_window<float>* __restrict out9,
                               output_window<float>* __restrict out10,
                               output_window<float>* __restrict out11) {
  constexpr int TOTAL = 768;
  constexpr int CHUNK = 64;
  constexpr int NOUT  = 12;

  static_assert(TOTAL == CHUNK * NOUT, "Mismatch: 768 != 12 * 64");

  output_window<float>* __restrict outs[NOUT] = {
      out0, out1, out2, out3, out4, out5,
      out6, out7, out8, out9, out10, out11};

  for (int o = 0; o < NOUT; ++o) {
    #pragma unroll
    for (int i = 0; i < CHUNK; ++i) {
      float v = window_readincr(in);
      window_writeincr(outs[o], v);
    }
  }
}
