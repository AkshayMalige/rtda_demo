#pragma once

#include <adf.h>
#include "include.h"
#include "matrix_vector_mul_graph.hpp"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

static constexpr unsigned int TP_SHIFT         = 0;
static constexpr unsigned int TP_RND           = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES    = 1;
static constexpr unsigned int TP_SAT           = 0;
static constexpr unsigned int TP_SSR           = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER2 = 2;

using dense8x128 = matrix_vector_mul_graph<
    float, float,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING
>;

using dense128x128 = matrix_vector_mul_graph<
    float, float,
    OUTPUT_SIZE,
    HIDDEN_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER2,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING
>;

class NeuralNetworkGraph : public graph {
public:
    input_plio  pl_in_dense1;
    input_plio  pl_w_dense1;
    output_plio pl_out_dense1;

    input_plio  pl_in_dense2[TP_CASC_LEN_LAYER2];
    input_plio  pl_w_dense2[TP_CASC_LEN_LAYER2];
    output_plio pl_out_dense2;

    dense8x128   dense1;
    dense128x128 dense2;

    NeuralNetworkGraph() {
        pl_in_dense1  = input_plio::create("plio_input_dense1", plio_32_bits, "data/input_data.txt");
        pl_w_dense1   = input_plio::create("plio_weights_dense1", plio_32_bits, "data/weights_dense1.txt");
        pl_out_dense1 = output_plio::create("plio_output_dense1", plio_32_bits, "data/leakyrelu_output.txt");

        connect<>(pl_w_dense1.out[0], dense1.inA[0]);
        connect<>(pl_in_dense1.out[0], dense1.inB[0]);
        connect<>(dense1.out[0], pl_out_dense1.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            std::string in_file = "data/leakyrelu_output_part" + std::to_string(i) + ".txt";
            std::string w_file  = "data/weights_dense2_part" + std::to_string(i) + ".txt";

            std::string in_name = "plio_input_dense2_" + std::to_string(i);
            std::string w_name  = "plio_weights_dense2_" + std::to_string(i);

            pl_in_dense2[i] = input_plio::create(in_name.c_str(), plio_32_bits, in_file.c_str());
            pl_w_dense2[i]  = input_plio::create(w_name.c_str(), plio_32_bits, w_file.c_str());

            connect<>(pl_in_dense2[i].out[0], dense2.inB[i]);
            connect<>(pl_w_dense2[i].out[0], dense2.inA[i]);
        }

        pl_out_dense2 = output_plio::create("plio_output_dense2", plio_32_bits, "data/output_data2.txt");
        connect<>(dense2.out[0], pl_out_dense2.in[0]);

        // Example Location Constraints:

        // Dense Layer 1 placement:

        // kernel* dense1_kernels = dense1.getKernels();
        // location<kernel>(dense1_kernels[0]) = tile(20, 0);

        // Dense Layer 2 cascade placement:
        // int base_row = 25;
        // kernel* dense2_kernels = dense2.getKernels();
        // for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        //     location<kernel>(dense2_kernels[i]) = tile(base_row + i, 0);
        // }
    }
};