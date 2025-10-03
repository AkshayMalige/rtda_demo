
#include "nn_defs.h"
#include "copy_to_locals_6.h"

// Instantiate the two flavors we need:
extern "C" {

// 768x128 bank → 6 x 8192-float legs
void copy768_lo(input_window<float>*  __restrict in,
                output_window<float>* __restrict o0,
                output_window<float>* __restrict o1,
                output_window<float>* __restrict o2,
                output_window<float>* __restrict o3,
                output_window<float>* __restrict o4,
                output_window<float>* __restrict o5) {
  copy_to_locals_6<FLOATS_PER_D768_LEG>(in,o0,o1,o2,o3,o4,o5);
}

void copy768_hi(input_window<float>*  __restrict in,
                output_window<float>* __restrict o0,
                output_window<float>* __restrict o1,
                output_window<float>* __restrict o2,
                output_window<float>* __restrict o3,
                output_window<float>* __restrict o4,
                output_window<float>* __restrict o5) {
  copy_to_locals_6<FLOATS_PER_D768_LEG>(in,o0,o1,o2,o3,o4,o5);
}

// 128x128 all layers (3×2 parts) → treat as 6 blocks of 8192 floats
void copy128_all(input_window<float>*  __restrict in,
                 output_window<float>* __restrict o0,
                 output_window<float>* __restrict o1,
                 output_window<float>* __restrict o2,
                 output_window<float>* __restrict o3,
                 output_window<float>* __restrict o4,
                 output_window<float>* __restrict o5) {
  copy_to_locals_6<FLOATS_PER_D128_PART>(in,o0,o1,o2,o3,o4,o5);
}

} // extern "C"
