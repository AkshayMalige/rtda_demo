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
void dense_1(input_window<float>* in, output_window<float>* out) {
    float data[INPUT_SIZE];
    for (int i = 0; i < INPUT_SIZE; i++) {
        data[i] = window_readincr(in);
    }
    static float weights[HIDDEN_SIZE][INPUT_SIZE];
    static float bias[HIDDEN_SIZE];

    for (int o = 0; o < HIDDEN_SIZE; o++) {
        bias[o] = 0.1f;
        for (int i = 0; i < INPUT_SIZE; i++) {
            weights[o][i] = 0.01f * (o + i);
        }
    }

    for (int o = 0; o < HIDDEN_SIZE; o++) {
        float acc = bias[o];
        for (int i = 0; i < INPUT_SIZE; i++) {
            acc += data[i] * weights[o][i];
        }
        window_writeincr(out, acc);
    }
}
*/