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

    kernel      k_split_768_512_256;
    kernel      k_split_512_256x2;
    kernel      k_split_256_128x2[3];
    kernel      k_split_128_64x2[6];

    // RTP ports for weights
    input_port matrixA_dense0_rtp;
    input_port bias_dense0_rtp;
    input_port matrixA_dense1_rtp[TP_CASC_LEN_LAYER2];
    input_port matrixA_dense2_rtp[TP_CASC_LEN_LAYER3];



    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer0_in      = input_plio::create("layer0_in", plio_32_bits, (base_path + "/" + EMBED_INPUT_DATA).c_str());
        layer1_out = output_plio::create("layer1_out", plio_32_bits, (base_path + "/" + EMBED_DENSE1_OUTPUT).c_str());




        k_split_768_512_256 = kernel::create(window_split_768_to_512_256);
        source(k_split_768_512_256) = "window_split_768_to_512_256.cpp";
        headers(k_split_768_512_256) = {"window_split_768_to_512_256.h"};
        runtime<ratio>(k_split_768_512_256) = 0.4;

        k_split_512_256x2 = kernel::create(window_split_512_to_256x2);
        source(k_split_512_256x2) = "window_split_512_to_256x2.cpp";
        headers(k_split_512_256x2) = {"window_split_512_to_256x2.h"};
        runtime<ratio>(k_split_512_256x2) = 0.5;

        for (int i = 0; i < 3; ++i) {
            k_split_256_128x2[i] = kernel::create(window_split_256_to_128x2);
            source(k_split_256_128x2[i]) = "window_split_256_to_128x2.cpp";
            headers(k_split_256_128x2[i]) = {"window_split_256_to_128x2.h"};
            runtime<ratio>(k_split_256_128x2[i]) = 0.3;
        }

        for (int i = 0; i < 6; ++i) {
            k_split_128_64x2[i] = kernel::create(window_split_128_to_64x2);
            source(k_split_128_64x2[i]) = "window_split_128_to_64x2.cpp";
            headers(k_split_128_64x2[i]) = {"window_split_128_to_64x2.h"};
            runtime<ratio>(k_split_128_64x2[i]) = 0.3;
        }




        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            adf::connect<adf::parameter>(matrixA_dense2_rtp[i], dense3.matrixA[i]);
        }
        

        connect<window<3072> >(layer0_in.out[0], k_split_768_512_256.in[0]);
        connect<window<2048> >(k_split_768_512_256.out[0], k_split_512_256x2.in[0]);
        connect<window<1024> >(k_split_768_512_256.out[1], k_split_256_128x2[2].in[0]);

        connect<window<1024> >(k_split_512_256x2.out[0], k_split_256_128x2[0].in[0]);
        connect<window<1024> >(k_split_512_256x2.out[1], k_split_256_128x2[1].in[0]);

        // Split 256->128->64 tree for 512-float path (left branch)
        connect< window<512> >(k_split_256_128x2[0].out[0], k_split_128_64x2[0].in[0]);
        connect< window<512> >(k_split_256_128x2[0].out[1], k_split_128_64x2[1].in[0]);
        connect< window<512> >(k_split_256_128x2[1].out[0], k_split_128_64x2[2].in[0]);
        connect< window<512> >(k_split_256_128x2[1].out[1], k_split_128_64x2[3].in[0]);

        // Split 256->128->64 tree for 256-float path (right branch)
        connect< window<512> >(k_split_256_128x2[2].out[0], k_split_128_64x2[4].in[0]);
        connect< window<512> >(k_split_256_128x2[2].out[1], k_split_128_64x2[5].in[0]);

        // Connect 12 windows of 64 floats (256 bytes) to dense3 cascade inputs
        connect< window<256> >(k_split_128_64x2[0].out[0], dense3.inB[0]);
        connect< window<256> >(k_split_128_64x2[0].out[1], dense3.inB[1]);
        connect< window<256> >(k_split_128_64x2[1].out[0], dense3.inB[2]);
        connect< window<256> >(k_split_128_64x2[1].out[1], dense3.inB[3]);
        connect< window<256> >(k_split_128_64x2[2].out[0], dense3.inB[4]);
        connect< window<256> >(k_split_128_64x2[2].out[1], dense3.inB[5]);
        connect< window<256> >(k_split_128_64x2[3].out[0], dense3.inB[6]);
        connect< window<256> >(k_split_128_64x2[3].out[1], dense3.inB[7]);
        connect< window<256> >(k_split_128_64x2[4].out[0], dense3.inB[8]);
        connect< window<256> >(k_split_128_64x2[4].out[1], dense3.inB[9]);
        connect< window<256> >(k_split_128_64x2[5].out[0], dense3.inB[10]);
        connect< window<256> >(k_split_128_64x2[5].out[1], dense3.inB[11]);

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
