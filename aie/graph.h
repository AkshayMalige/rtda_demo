#pragma once

#include <adf.h>
#include <string>

#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "packet_kernels.h"
#include "aie_api/aie_adf.hpp"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

// DSPLib configuration parameters for matrix-vector multiplication
static constexpr unsigned int TP_SHIFT = 0;              // No bit shifting
static constexpr unsigned int TP_RND = rnd_floor;        // Round towards negative infinity
static constexpr unsigned int TP_NUM_FRAMES = 1;         // Process one frame at a time
static constexpr unsigned int TP_SAT = 0;                // No saturation
static constexpr unsigned int TP_SSR = 1;                // Single channel (no super sample rate)
static constexpr unsigned int TP_DIM_A_LEADING = 1;      // Matrix A is row-major
static constexpr unsigned int TP_CASC_LEN_LAYER1 = 1;    // Layer 1: Single AIE tile (8x128)
static constexpr unsigned int TP_CASC_LEN_LAYER2 = 2;    // Layer 2: 2 AIE tiles in cascade (128x128)

// Layer 1: 8-input × 128-hidden dense layer (INPUT_SIZE=8, HIDDEN_SIZE=128)
// Matrix dimensions: A[128][8] × B[8][1] = C[128][1]
using dense8x128 = matrix_vector_mul_graph<
    float, float,                 // Input and output data types
    HIDDEN_SIZE,                  // Matrix A rows (128)
    INPUT_SIZE,                   // Matrix A columns / Vector B size (8)
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_DIM_A_LEADING,             // TP_DIM_B_LEADING (row-major vectors)
    0,                            // TP_ADD_TILING (no tiling)
    0,                            // TP_INPUT_WINDOW_VSIZE (auto)
    1,                            // TP_PORT_A uses a single port
    1>;                           // TP_PORT_B uses a single port

// Layer 2: 128-hidden × 128-output dense layer (HIDDEN_SIZE=128, OUTPUT_SIZE=128)
// Matrix dimensions: A[128][128] × B[128][1] = C[128][1]
using dense128x128 = matrix_vector_mul_graph<
    float, float,                 // Input and output data types
    OUTPUT_SIZE,                  // Matrix A rows (128)
    HIDDEN_SIZE,                  // Matrix A columns / Vector B size (128)
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER2,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_DIM_A_LEADING,             // TP_DIM_B_LEADING (row-major vectors)
    0,                            // TP_ADD_TILING (no tiling)
    0,                            // TP_INPUT_WINDOW_VSIZE (auto)
    TP_CASC_LEN_LAYER2,           // TP_PORT_A drives both cascaded tiles
    TP_CASC_LEN_LAYER2>;          // TP_PORT_B drives both cascaded tiles

class CoreNeuralNetworkGraph : public graph {
public:
    dense8x128   dense1;          // First layer: 8→128 transformation
    dense128x128 dense2;          // Second layer: 128→128 transformation

    CoreNeuralNetworkGraph() = default;
};

static const std::string COMBINED_INPUT_PATH  = std::string(DATA_DIR) + "/combined_input.txt";
static const std::string COMBINED_OUTPUT_PATH = std::string(DATA_DIR) + "/combined_output.txt";

class PacketStreamNeuralNetworkGraph : public graph {
public:
    input_plio  combined_input;
    output_plio combined_output;

    kernel multi_pkt_to_float;
    kernel multi_float_to_pkt;

    CoreNeuralNetworkGraph core_nn;

    pktsplit<6> pkt_split;
    pktmerge<2> pkt_merge;

    PacketStreamNeuralNetworkGraph() {
        combined_input  = input_plio::create("combined_input", plio_32_bits, COMBINED_INPUT_PATH.c_str());
        combined_output = output_plio::create("combined_output", plio_32_bits, COMBINED_OUTPUT_PATH.c_str());
        multi_pkt_to_float = kernel::create(multi_packet_to_float_converter);
        multi_float_to_pkt = kernel::create(multi_float_to_packet_converter);

        source(multi_pkt_to_float) = "packet_kernels.cpp";
        source(multi_float_to_pkt) = "packet_kernels.cpp";

        runtime<ratio>(multi_pkt_to_float) = 1;
        runtime<ratio>(multi_float_to_pkt) = 1;

        connect<pktstream>(combined_input.out[0], pkt_split.in[0]);

        connect<pktstream>(pkt_split.out[0], multi_pkt_to_float.in[0]); // PID 0: D1 weights
        connect<pktstream>(pkt_split.out[1], multi_pkt_to_float.in[1]); // PID 1: D2 weights (casc0)
        connect<pktstream>(pkt_split.out[2], multi_pkt_to_float.in[2]); // PID 2: D2 weights (casc1)
        connect<pktstream>(pkt_split.out[3], multi_pkt_to_float.in[3]); // PID 3: D1 input vector
        connect<pktstream>(pkt_split.out[4], multi_pkt_to_float.in[4]); // PID 4: D2 input (casc0)
        connect<pktstream>(pkt_split.out[5], multi_pkt_to_float.in[5]); // PID 5: D2 input (casc1)

        connect<>(multi_pkt_to_float.out[0], core_nn.dense1.inA[0]); // 1024 floats
        connect<>(multi_pkt_to_float.out[1], core_nn.dense2.inA[0]); // 8192 floats (casc0 weights)
        connect<>(multi_pkt_to_float.out[2], core_nn.dense2.inA[1]); // 8192 floats (casc1 weights)
        connect<>(multi_pkt_to_float.out[3], core_nn.dense1.inB[0]); // 8 floats
        connect<>(multi_pkt_to_float.out[4], core_nn.dense2.inB[0]); // 64 floats (casc0 vector slice)
        connect<>(multi_pkt_to_float.out[5], core_nn.dense2.inB[1]); // 64 floats (casc1 vector slice)

        connect<>(core_nn.dense1.out[0], multi_float_to_pkt.in[0]);   // Dense1 output (128 floats)
        connect<>(core_nn.dense2.out[0], multi_float_to_pkt.in[1]);   // Dense2 output (128 floats)

        connect<pktstream>(multi_float_to_pkt.out[0], pkt_merge.in[0]); // ID 10
        connect<pktstream>(multi_float_to_pkt.out[1], pkt_merge.in[1]); // ID 11

        connect<pktstream>(pkt_merge.out[0], combined_output.in[0]);
    }
};

using NeuralNetworkGraph = PacketStreamNeuralNetworkGraph;
