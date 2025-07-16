#pragma once
#include <adf.h>
#include "include.h"   // defines INPUT_SIZE, HIDDEN_SIZE, VEC_WIDTH, VEC_WIDTH, OUTPUT_SIZE, FUSE_WIDTH
// #include "kernels.h"  // forward declarations of dense1, leaky_relu, dense2
#include "matrix_vector_mul_graph.hpp"   // from Vitis_Libraries/dsp/L2/include/aie

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

/*
 *  Neural-network pipeline:  Dense1 → LeakyReLU → Dense2
 *  ──────────────────────────────────────────────────────
 *  Layer sizes assumed (edit include.h to change):
 *      INPUT_SIZE      = 6   floats   (vector from previous stage)
 *      HIDDEN_SIZE     = 128 neurons  (output of dense1 / input of dense2)
 *      OUTPUT_SIZE     = 128 neurons  (final output)
 *      VEC_WIDTH    = 4   lanes    (SIMD width of dense1)
 *      VEC_WIDTH    = 4   lanes    (SIMD width of dense2)
 *      FUSE_WIDTH   = 4   blocks   (blocks fused inside dense2)
 */

static constexpr unsigned int TP_SHIFT         = 0;          // no post-MAC shift
static constexpr unsigned int TP_RND           = rnd_floor;  // any valid rnd_… macro
static constexpr unsigned int TP_NUM_FRAMES    = 1;          // no batching
static constexpr unsigned int TP_CASC_LEN      = 2;          // no cascade of kernels
static constexpr unsigned int TP_SAT           = 0;          // no saturation
static constexpr unsigned int TP_SSR           = 1;          // single-chain
static constexpr unsigned int TP_DIM_A_LEADING = 1;          // weights in column-major


 using dense128x128 = matrix_vector_mul_graph<
    float, float,    // TT_DATA_A, TT_DATA_B
    HIDDEN_SIZE,    OUTPUT_SIZE,       // TP_DIM_A (rows), TP_DIM_B (cols)
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING
>;

using dense8x128 = matrix_vector_mul_graph<
    float, float,    // TT_DATA_A, TT_DATA_B
    HIDDEN_SIZE,   INPUT_SIZE,       // TP_DIM_A (rows), TP_DIM_B (cols)
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING
>;

class NeuralNetworkGraph : public graph {
public:
  /* PLIOs */
  input_plio  pl_inputd, pl_w1;
  output_plio pl_outputd;

  input_plio  pl_in[TP_CASC_LEN];
  input_plio  pl_weights[TP_CASC_LEN];
  output_plio pl_out;
  
  dense8x128 gemv1;
  dense128x128 gemv2;

  NeuralNetworkGraph() {

    /* ─────────────── Create PLIOs ─────────────── */
    pl_inputd   = input_plio ::create("plio_inputd",      plio_32_bits, "data/input_data2.txt");
    pl_w1  = input_plio ::create("plio_weights1",  plio_32_bits, "data/weights_dense1.txt");
    pl_outputd  = output_plio::create("plio_outputd",     plio_32_bits, "data/output_data2.txt");


    /* ─────────────── Window-size constants ─────────────── */

    connect<>(pl_w1.out[0], gemv1.inA[0]);
    connect<>(pl_inputd.out[0], gemv1.inB[0]);
    connect<>(gemv1.out[0],    pl_outputd.in[0]);

    for (int i = 0; i < TP_CASC_LEN; ++i) {
      std::string in_file = "data/leakyrelu_output" + std::to_string(i) + ".txt";
      std::string w_file = "data/weights_dense2_part" + std::to_string(i) + ".txt";
      std::string in_name = "plio_input_" + std::to_string(i);
      std::string w_name = "plio_weights_" + std::to_string(i);

      pl_in[i] = input_plio::create(in_name.c_str(), plio_32_bits, in_file.c_str());
      pl_weights[i] = input_plio::create(w_name.c_str(), plio_32_bits, w_file.c_str());

      connect<>(pl_in[i].out[0], gemv2.inB[i]);
      connect<>(pl_weights[i].out[0], gemv2.inA[i]);
    }

    pl_out = output_plio::create("plio_output", plio_32_bits, "data/output_data.txt");
    connect<>(gemv2.out[0], pl_out.in[0]);

    // Optional: Single buffering to reduce memory usage
    // for (auto k : gemv.getKernels()) {
    //     single_buffer(k.in[0]);
    //     single_buffer(k.in[1]);
    //     single_buffer(k.out[0]);
    // }

  }
};