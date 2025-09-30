#pragma once
#include <adf.h>
#include <array>
#include <stdexcept>

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
#include "stream_to_packet.h"
#include "packet_to_window.h"

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



    input_port matrixA_dense2_rtp[TP_CASC_LEN_LAYER3];

    kernel k_stream_to_packet;
    std::array<kernel, TP_CASC_LEN_LAYER3> k_packet_to_window;
    pktsplit<TP_CASC_LEN_LAYER3> splitter;


    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer1_out = output_plio::create("layer1_out", plio_32_bits, (base_path + "/" + EMBED_DENSE1_OUTPUT).c_str());

        layer0_in = input_plio::create("layer0_in", plio_32_bits, (base_path + "/solver_0_input.txt").c_str());

        k_stream_to_packet = kernel::create(stream_to_packet_kernel);
        source(k_stream_to_packet) = "stream_to_packet.cpp";
        headers(k_stream_to_packet) = {"stream_to_packet.h"};
        runtime<ratio>(k_stream_to_packet) = 1.0;

        splitter = pktsplit<TP_CASC_LEN_LAYER3>::create();

        for (int i = 0; i < (int)TP_CASC_LEN_LAYER3; ++i) {
            auto kernel_fn = select_packet_to_window_kernel(i);
            if (kernel_fn == nullptr) {
                throw std::runtime_error("Invalid packet_to_window kernel index");
            }

            k_packet_to_window[i] = kernel::create(kernel_fn);
            source(k_packet_to_window[i]) = "packet_to_window.cpp";
            headers(k_packet_to_window[i]) = {"packet_to_window.h"};
            runtime<ratio>(k_packet_to_window[i]) = 1.0;
        }

        connect<stream>(layer0_in.out[0], k_stream_to_packet.in[0]);
        connect<pktstream>(k_stream_to_packet.out[0], splitter.in[0]);

        for (int i = 0; i < (int)TP_CASC_LEN_LAYER3; ++i) {
            connect<pktstream>(splitter.out[i], k_packet_to_window[i].in[0]);
            connect<window<4 * SUBSOLVER0_INPUT_PART_SIZE>>(k_packet_to_window[i].out[0], dense3.inB[i]);
        }



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
