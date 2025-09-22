#pragma once
#include <adf.h>
#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "packet_kernels.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;
static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER1 = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER2 = 2;
using dense8x128 = matrix_vector_mul_graph<
    float, float,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;
using dense128x128 = matrix_vector_mul_graph<
    float, float,
    OUTPUT_SIZE,
    HIDDEN_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER2,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;
// Packet-routed neural network graph with 2 PLIOs
// Uses pktsplit/pktmerge with packet-to-stream conversion kernels
// Packet routing IDs:
//   0 -> dense1.inA[0]   (layer-1 weights)
//   1 -> dense1.inB[0]   (layer-1 activations)
//   2 -> dense2.inA[0]   (layer-2 weights, lane0)
//   3 -> dense2.inA[1]   (layer-2 weights, lane1)
//   4 -> dense2.inB[0]   (layer-2 activations, lane0)
//   5 -> dense2.inB[1]   (layer-2 activations, lane1)
class NeuralNetworkGraph : public graph {
public:
    // Only 2 PLIOs: input packets and output packets
    input_plio  all_in_pkts;
    output_plio all_out_pkts;

    // Packet routing fabric
    adf::pktsplit<6> sp;                                  // 6-way packet splitter
    adf::pktmerge<1 + TP_CASC_LEN_LAYER2> mg_all;         // merge outputs

    // Packet-to-stream conversion kernels (6 converters for 6 packet types)
    kernel pkt2stream[6];

    // Stream-to-packet conversion kernels
    kernel stream2pkt[1 + TP_CASC_LEN_LAYER2];

    // Neural network computation
    dense8x128   dense1;
    dense128x128 dense2;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;

        // Create packet routing components
        sp = adf::pktsplit<6>::create();
        mg_all = adf::pktmerge<1 + TP_CASC_LEN_LAYER2>::create();

        // Create PLIOs
        all_in_pkts  = input_plio ::create("all_in_pkts",  plio_32_bits, (base_path + "/" + ALL_INPUT_PKTS ).c_str());
        all_out_pkts = output_plio::create("all_out_pkts", plio_32_bits, (base_path + "/" + ALL_OUTPUT_PKTS).c_str());

        // Create packet-to-stream conversion kernels
        for (int i = 0; i < 6; i++) {
            pkt2stream[i] = kernel::create(packet_to_stream);
            source(pkt2stream[i]) = "packet_kernels.cpp";
        }

        // Create stream-to-packet conversion kernels
        for (int i = 0; i < 1 + TP_CASC_LEN_LAYER2; i++) {
            stream2pkt[i] = kernel::create(stream_to_packet);
            source(stream2pkt[i]) = "packet_kernels.cpp";
        }

        // Connect input: PLIO -> pktsplit
        adf::connect<adf::pktstream>(all_in_pkts.out[0], sp.in[0]);

        // Connect pktsplit outputs to packet-to-stream converters
        for (int i = 0; i < 6; i++) {
            adf::connect<adf::pktstream>(sp.out[i], pkt2stream[i].in[0]);
        }

        // Connect packet-to-stream converters to neural network inputs
        // dense1 connections
        adf::connect<adf::stream>(pkt2stream[0].out[0], dense1.inA[0]);  // weights
        adf::connect<adf::stream>(pkt2stream[1].out[0], dense1.inB[0]);  // activations

        // dense2 connections (cascaded)
        adf::connect<adf::stream>(pkt2stream[2].out[0], dense2.inA[0]);  // weights lane 0
        adf::connect<adf::stream>(pkt2stream[3].out[0], dense2.inA[1]);  // weights lane 1
        adf::connect<adf::stream>(pkt2stream[4].out[0], dense2.inB[0]);  // activations lane 0
        adf::connect<adf::stream>(pkt2stream[5].out[0], dense2.inB[1]);  // activations lane 1

        // Connect neural network outputs to stream-to-packet converters
        adf::connect<adf::stream>(dense1.out[0], stream2pkt[0].in[0]);
        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            adf::connect<adf::stream>(dense2.out[i], stream2pkt[1 + i].in[0]);
        }

        // Connect stream-to-packet converters to pktmerge
        for (int i = 0; i < 1 + TP_CASC_LEN_LAYER2; i++) {
            adf::connect<adf::pktstream>(stream2pkt[i].out[0], mg_all.in[i]);
        }

        // Connect pktmerge output to PLIO
        adf::connect<adf::pktstream>(mg_all.out[0], all_out_pkts.in[0]);

        // Optional placement constraints
        // constexpr unsigned dense1_base_col = 0;
        // constexpr unsigned dense1_row = 0;
        // auto d1k = dense1.getKernels();
        // for (unsigned i = 0; i < TP_CASC_LEN_LAYER1; ++i) {
        //   location<kernel>(d1k[i]) = tile(dense1_base_col + i, dense1_row);
        // }
        // constexpr unsigned dense2_base_col = 2;
        // constexpr unsigned dense2_row = 0;
        // auto d2k = dense2.getKernels();
        // for (unsigned i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        //   location<kernel>(d2k[i]) = tile(dense2_base_col + i, dense2_row);
        // }
    }
};