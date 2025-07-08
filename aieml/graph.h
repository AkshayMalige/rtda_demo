#pragma once
#include <adf.h>
#include "include.h"    // contains dimension definitions like INPUT_SIZE, HIDDEN_SIZE, OUTPUT_SIZE
#include "kernels.h"    // kernel function declarations

using namespace adf;

class NeuralNetworkGraph : public graph {
public:
    // PLIO port declarations for input, weights, and output
    input_plio in;
    input_plio weights1a;   // first half of weights for dense1
    input_plio weights1b;   // second half of weights for dense1
    input_plio weights2;    // weights for dense2
    output_plio out;

    // Kernel declarations
    kernel k_dense1;
    kernel k_relu;
    kernel k_dense2;

    NeuralNetworkGraph() {
        // Instantiate kernels (binding to their functions)
        k_dense1 = kernel::create(dense1);
        k_relu   = kernel::create(leaky_relu);
        k_dense2 = kernel::create(dense2);

        // Create PLIOs, pointing to data files (for simulation or testbench feeding)
        in        = input_plio::create("plio_input",    plio_32_bits, "data/input_data.h");
        weights1a = input_plio::create("plio_weights1a", plio_32_bits, "data/weights1a.h");
        weights1b = input_plio::create("plio_weights1b", plio_32_bits, "data/weights1b.h");
        weights2  = input_plio::create("plio_weights2",  plio_32_bits, "data/weights2.h");
        out       = output_plio::create("plio_output",   plio_32_bits, "data/output_data.h");

        // Define and connect windows between PLIOs and kernels.
        // Window sizes are in number of float samples to match kernel consumption/production per graph run.
        // Dense1 expects: INPUT_SIZE floats (features) per inference, and for each of HIDDEN_SIZE outputs it reads INPUT_SIZE/2 floats from each weight stream.
        // Dense2 expects: HIDDEN_SIZE floats (activations) per output, for OUTPUT_SIZE outputs (so HIDDEN_SIZE*OUTPUT_SIZE weight floats in total).
        // LeakyReLU expects: HIDDEN_SIZE floats in, HIDDEN_SIZE out.
        //
        // Input feature stream -> Dense1 input
        connect< window<INPUT_SIZE> >   (in.out[0],        k_dense1.in[0]);
        // First half of Dense1 weights -> Dense1
        connect< window<(INPUT_SIZE/2) * HIDDEN_SIZE> >  (weights1a.out[0], k_dense1.in[1]);
        // Second half of Dense1 weights -> Dense1
        connect< window< (INPUT_SIZE - INPUT_SIZE/2) * HIDDEN_SIZE > >  (weights1b.out[0], k_dense1.in[2]);
        // Dense1 output (hidden layer pre-activation) -> LeakyReLU input
        connect< window<HIDDEN_SIZE> >  (k_dense1.out[0],  k_relu.in[0]);
        // LeakyReLU output (hidden layer post-activation) -> (reusing same window memory for in-place) -> Dense2 input
        connect< window<HIDDEN_SIZE> >  (k_relu.out[0],    k_dense2.in[0]);
        // Dense2 weight stream -> Dense2
        connect< window< HIDDEN_SIZE * OUTPUT_SIZE > >   (weights2.out[0],  k_dense2.in[1]);
        // Dense2 output -> output PLIO stream
        connect< window<OUTPUT_SIZE> > (k_dense2.out[0],  out.in[0]);

        // Associate kernel source files
        source(k_dense1) = "kernels/dense_1.cpp";
        source(k_relu)   = "kernels/leaky_relu.cpp";
        source(k_dense2) = "kernels/dense_2.cpp";

        // Set kernel run-time ratio hints for performance (assuming ~80% utilization of target II)
        runtime<ratio>(k_dense1) = 0.8;
        runtime<ratio>(k_relu)   = 0.8;
        runtime<ratio>(k_dense2) = 0.8;
    }
};