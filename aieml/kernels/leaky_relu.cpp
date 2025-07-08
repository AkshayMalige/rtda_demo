// leaky_relu.cpp
#include <adf.h>
#include <aie_api/aie.hpp>
#include "../kernels.h"

using namespace aie;

void leaky_relu(
    input_window<float>  *in_win,
    output_window<float> *out_win
) {
  constexpr float α = LEAKY_SLOPE;
  for (int i = 0; i < HIDDEN_SIZE; i += VEC_WIDTH) {
    auto v = window_readincr_v< vector<float,VEC_WIDTH> >(in_win);
    vector<float,VEC_WIDTH> o;
    // elementwise compare + multiply
    for (int j = 0; j < VEC_WIDTH; ++j) {
      float x = v[j];
      o[j] = (x > 0.0f) ? x : α * x;
    }
    writeincr_v(out_win, o);
  }
}