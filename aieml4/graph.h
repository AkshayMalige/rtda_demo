#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "leaky_relu.h"


using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;
static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;
static constexpr unsigned int TP_KERNEL_API = 0;
static constexpr unsigned int TP_CASC_LEN_LAYER1 = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER2 = 1;
using dense8x128 = matrix_vector_mul_graph<
    float, float,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER1,
    TP_KERNEL_API,
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
    TP_KERNEL_API,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;
// Graph connects dense1 and dense2; leaky ReLU is handled in PL

class NeuralNetworkGraph : public graph {
public:
    input_plio  layer0_in;
    input_plio  layer0_weights;
    dense8x128   dense1;
    dense128x128 dense2;
    input_plio  layer1_weights;
    // Final dense layer output directly drives a PLIO
    output_plio layer1_out;
    kernel       k_lrelu0;


    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer0_in      = input_plio::create("layer0_in", plio_32_bits, (base_path + "/" + EMBED_INPUT_DATA).c_str());
        layer0_weights = input_plio::create("layer0_weights", plio_32_bits, (base_path + "/" + EMBED_DENSE0_WEIGHTS).c_str());
        connect<>(layer0_weights.out[0], dense1.inA[0]);
        connect<window<INPUT_SIZE * sizeof(float)>>(layer0_in.out[0], dense1.inB[0]);

        k_lrelu0 = kernel::create(leaky_relu_kernel);
        source(k_lrelu0) = "leaky_relu.cpp";
        headers(k_lrelu0) = {"leaky_relu.h"};

        runtime<ratio>(k_lrelu0) = 0.8;
        connect<window<HIDDEN_SIZE * sizeof(float)>>(dense1.out[0], k_lrelu0.in[0]);
        dimensions(k_lrelu0.in[0])  = { HIDDEN_SIZE };
        dimensions(k_lrelu0.out[0]) = { HIDDEN_SIZE };

        layer1_weights = input_plio::create("layer1_weights", plio_32_bits,
                                            (base_path + "/" + EMBED_DENSE1_WEIGHTS).c_str());
        connect<>(layer1_weights.out[0], dense2.inA[0]);

        connect<window<HIDDEN_SIZE>>(k_lrelu0.out[0], dense2.inB[0]);

        layer1_out = output_plio::create("layer1_out", plio_32_bits,
                                         (base_path + "/" + EMBED_MODEL_OUTPUT).c_str());
        connect<window<OUTPUT_SIZE>>(dense2.out[0], layer1_out.in[0]);

    }
};