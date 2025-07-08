#include <adf.h>
#include <aie_api/aie.hpp>
#include "../kernels.h"

using namespace aie;

void dense1(
    input_window<float>  *in_win,
    input_window<float>  *w1_win,
    input_window<float>  *w2_win,
    output_window<float> *out_win
) {
  for (int o = 0; o < HIDDEN_SIZE; ++o) {
    static float in_buf[INPUT_SIZE];
    for (int i = 0; i < INPUT_SIZE; ++i)
      in_buf[i] = window_readincr(in_win);

    vector<float, VEC_WIDTH_D1> acc_vec = aie::zeros<float, VEC_WIDTH_D1>();

    for (int i = 0; i < INPUT_SIZE/2; i += VEC_WIDTH_D1) {
      auto v = aie::load_v<VEC_WIDTH_D1>(in_buf + i);
      auto w = window_readincr_v<VEC_WIDTH_D1>(w1_win);
      acc_vec = aie::mac(acc_vec, v, w);
    }

    for (int i = INPUT_SIZE/2; i < INPUT_SIZE; i += VEC_WIDTH_D1) {
      auto v = aie::load_v<VEC_WIDTH_D1>(in_buf + i);
      auto w = window_readincr_v<VEC_WIDTH_D1>(w2_win);
      acc_vec = aie::mac(acc_vec, v, w);
    }

    float sum = aie::reduce_add(acc_vec);
    window_writeincr(out_win, sum);
  }
}