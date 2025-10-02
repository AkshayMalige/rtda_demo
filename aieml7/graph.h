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

static_assert((ROLL_CONC_SUBSET_SIZE * HIDDEN_SIZE) % TP_CASC_LEN_LAYER3 == 0,
              "ROLL_CONC_SUBSET_SIZE * HIDDEN_SIZE must be divisible by TP_CASC_LEN_LAYER3");
static constexpr unsigned int ROLL_CONCAT_TOTAL = ROLL_CONC_SUBSET_SIZE * HIDDEN_SIZE;
static constexpr unsigned int ROLL_CONCAT_TILE_SPAN = ROLL_CONCAT_TOTAL / TP_CASC_LEN_LAYER3;
static_assert(ROLL_CONCAT_TILE_SPAN * TP_CASC_LEN_LAYER3 == ROLL_CONCAT_TOTAL,
              "Shared buffer tiling must cover the entire roll-concat frame");


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
    TP_DIM_A_LEADING,
    TP_USE_MATRIX_RELOAD,
    TP_API,
    TP_DUAL_IP,
    TP_NUM_OUTPUTS>;


// Graph assembles the roll-concat output with a stack of dense, bias and
// leaky-ReLU layers executed entirely on the AIE graph
class NeuralNetworkGraph : public graph {
public:
    input_plio  layer0_in;
    dense768x128 dense0;
    dense128x128 dense1;
    dense128x128 dense2;
    dense128x128 dense3;
    output_plio layer_out;
    kernel      k_rollconcat0;
    kernel      k_biasadd0;
    kernel      k_biasadd1;
    kernel      k_biasadd2;
    kernel      k_biasadd3;
    kernel      k_lrelu0;
    kernel      k_lrelu1;
    kernel      k_lrelu2;
    kernel      k_lrelu3;
    kernel      k_wsplit0;
    kernel      k_wsplit1;
    kernel      k_wsplit2;
    adf::shared_buffer<float> roll_concat_buffer;

    input_port matrixA_dense0_rtp[TP_CASC_LEN_LAYER3];
    input_port bias_dense0_rtp;
    input_port matrixA_dense1_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_dense1_rtp;
    input_port matrixA_dense2_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_dense2_rtp;
    input_port matrixA_dense3_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_dense3_rtp;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer_out = output_plio::create("layer_out", plio_32_bits, (base_path + "/" + SUBSOLVER0_DENSE3_OUTPUT).c_str());

        layer0_in      = input_plio::create("layer0_in", plio_32_bits,
            (base_path + "/" + TMP_INP768).c_str());



        k_rollconcat0 = kernel::create(roll_concat_kernel);
        source(k_rollconcat0) = "roll_concat.cpp";
        headers(k_rollconcat0) = {"roll_concat.h"};
        runtime<ratio>(k_rollconcat0) = 0.60;
        location<kernel>(k_rollconcat0) = tile(6, 0);

        connect(layer0_in.out[0], k_rollconcat0.in[0]);
        dimensions(k_rollconcat0.in[0]) = {HIDDEN_SIZE};
        dimensions(k_rollconcat0.out[0]) = {ROLL_CONCAT_TOTAL};

        roll_concat_buffer = shared_buffer<float>::create(extents<window<ROLL_CONCAT_TOTAL>>(), 1, TP_CASC_LEN_LAYER3);
        location<buffer>(roll_concat_buffer) = tile(6, 0);

        auto rollconcat_to_buffer = connect<>(k_rollconcat0.out[0], roll_concat_buffer.in[0]);
        fifo_depth(rollconcat_to_buffer) = 384;
        location<fifo>(rollconcat_to_buffer) = dma_fifo(aie_tile, 6, 0, 0x0000, 384);

        write_access(roll_concat_buffer.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });



        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            connect<parameter>(matrixA_dense0_rtp[i], dense0.matrixA[i]);
        }

        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            connect<>(roll_concat_buffer.out[i], dense0.inB[i]);
            read_access(roll_concat_buffer.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}});
        }

        k_biasadd0 = kernel::create(bias_add_kernel);
        source(k_biasadd0) = "bias_add.cpp";
        headers(k_biasadd0) = {"bias_add.h"};
        runtime<ratio>(k_biasadd0) = 0.45;
        location<kernel>(k_biasadd0) = tile(10, 1);

        k_biasadd1 = kernel::create(bias_add_kernel);
        source(k_biasadd1) = "bias_add.cpp";
        headers(k_biasadd1) = {"bias_add.h"};
        runtime<ratio>(k_biasadd1) = 0.45;
        location<kernel>(k_biasadd1) = tile(23, 1);

        k_biasadd2 = kernel::create(bias_add_kernel);
        source(k_biasadd2) = "bias_add.cpp";
        headers(k_biasadd2) = {"bias_add.h"};
        runtime<ratio>(k_biasadd2) = 0.45;
        location<kernel>(k_biasadd2) = tile(26, 1);

        k_biasadd3 = kernel::create(bias_add_kernel);
        source(k_biasadd3) = "bias_add.cpp";
        headers(k_biasadd3) = {"bias_add.h"};
        runtime<ratio>(k_biasadd3) = 0.45;
        location<kernel>(k_biasadd3) = tile(29, 1);

        k_lrelu0 = kernel::create(leaky_relu_kernel);
        source(k_lrelu0) = "leaky_relu.cpp";
        headers(k_lrelu0) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu0) = 0.50;
        location<kernel>(k_lrelu0) = tile(10, 2);

        k_lrelu1 = kernel::create(leaky_relu_kernel);
        source(k_lrelu1) = "leaky_relu.cpp";
        headers(k_lrelu1) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu1) = 0.50;
        location<kernel>(k_lrelu1) = tile(23, 2);

        k_lrelu2 = kernel::create(leaky_relu_kernel);
        source(k_lrelu2) = "leaky_relu.cpp";
        headers(k_lrelu2) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu2) = 0.50;
        location<kernel>(k_lrelu2) = tile(26, 2);

        k_lrelu3 = kernel::create(leaky_relu_kernel);
        source(k_lrelu3) = "leaky_relu.cpp";
        headers(k_lrelu3) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu3) = 0.50;
        location<kernel>(k_lrelu3) = tile(29, 2);

        k_wsplit0 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit0) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit0) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit0) = 0.60;
        location<kernel>(k_wsplit0) = tile(7, 0);

        k_wsplit1 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit1) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit1) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit1) = 0.60;
        location<kernel>(k_wsplit1) = tile(6, 1);

        k_wsplit2 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit2) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit2) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit2) = 0.60;
        location<kernel>(k_wsplit2) = tile(7, 1);

        connect<window<512>>(dense0.out[0], k_biasadd0.in[0]);
        connect<parameter>(bias_dense0_rtp, k_biasadd0.in[1]);
        connect<window<512>>(k_biasadd0.out[0], k_lrelu0.in[0]);
        connect<window<512>>(k_lrelu0.out[0], k_wsplit0.in[0]);

        auto wsplit0_leg0 = connect<window<256>>(k_wsplit0.out[0], dense1.inB[0]);
        fifo_depth(wsplit0_leg0) = 384;
        location<fifo>(wsplit0_leg0) = dma_fifo(aie_tile, 7, 0, 0x0100, 384);

        auto wsplit0_leg1 = connect<window<256>>(k_wsplit0.out[1], dense1.inB[1]);
        fifo_depth(wsplit0_leg1) = 384;
        location<fifo>(wsplit0_leg1) = dma_fifo(aie_tile, 7, 0, 0x0700, 384);


        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_dense1_rtp[i], dense1.matrixA[i]);
        }

        connect<window<512>>(dense1.out[0], k_biasadd1.in[0]);
        connect<parameter>(bias_dense1_rtp, k_biasadd1.in[1]);
        connect<window<512>>(k_biasadd1.out[0], k_lrelu1.in[0]);
        connect<window<512>>(k_lrelu1.out[0], k_wsplit1.in[0]);

        auto wsplit1_leg0 = connect<window<256>>(k_wsplit1.out[0], dense2.inB[0]);
        fifo_depth(wsplit1_leg0) = 384;
        location<fifo>(wsplit1_leg0) = dma_fifo(aie_tile, 6, 1, 0x0100, 384);

        auto wsplit1_leg1 = connect<window<256>>(k_wsplit1.out[1], dense2.inB[1]);
        fifo_depth(wsplit1_leg1) = 384;
        location<fifo>(wsplit1_leg1) = dma_fifo(aie_tile, 6, 1, 0x0700, 384);


        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_dense2_rtp[i], dense2.matrixA[i]);
        }

        connect<window<512>>(dense2.out[0], k_biasadd2.in[0]);
        connect<parameter>(bias_dense2_rtp, k_biasadd2.in[1]);
        connect<window<512>>(k_biasadd2.out[0], k_lrelu2.in[0]);
        connect<window<512>>(k_lrelu2.out[0], k_wsplit2.in[0]);

        auto wsplit2_leg0 = connect<window<256>>(k_wsplit2.out[0], dense3.inB[0]);
        fifo_depth(wsplit2_leg0) = 384;
        location<fifo>(wsplit2_leg0) = dma_fifo(aie_tile, 7, 1, 0x0100, 384);

        auto wsplit2_leg1 = connect<window<256>>(k_wsplit2.out[1], dense3.inB[1]);
        fifo_depth(wsplit2_leg1) = 384;
        location<fifo>(wsplit2_leg1) = dma_fifo(aie_tile, 7, 1, 0x0700, 384);


        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_dense3_rtp[i], dense3.matrixA[i]);
        }

        connect<window<512>>(dense3.out[0], k_biasadd3.in[0]);
        connect<parameter>(bias_dense3_rtp, k_biasadd3.in[1]);
        connect<window<512>>(k_biasadd3.out[0], k_lrelu3.in[0]);

        auto lrelu3_to_plio = connect<window<512>>(k_lrelu3.out[0], layer_out.in[0]);
        fifo_depth(lrelu3_to_plio) = 512;
        location<fifo>(lrelu3_to_plio) = {dma_fifo(aie_tile, 29, 2, 0x0400, 512),
                                          ss_fifo(shim_tile, 29, 0, 0)};


        auto dense0_kernels = dense0.getKernels();
        for (auto& k : dense0_kernels) {
            runtime<ratio>(k) = 0.90;
        }
        auto dense1_kernels = dense1.getKernels();
        for (auto& k : dense1_kernels) {
            runtime<ratio>(k) = 0.90;
        }
        auto dense2_kernels = dense2.getKernels();
        for (auto& k : dense2_kernels) {
            runtime<ratio>(k) = 0.90;
        }
        auto dense3_kernels = dense3.getKernels();
        for (auto& k : dense3_kernels) {
            runtime<ratio>(k) = 0.90;
        }

        auto dense0_group = node_group::create(dense0_kernels);
        location<group>(dense0_group) = area_group({{aie_tile, 10, 1, 21, 6}}, true, false, true);

        auto dense1_group = node_group::create(dense1_kernels);
        location<group>(dense1_group) = area_group({{aie_tile, 23, 1, 24, 6}}, true, false, true);

        auto dense2_group = node_group::create(dense2_kernels);
        location<group>(dense2_group) = area_group({{aie_tile, 26, 1, 27, 6}}, true, false, true);

        auto dense3_group = node_group::create(dense3_kernels);
        location<group>(dense3_group) = area_group({{aie_tile, 29, 1, 30, 6}}, true, false, true);

        auto router_group = node_group::create({k_rollconcat0, k_wsplit0, k_wsplit1, k_wsplit2});
        location<group>(router_group) = area_group({{aie_tile, 6, 0, 8, 1}}, false, true, false);
    }
};
