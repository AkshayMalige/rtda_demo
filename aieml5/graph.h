#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "leaky_relu.h"
#include "packetize.h"
#include "pkt_to_stream_with_routing.h"

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
    input_plio  layer0_in;
    output_plio layer0_out;
    dense8x128   dense1;
    input_port matrixA_rtp;

    kernel            k_packet;
    kernel            k_pkt_to_stream;


    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer0_in      = input_plio::create("layer0_in", plio_32_bits, (base_path + "/" + EMBED_INPUT_DATA).c_str());
        layer0_out     = output_plio::create("layer0_out", plio_32_bits, (base_path + "/" + EMBED_DENSE0_OUTPUT).c_str());


        k_packet = kernel::create(packetize_kernel);
        source(k_packet) = "packetize.cpp";
        headers(k_packet) = {"packetize.h"};
        runtime<ratio>(k_packet) = 1.0;

        k_pkt_to_stream = kernel::create(pkt_to_stream_with_routing);
        source(k_pkt_to_stream) = "pkt_to_stream_with_routing.cpp";
        headers(k_pkt_to_stream) = {"pkt_to_stream_with_routing.h"};
        runtime<ratio>(k_pkt_to_stream) = 1.0;

        // Matrix A is provided via RTP (runtime parameter) - no PLIO connection needed
        // Vector B uses stream interface with TP_API=1
        adf::connect<adf::parameter>(matrixA_rtp, dense1.matrixA[0]);

        // New packet-based data flow:
        // layer0_in -> k_packet -> k_pkt_to_stream -> dense1
        connect<stream>(layer0_in.out[0], k_packet.in[0]);          // float stream → packet kernel
        connect<pktstream>(k_packet.out[0], k_pkt_to_stream.in[0]); // packet stream
        connect<stream>(k_pkt_to_stream.out[0], dense1.inB[0]);     // float stream → dense
        connect<stream>(dense1.out[0], layer0_out.in[0]);

    }
};