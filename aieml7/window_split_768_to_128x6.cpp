#include <adf/window/types.h>   // or <adf.h> depending on your include layout
#include "window_split_768_to_128x6.h"

void window_split_768_to_128x6(input_window<float>* __restrict in,
                               output_window<float>* __restrict out0,
                               output_window<float>* __restrict out1,
                               output_window<float>* __restrict out2,
                               output_window<float>* __restrict out3,
                               output_window<float>* __restrict out4,
                               output_window<float>* __restrict out5) {
  constexpr int TOTAL  = 768;
  constexpr int CHUNK  = 128;
  constexpr int NOUT   = 6;

  // Sanity (compile-time) checks if you like
  static_assert(TOTAL == CHUNK * NOUT, "Mismatch: 768 != 6 * 128");

  // Pack the output ports so we can loop
  output_window<float>* __restrict outs[NOUT] = {out0, out1, out2, out3, out4, out5};

  // Stream the input window in CHUNK-sized groups to each output
  for (int o = 0; o < NOUT; ++o) {
    // Optional: help the compiler pipeline the inner loop
    #pragma unroll
    for (int i = 0; i < CHUNK; ++i) {
      float v = window_readincr(in);
      window_writeincr(outs[o], v);
    }
  }
}
