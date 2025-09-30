#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "leaky_relu.h"
#include "window_split_128_to_64x2.h"
#include "roll_concat.h"
#include "bias_add.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;
static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER1 = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER2 = 2;
using dense8x128 = matrix_vector_mul_graph<
    float, float,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;
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
    TP_DIM_A_LEADING>;
// Graph connects dense1 and dense2; leaky ReLU is handled in PL
class NeuralNetworkGraph : public graph {
public:
    input_plio  layer0_in;
    input_plio  layer0_weights;
    // Output of first dense layer exposed via PLIO for direct PL interfacing
    // output_plio layer0_out;
    dense8x128   dense1;
    dense128x128 dense2;
    input_plio  layer1_in[TP_CASC_LEN_LAYER2];
    input_plio  layer1_weights[TP_CASC_LEN_LAYER2];
    // Final dense layer output directly drives a PLIO
    output_plio layer1_out;
    kernel      k_lrelu0;
    kernel      k_lrelu1;
    kernel      k_wsplit0;
    kernel      k_rollconcat0;
    kernel      k_biasadd0;
    input_port bias_dense0_rtp;



    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer0_in      = input_plio::create("layer0_in", plio_32_bits,
                                             (base_path + "/" + EMBED_INPUT_DATA).c_str());
        layer0_weights = input_plio::create("layer0_weights", plio_32_bits,
                                             (base_path + "/" + EMBED_DENSE0_WEIGHTS).c_str());
        // layer0_out     = output_plio::create("layer0_out", plio_32_bits,
        //                                      (base_path + "/" + EMBED_DENSE0_OUTPUT).c_str());
        connect<>(layer0_weights.out[0], dense1.inA[0]);
        connect<>(layer0_in.out[0], dense1.inB[0]);
        // connect<>(dense1.out[0], layer0_out.in[0]);
        constexpr unsigned dense1_base_col = 0;
        constexpr unsigned dense1_row = 0;
        auto dense1_kernels = dense1.getKernels();
        // for (unsigned i = 0; i < TP_CASC_LEN_LAYER1; ++i) {
        //     adf::location<adf::kernel>(dense1_kernels[i]) =
        //         adf::tile(dense1_base_col + i, dense1_row);
        // }

        k_lrelu0 = kernel::create(leaky_relu_kernel);
        source(k_lrelu0) = "leaky_relu.cpp";
        headers(k_lrelu0) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu0) = 1.0;
        k_lrelu1 = kernel::create(leaky_relu_kernel);
        source(k_lrelu1) = "leaky_relu.cpp";
        headers(k_lrelu1) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu1) = 1.0;

        // connect<window<512>>(k_lrelu0.out[0], layer0_out.in[0]);


        k_wsplit0 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit0) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit0) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit0) = 1.0;

        k_rollconcat0 = kernel::create(roll_concat_kernel);
        source(k_rollconcat0) = "roll_concat.cpp";
        headers(k_rollconcat0) = {"roll_concat.h"};
        runtime<ratio>(k_rollconcat0) = 1.0;

        k_biasadd0 = kernel::create(bias_add_kernel);
        source(k_biasadd0) = "bias_add.cpp";
        headers(k_biasadd0) = {"bias_add.h"};
        runtime<ratio>(k_biasadd0) = 1.0;

        
        connect<window<512>>(dense1.out[0], k_biasadd0.in[0]);
        connect<adf::parameter>(bias_dense0_rtp, k_biasadd0.in[1]);
        connect<window<512>>(k_biasadd0.out[0], k_lrelu0.in[0]);

        connect< window<512> >(k_lrelu0.out[0], k_wsplit0.in[0]);
        connect< window<256> >(k_wsplit0.out[0], dense2.inB[0]);
        connect< window<256> >(k_wsplit0.out[1], dense2.inB[1]);
        // connect<window<512>>(k_lrelu0.out[0], layer0_out.in[0]);


        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            std::string in_file = base_path + "/" + EMBED_LEAKYRELU0_OUTPUT_PREFIX + std::to_string(i) + ".txt";
            std::string w_file  = base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(i) + ".txt";
            // std::string in_name = "layer1_in_" + std::to_string(i);
            std::string w_name  = "layer1_weights_" + std::to_string(i);
            // layer1_in[i]      = input_plio::create(in_name.c_str(), plio_32_bits, in_file.c_str());
            layer1_weights[i] = input_plio::create(w_name.c_str(), plio_32_bits, w_file.c_str());
            // connect<>(layer1_in[i].out[0], dense2.inB[i]);
            connect<>(layer1_weights[i].out[0], dense2.inA[i]);
        }
        layer1_out = output_plio::create("layer1_out", plio_32_bits,
                                         (base_path + "/" + EMBED_DENSE1_OUTPUT).c_str());

        connect< window<512> >(dense2.out[0], k_lrelu1.in[0]);

        connect< window<512> >(k_lrelu1.out[0], k_rollconcat0.in[0]);
        connect<window<3072> >(k_rollconcat0.out[0], layer1_out.in[0]);

        
        // constexpr unsigned dense2_base_col = 2;
        // constexpr unsigned dense2_row = 0;
        // auto dense2_kernels = dense2.getKernels();
        // for (unsigned i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        //     adf::location<adf::kernel>(dense2_kernels[i]) =
        //         adf::tile(dense2_base_col + i, dense2_row);
        // }
    }
};