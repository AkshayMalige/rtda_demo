#include <adf.h>
#include <aie_api/aie.hpp>
#include "../include.h"          // INPUT_SIZE, HIDDEN_SIZE, VEC_WIDTH

using namespace adf;
using namespace aie;

/* ────────────────────────────────────────────────────────────────────────── *\
   FUSE-WIDTH:  how many output blocks we process at the same time.
   Choose any value that satisfies
        HIDDEN_SIZE % (FUSE_WIDTH * VEC_WIDTH) == 0
   and that fits in the tile’s local memory for weight windows.
\* ────────────────────────────────────────────────────────────────────────── */
// constexpr int FUSE_WIDTH = 4;       // e.g. 4 × 4-wide vectors → 16 neurons

/* Compile-time sanity checks */
static_assert(HIDDEN_SIZE % (FUSE_WIDTH * VEC_WIDTH) == 0, "HIDDEN_SIZE must be divisible by FUSE_WIDTH*VEC_WIDTH");
static_assert((VEC_WIDTH == 4) || (VEC_WIDTH == 8) || (VEC_WIDTH == 16) || (VEC_WIDTH == 32), "VEC_WIDTH must be a legal AIEML float vector width");

void dense1( input_window<float>*  __restrict in,
             input_window<float>*  __restrict w1a,
             input_window<float>*  __restrict w1b,
             output_window<float>* __restrict out )
{
  constexpr int OUT_TILE_PAIRS = HIDDEN_SIZE / (FUSE_WIDTH * VEC_WIDTH); // outer loop trips
  constexpr int INPUT_PAIRS    = INPUT_SIZE / 2;               // 2 scalars/iter

  /* ── Loop over groups of FUSE_WIDTH output blocks ─────────────────────── */
  loopy1: for (int ob = 0; ob < OUT_TILE_PAIRS; ++ob)
  {
    /* 1.  Initialise one accumulator per fused block */
    accum<accfloat, VEC_WIDTH> acc[FUSE_WIDTH];
    for (int k = 0; k < FUSE_WIDTH; ++k)
      acc[k] = zeros<accfloat, VEC_WIDTH>();

    /* 2.  Stream INPUT_SIZE scalars once and reuse them FUSE_WIDTH times */
    loopy2: for (int i = 0; i < INPUT_PAIRS; ++i)
    // chess_prepare_for_pipelining
    // chess_loop_range(INPUT_PAIRS, INPUT_PAIRS)
    {
      float x0 = window_readincr(in);
      float x1 = window_readincr(in);

      /* 2a.  For every k-th output block read its two weight vectors */
      loopy3: for (int k = 0; k < FUSE_WIDTH; ++k)
      {
        vector<float, VEC_WIDTH> w0 = window_readincr_v<VEC_WIDTH>(w1a);   // even-column weights
        vector<float, VEC_WIDTH> w1 = window_readincr_v<VEC_WIDTH>(w1b);   // odd-column  weights

        /* 2b.  Fused multiply–accumulate (vector × scalar) */
        acc[k] = mac(acc[k], w0, x0);
        acc[k] = mac(acc[k], w1, x1);
      }
    }

    /* 3.  Write the FUSE_WIDTH output vectors */
    loopy4: for (int k = 0; k < FUSE_WIDTH; ++k)
      window_writeincr(out, acc[k].to_vector<float>());
  }
}


/*
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
*/