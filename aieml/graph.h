#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER2 = 2;

static constexpr unsigned int TODO_WAYS = 4;
static constexpr unsigned int WAYS = TODO_WAYS;

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
    input_plio  in_weights;
    input_plio  in_data;
    output_plio out_merged;

    pktsplit<WAYS> weights_split;
    pktsplit<WAYS> data_split;
    pktmerge<WAYS> out_merge;


    input_plio  layer0_in;
    input_plio  layer0_weights;
    // Output of first dense layer exposed via PLIO for direct PL interfacing
    output_plio layer0_out;

    dense8x128   dense1;
    dense128x128 dense2;

    input_plio  layer1_in[TP_CASC_LEN_LAYER2];
    input_plio  layer1_weights[TP_CASC_LEN_LAYER2];
    // Final dense layer output directly drives a PLIO
    output_plio layer1_out;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        in_weights = input_plio::create("in_weights", plio_64_bits, (base_path + "/in_weights.txt").c_str());
        in_data    = input_plio::create("in_data",    plio_64_bits, (base_path + "/in_data.txt").c_str());
        out_merged = output_plio::create("out_merged", plio_64_bits, (base_path + "/out_merged.txt").c_str());

        connect<>(in_weights.out[0], weights_split.in[0]);
        connect<>(in_data.out[0],    data_split.in[0]);
        connect<>(weights_split.out[0], out_merge.in[0]);
        connect<>(data_split.out[0],   out_merge.in[1]);
        connect<>(out_merge.out[0], out_merged.in[0]);

        layer0_in      = input_plio::create("layer0_in", plio_32_bits,
                                             (base_path + "/" + EMBED_INPUT_DATA).c_str());
        layer0_weights = input_plio::create("layer0_weights", plio_32_bits,
                                             (base_path + "/" + EMBED_DENSE0_WEIGHTS).c_str());
        layer0_out     = output_plio::create("layer0_out", plio_32_bits,
                                             (base_path + "/" + EMBED_DENSE0_OUTPUT).c_str());

        connect<>(layer0_weights.out[0], dense1.inA[0]);
        connect<>(layer0_in.out[0], dense1.inB[0]);
        connect<>(dense1.out[0], layer0_out.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            std::string in_file = base_path + "/" + EMBED_LEAKYRELU0_OUTPUT_PREFIX + std::to_string(i) + ".txt";
            std::string w_file  = base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(i) + ".txt";

            std::string in_name = "layer1_in_" + std::to_string(i);
            std::string w_name  = "layer1_weights_" + std::to_string(i);

            layer1_in[i]      = input_plio::create(in_name.c_str(), plio_32_bits, in_file.c_str());
            layer1_weights[i] = input_plio::create(w_name.c_str(), plio_32_bits, w_file.c_str());

            connect<>(layer1_in[i].out[0], dense2.inB[i]);
            connect<>(layer1_weights[i].out[0], dense2.inA[i]);
        }

        layer1_out = output_plio::create("layer1_out", plio_32_bits,
                                         (base_path + "/" + EMBED_DENSE1_OUTPUT).c_str());
        connect<>(dense2.out[0], layer1_out.in[0]);
    }
};
