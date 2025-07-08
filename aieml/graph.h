// graph.h
#pragma once
#include <adf.h>
#include "include.h"
#include "kernels.h"
#include "system_settings.h"
#include "tiling_parameters.h"

using namespace adf;

class NeuralNetworkGraph : public graph {
public:
  // PLIO ports
  input_plio in_data;      // input feature vector
  input_plio wgt1_data;    // weights for dense1, part 1
  input_plio wgt2_data;    // weights for dense1, part 2
  output_plio out_data;    // final output

  // kernels
  kernel k_dense1, k_relu, k_dense2;

  NeuralNetworkGraph() {
    // create PLIOs (names must match your platform description)
    in_data     = input_plio::create("PLIO_01_IN",   plio_32_bits, "data/input.txt");
    wgt1_data   = input_plio::create("PLIO_02_WGT1", plio_32_bits, "data/wgt1.txt");
    wgt2_data   = input_plio::create("PLIO_03_WGT2", plio_32_bits, "data/wgt2.txt");
    out_data    = output_plio::create("PLIO_04_OUT",  plio_32_bits, "data/output.txt");

    // instantiate kernels
    k_dense1 = kernel::create(dense1,      "dense1");
    k_relu   = kernel::create(leaky_relu,  "leaky_relu");
    k_dense2 = kernel::create(dense2,      "dense2");

    // connect streams
    
    connect< window< DENSE1_INPUT_SIZE > >(in_data.out[0],    k_dense1.in[0]);  // feed input vector
    
    connect< window< DENSE1_INPUT_SIZE/2 > >(wgt1_data.out[0], k_dense1.in[1]); // feed first half of weight matrix
    
    connect< window< DENSE1_INPUT_SIZE/2 > >(wgt2_data.out[0], k_dense1.in[2]); // feed second half of weight matrix
    
    connect< window< DENSE1_OUTPUT_SIZE > >(k_dense1.out[0],   k_relu.in[0]);   // output of dense1 → activation
    
    connect< window< DENSE1_OUTPUT_SIZE > >(k_relu.out[0],     k_dense2.in[0]); // activation → dense2
    
    connect< window< DENSE2_INPUT_SIZE*DENSE2_OUTPUT_SIZE > >(wgt1_data.out[0], k_dense2.in[1]);    // weights for dense2 (single PLIO) → dense2
    
    connect< window< DENSE2_OUTPUT_SIZE > >(k_dense2.out[0],    out_data.in[0]);    // final result out
  }
};