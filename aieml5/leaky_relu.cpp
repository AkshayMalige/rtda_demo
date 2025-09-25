#include "leaky_relu.h"
#include <aie_api/aie.hpp>

// leaky_relu.h
#pragma once
#include <adf.h>
#include <aie_api/aie.hpp>

void leaky_relu_kernel(adf::input_stream<float>* __restrict in,
                              adf::output_stream<float>* __restrict out) {
  constexpr float alpha      = 0.1f;
  constexpr int   frame_size = HIDDEN_SIZE;

  for (int i = 0; i < frame_size; ++i) {
    float x = readincr(in);
    float y = (x >= 0.0f) ? x : (alpha * x);
    writeincr(out, y);
  }
}
