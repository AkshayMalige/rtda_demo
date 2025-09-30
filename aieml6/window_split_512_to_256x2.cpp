#include "window_split_512_to_256x2.h"

void window_split_512_to_256x2(input_window<float>* __restrict in,
                               output_window<float>* __restrict out0,
                               output_window<float>* __restrict out1) {
  constexpr int HALF = 256;

  for (int i = 0; i < HALF; ++i) {
    window_writeincr(out0, window_readincr(in));
  }

  for (int i = 0; i < HALF; ++i) {
    window_writeincr(out1, window_readincr(in));
  }
}
