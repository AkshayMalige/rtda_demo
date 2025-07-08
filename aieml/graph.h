#include <adf.h>
#include "graph.h"

using namespace adf;

dense_graph::dense_graph() {
  // --- 1) PLIO ports --------------------------------------------------
  //   input features, weights for dense1, weights for dense2, final output
  in   = input_plio::create("plio_input",    plio_32_bits, "data/input_data.h");
  w1   = input_plio::create("plio_weights1", plio_32_bits, "data/weights1.h");
  w2   = input_plio::create("plio_weights2", plio_32_bits, "data/weights2.h");
  out  = output_plio::create("plio_output",  plio_32_bits, "data/output_data.h");

  // --- 2) Windows -----------------------------------------------------
  //   window sizes in floats; must match what the kernels consume/produce
  //   e.g. INPUT_SIZE floats into dense1, HIDDEN_SIZE out of dense1/into relu,
  //        HIDDEN_SIZE floats into dense2, OUTPUT_SIZE floats out
  static window<float> w_in       (INPUT_SIZE);
  static window<float> w_w1       (INPUT_SIZE * HIDDEN_SIZE / INPUT_SIZE); // = HIDDEN_SIZE
  static window<float> w_mid      (HIDDEN_SIZE);
  static window<float> w_w2       (HIDDEN_SIZE * OUTPUT_SIZE / HIDDEN_SIZE); // = OUTPUT_SIZE
  static window<float> w_out      (OUTPUT_SIZE);

  // --- 3) Connect PLIOs → kernels → PLIOs -----------------------------
  connect(in.out[0],       w_in);
  connect(w1.out[0],       w_w1);
  connect(w_in,            k_dense1.in[0]);
  connect(w_w1,            k_dense1.in[1]);

  connect(k_dense1.out[0], w_mid);
  connect(w_mid,           k_relu.in[0]);

  connect(k_relu.out[0],   w_mid);    // reuse w_mid
  connect(w2.out[0],       w_w2);
  connect(w_mid,           k_dense2.in[0]);
  connect(w_w2,            k_dense2.in[1]);

  connect(k_dense2.out[0], w_out);
  connect(w_out,           out.in[0]);

  // --- 4) Specify sources & runtime targets --------------------------
  source(k_dense1) = "kernels/dense_1.cpp";
  source(k_relu)   = "kernels/leaky_relu.cpp";
  source(k_dense2) = "kernels/dense_2.cpp";

  // Assume each kernel uses ~80% of its cycle budget; tweak as needed:
  runtime<ratio>(k_dense1) = 0.8;
  runtime<ratio>(k_relu)   = 0.8;
  runtime<ratio>(k_dense2) = 0.8;
}