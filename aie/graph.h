#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "packet_kernels.h"
#include "aie_api/aie_adf.hpp"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

/*
 * Neural Network Graph Implementation for Packet Stream Processing
 *
 * This file implements a two-layer neural network that processes packetized data streams.
 * The design uses Xilinx DSPLib matrix-vector multiplication kernels and custom packet
 * processing to route data between AI Engine and PL domains.
 *
 * DATA FLOW OVERVIEW:
 * 1. Packetized input → Packet splitter (routes by ID: 0-3→AIE, 4-5→PL bypass)
 * 2. AIE path: Packet→Float converter → Dense layers → Float→Packet converter
 * 3. Both paths merge back into single packetized output stream
 *
 * PACKET FORMAT (as per docs/packet_contract.md):
 * - Bits [7:0]:   Packet ID (0-3 for neural network, 4-5 for bypass)
 * - Bits [11:8]:  Reserved (must be 0)
 * - Bits [14:12]: Packet Type (0 by default)
 * - Bits [27:16]: Payload length (optional, 0 if unused)
 * - Bit [31]:     Odd parity over bits [30:0]
 */
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
    TP_CASC_LEN_LAYER1,          // Single AIE tile
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;

// Layer 2: 128-hidden × 128-output dense layer (HIDDEN_SIZE=128, OUTPUT_SIZE=128)
// Matrix dimensions: A[128][128] × B[128][1] = C[128][1]
using dense128x128 = matrix_vector_mul_graph<
    float, float,                 // Input and output data types
    OUTPUT_SIZE,                  // Matrix A rows (128)
    HIDDEN_SIZE,                  // Matrix A columns / Vector B size (128)
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER2,          // 2 AIE tiles in cascade for larger computation
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;
/*
 * CoreNeuralNetworkGraph: Two-layer neural network without packet processing
 *
 * DATA ROUTING ARCHITECTURE:
 * 1. Input data comes via data_in port (from packet converter)
 * 2. Layer 0 weights loaded from PLIO file at initialization
 * 3. Layer 0 output goes to PLIO file for LeakyReLU processing in PL
 * 4. Layer 1 input comes from PLIO files (post-LeakyReLU data)
 * 5. Layer 1 weights loaded from separate PLIO files per cascade
 * 6. Final output goes via data_out port (to packet converter)
 *
 * WEIGHT AND DATA SPLIT MECHANISM:
 * - Layer 0: Single weight matrix (8x128), single input vector (8x1)
 * - Layer 1: Weight matrix split across 2 cascade tiles (128x128 total)
 * - Layer 1 input also split across 2 cascade inputs for parallel processing
 */
class CoreNeuralNetworkGraph : public graph {
public:
    // Primary data flow ports (connected to packet processing kernels)
    port<input> data_in;          // 8 floats from packet→float converter
    port<output> data_out;        // 128 floats to float→packet converter

    // PLIO interfaces for weights and intermediate data
    input_plio layer0_weights;                    // Layer 0 weight matrix [128x8]
    input_plio layer1_in[TP_CASC_LEN_LAYER2];   // Layer 1 input vectors (post-LeakyReLU)
    input_plio layer1_weights[TP_CASC_LEN_LAYER2]; // Layer 1 weight matrices (split)
    output_plio layer0_out;                      // Layer 0 output for PL processing

    // Dense layer instances using DSPLib matrix-vector multiplication
    dense8x128   dense1;          // First layer: 8→128 transformation
    dense128x128 dense2;          // Second layer: 128→128 transformation

    CoreNeuralNetworkGraph() {
        std::string base_path = DATA_DIR;

        // Initialize Layer 0 (8x128 dense layer) - Single AIE tile processing
        layer0_weights = input_plio::create("layer0_weights", plio_32_bits,
                                          (base_path + "/" + EMBED_DENSE0_WEIGHTS).c_str());
        layer0_out = output_plio::create("layer0_out", plio_32_bits,
                                       (base_path + "/" + EMBED_DENSE0_OUTPUT).c_str());

        // Layer 0 connections: weights[128x8] × input[8x1] = output[128x1]
        connect<>(layer0_weights.out[0], dense1.inA[0]);  // Weight matrix to port A
        connect<>(data_in, dense1.inB[0]);                // Input vector to port B
        connect<>(dense1.out[0], layer0_out.in[0]);       // Output to PLIO for LeakyReLU

        // Initialize Layer 1 (128x128 dense layer) - 2 AIE tiles in cascade
        // Data and weights are split across cascade tiles for parallel processing
        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            std::string in_file = base_path + "/" + EMBED_LEAKYRELU0_OUTPUT_PREFIX + std::to_string(i) + ".txt";
            std::string w_file  = base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(i) + ".txt";
            std::string in_name = "layer1_in_" + std::to_string(i);
            std::string w_name  = "layer1_weights_" + std::to_string(i);

            // Create PLIO for each cascade input (post-LeakyReLU data from PL)
            layer1_in[i] = input_plio::create(in_name.c_str(), plio_32_bits, in_file.c_str());
            // Create PLIO for each cascade weight matrix partition
            layer1_weights[i] = input_plio::create(w_name.c_str(), plio_32_bits, w_file.c_str());

            // Connect to cascade tile i: weights[partition_i] × input[partition_i]
            connect<>(layer1_in[i].out[0], dense2.inB[i]);        // Input vector partition
            connect<>(layer1_weights[i].out[0], dense2.inA[i]);   // Weight matrix partition
        }

        // Layer 1 output: Final 128-element result vector goes to packet converter
        connect<>(dense2.out[0], data_out);
    }
};

/*
 * PacketStreamNeuralNetworkGraph: Complete packet-processing neural network
 *
 * PACKET HEADER EXTRACTION AND ROUTING:
 * - Packet headers are extracted in packet_kernels.cpp:packet_splitter()
 * - Header parsing uses PacketHeader struct methods:
 *   * getPacketID(): Extracts bits [7:0] for routing decision
 *   * getPacketType(): Extracts bits [14:12] for packet classification
 *   * getOddParity(): Extracts bit [31] for error detection
 *
 * ROUTING LOGIC:
 * - Packet ID 0-3: Route to neural network processing path
 * - Packet ID 4-5: Route to bypass path (PL domain)
 * - Each packet contains 8 float payload words after header
 *
 * DATA FLOW THROUGH GRAPH:
 * Input PLIO → pktsplit → [NN path | Bypass path] → pktmerge → Output PLIO
 *              ↓                                       ↑
 *         packet→float                           float→packet
 *              ↓                                       ↑
 *         CoreNN Graph                               CoreNN
 */
class PacketStreamNeuralNetworkGraph : public graph {
public:
    // PLIO interfaces for packetized data streams
    input_plio combined_input;    // Packetized input stream (header + 8 floats)
    output_plio combined_output;  // Packetized output stream (header + 8 floats)

    // Single multi-channel packet converter (saves AIE resources)
    kernel multi_pkt_to_float;    // Handles all 6 channels: pktstream[6] → float[6]
    kernel multi_float_to_pkt;    // Handles all 6 channels: float[6] → pktstream[6]

    // Core neural network processing
    CoreNeuralNetworkGraph core_nn;

    // Packet routing infrastructure (uses packet ID for routing to 6 destinations)
    pktsplit<6> pkt_split;        // Routes packets by ID: 0=dense1_weights, 1=dense2a_weights,
                                  //                      2=dense2b_weights, 3=dense1_inputs,
                                  //                      4=dense2a_inputs, 5=dense2b_inputs
    pktmerge<6> pkt_merge;        // Merges all 6 streams back together

    PacketStreamNeuralNetworkGraph() {
        std::string base_path = DATA_DIR;

        // Initialize PLIO interfaces for packet streams
        combined_input = input_plio::create("combined_input", plio_32_bits,
                                           (base_path + "/" + "combined_input.txt").c_str());
        combined_output = output_plio::create("combined_output", plio_32_bits,
                                             (base_path + "/" + "combined_output.txt").c_str());

        // Create single multi-channel packet converters (resource efficient)
        multi_pkt_to_float = kernel::create(multi_packet_to_float_converter);
        multi_float_to_pkt = kernel::create(multi_float_to_packet_converter);

        // Link to packet_kernels.cpp
        source(multi_pkt_to_float) = "packet_kernels.cpp";
        source(multi_float_to_pkt) = "packet_kernels.cpp";

        // Create packet routing infrastructure for 6 destinations
        // pktsplit: Hardware packet router that reads packet ID from header
        // pktmerge: Hardware packet combiner that multiplexes six streams
        pkt_split = pktsplit<6>::create();
        pkt_merge = pktmerge<6>::create();

        // STEP 1: Route packets by ID automatically
        connect<pktstream>(combined_input.out[0], pkt_split.in[0]);

        // STEP 2: Connect all 6 packet streams to single multi-channel converter
        connect<pktstream>(pkt_split.out[0], multi_pkt_to_float.in[0]);  // ID 0 packets
        connect<pktstream>(pkt_split.out[1], multi_pkt_to_float.in[1]);  // ID 1 packets
        connect<pktstream>(pkt_split.out[2], multi_pkt_to_float.in[2]);  // ID 2 packets
        connect<pktstream>(pkt_split.out[3], multi_pkt_to_float.in[3]);  // ID 3 packets
        connect<pktstream>(pkt_split.out[4], multi_pkt_to_float.in[4]);  // ID 4 packets
        connect<pktstream>(pkt_split.out[5], multi_pkt_to_float.in[5]);  // ID 5 packets

        // STEP 3: Connect packet streams directly to neural network layers
        // NOTE: CoreNeuralNetworkGraph uses PLIO files, so connect directly to dense layer inputs

        // Connect to Dense1 layer inputs (8x128)
        connect<>(multi_pkt_to_float.out[0], core_nn.dense1.inA[0]);     // Channel 0 → Dense1 weights
        connect<>(multi_pkt_to_float.out[3], core_nn.dense1.inB[0]);     // Channel 3 → Dense1 inputs

        // Connect to Dense2 layer inputs (128x128 cascade)
        connect<>(multi_pkt_to_float.out[1], core_nn.dense2.inA[0]);     // Channel 1 → Dense2 weights cascade 0
        connect<>(multi_pkt_to_float.out[2], core_nn.dense2.inA[1]);     // Channel 2 → Dense2 weights cascade 1
        connect<>(multi_pkt_to_float.out[4], core_nn.dense2.inB[0]);     // Channel 4 → Dense2 inputs cascade 0
        connect<>(multi_pkt_to_float.out[5], core_nn.dense2.inB[1]);     // Channel 5 → Dense2 inputs cascade 1

        // STEP 4: Connect neural network outputs to packet converter
        connect<>(core_nn.dense1.out[0], multi_float_to_pkt.in[0]);      // Dense1 output
        connect<>(core_nn.dense2.out[0], multi_float_to_pkt.in[1]);      // Dense2 output
        // Use remaining channels for other data or leave unused

        // STEP 5: Connect all packet outputs to merge
        connect<pktstream>(multi_float_to_pkt.out[0], pkt_merge.in[0]);  // Channel 0
        connect<pktstream>(multi_float_to_pkt.out[1], pkt_merge.in[1]);  // Channel 1
        connect<pktstream>(multi_float_to_pkt.out[2], pkt_merge.in[2]);  // Channel 2
        connect<pktstream>(multi_float_to_pkt.out[3], pkt_merge.in[3]);  // NN output
        connect<pktstream>(multi_float_to_pkt.out[4], pkt_merge.in[4]);  // Channel 4
        connect<pktstream>(multi_float_to_pkt.out[5], pkt_merge.in[5]);  // Channel 5

        connect<pktstream>(pkt_merge.out[0], combined_output.in[0]);  // Final output

        // No runtime ratios needed - using pure hardware packet routing!
    }
};

// Legacy typedef for compatibility with existing code
using NeuralNetworkGraph = PacketStreamNeuralNetworkGraph;