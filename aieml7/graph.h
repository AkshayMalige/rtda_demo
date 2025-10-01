#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "leaky_relu.h"
#include "window_split_128_to_64x2.h"
#include "window_split_768_to_512_256.h"
#include "window_split_512_to_256x2.h"
#include "window_split_256_to_128x2.h"
#include "roll_concat.h"
#include "bias_add.h"
#include "roll_concat.h"

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
static constexpr unsigned int TP_CASC_LEN_LAYER2 = 2;
static constexpr unsigned int TP_CASC_LEN_LAYER3 = 12;


using dense768x128 = matrix_vector_mul_graph<
    float, float,
    128,
    768,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER3,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_USE_MATRIX_RELOAD,
    TP_API,
    TP_DUAL_IP,
    TP_NUM_OUTPUTS>;


// Graph connects dense1 and dense2; leaky ReLU is handled in PL
class NeuralNetworkGraph : public graph {
public:
    input_plio  layer0_in;

    dense768x128 dense3;
    // Final dense layer output directly drives a PLIO
    output_plio layer1_out;
    kernel      k_rollconcat0;



    input_port matrixA_dense2_rtp[TP_CASC_LEN_LAYER3];



    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer1_out = output_plio::create("layer1_out", plio_32_bits, (base_path + "/" + EMBED_DENSE1_OUTPUT).c_str());

        layer0_in      = input_plio::create("layer0_in", plio_32_bits,
            (base_path + "/" + TMP_INP768).c_str());



        k_rollconcat0 = kernel::create(roll_concat_kernel);
        source(k_rollconcat0) = "roll_concat.cpp";
        headers(k_rollconcat0) = {"roll_concat.h"};
        runtime<ratio>(k_rollconcat0) = 1.0;

        connect< window<512> >(layer0_in.out[0], k_rollconcat0.in[0]);



        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            adf::connect<adf::parameter>(matrixA_dense2_rtp[i], dense3.matrixA[i]);
        }
    
        connect<window<512> >(dense3.out[0], layer1_out.in[0]);


        
        // constexpr unsigned dense2_base_col = 2;
        // constexpr unsigned dense2_row = 0;
        // auto dense2_kernels = dense2.getKernels();
        // for (unsigned i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        //     adf::location<adf::kernel>(dense2_kernels[i]) =
        //         adf::tile(dense2_base_col + i, dense2_row);
        // }
    }
};
