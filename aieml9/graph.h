#pragma once
#include <adf.h>
#include <array>
#include <string>

#include "nn_defs.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"

#include "leaky_relu.h"
#include "window_split_128_to_64x2.h"
#include "roll_concat.h"
#include "bias_add.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

// Stage 1 (aieml6) configuration ------------------------------------------------
static constexpr unsigned int TP_SHIFT_STAGE1 = 0;
static constexpr unsigned int TP_RND_STAGE1 = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES_STAGE1 = 1;
static constexpr unsigned int TP_SAT_STAGE1 = 0;
static constexpr unsigned int TP_SSR_STAGE1 = 1;
static constexpr unsigned int TP_DIM_A_LEADING_STAGE1 = 1;
static constexpr unsigned int TP_USE_MATRIX_RELOAD_STAGE1 = 1;
static constexpr unsigned int TP_API_STAGE1 = 0;
static constexpr unsigned int TP_DUAL_IP_STAGE1 = 0;
static constexpr unsigned int TP_NUM_OUTPUTS_STAGE1 = 1;
static constexpr unsigned int TP_CASC_LEN_STAGE1_LAYER0 = 1;
static constexpr unsigned int TP_CASC_LEN_STAGE1_LAYER1 = 2;

using dense8x128 = matrix_vector_mul_graph<
    float, float,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT_STAGE1,
    TP_RND_STAGE1,
    TP_NUM_FRAMES_STAGE1,
    TP_CASC_LEN_STAGE1_LAYER0,
    TP_SAT_STAGE1,
    TP_SSR_STAGE1,
    TP_DIM_A_LEADING_STAGE1,
    TP_USE_MATRIX_RELOAD_STAGE1,
    TP_API_STAGE1,
    TP_DUAL_IP_STAGE1,
    TP_NUM_OUTPUTS_STAGE1>;

using dense128x128_stage1 = matrix_vector_mul_graph<
    float, float,
    OUTPUT_SIZE,
    HIDDEN_SIZE,
    TP_SHIFT_STAGE1,
    TP_RND_STAGE1,
    TP_NUM_FRAMES_STAGE1,
    TP_CASC_LEN_STAGE1_LAYER1,
    TP_SAT_STAGE1,
    TP_SSR_STAGE1,
    TP_DIM_A_LEADING_STAGE1,
    TP_USE_MATRIX_RELOAD_STAGE1,
    TP_API_STAGE1,
    TP_DUAL_IP_STAGE1,
    TP_NUM_OUTPUTS_STAGE1>;

// Stage 2 (aieml7) configuration ------------------------------------------------
static constexpr unsigned int TP_SHIFT_STAGE2 = 0;
static constexpr unsigned int TP_RND_STAGE2 = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES_STAGE2 = 1;
static constexpr unsigned int TP_SAT_STAGE2 = 0;
static constexpr unsigned int TP_SSR_STAGE2 = 1;
static constexpr unsigned int TP_DIM_A_LEADING_STAGE2 = 1;
static constexpr unsigned int TP_USE_MATRIX_RELOAD_STAGE2 = 0;
static constexpr unsigned int TP_API_STAGE2 = 0;
static constexpr unsigned int TP_DUAL_IP_STAGE2 = 0;
static constexpr unsigned int TP_NUM_OUTPUTS_STAGE2 = 1;
static constexpr unsigned int TP_CASC_LEN_STAGE2_LAYER0 = 12;
static constexpr unsigned int TP_CASC_LEN_STAGE2_LAYERX = 2;
static_assert(TP_CASC_LEN_STAGE2_LAYER0 % 2 == 0,
              "TP_CASC_LEN_STAGE2_LAYER0 must be even to split across shared buffers");
static constexpr unsigned int TP_CASC_PER_BUFFER = TP_CASC_LEN_STAGE2_LAYER0 / 2;
static_assert((ROLL_CONC_SUBSET_SIZE * HIDDEN_SIZE) % TP_CASC_LEN_STAGE2_LAYER0 == 0,
              "ROLL_CONC_SUBSET_SIZE * HIDDEN_SIZE must be divisible by TP_CASC_LEN_STAGE2_LAYER0");
static constexpr unsigned int ROLL_CONCAT_TOTAL = ROLL_CONC_SUBSET_SIZE * HIDDEN_SIZE;
static constexpr unsigned int ROLL_CONCAT_TILE_SPAN = ROLL_CONCAT_TOTAL / TP_CASC_LEN_STAGE2_LAYER0;
static_assert(ROLL_CONCAT_TILE_SPAN * TP_CASC_LEN_STAGE2_LAYER0 == ROLL_CONCAT_TOTAL,
              "Shared buffer tiling must cover the entire roll-concat frame");

using dense768x128 = matrix_vector_mul_graph<
    float, float,
    128,
    768,
    TP_SHIFT_STAGE2,
    TP_RND_STAGE2,
    TP_NUM_FRAMES_STAGE2,
    TP_CASC_LEN_STAGE2_LAYER0,
    TP_SAT_STAGE2,
    TP_SSR_STAGE2,
    TP_DIM_A_LEADING_STAGE2,
    TP_USE_MATRIX_RELOAD_STAGE2,
    TP_API_STAGE2,
    TP_DUAL_IP_STAGE2,
    TP_NUM_OUTPUTS_STAGE2>;

using dense128x128_stage2 = matrix_vector_mul_graph<
    float, float,
    OUTPUT_SIZE,
    HIDDEN_SIZE,
    TP_SHIFT_STAGE2,
    TP_RND_STAGE2,
    TP_NUM_FRAMES_STAGE2,
    TP_CASC_LEN_STAGE2_LAYERX,
    TP_SAT_STAGE2,
    TP_SSR_STAGE2,
    TP_DIM_A_LEADING_STAGE2,
    TP_USE_MATRIX_RELOAD_STAGE2,
    TP_API_STAGE2,
    TP_DUAL_IP_STAGE2,
    TP_NUM_OUTPUTS_STAGE2>;

// Stage 3 (aieml8) configuration ------------------------------------------------
static constexpr unsigned int TP_SHIFT_STAGE3 = 0;
static constexpr unsigned int TP_RND_STAGE3 = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES_STAGE3 = 1;
static constexpr unsigned int TP_SAT_STAGE3 = 0;
static constexpr unsigned int TP_SSR_STAGE3 = 1;
static constexpr unsigned int TP_DIM_A_LEADING_STAGE3 = 1;
static constexpr unsigned int TP_USE_MATRIX_RELOAD_STAGE3 = 1;
static constexpr unsigned int TP_API_STAGE3 = 0;
static constexpr unsigned int TP_DUAL_IP_STAGE3 = 0;
static constexpr unsigned int TP_NUM_OUTPUTS_STAGE3 = 1;
static constexpr unsigned int TP_CASC_LEN_STAGE3 = 1;

using dense128x32 = matrix_vector_mul_graph<
    float, float,
    32,
    HIDDEN_SIZE,
    TP_SHIFT_STAGE3,
    TP_RND_STAGE3,
    TP_NUM_FRAMES_STAGE3,
    TP_CASC_LEN_STAGE3,
    TP_SAT_STAGE3,
    TP_SSR_STAGE3,
    TP_DIM_A_LEADING_STAGE3,
    TP_USE_MATRIX_RELOAD_STAGE3,
    TP_API_STAGE3,
    TP_DUAL_IP_STAGE3,
    TP_NUM_OUTPUTS_STAGE3>;

class NeuralNetworkGraph : public graph {
public:
    // Top-level I/O
    input_plio  pipeline_in;
    output_plio pipeline_out;

    // Stage 1 modules -------------------------------------------------------
    dense8x128            embed_dense0;
    dense128x128_stage1   embed_dense1;
    kernel                embed_bias0;
    kernel                embed_bias1;
    kernel                embed_relu0;
    kernel                embed_relu1;
    kernel                embed_split0;

    input_port            embed_matrixA_rtp;
    input_port            embed_bias0_rtp;
    input_port            embed_bias1_rtp;
    input_port            embed_matrixA1_rtp[TP_CASC_LEN_STAGE1_LAYER1];

    // Stage 2 modules -------------------------------------------------------
    dense768x128          solver_dense0;
    dense128x128_stage2   solver_dense1;
    dense128x128_stage2   solver_dense2;
    dense128x128_stage2   solver_dense3;

    kernel                solver_rollconcat;
    kernel                solver_bias0;
    kernel                solver_bias1;
    kernel                solver_bias2;
    kernel                solver_bias3;
    kernel                solver_relu0;
    kernel                solver_relu1;
    kernel                solver_relu2;
    kernel                solver_relu3;
    kernel                solver_split0;
    kernel                solver_split1;
    kernel                solver_split2;

    adf::shared_buffer<float> solver_roll_buf_a;
    adf::shared_buffer<float> solver_roll_buf_b;

    input_port            solver_bias0_rtp;
    input_port            solver_bias1_rtp;
    input_port            solver_bias2_rtp;
    input_port            solver_bias3_rtp;

    std::array<input_plio, SUBSOLVER0_INPUT_PARTS>         solver_dense0_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver_dense1_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver_dense2_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver_dense3_weight_plios;

    // Stage 3 modules -------------------------------------------------------
    dense128x32           output_dense0;
    input_port            output_matrixA_rtp;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;

        // Create top level PLIO
        pipeline_in = input_plio::create("aieml9_in", plio_32_bits,
                                         (base_path + "/" + EMBED_INPUT_DATA).c_str());
        pipeline_out = output_plio::create("aieml9_out", plio_32_bits,
                                           (base_path + "/" + AIEML9_OUTPUT_FILE).c_str());

        // ------------------------- Stage 1 ---------------------------------
        connect<parameter>(embed_matrixA_rtp, embed_dense0.matrixA[0]);
        connect<>(pipeline_in.out[0], embed_dense0.inB[0]);

        embed_bias0 = kernel::create(bias_add_kernel);
        source(embed_bias0)  = "bias_add.cpp";
        headers(embed_bias0) = {"bias_add.h"};
        runtime<ratio>(embed_bias0) = 1.0;

        embed_bias1 = kernel::create(bias_add_kernel);
        source(embed_bias1)  = "bias_add.cpp";
        headers(embed_bias1) = {"bias_add.h"};
        runtime<ratio>(embed_bias1) = 1.0;

        embed_relu0 = kernel::create(leaky_relu_kernel);
        source(embed_relu0)  = "leaky_relu.cpp";
        headers(embed_relu0) = {"leaky_relu.h"};
        runtime<ratio>(embed_relu0) = 1.0;

        embed_relu1 = kernel::create(leaky_relu_kernel);
        source(embed_relu1)  = "leaky_relu.cpp";
        headers(embed_relu1) = {"leaky_relu.h"};
        runtime<ratio>(embed_relu1) = 1.0;

        embed_split0 = kernel::create(window_split_128_to_64x2);
        source(embed_split0)  = "window_split_128_to_64x2.cpp";
        headers(embed_split0) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(embed_split0) = 1.0;

        connect<window<512>>(embed_dense0.out[0], embed_bias0.in[0]);
        connect<parameter>(embed_bias0_rtp, embed_bias0.in[1]);
        connect<window<512>>(embed_bias0.out[0], embed_relu0.in[0]);
        connect<window<512>>(embed_relu0.out[0], embed_split0.in[0]);

        auto embed_split_leg0 = connect<window<256>>(embed_split0.out[0], embed_dense1.inB[0]);
        auto embed_split_leg1 = connect<window<256>>(embed_split0.out[1], embed_dense1.inB[1]);
        adf::fifo_depth(embed_split_leg0) = 8;
        adf::fifo_depth(embed_split_leg1) = 8;

        for (int i = 0; i < TP_CASC_LEN_STAGE1_LAYER1; ++i) {
            connect<parameter>(embed_matrixA1_rtp[i], embed_dense1.matrixA[i]);
        }

        connect<window<512>>(embed_dense1.out[0], embed_bias1.in[0]);
        connect<parameter>(embed_bias1_rtp, embed_bias1.in[1]);
        connect<window<512>>(embed_bias1.out[0], embed_relu1.in[0]);

        // ------------------------- Stage 2 ---------------------------------
        solver_rollconcat = kernel::create(roll_concat_kernel);
        source(solver_rollconcat)  = "roll_concat.cpp";
        headers(solver_rollconcat) = {"roll_concat.h"};
        runtime<ratio>(solver_rollconcat) = 1.0;

        connect<window<512>>(embed_relu1.out[0], solver_rollconcat.in[0]);
        dimensions(solver_rollconcat.in[0])  = {HIDDEN_SIZE};
        dimensions(solver_rollconcat.out[0]) = {ROLL_CONCAT_TOTAL};
        dimensions(solver_rollconcat.out[1]) = {ROLL_CONCAT_TOTAL};

        solver_roll_buf_a = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, TP_CASC_PER_BUFFER);
        solver_roll_buf_b = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, TP_CASC_PER_BUFFER);

        connect<>(solver_rollconcat.out[0], solver_roll_buf_a.in[0]);
        connect<>(solver_rollconcat.out[1], solver_roll_buf_b.in[0]);

        write_access(solver_roll_buf_a.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });
        write_access(solver_roll_buf_b.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });

        for (int i = 0; i < TP_CASC_PER_BUFFER; ++i) {
            connect<>(solver_roll_buf_a.out[i], solver_dense0.inB[i]);
            read_access(solver_roll_buf_a.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}
            });
        }
        for (int i = 0; i < TP_CASC_PER_BUFFER; ++i) {
            const int cascade_index = TP_CASC_PER_BUFFER + i;
            connect<>(solver_roll_buf_b.out[i], solver_dense0.inB[cascade_index]);
            read_access(solver_roll_buf_b.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(cascade_index * ROLL_CONCAT_TILE_SPAN)}
            });
        }

        auto connect_layer_weights = [&](auto& plios,
                                         const char* name_prefix,
                                         const char* file_prefix) {
            for (int part = 0; part < static_cast<int>(plios.size()); ++part) {
                const std::string plio_name = std::string(name_prefix) + std::to_string(part);
                const std::string file_path = base_path + "/" + file_prefix + std::to_string(part) + ".txt";
                plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            }
        };

        for (int part = 0; part < SUBSOLVER0_INPUT_PARTS; ++part) {
            const std::string plio_name = "solver_dense0_w_part" + std::to_string(part);
            const std::string file_path = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
            solver_dense0_weight_plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            connect<>(solver_dense0_weight_plios[part].out[0], solver_dense0.inA[part]);
        }

        connect_layer_weights(solver_dense1_weight_plios, "solver_dense1_w_part", SUBSOLVER0_DENSE1_WEIGHTS_PREFIX);
        connect_layer_weights(solver_dense2_weight_plios, "solver_dense2_w_part", SUBSOLVER0_DENSE2_WEIGHTS_PREFIX);
        connect_layer_weights(solver_dense3_weight_plios, "solver_dense3_w_part", SUBSOLVER0_DENSE3_WEIGHTS_PREFIX);

        connect<>(solver_dense1_weight_plios[0].out[0], solver_dense1.inA[0]);
        connect<>(solver_dense1_weight_plios[1].out[0], solver_dense1.inA[1]);
        connect<>(solver_dense2_weight_plios[0].out[0], solver_dense2.inA[0]);
        connect<>(solver_dense2_weight_plios[1].out[0], solver_dense2.inA[1]);
        connect<>(solver_dense3_weight_plios[0].out[0], solver_dense3.inA[0]);
        connect<>(solver_dense3_weight_plios[1].out[0], solver_dense3.inA[1]);

        solver_bias0 = kernel::create(bias_add_kernel);
        source(solver_bias0)  = "bias_add.cpp";
        headers(solver_bias0) = {"bias_add.h"};
        runtime<ratio>(solver_bias0) = 0.45;

        solver_bias1 = kernel::create(bias_add_kernel);
        source(solver_bias1)  = "bias_add.cpp";
        headers(solver_bias1) = {"bias_add.h"};
        runtime<ratio>(solver_bias1) = 0.45;

        solver_bias2 = kernel::create(bias_add_kernel);
        source(solver_bias2)  = "bias_add.cpp";
        headers(solver_bias2) = {"bias_add.h"};
        runtime<ratio>(solver_bias2) = 0.45;

        solver_bias3 = kernel::create(bias_add_kernel);
        source(solver_bias3)  = "bias_add.cpp";
        headers(solver_bias3) = {"bias_add.h"};
        runtime<ratio>(solver_bias3) = 0.45;

        solver_relu0 = kernel::create(leaky_relu_kernel);
        source(solver_relu0)  = "leaky_relu.cpp";
        headers(solver_relu0) = {"leaky_relu.h"};
        runtime<ratio>(solver_relu0) = 0.5;

        solver_relu1 = kernel::create(leaky_relu_kernel);
        source(solver_relu1)  = "leaky_relu.cpp";
        headers(solver_relu1) = {"leaky_relu.h"};
        runtime<ratio>(solver_relu1) = 0.5;

        solver_relu2 = kernel::create(leaky_relu_kernel);
        source(solver_relu2)  = "leaky_relu.cpp";
        headers(solver_relu2) = {"leaky_relu.h"};
        runtime<ratio>(solver_relu2) = 0.5;

        solver_relu3 = kernel::create(leaky_relu_kernel);
        source(solver_relu3)  = "leaky_relu.cpp";
        headers(solver_relu3) = {"leaky_relu.h"};
        runtime<ratio>(solver_relu3) = 0.5;

        solver_split0 = kernel::create(window_split_128_to_64x2);
        source(solver_split0)  = "window_split_128_to_64x2.cpp";
        headers(solver_split0) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(solver_split0) = 0.65;

        solver_split1 = kernel::create(window_split_128_to_64x2);
        source(solver_split1)  = "window_split_128_to_64x2.cpp";
        headers(solver_split1) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(solver_split1) = 0.65;

        solver_split2 = kernel::create(window_split_128_to_64x2);
        source(solver_split2)  = "window_split_128_to_64x2.cpp";
        headers(solver_split2) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(solver_split2) = 0.65;

        connect<window<512>>(solver_dense0.out[0], solver_bias0.in[0]);
        connect<parameter>(solver_bias0_rtp, solver_bias0.in[1]);
        connect<window<512>>(solver_bias0.out[0], solver_relu0.in[0]);
        connect<window<512>>(solver_relu0.out[0], solver_split0.in[0]);

        auto solver_split0_leg0 = connect<window<256>>(solver_split0.out[0], solver_dense1.inB[0]);
        auto solver_split0_leg1 = connect<window<256>>(solver_split0.out[1], solver_dense1.inB[1]);
        adf::fifo_depth(solver_split0_leg0) = 8;
        adf::fifo_depth(solver_split0_leg1) = 8;

        connect<window<512>>(solver_dense1.out[0], solver_bias1.in[0]);
        connect<parameter>(solver_bias1_rtp, solver_bias1.in[1]);
        connect<window<512>>(solver_bias1.out[0], solver_relu1.in[0]);
        connect<window<512>>(solver_relu1.out[0], solver_split1.in[0]);

        auto solver_split1_leg0 = connect<window<256>>(solver_split1.out[0], solver_dense2.inB[0]);
        auto solver_split1_leg1 = connect<window<256>>(solver_split1.out[1], solver_dense2.inB[1]);
        adf::fifo_depth(solver_split1_leg0) = 8;
        adf::fifo_depth(solver_split1_leg1) = 8;

        connect<window<512>>(solver_dense2.out[0], solver_bias2.in[0]);
        connect<parameter>(solver_bias2_rtp, solver_bias2.in[1]);
        connect<window<512>>(solver_bias2.out[0], solver_relu2.in[0]);
        connect<window<512>>(solver_relu2.out[0], solver_split2.in[0]);

        auto solver_split2_leg0 = connect<window<256>>(solver_split2.out[0], solver_dense3.inB[0]);
        auto solver_split2_leg1 = connect<window<256>>(solver_split2.out[1], solver_dense3.inB[1]);
        adf::fifo_depth(solver_split2_leg0) = 8;
        adf::fifo_depth(solver_split2_leg1) = 8;

        connect<window<512>>(solver_dense3.out[0], solver_bias3.in[0]);
        connect<parameter>(solver_bias3_rtp, solver_bias3.in[1]);
        connect<window<512>>(solver_bias3.out[0], solver_relu3.in[0]);

        // ------------------------- Stage 3 ---------------------------------
        connect<parameter>(output_matrixA_rtp, output_dense0.matrixA[0]);

        auto solver_to_output = connect<window<512>>(solver_relu3.out[0], output_dense0.inB[0]);
        adf::fifo_depth(solver_to_output) = 8;

        connect<window<128>>(output_dense0.out[0], pipeline_out.in[0]);
    }
};
