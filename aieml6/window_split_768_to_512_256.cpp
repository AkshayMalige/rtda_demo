#include "window_split_768_to_512_256.h"

void window_split_768_to_512_256(input_window<float>* __restrict in,
                                  output_window<float>* __restrict out0,
                                  output_window<float>* __restrict out1) {
  constexpr int N0 = 512;
  constexpr int N1 = 256;

  for (int i = 0; i < N0; ++i) {
    window_writeincr(out0, window_readincr(in));
  }

  for (int i = 0; i < N1; ++i) {
    window_writeincr(out1, window_readincr(in));
  }
}
