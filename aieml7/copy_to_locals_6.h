#pragma once
#include <adf.h>
#include <aie_api/aie_adf.hpp>  // <-- use aie_adf for window_* intrinsics
using namespace adf;

// Copies 6 contiguous blocks of BLOCK floats from one input window
// into 6 output windows, sequentially (low port pressure).
template<int BLOCK>
void copy_to_locals_6(input_window<float>* __restrict in,
                      output_window<float>* __restrict o0,
                      output_window<float>* __restrict o1,
                      output_window<float>* __restrict o2,
                      output_window<float>* __restrict o3,
                      output_window<float>* __restrict o4,
                      output_window<float>* __restrict o5) {
  output_window<float>* outs[6] = {o0,o1,o2,o3,o4,o5};
  for (int b = 0; b < 6; ++b) {
    for (int i = 0; i < BLOCK; ++i)
      window_writeincr(outs[b], window_readincr(in));
  }
}
