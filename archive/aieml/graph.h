#pragma once
#include <adf.h>
#include <array>
#include <string>
#include <utility>

#include "nn_defs10.h"
#include "data_paths.h"
#include "data_types.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"

#include "bias_relu_fused.h"
#include "window_split_128_to_64x2.h"
#include "roll_concat.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

constexpr unsigned WINDOW_BYTES_HIDDEN = HIDDEN_SIZE * sizeof(DATA_TYPE);
constexpr unsigned EMBED_DENSE0_WEIGHTS_TOTAL = HIDDEN_SIZE * INPUT_SIZE;
constexpr unsigned EMBED_DENSE1_WEIGHTS_TOTAL = OUTPUT_SIZE * HIDDEN_SIZE;
constexpr unsigned EMBED_DENSE1_WEIGHTS_PER_PART = EMBED_DENSE1_WEIGHTS_TOTAL / EMBED_DENSE1_CASC_LEN;
static_assert(EMBED_DENSE1_WEIGHTS_PER_PART * EMBED_DENSE1_CASC_LEN == EMBED_DENSE1_WEIGHTS_TOTAL,
              "EMBED_DENSE1 weights must divide evenly across cascades");

constexpr unsigned SOLVER_DENSE0_WEIGHTS_TOTAL = HIDDEN_SIZE * SUBSOLVER0_INPUT_SIZE;
constexpr unsigned SOLVER_DENSE0_WEIGHTS_PER_PART = SOLVER_DENSE0_WEIGHTS_TOTAL / SOLVER_DENSE0_CASC_LEN;
static_assert(SOLVER_DENSE0_WEIGHTS_PER_PART * SOLVER_DENSE0_CASC_LEN == SOLVER_DENSE0_WEIGHTS_TOTAL,
              "Solver dense0 weights must divide evenly across cascades");

constexpr unsigned SOLVER_DENSEX_WEIGHTS_TOTAL = OUTPUT_SIZE * HIDDEN_SIZE;
constexpr unsigned SOLVER_DENSEX_WEIGHTS_PER_PART = SOLVER_DENSEX_WEIGHTS_TOTAL / SOLVER_DENSEX_CASC_LEN;
static_assert(SOLVER_DENSEX_WEIGHTS_PER_PART * SOLVER_DENSEX_CASC_LEN == SOLVER_DENSEX_WEIGHTS_TOTAL,
              "Solver denseX weights must divide evenly across cascades");
constexpr unsigned WINDOW_BYTES_HALF_HIDDEN = HIDDEN_SPLIT_SIZE * sizeof(DATA_TYPE);
constexpr unsigned WINDOW_BYTES_ROLL_CONCAT = ROLL_CONCAT_TOTAL * sizeof(DATA_TYPE);


constexpr unsigned DEFAULT_FIFO_DEPTH = 8U;
constexpr unsigned GMIO_WEIGHT_BURST_BYTES = 64U;
constexpr unsigned GMIO_WEIGHT_BANDWIDTH_MBPS = 256U;
constexpr unsigned GMIO_ACTIVATION_BURST_BYTES = 64U;
constexpr unsigned GMIO_ACTIVATION_BANDWIDTH_MBPS = 256U;

// VECTOR_BITS, ALIGNMENT_ELEMENTS, GRAPH_INPUT_SIZE now live in common/data_types.h
// (shared with the host so weight/GMIO sizing stays in lock-step with the kernel).

template<
    unsigned Rows,
    unsigned Cols,
    unsigned CascLen,
    unsigned UseMatrixReload,
    unsigned DimALeading = 1,
    unsigned Shift = 0,
    unsigned Rnd = rnd_floor,
    unsigned NumFrames = 1,
    unsigned Saturation = 0,
    unsigned Ssr = 1,
    unsigned Api = 0,
    unsigned DualIp = 0,
    unsigned NumOutputs = 1>
using dense_matrix_graph = matrix_vector_mul_graph<
    DATA_TYPE,
    DATA_TYPE,
    Rows,
    Cols,
    Shift,
    Rnd,
    NumFrames,
    CascLen,
    Saturation,
    Ssr,
    DimALeading,
    UseMatrixReload,
    Api,
    DualIp,
    NumOutputs>;

    // Use GRAPH_INPUT_SIZE instead of INPUT_SIZE for the template instantiation
    using embed_dense0_graph = dense_matrix_graph<HIDDEN_SIZE, GRAPH_INPUT_SIZE, EMBED_DENSE0_CASC_LEN, 1>;
    using embed_dense1_graph = dense_matrix_graph<OUTPUT_SIZE, HIDDEN_SIZE, EMBED_DENSE1_CASC_LEN, 1>;
    using solver_dense0_graph = dense_matrix_graph<HIDDEN_SIZE, SUBSOLVER0_INPUT_SIZE, SOLVER_DENSE0_CASC_LEN, 1>;
    using solver_dense_graph = dense_matrix_graph<OUTPUT_SIZE, HIDDEN_SIZE, SOLVER_DENSEX_CASC_LEN, 1>;

class NeuralNetworkGraph : public graph {
    public:

    embed_dense0_graph          embed_dense0;
    kernel                      embed_bias_relu0;
    input_gmio                  embed_input_gmio;
    input_port                  embed_matrixA0_rtp;
    output_plio                 embed_output_plio;
    input_port                  embed_bias0_rtp;
    kernel                      embed_split0;
    embed_dense1_graph          embed_dense1;
    input_port                  embed_matrixA1_0_rtp;
    input_port                  embed_matrixA1_1_rtp;
    kernel                      embed_bias_relu1;
    input_port                  embed_bias1_rtp;


    adf::shared_buffer<DATA_TYPE>   	solver0_roll_buf;
    kernel                              solver0_rollconcat;
    solver_dense0_graph             solver0_dense0;
    kernel                      	solver0_bias_relu0;
    kernel                      	solver0_split0;
    solver_dense_graph              solver0_dense1;
    kernel                      	solver0_bias_relu1;
    kernel                      	solver0_split1;
    solver_dense_graph              solver0_dense2;
    kernel                      	solver0_bias_relu2;
    kernel                      	solver0_split2;
    solver_dense_graph              solver0_dense3;
    kernel                      	solver0_bias_relu3;
    input_port                  	solver0_bias0_rtp;
    input_port                  	solver0_bias1_rtp;
    input_port                  	solver0_bias2_rtp;
    input_port                  	solver0_bias3_rtp;
    std::array<input_port, SUBSOLVER0_INPUT_PARTS> solver0_dense0_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver0_dense1_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver0_dense2_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver0_dense3_matrixA_rtp;


    adf::shared_buffer<DATA_TYPE>   	solver1_roll_buf;
    kernel                              solver1_rollconcat;
    solver_dense0_graph             solver1_dense0;
    kernel                      	solver1_bias_relu0;
    kernel                      	solver1_split0;
    solver_dense_graph              solver1_dense1;
    kernel                      	solver1_bias_relu1;
    kernel                      	solver1_split1;
    solver_dense_graph              solver1_dense2;
    kernel                      	solver1_bias_relu2;
    kernel                      	solver1_split2;
    solver_dense_graph              solver1_dense3;
    kernel                      	solver1_bias_relu3;
    input_port                  	solver1_bias0_rtp;
    input_port                  	solver1_bias1_rtp;
    input_port                  	solver1_bias2_rtp;
    input_port                  	solver1_bias3_rtp;
    std::array<input_port, SUBSOLVER0_INPUT_PARTS> solver1_dense0_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver1_dense1_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver1_dense2_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver1_dense3_matrixA_rtp;


    adf::shared_buffer<DATA_TYPE>   	solver2_roll_buf;
    kernel                              solver2_rollconcat;
    solver_dense0_graph             solver2_dense0;
    kernel                      	solver2_bias_relu0;
    kernel                      	solver2_split0;
    solver_dense_graph              solver2_dense1;
    kernel                      	solver2_bias_relu1;
    kernel                      	solver2_split1;
    solver_dense_graph              solver2_dense2;
    kernel                      	solver2_bias_relu2;
    kernel                      	solver2_split2;
    solver_dense_graph              solver2_dense3;
    kernel                      	solver2_bias_relu3;
    input_port                  	solver2_bias0_rtp;
    input_port                  	solver2_bias1_rtp;
    input_port                  	solver2_bias2_rtp;
    input_port                  	solver2_bias3_rtp;
    std::array<input_port, SUBSOLVER0_INPUT_PARTS> solver2_dense0_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver2_dense1_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver2_dense2_matrixA_rtp;
    std::array<input_port, SUBSOLVER0_LAYER_WEIGHTS_PARTS> solver2_dense3_matrixA_rtp;


    NeuralNetworkGraph() {

        const auto make_bias_relu_kernel = []() {
            kernel k = kernel::create(bias_add_leaky_relu_kernel);
            source(k)  = "bias_relu_fused.cpp";
            headers(k) = {"bias_relu_fused.h"};
            return k;
        };
        const auto make_split_kernel = []() {
            kernel k = kernel::create(window_split_128_to_64x2);
            source(k)  = "window_split_128_to_64x2.cpp";
            headers(k) = {"window_split_128_to_64x2.h"};
            return k;
        };

        embed_input_gmio = input_gmio::create("embed_input_gmio", GMIO_ACTIVATION_BURST_BYTES, GMIO_ACTIVATION_BANDWIDTH_MBPS);

        std::string base_path = std::string(DATA_DIR);
        embed_output_plio = output_plio::create("embed_output", plio_32_bits,
                                                (base_path + "/" + AIEML10_OUTPUT_FILE).c_str());

        connect<>(embed_input_gmio.out[0], embed_dense0.inB[0]);
        connect<parameter>(embed_matrixA0_rtp, async(embed_dense0.matrixA[0]));

        embed_bias_relu0 = make_bias_relu_kernel();
        
        embed_split0 = make_split_kernel();
        embed_bias_relu1 = make_bias_relu_kernel();

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_dense0.out[0], embed_bias_relu0.in[0]);
        connect<parameter>(embed_bias0_rtp, async(embed_bias_relu0.in[1]));

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias_relu0.out[0], embed_split0.in[0]);

        auto embed_split_leg0 = connect<window<WINDOW_BYTES_HALF_HIDDEN>>(embed_split0.out[0], embed_dense1.inB[0]);
        auto embed_split_leg1 = connect<window<WINDOW_BYTES_HALF_HIDDEN>>(embed_split0.out[1], embed_dense1.inB[1]);
        adf::fifo_depth(embed_split_leg0) = DEFAULT_FIFO_DEPTH;
        adf::fifo_depth(embed_split_leg1) = DEFAULT_FIFO_DEPTH;

        connect<parameter>(embed_matrixA1_0_rtp, async(embed_dense1.matrixA[0]));
        connect<parameter>(embed_matrixA1_1_rtp, async(embed_dense1.matrixA[1]));

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_dense1.out[0], embed_bias_relu1.in[0]);
        connect<parameter>(embed_bias1_rtp, async(embed_bias_relu1.in[1]));



        solver0_rollconcat = kernel::create(roll_concat_kernel);
        source(solver0_rollconcat)  = "roll_concat.cpp";
        headers(solver0_rollconcat) = {"roll_concat.h"};

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias_relu1.out[0], solver0_rollconcat.in[0]);

        solver0_roll_buf = shared_buffer<DATA_TYPE>::create({ROLL_CONCAT_TOTAL}, 1, SUBSOLVER0_INPUT_PARTS);
        connect<window<WINDOW_BYTES_ROLL_CONCAT>>(solver0_rollconcat.out[0], solver0_roll_buf.in[0]);

        write_access(solver0_roll_buf.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });

        for (int i = 0; i < SUBSOLVER0_INPUT_PARTS; ++i) {
            connect<>(solver0_roll_buf.out[i], solver0_dense0.inB[i]);
            read_access(solver0_roll_buf.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}
            });
        }


        for (int part = 0; part < SUBSOLVER0_INPUT_PARTS; ++part) {
            connect<parameter>(solver0_dense0_matrixA_rtp[part], async(solver0_dense0.matrixA[part]));
        }

        for (int part = 0; part < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++part) {
            connect<parameter>(solver0_dense1_matrixA_rtp[part], async(solver0_dense1.matrixA[part]));
            connect<parameter>(solver0_dense2_matrixA_rtp[part], async(solver0_dense2.matrixA[part]));
            connect<parameter>(solver0_dense3_matrixA_rtp[part], async(solver0_dense3.matrixA[part]));
        }

        for (kernel* br : {&solver0_bias_relu0, &solver0_bias_relu1, &solver0_bias_relu2, &solver0_bias_relu3}) {
            *br = make_bias_relu_kernel();
        }
        for (kernel* split : {&solver0_split0, &solver0_split1, &solver0_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver0_bias0_rtp, async(solver0_bias_relu0.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_dense0.out[0], solver0_bias_relu0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu0.out[0], solver0_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split0.out[0], solver0_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split0.out[1], solver0_dense1.inB[1]);


        connect<parameter>(solver0_bias1_rtp, async(solver0_bias_relu1.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_dense1.out[0], solver0_bias_relu1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu1.out[0], solver0_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split1.out[0], solver0_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split1.out[1], solver0_dense2.inB[1]);

        connect<parameter>(solver0_bias2_rtp, async(solver0_bias_relu2.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_dense2.out[0], solver0_bias_relu2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu2.out[0], solver0_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split2.out[0], solver0_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split2.out[1], solver0_dense3.inB[1]);

        connect<parameter>(solver0_bias3_rtp, async(solver0_bias_relu3.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_dense3.out[0], solver0_bias_relu3.in[0]);


        // =====================================================================
        // Solver1 block  (solver0_bias_relu3 → rollconcat → dense0..3 chain)
        // =====================================================================
        solver1_rollconcat = kernel::create(roll_concat_kernel_1);
        source(solver1_rollconcat)  = "roll_concat.cpp";
        headers(solver1_rollconcat) = {"roll_concat.h"};

        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu3.out[0], solver1_rollconcat.in[0]);

        solver1_roll_buf = shared_buffer<DATA_TYPE>::create({ROLL_CONCAT_TOTAL}, 1, SUBSOLVER0_INPUT_PARTS);
        connect<window<WINDOW_BYTES_ROLL_CONCAT>>(solver1_rollconcat.out[0], solver1_roll_buf.in[0]);

        write_access(solver1_roll_buf.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });

        for (int i = 0; i < SUBSOLVER0_INPUT_PARTS; ++i) {
            connect<>(solver1_roll_buf.out[i], solver1_dense0.inB[i]);
            read_access(solver1_roll_buf.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}
            });
        }

        for (int part = 0; part < SUBSOLVER0_INPUT_PARTS; ++part) {
            connect<parameter>(solver1_dense0_matrixA_rtp[part], async(solver1_dense0.matrixA[part]));
        }

        for (int part = 0; part < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++part) {
            connect<parameter>(solver1_dense1_matrixA_rtp[part], async(solver1_dense1.matrixA[part]));
            connect<parameter>(solver1_dense2_matrixA_rtp[part], async(solver1_dense2.matrixA[part]));
            connect<parameter>(solver1_dense3_matrixA_rtp[part], async(solver1_dense3.matrixA[part]));
        }

        for (kernel* br : {&solver1_bias_relu0, &solver1_bias_relu1, &solver1_bias_relu2, &solver1_bias_relu3}) {
            *br = make_bias_relu_kernel();
        }
        for (kernel* split : {&solver1_split0, &solver1_split1, &solver1_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver1_bias0_rtp, async(solver1_bias_relu0.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_dense0.out[0], solver1_bias_relu0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_bias_relu0.out[0], solver1_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split0.out[0], solver1_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split0.out[1], solver1_dense1.inB[1]);

        connect<parameter>(solver1_bias1_rtp, async(solver1_bias_relu1.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_dense1.out[0], solver1_bias_relu1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_bias_relu1.out[0], solver1_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split1.out[0], solver1_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split1.out[1], solver1_dense2.inB[1]);

        connect<parameter>(solver1_bias2_rtp, async(solver1_bias_relu2.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_dense2.out[0], solver1_bias_relu2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_bias_relu2.out[0], solver1_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split2.out[0], solver1_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split2.out[1], solver1_dense3.inB[1]);

        connect<parameter>(solver1_bias3_rtp, async(solver1_bias_relu3.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_dense3.out[0], solver1_bias_relu3.in[0]);

        // =====================================================================
        // Solver2 block  (solver1_bias_relu3 → rollconcat → dense0..3 chain)
        // =====================================================================
        solver2_rollconcat = kernel::create(roll_concat_kernel_2);
        source(solver2_rollconcat)  = "roll_concat.cpp";
        headers(solver2_rollconcat) = {"roll_concat.h"};

        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_bias_relu3.out[0], solver2_rollconcat.in[0]);

        solver2_roll_buf = shared_buffer<DATA_TYPE>::create({ROLL_CONCAT_TOTAL}, 1, SUBSOLVER0_INPUT_PARTS);
        connect<window<WINDOW_BYTES_ROLL_CONCAT>>(solver2_rollconcat.out[0], solver2_roll_buf.in[0]);

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

        for (int part = 0; part < SUBSOLVER0_INPUT_PARTS; ++part) {
            connect<parameter>(solver2_dense0_matrixA_rtp[part], async(solver2_dense0.matrixA[part]));
        }

        for (int part = 0; part < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++part) {
            connect<parameter>(solver2_dense1_matrixA_rtp[part], async(solver2_dense1.matrixA[part]));
            connect<parameter>(solver2_dense2_matrixA_rtp[part], async(solver2_dense2.matrixA[part]));
            connect<parameter>(solver2_dense3_matrixA_rtp[part], async(solver2_dense3.matrixA[part]));
        }

        for (kernel* br : {&solver2_bias_relu0, &solver2_bias_relu1, &solver2_bias_relu2, &solver2_bias_relu3}) {
            *br = make_bias_relu_kernel();
        }
        for (kernel* split : {&solver2_split0, &solver2_split1, &solver2_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver2_bias0_rtp, async(solver2_bias_relu0.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense0.out[0], solver2_bias_relu0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias_relu0.out[0], solver2_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split0.out[0], solver2_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split0.out[1], solver2_dense1.inB[1]);

        connect<parameter>(solver2_bias1_rtp, async(solver2_bias_relu1.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense1.out[0], solver2_bias_relu1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias_relu1.out[0], solver2_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split1.out[0], solver2_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split1.out[1], solver2_dense2.inB[1]);

        connect<parameter>(solver2_bias2_rtp, async(solver2_bias_relu2.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense2.out[0], solver2_bias_relu2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias_relu2.out[0], solver2_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split2.out[0], solver2_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split2.out[1], solver2_dense3.inB[1]);

        connect<parameter>(solver2_bias3_rtp, async(solver2_bias_relu3.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense3.out[0], solver2_bias_relu3.in[0]);

        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias_relu3.out[0], embed_output_plio.in[0]);

        apply_layout();
    }

private:
    void apply_layout();
};

#include "graph_layout.hpp"