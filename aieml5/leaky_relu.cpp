#include "leaky_relu.h"
#include <aie_api/aie.hpp>

// leaky_relu.h
#pragma once
#include <adf.h>
#include <aie_api/aie.hpp>

void leaky_relu_kernel(adf::input_buffer<float>& __restrict in,
                              adf::output_buffer<float>& __restrict out) {
  constexpr float alpha = 0.1f;

  auto inIt  = aie::begin(in);
  auto outIt = aie::begin(out);
  const int N = in.size();   // number of float elements in this window

  for (int i = 0; i < N; ++i) {
    float x = *inIt++;
    *outIt++ = (x >= 0.0f) ? x : (alpha * x);
  }
}
