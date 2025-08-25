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

// Number of packet-switch legs. We only have two layers in this graph,
// therefore pktsplit/pktmerge use two ways.
static constexpr unsigned int WAYS = 2;

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

    pktsplit<WAYS> pktsplit_w;
    pktsplit<WAYS> pktsplit_x;
    pktmerge<WAYS> pktmerge_y;

    dense8x128   dense1;
    dense128x128 dense2;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        in_weights = input_plio::create("in_weights", plio_64_bits, (base_path + "/in_weights.txt").c_str());
        in_data    = input_plio::create("in_data",    plio_64_bits, (base_path + "/in_data.txt").c_str());
        out_merged = output_plio::create("out_merged", plio_64_bits, (base_path + "/out_merged.txt").c_str());

        connect<>(in_weights.out[0], pktsplit_w.in[0]);
        connect<>(in_data.out[0],    pktsplit_x.in[0]);

        // Route packetized weights and activations to each layer.
        connect< fifo_depth<32> >(pktsplit_w.out[0], dense1.inA[0]);
        connect< fifo_depth<32> >(pktsplit_x.out[0], dense1.inB[0]);

        connect<>(pktsplit_w.out[1], dense2.inA[0]);
        connect<>(pktsplit_w.out[1], dense2.inA[1]);
        connect<>(pktsplit_x.out[1], dense2.inB[0]);
        connect<>(pktsplit_x.out[1], dense2.inB[1]);

        // Merge layer outputs back into a single packet stream.
        connect<>(dense1.out[0], pktmerge_y.in[0]);
        connect< fifo_depth<32> >(dense2.out[0], pktmerge_y.in[1]);
        connect<>(pktmerge_y.out[0], out_merged.in[0]);
    }
};
