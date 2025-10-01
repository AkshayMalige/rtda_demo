#include "leaky_relu.h"
#include <aie_api/aie.hpp>

using namespace adf;

void leaky_relu_kernel(input_window<float>* __restrict in,
                       output_window<float>* __restrict out) {
  constexpr float alpha      = 0.1f;
  constexpr int   frame_size = 128;

  // process one window of HIDDEN_SIZE elements
  for (int i = 0; i < frame_size; ++i) {
    float x = window_readincr(in);
    float y = (x >= 0.0f) ? x : (alpha * x);
    window_writeincr(out, y);
  }
}
