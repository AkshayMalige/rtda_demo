#pragma once
#include <adf.h>
#include <array>

#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "kernels/stream_to_packet.h"
#include "kernels/packet_to_stream.h"
#include "kernels/leaky_relu.h"
#include "kernels/bias_add.h"
#include "kernels/hidden_stream_to_packet.h"
#include "kernels/roll_concat.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

static constexpr unsigned int TP_RND = rnd_floor;

static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;
static constexpr unsigned int TP_USE_MATRIX_RELOAD = 1;
static constexpr unsigned int TP_API = 1;
static constexpr unsigned int TP_DUAL_IP = 0;
static constexpr unsigned int TP_NUM_OUTPUTS = 1;

using dense8x128 = matrix_vector_mul_graph<
    float,
    float,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_USE_MATRIX_RELOAD,
    TP_API,
    TP_DUAL_IP,
    TP_NUM_OUTPUTS>;

using dense128x128 = matrix_vector_mul_graph<
    float,
    float,
    OUTPUT_SIZE,
    HIDDEN_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    CASCADE_LENGTH,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_USE_MATRIX_RELOAD,
    TP_API,
    TP_DUAL_IP,
    TP_NUM_OUTPUTS>;


class NeuralNetworkGraph : public graph {
public:
    input_plio  input_data;
    output_plio output_data;
    dense8x128   dense1;
    dense128x128 dense2;
    input_port matrixA_dense0_rtp;
    input_port bias_dense0_rtp;
    input_port matrixA_dense1_rtp[CASCADE_LENGTH];

    kernel      k_stream_to_packet;
    kernel      k_packet_to_stream;
    kernel      k_bias_add;
    kernel      k_lrelu0;
    kernel      k_hidden_stream_to_packet;
    kernel      k_roll_concat;
    std::array<kernel, CASCADE_LENGTH> k_packet_to_stream_hidden;

    // ADF packet switching components
    pktsplit<1>                 splitter;
    pktsplit<CASCADE_LENGTH>    layer_splitter;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        input_data     = input_plio::create("input_data", plio_32_bits, (base_path + "/" + EMBED_INPUT_DATA).c_str());
        output_data    = output_plio::create("output_data", plio_32_bits, (base_path + "/" + EMBED_DENSE1_OUTPUT).c_str());

        k_stream_to_packet = kernel::create(stream_to_packet_kernel);
        source(k_stream_to_packet) = "kernels/stream_to_packet.cpp";
        headers(k_stream_to_packet) = {"kernels/stream_to_packet.h"};
        runtime<ratio>(k_stream_to_packet) = 1.0;

        k_packet_to_stream = kernel::create(packet_to_stream_kernel);
        source(k_packet_to_stream) = "kernels/packet_to_stream.cpp";
        headers(k_packet_to_stream) = {"kernels/packet_to_stream.h"};
        runtime<ratio>(k_packet_to_stream) = 1.0;

        k_bias_add = kernel::create(bias_add_kernel);
        source(k_bias_add) = "kernels/bias_add.cpp";
        headers(k_bias_add) = {"kernels/bias_add.h"};
        runtime<ratio>(k_bias_add) = 1.0;

        k_lrelu0 = kernel::create(leaky_relu_kernel);
        source(k_lrelu0) = "kernels/leaky_relu.cpp";
        headers(k_lrelu0) = {"kernels/leaky_relu.h"};
        runtime<ratio>(k_lrelu0) = 1.0;

        k_hidden_stream_to_packet = kernel::create(hidden_stream_to_packet_kernel);
        source(k_hidden_stream_to_packet) = "kernels/hidden_stream_to_packet.cpp";
        headers(k_hidden_stream_to_packet) = {"kernels/hidden_stream_to_packet.h"};
        runtime<ratio>(k_hidden_stream_to_packet) = 1.0;

        k_roll_concat = kernel::create(roll_concat_kernel);
        source(k_roll_concat) = "kernels/roll_concat.cpp";
        headers(k_roll_concat) = {"kernels/roll_concat.h"};
        runtime<ratio>(k_roll_concat) = 1.0;

        for (int i = 0; i < CASCADE_LENGTH; ++i) {
            k_packet_to_stream_hidden[i] = kernel::create(packet_to_stream_hidden_kernel);
            source(k_packet_to_stream_hidden[i]) = "kernels/packet_to_stream.cpp";
            headers(k_packet_to_stream_hidden[i]) = {"kernels/packet_to_stream.h"};
            runtime<ratio>(k_packet_to_stream_hidden[i]) = 1.0;
        }

        // Create ADF packet switching infrastructure
        splitter = pktsplit<1>::create();
        layer_splitter = pktsplit<CASCADE_LENGTH>::create();

        // Matrix A is provided via RTP (runtime parameter) - no PLIO connection needed
        // Vector B uses stream interface with TP_API=1
        adf::connect<adf::parameter>(matrixA_dense0_rtp, dense1.matrixA[0]);
        adf::connect<adf::parameter>(bias_dense0_rtp, k_bias_add.param[0]);
        for (int i = 0; i < CASCADE_LENGTH; ++i) {
            adf::connect<adf::parameter>(matrixA_dense1_rtp[i], dense2.matrixA[i]);
        }

        // ADF packet switching data flow:
        // input_data -> k_stream_to_packet -> splitter -> k_packet_to_stream -> dense1 -> output_data
        connect<stream>(input_data.out[0], k_stream_to_packet.in[0]);           // float stream → packet kernel
        connect<pktstream>(k_stream_to_packet.out[0], splitter.in[0]);          // packet stream → splitter
        connect<pktstream>(splitter.out[0], k_packet_to_stream.in[0]);          // splitter → packet_to_stream
        connect<stream>(k_packet_to_stream.out[0], dense1.inB[0]);              // float stream → dense

        connect<stream>(dense1.out[0], k_bias_add.in[0]);
        connect<stream>(k_bias_add.out[0], k_lrelu0.in[0]);
        connect<stream>(k_lrelu0.out[0], k_hidden_stream_to_packet.in[0]);
        connect<pktstream>(k_hidden_stream_to_packet.out[0], layer_splitter.in[0]);

        for (int i = 0; i < CASCADE_LENGTH; ++i) {
            connect<pktstream>(layer_splitter.out[i], k_packet_to_stream_hidden[i].in[0]);
            connect<stream>(k_packet_to_stream_hidden[i].out[0], dense2.inB[i]);
        }

        connect<stream>(dense2.out[0], k_roll_concat.in[0]);
        connect<stream>(k_roll_concat.out[0], output_data.in[0]);
    }
};
