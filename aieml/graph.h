#pragma once
#include <adf.h>
#include "include.h"   // defines INPUT_SIZE, HIDDEN_SIZE, VEC_WIDTH, VEC_WIDTH, OUTPUT_SIZE, FUSE_WIDTH
#include "kernels.h"  // forward declarations of dense1, leaky_relu, dense2

using namespace adf;

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

class NeuralNetworkGraph : public graph {
public:
  /* PLIOs */
  input_plio  pl_in;
  input_plio  pl_w1a, pl_w1b;
  input_plio  pl_w2a, pl_w2b;
  output_plio pl_out;

  /* Kernels */
  kernel k_dense1;
  kernel k_act;
  kernel k_dense2;

  NeuralNetworkGraph() {
    /* ─────────────── Create kernels ─────────────── */
    k_dense1 = kernel::create(dense1);
    k_act    = kernel::create(leaky_relu);
    k_dense2 = kernel::create(dense2);

    /* ─────────────── Create PLIOs ─────────────── */
    pl_in   = input_plio ::create("plio_input",      plio_32_bits, "data/input_data.txt");
    pl_w1a  = input_plio ::create("plio_weights1a",  plio_32_bits, "data/weights1a.txt");
    pl_w1b  = input_plio ::create("plio_weights1b",  plio_32_bits, "data/weights1b.txt");
    pl_w2a  = input_plio ::create("plio_weights2a",  plio_32_bits, "data/weights2a.txt");
    pl_w2b  = input_plio ::create("plio_weights2b",  plio_32_bits, "data/weights2b.txt");
    pl_out  = output_plio::create("plio_output",     plio_32_bits, "data/output_data.txt");

    /* ─────────────── Window-size constants ─────────────── */
    constexpr int D1_IN_WINDOW  = INPUT_SIZE * HIDDEN_SIZE / VEC_WIDTH;           // 192  floats
    constexpr int D1_W_WINDOW   = (INPUT_SIZE / 2) * HIDDEN_SIZE;                   // 384  floats

    // constexpr int VEC_WIDTH    = 4;       // AIEML float SIMD width (4 lanes)
    // constexpr int FUSE_WIDTH   = 4;       // four 4-lane blocks → 16 neurons



    /*  Dense-2 consumes each activation vector  (HIDDEN_SIZE)  FUSE_WIDTH*VEC_WIDTH times */
    constexpr int D2_IN_REPS    = HIDDEN_SIZE / (FUSE_WIDTH * VEC_WIDTH);      // 8    repetitions
    constexpr int D2_IN_WINDOW  = HIDDEN_SIZE * D2_IN_REPS;                          // 1024 floats

    constexpr int D2_W_WINDOW   = (HIDDEN_SIZE * OUTPUT_SIZE) / 2;                   // 8192 floats / window

    /* ─────────────── Connect dataflow ─────────────── */

    // Input vector for dense1
    connect< window<D1_IN_WINDOW> >(pl_in.out[0],      k_dense1.in[0]);

    // Weight matrix for dense1 (even/odd split)
    connect< window<D1_W_WINDOW> >(pl_w1a.out[0],      k_dense1.in[1]);
    connect< window<D1_W_WINDOW> >(pl_w1b.out[0],      k_dense1.in[2]);

    // Dense1 → Leaky ReLU
    connect< window<HIDDEN_SIZE> >(k_dense1.out[0],    k_act.in[0]);

    // Leaky ReLU → Dense2 (activation vector replicated 8× in input file),     // Weight matrix for dense2 (even/odd split)
    connect< window<D2_IN_WINDOW> >(k_act.out[0],      k_dense2.in[0]);
    connect< window<D2_W_WINDOW> >(pl_w2a.out[0],      k_dense2.in[1]);
    connect< window<D2_W_WINDOW> >(pl_w2b.out[0],      k_dense2.in[2]);

    // Dense2 → output
    connect< window<OUTPUT_SIZE> >(k_dense2.out[0],    pl_out.in[0]);

    // connect< window<OUTPUT_SIZE> >(k_act.out[0],    pl_out.in[0]);

    /* ─────────────── Kernel sources & run-time hints ─────────────── */
    source(k_dense1) = "kernels/dense1.cpp";
    source(k_act)    = "kernels/leaky_relu.cpp";
    source(k_dense2) = "kernels/dense2.cpp";

    runtime<ratio>(k_dense1) = 0.8;
    runtime<ratio>(k_act)    = 0.2;
    runtime<ratio>(k_dense2) = 0.8;
  }
};
