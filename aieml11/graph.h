#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;
// static constexpr unsigned int TP_SHIFT = 0;
// static constexpr unsigned int TP_RND = rnd_floor;
// static constexpr unsigned int TP_NUM_FRAMES = 1;
// static constexpr unsigned int TP_SAT = 0;
// static constexpr unsigned int TP_SSR = 1;
// static constexpr unsigned int TP_DIM_A_LEADING = 1;
// static constexpr unsigned int TP_CASC_LEN_LAYER1 = 1;
// static constexpr unsigned int TP_CASC_LEN_LAYER2 = 2;
// using dense8x128 = matrix_vector_mul_graph<
//     float, float,
//     HIDDEN_SIZE,
//     INPUT_SIZE,
//     TP_SHIFT,
//     TP_RND,
//     TP_NUM_FRAMES,
//     TP_CASC_LEN_LAYER1,
//     TP_SAT,
//     TP_SSR,
//     TP_DIM_A_LEADING>;


    template<
    unsigned Rows,
    unsigned Cols,
    unsigned CascLen,
    unsigned UseMatrixReload,
    unsigned DimALeading = 1,
    unsigned Shift = 0,
    unsigned Rnd = rnd_floor,
    unsigned NumFrames = 1,
    unsigned Saturation = 0,
    unsigned Ssr = 1,
    unsigned Api = 0,
    unsigned DualIp = 0,
    unsigned NumOutputs = 1>
using dense_matrix_graph = matrix_vector_mul_graph<
    float,
    float,
    Rows,
    Cols,
    Shift,
    Rnd,
    NumFrames,
    CascLen,
    Saturation,
    Ssr,
    DimALeading,
    UseMatrixReload,
    Api,
    DualIp,
    NumOutputs>;

using embed_dense0_graph = dense_matrix_graph<HIDDEN_SIZE, INPUT_SIZE, EMBED_DENSE0_CASC_LEN, 1>;


class NeuralNetworkGraph : public graph {
public:
    // input_plio  layer0_in;
    input_plio  layer0_weights;
    // Output of first dense layer exposed via PLIO for direct PL interfacing
    // output_plio layer0_out;
    embed_dense0_graph   dense1;

    adf::output_gmio gmioOut; 
	adf::input_gmio gmioIn;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        
        layer0_weights = input_plio::create("layer0_weights", plio_32_bits,
                                             (base_path + "/" + EMBED_DENSE0_WEIGHTS).c_str());

        gmioOut=adf::output_gmio::create("gmioOut",64,1000);
		gmioIn=adf::input_gmio::create("gmioIn",64,1000);

        connect<>(layer0_weights.out[0], dense1.inA[0]);
        connect<>(gmioIn.out[0], dense1.inB[0]);
        connect<>(dense1.out[0], gmioOut.in[0]);

    }
};
