#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "stream_to_packet.h"
#include "packet_to_stream.h"
#include "leaky_relu.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

static constexpr unsigned int TP_RND = rnd_floor;

using dense8x128 = matrix_vector_mul_graph<
    float,      // TT_DATA_A
    float,      // TT_DATA_B
    128,        // TP_DIM_A
    8,          // TP_DIM_B
    0,          // TP_SHIFT
    TP_RND,     // TP_RND
    1,          // TP_NUM_FRAMES
    1,          // TP_CASC_LEN
    0,          // TP_SAT
    1,          // TP_SSR
    1,          // TP_DIM_A_LEADING
    1,          // TP_USE_MATRIX_RELOAD (required for TP_API=1)
    1,          // TP_API (stream interface for vector B)
    0,          // TP_DUAL_IP (default = 0)
    1>;  


class NeuralNetworkGraph : public graph {
public:
    input_plio  input_data;
    output_plio output_data;
    dense8x128   dense1;
    input_port matrixA_rtp;

    kernel      k_stream_to_packet;
    kernel      k_packet_to_stream;
    kernel      k_lrelu0;

    // ADF packet switching components
    pktsplit<1> splitter;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        input_data     = input_plio::create("input_data", plio_32_bits, (base_path + "/" + EMBED_INPUT_DATA).c_str());
        output_data    = output_plio::create("output_data", plio_32_bits, (base_path + "/" + EMBED_DENSE0_OUTPUT).c_str());

        k_stream_to_packet = kernel::create(stream_to_packet_kernel);
        source(k_stream_to_packet) = "stream_to_packet.cpp";
        headers(k_stream_to_packet) = {"stream_to_packet.h"};
        runtime<ratio>(k_stream_to_packet) = 1.0;

        k_packet_to_stream = kernel::create(packet_to_stream_kernel);
        source(k_packet_to_stream) = "packet_to_stream.cpp";
        headers(k_packet_to_stream) = {"packet_to_stream.h"};
        runtime<ratio>(k_packet_to_stream) = 1.0;

        k_lrelu0 = kernel::create(leaky_relu_kernel);
        source(k_lrelu0) = "leaky_relu.cpp";
        headers(k_lrelu0) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu0) = 1.0;


        // Create ADF packet switching infrastructure
        splitter = pktsplit<1>::create();

        // Matrix A is provided via RTP (runtime parameter) - no PLIO connection needed
        // Vector B uses stream interface with TP_API=1
        adf::connect<adf::parameter>(matrixA_rtp, dense1.matrixA[0]);

        // ADF packet switching data flow:
        // input_data -> k_stream_to_packet -> splitter -> k_packet_to_stream -> dense1 -> output_data
        connect<stream>(input_data.out[0], k_stream_to_packet.in[0]);           // float stream → packet kernel
        connect<pktstream>(k_stream_to_packet.out[0], splitter.in[0]);          // packet stream → splitter
        connect<pktstream>(splitter.out[0], k_packet_to_stream.in[0]);          // splitter → packet_to_stream
        connect<stream>(k_packet_to_stream.out[0], dense1.inB[0]);              // float stream → dense
        // connect<stream>(dense1.out[0], output_data.in[0]);                      // dense output → output



        connect<>(dense1.out[0], k_lrelu0.in[0]);
        connect<>(k_lrelu0.out[0], output_data.in[0]);
        dimensions(k_lrelu0.in[0])  = { HIDDEN_SIZE };
        dimensions(k_lrelu0.out[0]) = { HIDDEN_SIZE };
    }
};