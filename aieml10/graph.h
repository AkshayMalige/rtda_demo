#pragma once
#include <adf.h>
#include <array>
#include <string>
#include <utility>

#include "nn_defs10.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"

#include "bias_relu_fused.h"
#include "window_split_128_to_64x2.h"
#include "roll_concat.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

constexpr unsigned WINDOW_BYTES_HIDDEN = bytes_per_vector(HIDDEN_SIZE);
constexpr unsigned WINDOW_BYTES_HALF_HIDDEN = bytes_per_vector(HIDDEN_SPLIT_SIZE);
constexpr unsigned WINDOW_BYTES_OUTPUT_PAD = bytes_per_vector(OUTPUT_DENSE0_OUT_PAD);

constexpr unsigned DEFAULT_FIFO_DEPTH = 8U;

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
    float,
    float,
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

using embed_dense0_graph = dense_matrix_graph<HIDDEN_SIZE, INPUT_SIZE, EMBED_DENSE0_CASC_LEN, 0>;
using embed_dense1_graph = dense_matrix_graph<OUTPUT_SIZE, HIDDEN_SIZE, EMBED_DENSE1_CASC_LEN, 0>;
using solver_dense0_graph = dense_matrix_graph<HIDDEN_SIZE, SUBSOLVER0_INPUT_SIZE, SOLVER_DENSE0_CASC_LEN, 0>;
using solver_dense_graph = dense_matrix_graph<OUTPUT_SIZE, HIDDEN_SIZE, SOLVER_DENSEX_CASC_LEN, 0>;
using output_dense0_graph = dense_matrix_graph<OUTPUT_DENSE0_OUT_PAD, HIDDEN_SIZE, OUTPUT_DENSE0_CASC_LEN, 1>;

class NeuralNetworkGraph : public graph {
public:

    input_plio                  pipeline_in;
    output_plio                 pipeline_out;


    embed_dense0_graph          embed_dense0;
    kernel                      embed_bias_relu0;
    kernel                      embed_split0;
    embed_dense1_graph          embed_dense1;
    kernel                      embed_bias_relu1;
    input_plio                  embed_layer0_weights;
    input_port                  embed_bias0_rtp;
    input_port                  embed_bias1_rtp;
    std::array<input_plio, EMBED_DENSE1_CASC_LEN> embed_dense1_weight_plios;



    kernel                      	solver0_rollconcat;
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
    adf::shared_buffer<float>   	solver0_roll_buf;
    std::array<input_plio, SUBSOLVER0_INPUT_PARTS>         			solver0_dense0_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver0_dense1_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver0_dense2_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver0_dense3_weight_plios;



    kernel                      	solver1_rollconcat;
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
    adf::shared_buffer<float>   	solver1_roll_buf;
    std::array<input_plio, SUBSOLVER0_INPUT_PARTS>         			solver1_dense0_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver1_dense1_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver1_dense2_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver1_dense3_weight_plios;


    kernel                      	solver2_rollconcat;
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
    adf::shared_buffer<float>   	solver2_roll_buf;
    std::array<input_plio, SUBSOLVER0_INPUT_PARTS>         			solver2_dense0_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver2_dense1_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver2_dense2_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS> 	solver2_dense3_weight_plios;


    output_dense0_graph         output_dense0;
    input_port                  	output_matrixA_rtp;


    NeuralNetworkGraph() {
        const std::string base_path = DATA_DIR;

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

        pipeline_in = input_plio::create("aieml10_in", plio_32_bits,
                                         (base_path + "/" + EMBED_INPUT_DATA).c_str());
        pipeline_out = output_plio::create("aieml10_out", plio_32_bits,
                                           (base_path + "/" + AIEML10_OUTPUT_FILE).c_str());

        embed_layer0_weights = input_plio::create("embed_layer0_weights", plio_32_bits, (base_path + "/" + EMBED_DENSE0_WEIGHTS).c_str());

        connect<>(embed_layer0_weights.out[0], embed_dense0.inA[0]);
        connect<>(pipeline_in.out[0], embed_dense0.inB[0]);

        embed_bias_relu0 = make_bias_relu_kernel();
        embed_bias_relu1 = make_bias_relu_kernel();
        embed_split0 = make_split_kernel();

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_dense0.out[0], embed_bias_relu0.in[0]);
        connect<parameter>(embed_bias0_rtp, embed_bias_relu0.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias_relu0.out[0], embed_split0.in[0]);

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

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_dense1.out[0], embed_bias_relu1.in[0]);
        connect<parameter>(embed_bias1_rtp, embed_bias_relu1.in[1]);

        // // Solver 0 -------------------------------------------------

        solver0_rollconcat = kernel::create(roll_concat_kernel);
        source(solver0_rollconcat)  = "roll_concat.cpp";
        headers(solver0_rollconcat) = {"roll_concat.h"};

        connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias_relu1.out[0], solver0_rollconcat.in[0]);
        dimensions(solver0_rollconcat.in[0])  = {HIDDEN_SIZE};
        dimensions(solver0_rollconcat.out[0]) = {ROLL_CONCAT_TOTAL};

        solver0_roll_buf = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, SUBSOLVER0_INPUT_PARTS);
        connect<>(solver0_rollconcat.out[0], solver0_roll_buf.in[0]);

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

        for (std::size_t part = 0; part < solver0_dense0_weight_plios.size(); ++part) {
            const std::string plio_name = "solver0_dense0_w_part" + std::to_string(part);
            const std::string file_path = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
            solver0_dense0_weight_plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            connect<>(solver0_dense0_weight_plios[part].out[0], solver0_dense0.inA[part]);
        }

        const auto connect_layer_weights = [&](auto& plios, auto& dense, const std::string& name_prefix, const std::string& file_prefix) {
            for (std::size_t part = 0; part < plios.size(); ++part) {
                const std::string plio_name = name_prefix + std::to_string(part);
                const std::string file_path = base_path + "/" + file_prefix + std::to_string(part) + ".txt";
                plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
                connect<>(plios[part].out[0], dense.inA[part]);
            }
        };

        connect_layer_weights(solver0_dense1_weight_plios, solver0_dense1, "solver0_dense1_w_part", SUBSOLVER0_DENSE1_WEIGHTS_PREFIX);
        connect_layer_weights(solver0_dense2_weight_plios, solver0_dense2, "solver0_dense2_w_part", SUBSOLVER0_DENSE2_WEIGHTS_PREFIX);
        connect_layer_weights(solver0_dense3_weight_plios, solver0_dense3, "solver0_dense3_w_part", SUBSOLVER0_DENSE3_WEIGHTS_PREFIX);

        for (kernel* br : {&solver0_bias_relu0, &solver0_bias_relu1, &solver0_bias_relu2, &solver0_bias_relu3}) {
            *br = make_bias_relu_kernel();
        }
        for (kernel* split : {&solver0_split0, &solver0_split1, &solver0_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver0_bias0_rtp, solver0_bias_relu0.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_dense0.out[0], solver0_bias_relu0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu0.out[0], solver0_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split0.out[0], solver0_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split0.out[1], solver0_dense1.inB[1]);


        connect<parameter>(solver0_bias1_rtp, solver0_bias_relu1.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_dense1.out[0], solver0_bias_relu1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu1.out[0], solver0_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split1.out[0], solver0_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split1.out[1], solver0_dense2.inB[1]);

        connect<parameter>(solver0_bias2_rtp, solver0_bias_relu2.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_dense2.out[0], solver0_bias_relu2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu2.out[0], solver0_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split2.out[0], solver0_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver0_split2.out[1], solver0_dense3.inB[1]);

        connect<parameter>(solver0_bias3_rtp, solver0_bias_relu3.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_dense3.out[0], solver0_bias_relu3.in[0]);

        // // // Solver 1 -------------------------------------------------
      
        solver1_rollconcat = kernel::create(roll_concat_kernel);
        source(solver1_rollconcat)  = "roll_concat.cpp";
        headers(solver1_rollconcat) = {"roll_concat.h"};

        connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu3.out[0], solver1_rollconcat.in[0]);
        // connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias_relu1.out[0], solver1_rollconcat.in[0]);
        dimensions(solver1_rollconcat.in[0])  = {HIDDEN_SIZE};
        dimensions(solver1_rollconcat.out[0]) = {ROLL_CONCAT_TOTAL};

        solver1_roll_buf = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, SUBSOLVER0_INPUT_PARTS);
        connect<>(solver1_rollconcat.out[0], solver1_roll_buf.in[0]);

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

        for (std::size_t part = 0; part < solver1_dense0_weight_plios.size(); ++part) {
            const std::string plio_name = "solver1_dense0_w_part" + std::to_string(part);
            const std::string file_path = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
            solver1_dense0_weight_plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            connect<>(solver1_dense0_weight_plios[part].out[0], solver1_dense0.inA[part]);
        }

        connect_layer_weights(solver1_dense1_weight_plios, solver1_dense1, "solver1_dense1_w_part", SUBSOLVER1_DENSE1_WEIGHTS_PREFIX);
        connect_layer_weights(solver1_dense2_weight_plios, solver1_dense2, "solver1_dense2_w_part", SUBSOLVER1_DENSE2_WEIGHTS_PREFIX);
        connect_layer_weights(solver1_dense3_weight_plios, solver1_dense3, "solver1_dense3_w_part", SUBSOLVER1_DENSE3_WEIGHTS_PREFIX);

        for (kernel* br : {&solver1_bias_relu0, &solver1_bias_relu1, &solver1_bias_relu2, &solver1_bias_relu3}) {
            *br = make_bias_relu_kernel();
        }
        for (kernel* split : {&solver1_split0, &solver1_split1, &solver1_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver1_bias0_rtp, solver1_bias_relu0.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_dense0.out[0], solver1_bias_relu0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_bias_relu0.out[0], solver1_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split0.out[0], solver1_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split0.out[1], solver1_dense1.inB[1]);

        connect<parameter>(solver1_bias1_rtp, solver1_bias_relu1.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_dense1.out[0], solver1_bias_relu1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_bias_relu1.out[0], solver1_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split1.out[0], solver1_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split1.out[1], solver1_dense2.inB[1]);

        connect<parameter>(solver1_bias2_rtp, solver1_bias_relu2.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_dense2.out[0], solver1_bias_relu2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_bias_relu2.out[0], solver1_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split2.out[0], solver1_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver1_split2.out[1], solver1_dense3.inB[1]);

        connect<parameter>(solver1_bias3_rtp, solver1_bias_relu3.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_dense3.out[0], solver1_bias_relu3.in[0]);


        // // // // Solver 2 -------------------------------------------------
        
        solver2_rollconcat = kernel::create(roll_concat_kernel);
        source(solver2_rollconcat)  = "roll_concat.cpp";
        headers(solver2_rollconcat) = {"roll_concat.h"};
        connect<window<WINDOW_BYTES_HIDDEN>>(solver1_bias_relu3.out[0], solver2_rollconcat.in[0]);
        // connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias_relu1.out[0], solver2_rollconcat.in[0]);
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

        connect_layer_weights(solver2_dense1_weight_plios, solver2_dense1, "solver2_dense1_w_part", SUBSOLVER2_DENSE1_WEIGHTS_PREFIX);
        connect_layer_weights(solver2_dense2_weight_plios, solver2_dense2, "solver2_dense2_w_part", SUBSOLVER2_DENSE2_WEIGHTS_PREFIX);
        connect_layer_weights(solver2_dense3_weight_plios, solver2_dense3, "solver2_dense3_w_part", SUBSOLVER2_DENSE3_WEIGHTS_PREFIX);

        for (kernel* br : {&solver2_bias_relu0, &solver2_bias_relu1, &solver2_bias_relu2, &solver2_bias_relu3}) {
            *br = make_bias_relu_kernel();
        }
        for (kernel* split : {&solver2_split0, &solver2_split1, &solver2_split2}) {
            *split = make_split_kernel();
        }

        connect<parameter>(solver2_bias0_rtp, solver2_bias_relu0.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense0.out[0], solver2_bias_relu0.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias_relu0.out[0], solver2_split0.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split0.out[0], solver2_dense1.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split0.out[1], solver2_dense1.inB[1]);

        connect<parameter>(solver2_bias1_rtp, solver2_bias_relu1.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense1.out[0], solver2_bias_relu1.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias_relu1.out[0], solver2_split1.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split1.out[0], solver2_dense2.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split1.out[1], solver2_dense2.inB[1]);

        connect<parameter>(solver2_bias2_rtp, solver2_bias_relu2.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense2.out[0], solver2_bias_relu2.in[0]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias_relu2.out[0], solver2_split2.in[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split2.out[0], solver2_dense3.inB[0]);
        connect<window<WINDOW_BYTES_HALF_HIDDEN>>(solver2_split2.out[1], solver2_dense3.inB[1]);

        connect<parameter>(solver2_bias3_rtp, solver2_bias_relu3.in[1]);
        connect<window<WINDOW_BYTES_HIDDEN>>(solver2_dense3.out[0], solver2_bias_relu3.in[0]);

        
 // // // Output  -------------------------------------------------
     
        connect<parameter>(output_matrixA_rtp, output_dense0.matrixA[0]);
        // auto solver2_to_output = connect<window<WINDOW_BYTES_HIDDEN>>(solver0_bias_relu3.out[0], output_dense0.inB[0]);
        auto solver2_to_output = connect<window<WINDOW_BYTES_HIDDEN>>(solver2_bias_relu3.out[0], output_dense0.inB[0]);
        adf::fifo_depth(solver2_to_output) = DEFAULT_FIFO_DEPTH;
        connect<window<WINDOW_BYTES_OUTPUT_PAD>>(output_dense0.out[0], pipeline_out.in[0]);
        
        // connect<window<WINDOW_BYTES_OUTPUT_PAD>>(solver0_bias_relu3.out[0], pipeline_out.in[0]);

        apply_layout();
    }

private:
    void apply_layout();
};

#include "graph_layout.hpp"
