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
using namespace pkt_adapters;

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

class NeuralNetworkGraph : public graph {
public:
    // Packet ingress/egress
    input_plio  all_in_pkts;
    output_plio all_out_pkts;

    // Packet routing infrastructure
    pktsplit<6> sp;   // Six downstream packet destinations
    pktmerge<2> mg;   // Two upstream packet sources

    // Packet/window adapter kernels
    kernel k_pkt2win_d1A;
    kernel k_pkt2win_d1B;
    kernel k_pkt2win_d2A0;
    kernel k_pkt2win_d2A1;
    kernel k_pkt2win_d2B0;
    kernel k_pkt2win_d2B1;

    kernel k_win2pkt_d1Y;
    kernel k_win2pkt_d2Y;

    // Dense layers
    dense8x128   dense1;
    dense128x128 dense2;

    NeuralNetworkGraph() {
        const std::string base = DATA_DIR;

        all_in_pkts  = input_plio ::create("all_in_pkts",  plio_32_bits, (base + "/" + ALL_INPUT_PKTS).c_str());
        all_out_pkts = output_plio::create("all_out_pkts", plio_32_bits, (base + "/" + ALL_OUTPUT_PKTS).c_str());

        // Instantiate packet/window adapters
        k_pkt2win_d1A = kernel::create(pkt_to_win_mat);
        k_pkt2win_d1B = kernel::create(pkt_to_win_vec);
        k_pkt2win_d2A0 = kernel::create(pkt_to_win_mat);
        k_pkt2win_d2A1 = kernel::create(pkt_to_win_mat);
        k_pkt2win_d2B0 = kernel::create(pkt_to_win_vec);
        k_pkt2win_d2B1 = kernel::create(pkt_to_win_vec);

        k_win2pkt_d1Y = kernel::create(win_to_pkt_vec_d1);
        k_win2pkt_d2Y = kernel::create(win_to_pkt_vec_d2);

        source(k_pkt2win_d1A) = "packet_kernels.cpp";
        source(k_pkt2win_d1B) = "packet_kernels.cpp";
        source(k_pkt2win_d2A0) = "packet_kernels.cpp";
        source(k_pkt2win_d2A1) = "packet_kernels.cpp";
        source(k_pkt2win_d2B0) = "packet_kernels.cpp";
        source(k_pkt2win_d2B1) = "packet_kernels.cpp";
        source(k_win2pkt_d1Y) = "packet_kernels.cpp";
        source(k_win2pkt_d2Y) = "packet_kernels.cpp";

        // Packet routing topology
        connect<pktstream>(all_in_pkts.out[0], sp.in[0]);

        connect<pktstream>(sp.out[0], k_pkt2win_d1A.in[0]);
        connect<>(k_pkt2win_d1A.out[0], dense1.inA[0]);

        connect<pktstream>(sp.out[1], k_pkt2win_d1B.in[0]);
        connect<>(k_pkt2win_d1B.out[0], dense1.inB[0]);

        connect<pktstream>(sp.out[2], k_pkt2win_d2A0.in[0]);
        connect<>(k_pkt2win_d2A0.out[0], dense2.inA[0]);

        connect<pktstream>(sp.out[3], k_pkt2win_d2A1.in[0]);
        connect<>(k_pkt2win_d2A1.out[0], dense2.inA[1]);

        connect<pktstream>(sp.out[4], k_pkt2win_d2B0.in[0]);
        connect<>(k_pkt2win_d2B0.out[0], dense2.inB[0]);

        connect<pktstream>(sp.out[5], k_pkt2win_d2B1.in[0]);
        connect<>(k_pkt2win_d2B1.out[0], dense2.inB[1]);

        connect<>(dense1.out[0], k_win2pkt_d1Y.in[0]);
        connect<pktstream>(k_win2pkt_d1Y.out[0], mg.in[0]);

        connect<>(dense2.out[0], k_win2pkt_d2Y.in[0]);
        connect<pktstream>(k_win2pkt_d2Y.out[0], mg.in[1]);

        connect<pktstream>(mg.out[0], all_out_pkts.in[0]);
    }
};

