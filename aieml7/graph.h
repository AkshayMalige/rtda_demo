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
static constexpr unsigned int TP_USE_MATRIX_RELOAD = 0;
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

static constexpr unsigned int DENSE0_WEIGHTS_OFFSET = 0;
static constexpr unsigned int DENSE1_WEIGHTS_OFFSET =
    DENSE0_WEIGHTS_OFFSET + SUBSOLVER0_DENSE0_WEIGHTS_SIZE;
static constexpr unsigned int DENSE2_WEIGHTS_OFFSET =
    DENSE1_WEIGHTS_OFFSET + SUBSOLVER0_DENSE1_WEIGHTS_SIZE;
static constexpr unsigned int DENSE3_WEIGHTS_OFFSET =
    DENSE2_WEIGHTS_OFFSET + SUBSOLVER0_DENSE2_WEIGHTS_SIZE;
static constexpr unsigned int TOTAL_WEIGHT_ELEMENTS =
    DENSE3_WEIGHTS_OFFSET + SUBSOLVER0_DENSE3_WEIGHTS_SIZE;
static constexpr unsigned int TOTAL_WEIGHT_BYTES = TOTAL_WEIGHT_ELEMENTS * sizeof(float);
static_assert(TOTAL_WEIGHT_ELEMENTS == SUBSOLVER0_DENSE0_WEIGHTS_SIZE +
                                          SUBSOLVER0_DENSE1_WEIGHTS_SIZE +
                                          SUBSOLVER0_DENSE2_WEIGHTS_SIZE +
                                          SUBSOLVER0_DENSE3_WEIGHTS_SIZE,
              "Weight buffer size must cover all dense layers");
static_assert(TOTAL_WEIGHT_BYTES > 32 * 1024,
              "Total dense weights overflow a single shared buffer tile and require external memory");

static constexpr unsigned int DENSE0_WEIGHT_PORT_BASE = 0;
static constexpr unsigned int DENSE1_WEIGHT_PORT_BASE =
    DENSE0_WEIGHT_PORT_BASE + TP_CASC_LEN_LAYER3;
static constexpr unsigned int DENSE2_WEIGHT_PORT_BASE =
    DENSE1_WEIGHT_PORT_BASE + TP_CASC_LEN_LAYER2;
static constexpr unsigned int DENSE3_WEIGHT_PORT_BASE =
    DENSE2_WEIGHT_PORT_BASE + TP_CASC_LEN_LAYER2;
static constexpr unsigned int TOTAL_WEIGHT_PORTS =
    DENSE3_WEIGHT_PORT_BASE + TP_CASC_LEN_LAYER2;
static_assert(TOTAL_WEIGHT_PORTS == TP_CASC_LEN_LAYER3 + 3 * TP_CASC_LEN_LAYER2,
              "Weight buffer must expose one port per cascade leg");

static constexpr unsigned int DENSE0_BIAS_OFFSET = 0;
static constexpr unsigned int DENSE1_BIAS_OFFSET =
    DENSE0_BIAS_OFFSET + SUBSOLVER0_DENSE0_BIAS_SIZE;
static constexpr unsigned int DENSE2_BIAS_OFFSET =
    DENSE1_BIAS_OFFSET + SUBSOLVER0_DENSE1_BIAS_SIZE;
static constexpr unsigned int DENSE3_BIAS_OFFSET =
    DENSE2_BIAS_OFFSET + SUBSOLVER0_DENSE2_BIAS_SIZE;
static constexpr unsigned int TOTAL_BIAS_ELEMENTS =
    DENSE3_BIAS_OFFSET + SUBSOLVER0_DENSE3_BIAS_SIZE;
static_assert(TOTAL_BIAS_ELEMENTS == SUBSOLVER0_DENSE0_BIAS_SIZE +
                                         SUBSOLVER0_DENSE1_BIAS_SIZE +
                                         SUBSOLVER0_DENSE2_BIAS_SIZE +
                                         SUBSOLVER0_DENSE3_BIAS_SIZE,
              "Bias buffer size must cover all dense layers");

static constexpr unsigned int DENSE0_BIAS_PORT = 0;
static constexpr unsigned int DENSE1_BIAS_PORT = 1;
static constexpr unsigned int DENSE2_BIAS_PORT = 2;
static constexpr unsigned int DENSE3_BIAS_PORT = 3;
static constexpr unsigned int TOTAL_BIAS_PORTS = 4;
static_assert(TOTAL_BIAS_PORTS == 4, "Bias buffer must expose one port per dense layer");


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
    input_plio  weights_in;
    input_plio  biases_in;
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
    adf::external_buffer<float> weights_buffer;
    adf::shared_buffer<float> bias_buffer;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer_out = output_plio::create("layer_out", plio_32_bits, (base_path + "/" + SUBSOLVER0_DENSE3_OUTPUT).c_str());

        layer0_in      = input_plio::create("layer0_in", plio_32_bits,
            (base_path + "/" + TMP_INP768).c_str());
        weights_in     = input_plio::create("weights_in", plio_32_bits,
            (base_path + "/" + SUBSOLVER0_WEIGHT_STREAM).c_str());
        biases_in      = input_plio::create("biases_in", plio_32_bits,
            (base_path + "/" + SUBSOLVER0_BIAS_STREAM).c_str());



        k_rollconcat0 = kernel::create(roll_concat_kernel);
        source(k_rollconcat0) = "roll_concat.cpp";
        headers(k_rollconcat0) = {"roll_concat.h"};
        runtime<ratio>(k_rollconcat0) = 1.0;

        connect(layer0_in.out[0], k_rollconcat0.in[0]);
        dimensions(k_rollconcat0.in[0]) = {HIDDEN_SIZE};
        dimensions(k_rollconcat0.out[0]) = {ROLL_CONCAT_TOTAL};

        roll_concat_buffer = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, TP_CASC_LEN_LAYER3);

        connect<>(k_rollconcat0.out[0], roll_concat_buffer.in[0]);

        write_access(roll_concat_buffer.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });
        // TOTAL_WEIGHT_BYTES (~576 KiB) exceeds the 32 KiB on-tile memory footprint of a shared buffer,
        // so stage all dense weights in external memory instead.
        weights_buffer = external_buffer<float>::create({TOTAL_WEIGHT_ELEMENTS}, 1, TOTAL_WEIGHT_PORTS);
        write_access(weights_buffer.in[0]) = tiling({
            .buffer_dimension = {TOTAL_WEIGHT_ELEMENTS},
            .tiling_dimension = {TOTAL_WEIGHT_ELEMENTS},
            .offset = {0}
        });

        bias_buffer = shared_buffer<float>::create({TOTAL_BIAS_ELEMENTS}, 1, TOTAL_BIAS_PORTS);
        write_access(bias_buffer.in[0]) = tiling({
            .buffer_dimension = {TOTAL_BIAS_ELEMENTS},
            .tiling_dimension = {TOTAL_BIAS_ELEMENTS},
            .offset = {0}
        });

        connect<>(weights_in.out[0], weights_buffer.in[0]);
        connect<>(biases_in.out[0], bias_buffer.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            const int port = DENSE0_WEIGHT_PORT_BASE + i;
            connect<>(weights_buffer.out[port], dense0.inA[i]);
            read_access(weights_buffer.out[port]) = tiling({
                .buffer_dimension = {TOTAL_WEIGHT_ELEMENTS},
                .tiling_dimension = {SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE},
                .offset = {DENSE0_WEIGHTS_OFFSET + i * SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE}
            });
            dimensions(dense0.inA[i]) = {SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE};
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
        runtime<ratio>(k_biasadd0) = 1.0;

        k_biasadd1 = kernel::create(bias_add_kernel);
        source(k_biasadd1) = "bias_add.cpp";
        headers(k_biasadd1) = {"bias_add.h"};
        runtime<ratio>(k_biasadd1) = 1.0;

        k_biasadd2 = kernel::create(bias_add_kernel);
        source(k_biasadd2) = "bias_add.cpp";
        headers(k_biasadd2) = {"bias_add.h"};
        runtime<ratio>(k_biasadd2) = 1.0;

        k_biasadd3 = kernel::create(bias_add_kernel);
        source(k_biasadd3) = "bias_add.cpp";
        headers(k_biasadd3) = {"bias_add.h"};
        runtime<ratio>(k_biasadd3) = 1.0;

        k_lrelu0 = kernel::create(leaky_relu_kernel);
        source(k_lrelu0) = "leaky_relu.cpp";
        headers(k_lrelu0) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu0) = 1.0;

        k_lrelu1 = kernel::create(leaky_relu_kernel);
        source(k_lrelu1) = "leaky_relu.cpp";
        headers(k_lrelu1) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu1) = 1.0;

        k_lrelu2 = kernel::create(leaky_relu_kernel);
        source(k_lrelu2) = "leaky_relu.cpp";
        headers(k_lrelu2) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu2) = 1.0;

        k_lrelu3 = kernel::create(leaky_relu_kernel);
        source(k_lrelu3) = "leaky_relu.cpp";
        headers(k_lrelu3) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu3) = 1.0;

        k_wsplit0 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit0) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit0) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit0) = 1.0;

        k_wsplit1 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit1) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit1) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit1) = 1.0;

        k_wsplit2 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit2) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit2) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit2) = 1.0;

        connect<window<512>>(dense0.out[0], k_biasadd0.in[0]);
        connect<>(bias_buffer.out[DENSE0_BIAS_PORT], k_biasadd0.in[1]);
        read_access(bias_buffer.out[DENSE0_BIAS_PORT]) = tiling({
            .buffer_dimension = {TOTAL_BIAS_ELEMENTS},
            .tiling_dimension = {SUBSOLVER0_DENSE0_BIAS_SIZE},
            .offset = {DENSE0_BIAS_OFFSET}
        });
        connect<window<512>>(k_biasadd0.out[0], k_lrelu0.in[0]);
        connect<window<512>>(k_lrelu0.out[0], k_wsplit0.in[0]);

        connect<window<256>>(k_wsplit0.out[0], dense1.inB[0]);
        connect<window<256>>(k_wsplit0.out[1], dense1.inB[1]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            const int port = DENSE1_WEIGHT_PORT_BASE + i;
            connect<>(weights_buffer.out[port], dense1.inA[i]);
            read_access(weights_buffer.out[port]) = tiling({
                .buffer_dimension = {TOTAL_WEIGHT_ELEMENTS},
                .tiling_dimension = {SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE},
                .offset = {DENSE1_WEIGHTS_OFFSET + i * SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE}
            });
            dimensions(dense1.inA[i]) = {SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE};
        }

        connect<window<512>>(dense1.out[0], k_biasadd1.in[0]);
        connect<>(bias_buffer.out[DENSE1_BIAS_PORT], k_biasadd1.in[1]);
        read_access(bias_buffer.out[DENSE1_BIAS_PORT]) = tiling({
            .buffer_dimension = {TOTAL_BIAS_ELEMENTS},
            .tiling_dimension = {SUBSOLVER0_DENSE1_BIAS_SIZE},
            .offset = {DENSE1_BIAS_OFFSET}
        });
        connect<window<512>>(k_biasadd1.out[0], k_lrelu1.in[0]);
        connect<window<512>>(k_lrelu1.out[0], k_wsplit1.in[0]);

        connect<window<256>>(k_wsplit1.out[0], dense2.inB[0]);
        connect<window<256>>(k_wsplit1.out[1], dense2.inB[1]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            const int port = DENSE2_WEIGHT_PORT_BASE + i;
            connect<>(weights_buffer.out[port], dense2.inA[i]);
            read_access(weights_buffer.out[port]) = tiling({
                .buffer_dimension = {TOTAL_WEIGHT_ELEMENTS},
                .tiling_dimension = {SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE},
                .offset = {DENSE2_WEIGHTS_OFFSET + i * SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE}
            });
            dimensions(dense2.inA[i]) = {SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE};
        }

        connect<window<512>>(dense2.out[0], k_biasadd2.in[0]);
        connect<>(bias_buffer.out[DENSE2_BIAS_PORT], k_biasadd2.in[1]);
        read_access(bias_buffer.out[DENSE2_BIAS_PORT]) = tiling({
            .buffer_dimension = {TOTAL_BIAS_ELEMENTS},
            .tiling_dimension = {SUBSOLVER0_DENSE2_BIAS_SIZE},
            .offset = {DENSE2_BIAS_OFFSET}
        });
        connect<window<512>>(k_biasadd2.out[0], k_lrelu2.in[0]);
        connect<window<512>>(k_lrelu2.out[0], k_wsplit2.in[0]);

        connect<window<256>>(k_wsplit2.out[0], dense3.inB[0]);
        connect<window<256>>(k_wsplit2.out[1], dense3.inB[1]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            const int port = DENSE3_WEIGHT_PORT_BASE + i;
            connect<>(weights_buffer.out[port], dense3.inA[i]);
            read_access(weights_buffer.out[port]) = tiling({
                .buffer_dimension = {TOTAL_WEIGHT_ELEMENTS},
                .tiling_dimension = {SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE},
                .offset = {DENSE3_WEIGHTS_OFFSET + i * SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE}
            });
            dimensions(dense3.inA[i]) = {SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE};
        }

        connect<window<512>>(dense3.out[0], k_biasadd3.in[0]);
        connect<>(bias_buffer.out[DENSE3_BIAS_PORT], k_biasadd3.in[1]);
        read_access(bias_buffer.out[DENSE3_BIAS_PORT]) = tiling({
            .buffer_dimension = {TOTAL_BIAS_ELEMENTS},
            .tiling_dimension = {SUBSOLVER0_DENSE3_BIAS_SIZE},
            .offset = {DENSE3_BIAS_OFFSET}
        });
        connect<window<512>>(k_biasadd3.out[0], k_lrelu3.in[0]);

        connect<window<512>>(k_lrelu3.out[0], layer_out.in[0]);


        auto d0_k = dense0.getKernels();
        location<kernel>(d0_k[0]) = tile(20, 4);


        // constexpr unsigned dense2_base_col = 2;
        // constexpr unsigned dense2_row = 0;
        // auto dense2_kernels = dense2.getKernels();
        // for (unsigned i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        //     adf::location<adf::kernel>(dense2_kernels[i]) =
        //         adf::tile(dense2_base_col + i, dense2_row);
        // }
    }
};
