#include "weights_split.h"

void split_dense_weights(adf::input_window<float>* __restrict in,
                         adf::output_window<float>* __restrict dense0_out,
                         adf::output_window<float>* __restrict remainder_out) {
  constexpr int dense0Count = SUBSOLVER0_DENSE0_WEIGHTS_SIZE;
  constexpr int dense1Count = SUBSOLVER0_DENSE1_WEIGHTS_SIZE;
  constexpr int dense2Count = SUBSOLVER0_DENSE2_WEIGHTS_SIZE;
  constexpr int dense3Count = SUBSOLVER0_DENSE3_WEIGHTS_SIZE;

  for (int i = 0; i < dense0Count; ++i) {
    window_writeincr(dense0_out, window_readincr(in));
  }

  for (int i = 0; i < dense1Count + dense2Count + dense3Count; ++i) {
    window_writeincr(remainder_out, window_readincr(in));
  }
}
