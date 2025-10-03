
#include <aie_api/aie_adf.hpp>

#include "nn_defs.h"
#include "copy_to_locals_6.h"

namespace {

template <int BLOCK>
inline void copy_to_locals_6_impl(input_window<float>* __restrict in,
                                  output_window<float>* __restrict o0,
                                  output_window<float>* __restrict o1,
                                  output_window<float>* __restrict o2,
                                  output_window<float>* __restrict o3,
                                  output_window<float>* __restrict o4,
                                  output_window<float>* __restrict o5) {
  output_window<float>* outs[6] = {o0, o1, o2, o3, o4, o5};

  for (int b = 0; b < 6; ++b) {
    for (int i = 0; i < BLOCK; ++i) {
      float v = window_readincr(in);
      window_writeincr(outs[b], v);
    }
  }
}

}  // namespace

// Instantiate the kernel variants required by graph.h.
extern "C" {

void copy768_lo(input_window<float>* __restrict in,
                output_window<float>* __restrict o0,
                output_window<float>* __restrict o1,
                output_window<float>* __restrict o2,
                output_window<float>* __restrict o3,
                output_window<float>* __restrict o4,
                output_window<float>* __restrict o5) {
  copy_to_locals_6_impl<FLOATS_PER_D768_LEG>(in, o0, o1, o2, o3, o4, o5);
}

void copy768_hi(input_window<float>* __restrict in,
                output_window<float>* __restrict o0,
                output_window<float>* __restrict o1,
                output_window<float>* __restrict o2,
                output_window<float>* __restrict o3,
                output_window<float>* __restrict o4,
                output_window<float>* __restrict o5) {
  copy_to_locals_6_impl<FLOATS_PER_D768_LEG>(in, o0, o1, o2, o3, o4, o5);
}

void copy128_all(input_window<float>* __restrict in,
                 output_window<float>* __restrict o0,
                 output_window<float>* __restrict o1,
                 output_window<float>* __restrict o2,
                 output_window<float>* __restrict o3,
                 output_window<float>* __restrict o4,
                 output_window<float>* __restrict o5) {
  copy_to_locals_6_impl<FLOATS_PER_D128_PART>(in, o0, o1, o2, o3, o4, o5);
}

}  // extern "C"
