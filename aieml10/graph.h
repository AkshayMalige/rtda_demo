#pragma once
#include <adf.h>
#include <array>
#include <string>
#include <utility>

#include "nn_defs10.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"

#include "leaky_relu.h"
#include "window_split_128_to_64x2.h"
#include "roll_concat.h"
#include "bias_add.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

constexpr unsigned WINDOW_BYTES_HIDDEN = bytes_per_vector(HIDDEN_SIZE);
constexpr unsigned WINDOW_BYTES_HALF_HIDDEN = bytes_per_vector(HIDDEN_SPLIT_SIZE);
constexpr unsigned WINDOW_BYTES_OUTPUT_PAD = bytes_per_vector(OUTPUT_DENSE0_OUT_PAD);

constexpr unsigned DEFAULT_FIFO_DEPTH = 8U;

// Stage 1 configuration ----------------------------------------------------
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
static constexpr unsigned int TP_CASC_LEN_STAGE1_LAYER0 = EMBED_DENSE0_CASC_LEN;
static constexpr unsigned int TP_CASC_LEN_STAGE1_LAYER1 = EMBED_DENSE1_CASC_LEN;

using dense8x128 = matrix_vector_mul_graph<
    float,
    float,
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

// Non-reload variant for PLIO-fed weights on embed_dense0
using dense8x128_plio = matrix_vector_mul_graph<
    float,
    float,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT_STAGE1,
    TP_RND_STAGE1,
    TP_NUM_FRAMES_STAGE1,
    TP_CASC_LEN_STAGE1_LAYER0,
    TP_SAT_STAGE1,
    TP_SSR_STAGE1,
    TP_DIM_A_LEADING_STAGE1,
    /* TP_USE_MATRIX_RELOAD = */ 0,
    TP_API_STAGE1,
    TP_DUAL_IP_STAGE1,
    TP_NUM_OUTPUTS_STAGE1>;

using dense128x128_stage1 = matrix_vector_mul_graph<
    float,
    float,
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

// Non-reload variant for PLIO-fed weights on embed_dense1
using dense128x128_stage1_plio = matrix_vector_mul_graph<
    float,
    float,
    OUTPUT_SIZE,
    HIDDEN_SIZE,
    TP_SHIFT_STAGE1,
    TP_RND_STAGE1,
    TP_NUM_FRAMES_STAGE1,
    TP_CASC_LEN_STAGE1_LAYER1,
    TP_SAT_STAGE1,
    TP_SSR_STAGE1,
    TP_DIM_A_LEADING_STAGE1,
    /* TP_USE_MATRIX_RELOAD = */ 0,
    TP_API_STAGE1,
    TP_DUAL_IP_STAGE1,
    TP_NUM_OUTPUTS_STAGE1>;

// Stage 2 configuration ----------------------------------------------------
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
static constexpr unsigned int TP_CASC_LEN_STAGE2_LAYER0 = SOLVER_DENSE0_CASC_LEN;
static constexpr unsigned int TP_CASC_LEN_STAGE2_LAYERX = SOLVER_DENSEX_CASC_LEN;

using dense256x128 = matrix_vector_mul_graph<
    float,
    float,
    HIDDEN_SIZE,
    SUBSOLVER0_INPUT_SIZE,
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
    float,
    float,
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

// Stage 3 configuration ----------------------------------------------------
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
static constexpr unsigned int TP_CASC_LEN_STAGE3 = OUTPUT_DENSE0_CASC_LEN;

using dense128x32 = matrix_vector_mul_graph<
    float,
    float,
    OUTPUT_DENSE0_OUT_PAD,
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
    input_plio  pipeline_in;
    output_plio pipeline_out;

    dense8x128_plio      embed_dense0;
    input_plio            embed_layer0_weights;
    dense128x128_stage1_plio   embed_dense1;

    kernel                embed_bias0;
    kernel                embed_bias1;
    kernel                embed_relu0;
    kernel                embed_relu1;
    kernel                embed_split0;

    input_port            embed_bias0_rtp;
    input_port            embed_bias1_rtp;
    std::array<input_plio, EMBED_DENSE1_CASC_LEN> embed_dense1_weight_plios;

    dense256x128          solver_dense0;
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

    adf::shared_buffer<float> solver_roll_buf;

    input_port            solver_bias0_rtp;
    input_port            solver_bias1_rtp;
    input_port            solver_bias2_rtp;
    input_port            solver_bias3_rtp;

    std::array<input_plio, SUBSOLVER0_INPUT_PARTS>         solver_dense0_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver_dense1_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver_dense2_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver_dense3_weight_plios;

    dense256x128          solver2_dense0;
    dense256x128          solver3_dense0;
    dense128x128_stage2   solver2_dense1;
    dense128x128_stage2   solver3_dense1;
    dense128x128_stage2   solver2_dense2;
    dense128x128_stage2   solver3_dense2;
    dense128x128_stage2   solver2_dense3;
    dense128x128_stage2   solver3_dense3;


    kernel                solver2_rollconcat;
    kernel                solver3_rollconcat;
    kernel                solver2_bias0;
    kernel                solver2_bias1;
    kernel                solver2_bias2;
    kernel                solver2_bias3;
    kernel                solver2_relu0;
    kernel                solver2_relu1;
    kernel                solver2_relu2;
    kernel                solver2_relu3;
    kernel                solver2_split0;
    kernel                solver2_split1;
    kernel                solver2_split2;

    kernel                solver3_bias0;
    kernel                solver3_bias1;
    kernel                solver3_bias2;
    kernel                solver3_bias3;
    kernel                solver3_relu0;
    kernel                solver3_relu1;
    kernel                solver3_relu2;
    kernel                solver3_relu3;
    kernel                solver3_split0;
    kernel                solver3_split1;
    kernel                solver3_split2;

    adf::shared_buffer<float> solver2_roll_buf;
    adf::shared_buffer<float> solver3_roll_buf;

    input_port            solver2_bias0_rtp;
    input_port            solver2_bias1_rtp;
    input_port            solver2_bias2_rtp;
    input_port            solver2_bias3_rtp;

    input_port            solver3_bias0_rtp;
    input_port            solver3_bias1_rtp;
    input_port            solver3_bias2_rtp;
    input_port            solver3_bias3_rtp;

    std::array<input_plio, SUBSOLVER0_INPUT_PARTS>         solver2_dense0_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver2_dense1_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver2_dense2_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver2_dense3_weight_plios;

    std::array<input_plio, SUBSOLVER0_INPUT_PARTS>         solver3_dense0_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver3_dense1_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver3_dense2_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver3_dense3_weight_plios;
    dense128x32           output_dense0;
    input_port            output_matrixA_rtp;

    NeuralNetworkGraph() {
        const std::string base_path = DATA_DIR;

        const auto make_bias_kernel = []() {
            kernel k = kernel::create(bias_add_kernel);
            source(k)  = "bias_add.cpp";
            headers(k) = {"bias_add.h"};
            return k;
        };
        const auto make_relu_kernel = []() {
            kernel k = kernel::create(leaky_relu_kernel);
            source(k)  = "leaky_relu.cpp";
            headers(k) = {"leaky_relu.h"};
            return k;
        };
        const auto make_split_kernel = []() {
            kernel k = kernel::create(window_split_128_to_64x2);
            source(k)  = "window_split_128_to_64x2.cpp";
            headers(k) = {"window_split_128_to_64x2.h"};
            return k;
        };

        pipeline_in = input_plio::create("aieml10_in", plio_32_bits,
                                         (base_path + "/" + EMBED_INPUT_DATA).c_str());
        pipeline_out = output_plio::create("aieml10_out", plio_32_bits,
                                           (base_path + "/" + AIEML10_OUTPUT_FILE).c_str());

        embed_layer0_weights = input_plio::create("embed_layer0_weights", plio_32_bits, (base_path + "/" + EMBED_DENSE0_WEIGHTS).c_str());

        connect<>(embed_layer0_weights.out[0], embed_dense0.inA[0]);
        connect<>(pipeline_in.out[0], embed_dense0.inB[0]);

        embed_bias0 = make_bias_kernel();
        embed_bias1 = make_bias_kernel();
        embed_relu0 = make_relu_kernel();
        embed_relu1 = make_relu_kernel();
        embed_split0 = make_split_kernel();

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_dense0.out[0], embed_bias0.in[0]);
        connect<parameter>(embed_bias0_rtp, embed_bias0.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias0.out[0], embed_relu0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(embed_relu0.out[0], embed_split0.in[0]);

        auto embed_split_leg0 = connect<window<WINDOW_BYTES_HALF_HIDDEN>>(embed_split0.out[0], embed_dense1.inB[0]);
        auto embed_split_leg1 = connect<window<WINDOW_BYTES_HALF_HIDDEN>>(embed_split0.out[1], embed_dense1.inB[1]);
        adf::fifo_depth(embed_split_leg0) = DEFAULT_FIFO_DEPTH;
        adf::fifo_depth(embed_split_leg1) = DEFAULT_FIFO_DEPTH;

        // Feed embed_dense1 weights via PLIOs instead of RTP
        for (std::size_t part = 0; part < embed_dense1_weight_plios.size(); ++part) {
            const std::string plio_name = "embed_dense1_w_part" + std::to_string(part);
            const std::string file_path = base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
            embed_dense1_weight_plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            connect<>(embed_dense1_weight_plios[part].out[0], embed_dense1.inA[part]);
        }

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_dense1.out[0], embed_bias1.in[0]);
        connect<parameter>(embed_bias1_rtp, embed_bias1.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias1.out[0], embed_relu1.in[0]);

        // // Solver 1 -------------------------------------------------

        solver_rollconcat = kernel::create(roll_concat_kernel);
        source(solver_rollconcat)  = "roll_concat.cpp";
        headers(solver_rollconcat) = {"roll_concat.h"};

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_relu1.out[0], solver_rollconcat.in[0]);
        dimensions(solver_rollconcat.in[0])  = {HIDDEN_SIZE};
        dimensions(solver_rollconcat.out[0]) = {ROLL_CONCAT_TOTAL};

        solver_roll_buf = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, SUBSOLVER0_INPUT_PARTS);
        connect<>(solver_rollconcat.out[0], solver_roll_buf.in[0]);

        write_access(solver_roll_buf.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });

        for (int i = 0; i < SUBSOLVER0_INPUT_PARTS; ++i) {
            connect<>(solver_roll_buf.out[i], solver_dense0.inB[i]);
            read_access(solver_roll_buf.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}
            });
        }

        for (std::size_t part = 0; part < solver_dense0_weight_plios.size(); ++part) {
            const std::string plio_name = "solver_dense0_w_part" + std::to_string(part);
            const std::string file_path = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
            solver_dense0_weight_plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            connect<>(solver_dense0_weight_plios[part].out[0], solver_dense0.inA[part]);
        }

        const auto connect_layer_weights = [&](auto& plios, auto& dense, const std::string& name_prefix, const std::string& file_prefix) {
            for (std::size_t part = 0; part < plios.size(); ++part) {
                const std::string plio_name = name_prefix + std::to_string(part);
                const std::string file_path = base_path + "/" + file_prefix + std::to_string(part) + ".txt";
                plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
                connect<>(plios[part].out[0], dense.inA[part]);
            }
        };

        connect_layer_weights(solver_dense1_weight_plios, solver_dense1, "solver_dense1_w_part", SUBSOLVER0_DENSE1_WEIGHTS_PREFIX);
        connect_layer_weights(solver_dense2_weight_plios, solver_dense2, "solver_dense2_w_part", SUBSOLVER0_DENSE2_WEIGHTS_PREFIX);
        connect_layer_weights(solver_dense3_weight_plios, solver_dense3, "solver_dense3_w_part", SUBSOLVER0_DENSE3_WEIGHTS_PREFIX);

        for (kernel* bias : {&solver_bias0, &solver_bias1, &solver_bias2, &solver_bias3}) {
            *bias = make_bias_kernel();
        }
        for (kernel* relu : {&solver_relu0, &solver_relu1, &solver_relu2, &solver_relu3}) {
            *relu = make_relu_kernel();
        }
        for (kernel* split : {&solver_split0, &solver_split1, &solver_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver_bias0_rtp, solver_bias0.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver_dense0.out[0], solver_bias0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver_bias0.out[0], solver_relu0.in[0]);

        connect<window<WINDOW_BYTES_HIDDEN>>(solver_relu0.out[0], solver_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver_split0.out[0], solver_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver_split0.out[1], solver_dense1.inB[1]);


        connect<parameter>(solver_bias1_rtp, solver_bias1.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver_dense1.out[0], solver_bias1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver_bias1.out[0], solver_relu1.in[0]);

        connect<window<WINDOW_BYTES_HIDDEN>>(solver_relu1.out[0], solver_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver_split1.out[0], solver_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver_split1.out[1], solver_dense2.inB[1]);

        connect<parameter>(solver_bias2_rtp, solver_bias2.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver_dense2.out[0], solver_bias2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver_bias2.out[0], solver_relu2.in[0]);

        connect<window<WINDOW_BYTES_HIDDEN>>(solver_relu2.out[0], solver_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver_split2.out[0], solver_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver_split2.out[1], solver_dense3.inB[1]);

        connect<parameter>(solver_bias3_rtp, solver_bias3.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver_dense3.out[0], solver_bias3.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver_bias3.out[0], solver_relu3.in[0]);

        // // Solver 2 -------------------------------------------------
        solver2_rollconcat = kernel::create(roll_concat_kernel);
        source(solver2_rollconcat)  = "roll_concat.cpp";
        headers(solver2_rollconcat) = {"roll_concat.h"};

        connect<window<WINDOW_BYTES_HIDDEN>>(solver_relu3.out[0], solver2_rollconcat.in[0]);
        dimensions(solver2_rollconcat.in[0])  = {HIDDEN_SIZE};
        dimensions(solver2_rollconcat.out[0]) = {ROLL_CONCAT_TOTAL};

        solver2_roll_buf = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, SUBSOLVER0_INPUT_PARTS);
        connect<>(solver2_rollconcat.out[0], solver2_roll_buf.in[0]);

        write_access(solver2_roll_buf.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });

        for (int i = 0; i < SUBSOLVER0_INPUT_PARTS; ++i) {
            connect<>(solver2_roll_buf.out[i], solver2_dense0.inB[i]);
            read_access(solver2_roll_buf.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}
            });
        }

        for (std::size_t part = 0; part < solver2_dense0_weight_plios.size(); ++part) {
            const std::string plio_name = "solver2_dense0_w_part" + std::to_string(part);
            const std::string file_path = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
            solver2_dense0_weight_plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            connect<>(solver2_dense0_weight_plios[part].out[0], solver2_dense0.inA[part]);
        }

        connect_layer_weights(solver2_dense1_weight_plios, solver2_dense1, "solver2_dense1_w_part", SUBSOLVER0_DENSE1_WEIGHTS_PREFIX);
        connect_layer_weights(solver2_dense2_weight_plios, solver2_dense2, "solver2_dense2_w_part", SUBSOLVER0_DENSE2_WEIGHTS_PREFIX);
        connect_layer_weights(solver2_dense3_weight_plios, solver2_dense3, "solver2_dense3_w_part", SUBSOLVER0_DENSE3_WEIGHTS_PREFIX);

        for (kernel* bias : {&solver2_bias0, &solver2_bias1, &solver2_bias2, &solver2_bias3}) {
            *bias = make_bias_kernel();
        }
        for (kernel* relu : {&solver2_relu0, &solver2_relu1, &solver2_relu2, &solver2_relu3}) {
            *relu = make_relu_kernel();
        }
        for (kernel* split : {&solver2_split0, &solver2_split1, &solver2_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver2_bias0_rtp, solver2_bias0.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense0.out[0], solver2_bias0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias0.out[0], solver2_relu0.in[0]);
        
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_relu0.out[0], solver2_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split0.out[0], solver2_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split0.out[1], solver2_dense1.inB[1]);

        connect<parameter>(solver2_bias1_rtp, solver2_bias1.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense1.out[0], solver2_bias1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias1.out[0], solver2_relu1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_relu1.out[0], solver2_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split1.out[0], solver2_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split1.out[1], solver2_dense2.inB[1]);

        connect<parameter>(solver2_bias2_rtp, solver2_bias2.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense2.out[0], solver2_bias2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias2.out[0], solver2_relu2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_relu2.out[0], solver2_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split2.out[0], solver2_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split2.out[1], solver2_dense3.inB[1]);

        connect<parameter>(solver2_bias3_rtp, solver2_bias3.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense3.out[0], solver2_bias3.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias3.out[0], solver2_relu3.in[0]);


        // // Solver 2 -------------------------------------------------
        solver3_rollconcat = kernel::create(roll_concat_kernel);
        source(solver3_rollconcat)  = "roll_concat.cpp";
        headers(solver3_rollconcat) = {"roll_concat.h"};

        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_relu3.out[0], solver3_rollconcat.in[0]);
        dimensions(solver3_rollconcat.in[0])  = {HIDDEN_SIZE};
        dimensions(solver3_rollconcat.out[0]) = {ROLL_CONCAT_TOTAL};

        solver3_roll_buf = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, SUBSOLVER0_INPUT_PARTS);
        connect<>(solver3_rollconcat.out[0], solver3_roll_buf.in[0]);

        write_access(solver3_roll_buf.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });

        for (int i = 0; i < SUBSOLVER0_INPUT_PARTS; ++i) {
            connect<>(solver3_roll_buf.out[i], solver3_dense0.inB[i]);
            read_access(solver3_roll_buf.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}
            });
        }

        for (std::size_t part = 0; part < solver3_dense0_weight_plios.size(); ++part) {
            const std::string plio_name = "solver3_dense0_w_part" + std::to_string(part);
            const std::string file_path = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
            solver3_dense0_weight_plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            connect<>(solver3_dense0_weight_plios[part].out[0], solver3_dense0.inA[part]);
        }

        connect_layer_weights(solver3_dense1_weight_plios, solver3_dense1, "solver3_dense1_w_part", SUBSOLVER0_DENSE1_WEIGHTS_PREFIX);
        connect_layer_weights(solver3_dense2_weight_plios, solver3_dense2, "solver3_dense2_w_part", SUBSOLVER0_DENSE2_WEIGHTS_PREFIX);
        connect_layer_weights(solver3_dense3_weight_plios, solver3_dense3, "solver3_dense3_w_part", SUBSOLVER0_DENSE3_WEIGHTS_PREFIX);

        for (kernel* bias : {&solver3_bias0, &solver3_bias1, &solver3_bias2, &solver3_bias3}) {
            *bias = make_bias_kernel();
        }
        for (kernel* relu : {&solver3_relu0, &solver3_relu1, &solver3_relu2, &solver3_relu3}) {
            *relu = make_relu_kernel();
        }
        for (kernel* split : {&solver3_split0, &solver3_split1, &solver3_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver3_bias0_rtp, solver3_bias0.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_dense0.out[0], solver3_bias0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_bias0.out[0], solver3_relu0.in[0]);
        
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_relu0.out[0], solver3_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver3_split0.out[0], solver3_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver3_split0.out[1], solver3_dense1.inB[1]);

        connect<parameter>(solver3_bias1_rtp, solver3_bias1.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_dense1.out[0], solver3_bias1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_bias1.out[0], solver3_relu1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_relu1.out[0], solver3_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver3_split1.out[0], solver3_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver3_split1.out[1], solver3_dense2.inB[1]);

        connect<parameter>(solver3_bias2_rtp, solver3_bias2.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_dense2.out[0], solver3_bias2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_bias2.out[0], solver3_relu2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_relu2.out[0], solver3_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver3_split2.out[0], solver3_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver3_split2.out[1], solver3_dense3.inB[1]);

        connect<parameter>(solver3_bias3_rtp, solver3_bias3.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_dense3.out[0], solver3_bias3.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver3_bias3.out[0], solver3_relu3.in[0]);

        connect<parameter>(output_matrixA_rtp, output_dense0.matrixA[0]);
        auto solver2_to_output = connect<window<WINDOW_BYTES_HIDDEN>>(solver3_relu3.out[0], output_dense0.inB[0]);
        adf::fifo_depth(solver2_to_output) = DEFAULT_FIFO_DEPTH;

        connect<window<WINDOW_BYTES_OUTPUT_PAD>>(output_dense0.out[0], pipeline_out.in[0]);

        apply_layout();
    }

private:
    void apply_layout();
};

#include "graph_layout.hpp"
