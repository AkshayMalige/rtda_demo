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
static constexpr unsigned int TP_USE_MATRIX_RELOAD = 1;
static constexpr unsigned int TP_API = 0;
static constexpr unsigned int TP_DUAL_IP = 0;
static constexpr unsigned int TP_NUM_OUTPUTS = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER1 = 1;



using dense128x32 = matrix_vector_mul_graph<
    float, float,
    32,
    HIDDEN_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_USE_MATRIX_RELOAD,
    TP_API,
    TP_DUAL_IP,
    TP_NUM_OUTPUTS>;


// Graph assembles the roll-concat output with a stack of dense, bias and
// leaky-ReLU layers executed entirely on the AIE graph
class NeuralNetworkGraph : public graph {
public:
    input_plio  layer0_in;
    dense128x32 dense1;
    input_port matrixA_dense0_rtp;
    output_plio layer_out;


    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer0_in      = input_plio::create("layer0_in", plio_32_bits, (base_path + "/" + OUTPUT_INPUT_DATA).c_str());
        layer_out = output_plio::create("layer_out", plio_32_bits, (base_path + "/" + SUBSOLVER0_DENSE3_OUTPUT).c_str());
        
        connect<window<32> >(layer0_in.out[0], dense1.inB[0]);
        connect<parameter>(matrixA_dense0_rtp, dense1.matrixA[0]);
        connect<window<128> >(dense1.out[0], layer_out.in[0]);

    }
};
