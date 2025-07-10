/**********************************************************************
 * dense128.cpp  —  128 × 128 fully–connected layer for AI Engine-ML
 * -------------------------------------------------------------------
 *   - SIMD width (lanes)      : VEC_WIDTH = 8      (FP32 max)
 *   - Fused vectors per group : FUSE_WIDTH = 4     (→ 32 neurons)
 *   - 4 outer groups          : 4 × 32 = 128 outputs
 *   - Weights arrive from two input_streams<float>
 *********************************************************************/
#include <adf.h>
#include <aie_api/aie.hpp>
#include "../include.h"          /* expects
                                    INPUT_SIZE   = 128
                                    HIDDEN_SIZE  = 128
                                    OUTPUT_SIZE  = 128  */

using namespace adf;
using namespace aie;

// constexpr int VEC_WIDTH  = 4;    // 4-lane FP32 SIMD
// constexpr int FUSE_WIDTH = 4;    // 4 vectors in flight  → 16 neurons

/* Sanity checks */
static_assert(INPUT_SIZE2  == 128 && HIDDEN_SIZE == 128,
              "dense128 kernel hard-wired for 128×128");
static_assert(VEC_WIDTH == 4, "Use 4-lane vectors on AIEML FP32");
static_assert(HIDDEN_SIZE % (FUSE_WIDTH * VEC_WIDTH) == 0,
              "HIDDEN_SIZE must divide FUSE_WIDTH × VEC_WIDTH");

void dense2( /* 128 activations (read once)            */
               input_window<float>*  __restrict in_act,
               /* streamed weight matrix (even columns)  */
               input_window<float>* __restrict w_even,
               /* streamed weight matrix (odd  columns)  */
               input_window<float>* __restrict w_odd,
               /* 128 outputs                            */
               output_window<float>* __restrict out_act )
{
  /* ── 1. Cache the 128-value input vector ─────────────────────────── */
  float act[INPUT_SIZE2] __attribute__((aligned(16)));

  
  for (int i = 0; i < INPUT_SIZE2; ++i)
  chess_prepare_for_pipelining
  {
    act[i] = window_readincr(in_act);
  }

  /* ── 2. Outer loop over 32-neuron blocks (4 groups) ──────────────── */
  constexpr int OUT_GROUPS  = HIDDEN_SIZE / (FUSE_WIDTH * VEC_WIDTH); // 4
  constexpr int INPUT_PAIRS = INPUT_SIZE2 / 2;                         // 64

  for (int g = 0; g < OUT_GROUPS; ++g)
  {
    /* a. Initialise one accumulator per fused vector */
    accum<accfloat,VEC_WIDTH> acc[FUSE_WIDTH];
    for (auto& a : acc) a = zeros<accfloat,VEC_WIDTH>();

    /* b. Walk once over the 128 inputs (64 even/odd pairs) */
    for (int ip = 0; ip < INPUT_PAIRS; ++ip)
    chess_prepare_for_pipelining
    chess_loop_range(INPUT_PAIRS, INPUT_PAIRS)
    {
      float x_even = act[2*ip];
      float x_odd  = act[2*ip + 1];

      /* inner k-loop: reuse each scalar 4× */
      for (int k = 0; k < FUSE_WIDTH; ++k)
      {
        vector<float,VEC_WIDTH> wE = window_readincr_v<VEC_WIDTH>(w_even);
        vector<float,VEC_WIDTH> wO = window_readincr_v<VEC_WIDTH>(w_odd);

        acc[k] = mac(acc[k], wE, x_even);   // vector × scalar FMA
        acc[k] = mac(acc[k], wO, x_odd );
      }
    }

    /* c. Emit the 32 results for this block */
    for (int k = 0; k < FUSE_WIDTH; ++k)
      window_writeincr(out_act, acc[k].to_vector<float>());
  }
}



/*
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
/*