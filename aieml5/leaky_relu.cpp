#include "leaky_relu.h"

#include <aie_api/aie.hpp>

using namespace adf;

void leaky_relu_kernel(input_stream<float>* __restrict in,
                       output_stream<float>* __restrict out) {
  constexpr float alpha      = 0.1f;
  constexpr int   frame_size = HIDDEN_SIZE;

  for (int i = 0; i < frame_size; ++i) {
    const float x = readincr(in);
    const float y = (x >= 0.0f) ? x : (alpha * x);
    writeincr(out, y);
  }
}
