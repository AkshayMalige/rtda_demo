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
static constexpr unsigned int TP_CASC_LEN      = 1;          // no cascade of kernels
static constexpr unsigned int TP_SAT           = 0;          // no saturation
static constexpr unsigned int TP_SSR           = 1;          // single-chain
static constexpr unsigned int TP_DIM_A_LEADING = 1;          // weights in column-major

 using gemv_graph_t = matrix_vector_mul_graph<
    float, float,    // TT_DATA_A, TT_DATA_B
    HIDDEN_SIZE,    INPUT_SIZE,       // TP_DIM_A (rows), TP_DIM_B (cols)
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING
>;

class NeuralNetworkGraph : public gemv_graph_t {
public:
  /* PLIOs */
  input_plio  pl_in, pl_w1;
  output_plio pl_out;

  /* Kernels */
  // kernel k_dense1;
  // kernel k_act;
  // kernel k_dense2;

  NeuralNetworkGraph() {
    /* ─────────────── Create kernels ─────────────── */
    // k_dense1 = kernel::create(dense1);
    // k_act    = kernel::create(leaky_relu);
    // k_dense2 = kernel::create(dense2);

    /* ─────────────── Create PLIOs ─────────────── */
    pl_in   = input_plio ::create("plio_input",      plio_32_bits, "data/input_data.txt");
    pl_w1  = input_plio ::create("plio_weights1",  plio_32_bits, "data/weights_dense1.txt");
    // pl_w2a  = input_plio ::create("plio_weights2a",  plio_32_bits, "data/weights_dense2a.txt");
    // pl_w2b  = input_plio ::create("plio_weights2b",  plio_32_bits, "data/weights_dense2b.txt");
    pl_out  = output_plio::create("plio_output",     plio_32_bits, "data/output_data.txt");

    /* ─────────────── Window-size constants ─────────────── */
    constexpr int D1_W_WINDOW   = (INPUT_SIZE) * HIDDEN_SIZE;                   // 1024  floats



    /*  Dense-2 consumes each activation vector  (HIDDEN_SIZE)  FUSE_WIDTH*VEC_WIDTH times */
    // constexpr int D2_IN_REPS    = HIDDEN_SIZE / (FUSE_WIDTH * VEC_WIDTH);      // 8    repetitions
    // constexpr int D2_IN_WINDOW  = HIDDEN_SIZE * D2_IN_REPS;                          // 1024 floats

    // constexpr int D2_W_WINDOW   = (HIDDEN_SIZE * OUTPUT_SIZE) / 2;                   // 8192 floats / window

    /* ─────────────── Connect dataflow ─────────────── */

    // Input vector for dense1
    // connect< window<INPUT_SIZE> >(pl_in.out[0],      k_dense1.in[0]);

    // Weight matrix for dense1 (even/odd split)
    // connect< window<D1_W_WINDOW> >(pl_w1a.out[0],      k_dense1.in[1]);
    // connect< window<D1_W_WINDOW> >(pl_w1b.out[0],      k_dense1.in[2]);

    // Dense1 → Leaky ReLU
    // connect< window<HIDDEN_SIZE> >(k_dense1.out[0],    k_act.in[0]);

    // // Leaky ReLU → Dense2 (activation vector replicated 8× in input file),     // Weight matrix for dense2 (even/odd split)
    // connect< window<HIDDEN_SIZE> >(k_act.out[0],      k_dense2.in[0]);
    // connect< window<D2_W_WINDOW> >(pl_w2a.out[0],      k_dense2.in[1]);
    // connect< window<D2_W_WINDOW> >(pl_w2b.out[0],      k_dense2.in[2]);
    // connect< window<OUTPUT_SIZE> >(k_dense2.out[0],    pl_out.in[0]);

    // connect< window<OUTPUT_SIZE> >(k_dense1.out[0],    pl_out.in[0]);

    /* ─────────────── Kernel sources & run-time hints ─────────────── */
    // source(k_dense1) = "kernels/dense1.cpp";
    // source(k_act)    = "kernels/leaky_relu.cpp";
    // source(k_dense2) = "kernels/dense2.cpp";

    connect<>(pl_w1.out[0], this->inA[0]);
    connect<>(pl_in.out[0], this->inB[0]);
    connect<>(this->out[0],    pl_out.in[0]);


    // runtime<ratio>(k_dense1) = 0.8;
    // runtime<ratio>(k_act)    = 0.8;
    // runtime<ratio>(k_dense2) = 0.8;
  }
};



// #include <adf.h>
// #include "matrix_vector_mul_graph.hpp"   // from Vitis_Libraries/dsp/L2/include/aie

// using namespace adf;
// // pull in the nested namespace where the graph actually lives:
// using namespace xf::dsp::aie::blas::matrix_vector_mul;

// //-----------------------------------------------------------------------------
// // parameters for a 6×128 float GEMV
// //-----------------------------------------------------------------------------
// static constexpr unsigned int TP_SHIFT         = 0;          // no post-MAC shift
// static constexpr unsigned int TP_RND           = rnd_floor;  // any valid rnd_… macro
// static constexpr unsigned int TP_NUM_FRAMES    = 1;          // no batching
// static constexpr unsigned int TP_CASC_LEN      = 1;          // no cascade of kernels
// static constexpr unsigned int TP_SAT           = 0;          // no saturation
// static constexpr unsigned int TP_SSR           = 1;          // single-chain
// static constexpr unsigned int TP_DIM_A_LEADING = 1;          // weights in column-major

// // full 11-parameter alias for readability:
// using gemv_graph_t = matrix_vector_mul_graph<
//     float, float,    // TT_DATA_A, TT_DATA_B
//     128,    8,       // TP_DIM_A (rows), TP_DIM_B (cols)
//     TP_SHIFT,
//     TP_RND,
//     TP_NUM_FRAMES,
//     TP_CASC_LEN,
//     TP_SAT,
//     TP_SSR,
//     TP_DIM_A_LEADING
// >;

// class MyGemvGraph : public gemv_graph_t {
// public:
//   // give these different names so they don't hide the base-class ports:
//   input_plio  plio_weights = input_plio::create(
//                             "PLIO_weights",   // logical name
//                             plio_32_bits,     // must specify width
//                             "data/weights_dense1.txt");   // file to stream in

//   input_plio  plio_input   = input_plio::create(
//                             "PLIO_input",
//                             plio_32_bits,
//                             "data/input_data.txt");

//   output_plio plio_output  = output_plio::create(
//                             "PLIO_output",
//                             plio_32_bits,
//                             "data/output_data.txt");

//   MyGemvGraph() {
//     // hook your PLIO → the base-class ports inA[], inB[], out[]
//     connect<>(plio_weights.out[0], this->inA[0]);
//     connect<>(plio_input  .out[0], this->inB[0]);
//     connect<>(this->out    [0],    plio_output.in[0]);
//   }
// };