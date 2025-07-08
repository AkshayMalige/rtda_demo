#include <adf.h>
#include <aie_api/aie.hpp>
#include "../kernels.h"

using namespace aie;

void dense2(
    input_window<float>  *in_win,
    input_window<float>  *w_win,
    output_window<float> *out_win
) {
  for (int o = 0; o < OUTPUT_SIZE; ++o) {
    static float act_buf[HIDDEN_SIZE];
    for (int i = 0; i < HIDDEN_SIZE; ++i)
      act_buf[i] = window_readincr(in_win);

    vector<float, VEC_WIDTH_D2> acc_vec = aie::zeros<float, VEC_WIDTH_D2>();
    for (int i = 0; i < HIDDEN_SIZE; i += VEC_WIDTH_D2) {
      auto a = aie::load_v<VEC_WIDTH_D2>(act_buf + i);
      auto w = window_readincr_v<VEC_WIDTH_D2>(w_win);
      acc_vec = aie::mac(acc_vec, a, w);
    }

    float sum = aie::reduce_add(acc_vec);
    window_writeincr(out_win, sum);
  }
}