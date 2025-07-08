// leaky_relu.cpp
#include <adf.h>
#include <aie_api/aie.hpp>
#include "../include.h"               // HIDDEN_SIZE (=128), VEC_WIDTH_D1 (=4),
                                      // LEAKY_SLOPE (e.g. 0.1f)

using namespace adf;
using namespace aie;

void leaky_relu(input_window<float>*  __restrict in,
                output_window<float>* __restrict out)
{
  constexpr int VEC = VEC_WIDTH_D1;                 // 4 lanes per SIMD vector
  constexpr int NUM_VECTORS = HIDDEN_SIZE / VEC;    // 128 / 4 = 32 vectors

  const vector<float,VEC> v_zero  = broadcast<float,VEC>(0.0f);
  const vector<float,VEC> v_slope = broadcast<float,VEC>(LEAKY_SLOPE);


  for (int i = 0; i < NUM_VECTORS; ++i)
  chess_prepare_for_pipelining
  chess_loop_range(NUM_VECTORS, NUM_VECTORS)
  {
    /* 1. stream four activations from the previous layer */
    vector<float,VEC> v_in = window_readincr_v<VEC>(in);

    /* 2. split positive and negative parts in-lane            ────────────
          v_pos = max(v_in, 0)         keeps x      for x≥0, else 0
          v_neg = min(v_in, 0)         keeps x      for x≤0, else 0   */
    vector<float,VEC> v_pos = max(v_in, v_zero);
    vector<float,VEC> v_neg = min(v_in, v_zero);

    /* 3. scale the negative part by the leak factor α           */
    vector<float,VEC> v_neg_scaled = mul(v_neg, v_slope);

    /* 4. add the two halves → y = x (x≥0)  +  α·x (x<0)         */
    vector<float,VEC> v_out = add(v_pos, v_neg_scaled);

    /* 5. stream the result onwards                              */
    window_writeincr(out, v_out);
  }
}