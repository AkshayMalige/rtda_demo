#pragma once
#include <adf.h>
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

using dense128x32 = matrix_vector_mul_graph<
    float, float,
    32,
    HIDDEN_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_USE_MATRIX_RELOAD,
    TP_API,
    TP_DUAL_IP,
    TP_NUM_OUTPUTS>;

class NeuralNetworkGraph : public graph {
public:
    input_plio  layer0_in;
    dense8x128   embed_dense0;
    dense128x128 embed_dense1;
    dense768x128 solver_dense0;
    dense128x128 solver_dense1;
    dense128x128 solver_dense2;
    dense128x128 solver_dense3;
    dense768x128 solver_dense4;
    dense128x128 solver_dense5;
    dense128x128 solver_dense6;
    dense128x128 solver_dense7;
    dense128x32  output_dense0;
    output_plio layer_out;

    kernel k_bias_embed0;
    kernel k_bias_embed1;
    kernel k_bias_solver0;
    kernel k_bias_solver1;
    kernel k_bias_solver2;
    kernel k_bias_solver3;
    kernel k_bias_solver4;
    kernel k_bias_solver5;
    kernel k_bias_solver6;
    kernel k_bias_solver7;

    kernel k_lrelu_embed0;
    kernel k_lrelu_embed1;
    kernel k_lrelu_solver0;
    kernel k_lrelu_solver1;
    kernel k_lrelu_solver2;
    kernel k_lrelu_solver3;
    kernel k_lrelu_solver4;
    kernel k_lrelu_solver5;
    kernel k_lrelu_solver6;
    kernel k_lrelu_solver7;

    kernel k_wsplit_embed0;
    kernel k_wsplit_solver0;
    kernel k_wsplit_solver1;
    kernel k_wsplit_solver2;
    kernel k_wsplit_solver3;
    kernel k_wsplit_solver4;
    kernel k_wsplit_solver5;

    kernel k_rollconcat;
    kernel k_rollconcat1;

    shared_buffer<float> roll_concat_buffer;
    shared_buffer<float> roll_concat_buffer1;

    input_port matrixA_embed0_rtp;
    input_port bias_embed0_rtp;
    input_port matrixA_embed1_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_embed1_rtp;

    input_port matrixA_solver0_rtp[TP_CASC_LEN_LAYER3];
    input_port bias_solver0_rtp;
    input_port matrixA_solver1_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_solver1_rtp;
    input_port matrixA_solver2_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_solver2_rtp;
    input_port matrixA_solver3_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_solver3_rtp;
    input_port matrixA_solver4_rtp[TP_CASC_LEN_LAYER3];
    input_port bias_solver4_rtp;
    input_port matrixA_solver5_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_solver5_rtp;
    input_port matrixA_solver6_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_solver6_rtp;
    input_port matrixA_solver7_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_solver7_rtp;

    input_port matrixA_output0_rtp;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer0_in = input_plio::create("layer0_in", plio_32_bits,
                                       (base_path + "/" + EMBED_INPUT_DATA).c_str());
        layer_out = output_plio::create("layer_out", plio_32_bits,
                                        (base_path + "/" + OUTPUT_DENSE0_OUTPUT).c_str());

        connect<parameter>(matrixA_embed0_rtp, embed_dense0.matrixA[0]);
        connect<>(layer0_in.out[0], embed_dense0.inB[0]);

        k_bias_embed0 = kernel::create(bias_add_kernel);
        source(k_bias_embed0) = "bias_add.cpp";
        headers(k_bias_embed0) = {"bias_add.h"};
        runtime<ratio>(k_bias_embed0) = 1.0;

        k_bias_embed1 = kernel::create(bias_add_kernel);
        source(k_bias_embed1) = "bias_add.cpp";
        headers(k_bias_embed1) = {"bias_add.h"};
        runtime<ratio>(k_bias_embed1) = 1.0;

        k_bias_solver0 = kernel::create(bias_add_kernel);
        source(k_bias_solver0) = "bias_add.cpp";
        headers(k_bias_solver0) = {"bias_add.h"};
        runtime<ratio>(k_bias_solver0) = 1.0;

        k_bias_solver1 = kernel::create(bias_add_kernel);
        source(k_bias_solver1) = "bias_add.cpp";
        headers(k_bias_solver1) = {"bias_add.h"};
        runtime<ratio>(k_bias_solver1) = 1.0;

        k_bias_solver2 = kernel::create(bias_add_kernel);
        source(k_bias_solver2) = "bias_add.cpp";
        headers(k_bias_solver2) = {"bias_add.h"};
        runtime<ratio>(k_bias_solver2) = 1.0;

        k_bias_solver3 = kernel::create(bias_add_kernel);
        source(k_bias_solver3) = "bias_add.cpp";
        headers(k_bias_solver3) = {"bias_add.h"};
        runtime<ratio>(k_bias_solver3) = 1.0;

        k_bias_solver4 = kernel::create(bias_add_kernel);
        source(k_bias_solver4) = "bias_add.cpp";
        headers(k_bias_solver4) = {"bias_add.h"};
        runtime<ratio>(k_bias_solver4) = 1.0;

        k_bias_solver5 = kernel::create(bias_add_kernel);
        source(k_bias_solver5) = "bias_add.cpp";
        headers(k_bias_solver5) = {"bias_add.h"};
        runtime<ratio>(k_bias_solver5) = 1.0;

        k_bias_solver6 = kernel::create(bias_add_kernel);
        source(k_bias_solver6) = "bias_add.cpp";
        headers(k_bias_solver6) = {"bias_add.h"};
        runtime<ratio>(k_bias_solver6) = 1.0;

        k_bias_solver7 = kernel::create(bias_add_kernel);
        source(k_bias_solver7) = "bias_add.cpp";
        headers(k_bias_solver7) = {"bias_add.h"};
        runtime<ratio>(k_bias_solver7) = 1.0;

        k_lrelu_embed0 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_embed0) = "leaky_relu.cpp";
        headers(k_lrelu_embed0) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_embed0) = 1.0;

        k_lrelu_embed1 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_embed1) = "leaky_relu.cpp";
        headers(k_lrelu_embed1) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_embed1) = 1.0;

        k_lrelu_solver0 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_solver0) = "leaky_relu.cpp";
        headers(k_lrelu_solver0) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_solver0) = 1.0;

        k_lrelu_solver1 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_solver1) = "leaky_relu.cpp";
        headers(k_lrelu_solver1) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_solver1) = 1.0;

        k_lrelu_solver2 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_solver2) = "leaky_relu.cpp";
        headers(k_lrelu_solver2) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_solver2) = 1.0;

        k_lrelu_solver3 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_solver3) = "leaky_relu.cpp";
        headers(k_lrelu_solver3) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_solver3) = 1.0;

        k_lrelu_solver4 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_solver4) = "leaky_relu.cpp";
        headers(k_lrelu_solver4) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_solver4) = 1.0;

        k_lrelu_solver5 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_solver5) = "leaky_relu.cpp";
        headers(k_lrelu_solver5) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_solver5) = 1.0;

        k_lrelu_solver6 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_solver6) = "leaky_relu.cpp";
        headers(k_lrelu_solver6) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_solver6) = 1.0;

        k_lrelu_solver7 = kernel::create(leaky_relu_kernel);
        source(k_lrelu_solver7) = "leaky_relu.cpp";
        headers(k_lrelu_solver7) = {"leaky_relu.h"};
        runtime<ratio>(k_lrelu_solver7) = 1.0;

        k_wsplit_embed0 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit_embed0) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit_embed0) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit_embed0) = 1.0;

        k_wsplit_solver0 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit_solver0) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit_solver0) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit_solver0) = 1.0;

        k_wsplit_solver1 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit_solver1) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit_solver1) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit_solver1) = 1.0;

        k_wsplit_solver2 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit_solver2) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit_solver2) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit_solver2) = 1.0;

        k_rollconcat = kernel::create(roll_concat_kernel);
        source(k_rollconcat) = "roll_concat.cpp";
        headers(k_rollconcat) = {"roll_concat.h"};
        runtime<ratio>(k_rollconcat) = 1.0;

        k_wsplit_solver3 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit_solver3) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit_solver3) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit_solver3) = 1.0;

        k_wsplit_solver4 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit_solver4) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit_solver4) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit_solver4) = 1.0;

        k_wsplit_solver5 = kernel::create(window_split_128_to_64x2);
        source(k_wsplit_solver5) = "window_split_128_to_64x2.cpp";
        headers(k_wsplit_solver5) = {"window_split_128_to_64x2.h"};
        runtime<ratio>(k_wsplit_solver5) = 1.0;

        k_rollconcat1 = kernel::create(roll_concat_kernel);
        source(k_rollconcat1) = "roll_concat.cpp";
        headers(k_rollconcat1) = {"roll_concat.h"};
        runtime<ratio>(k_rollconcat1) = 1.0;

        connect<window<512>>(embed_dense0.out[0], k_bias_embed0.in[0]);
        connect<parameter>(bias_embed0_rtp, k_bias_embed0.in[1]);
        connect<window<512>>(k_bias_embed0.out[0], k_lrelu_embed0.in[0]);
        connect<window<512>>(k_lrelu_embed0.out[0], k_wsplit_embed0.in[0]);

        connect<window<256>>(k_wsplit_embed0.out[0], embed_dense1.inB[0]);
        connect<window<256>>(k_wsplit_embed0.out[1], embed_dense1.inB[1]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_embed1_rtp[i], embed_dense1.matrixA[i]);
        }

        connect<window<512>>(embed_dense1.out[0], k_bias_embed1.in[0]);
        connect<parameter>(bias_embed1_rtp, k_bias_embed1.in[1]);
        connect<window<512>>(k_bias_embed1.out[0], k_lrelu_embed1.in[0]);
        connect<window<512>>(k_lrelu_embed1.out[0], k_rollconcat.in[0]);

        dimensions(k_rollconcat.in[0]) = {HIDDEN_SIZE};
        dimensions(k_rollconcat.out[0]) = {ROLL_CONCAT_TOTAL};

        roll_concat_buffer = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, TP_CASC_LEN_LAYER3);

        connect<>(k_rollconcat.out[0], roll_concat_buffer.in[0]);
        write_access(roll_concat_buffer.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });

        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            connect<parameter>(matrixA_solver0_rtp[i], solver_dense0.matrixA[i]);
        }

        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            connect<>(roll_concat_buffer.out[i], solver_dense0.inB[i]);
            read_access(roll_concat_buffer.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}
            });
        }

        connect<window<512>>(solver_dense0.out[0], k_bias_solver0.in[0]);
        connect<parameter>(bias_solver0_rtp, k_bias_solver0.in[1]);
        connect<window<512>>(k_bias_solver0.out[0], k_lrelu_solver0.in[0]);
        connect<window<512>>(k_lrelu_solver0.out[0], k_wsplit_solver0.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_solver1_rtp[i], solver_dense1.matrixA[i]);
        }
        connect<window<256>>(k_wsplit_solver0.out[0], solver_dense1.inB[0]);
        connect<window<256>>(k_wsplit_solver0.out[1], solver_dense1.inB[1]);

        connect<window<512>>(solver_dense1.out[0], k_bias_solver1.in[0]);
        connect<parameter>(bias_solver1_rtp, k_bias_solver1.in[1]);
        connect<window<512>>(k_bias_solver1.out[0], k_lrelu_solver1.in[0]);
        connect<window<512>>(k_lrelu_solver1.out[0], k_wsplit_solver1.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_solver2_rtp[i], solver_dense2.matrixA[i]);
        }
        connect<window<256>>(k_wsplit_solver1.out[0], solver_dense2.inB[0]);
        connect<window<256>>(k_wsplit_solver1.out[1], solver_dense2.inB[1]);

        connect<window<512>>(solver_dense2.out[0], k_bias_solver2.in[0]);
        connect<parameter>(bias_solver2_rtp, k_bias_solver2.in[1]);
        connect<window<512>>(k_bias_solver2.out[0], k_lrelu_solver2.in[0]);
        connect<window<512>>(k_lrelu_solver2.out[0], k_wsplit_solver2.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_solver3_rtp[i], solver_dense3.matrixA[i]);
        }
        connect<window<256>>(k_wsplit_solver2.out[0], solver_dense3.inB[0]);
        connect<window<256>>(k_wsplit_solver2.out[1], solver_dense3.inB[1]);

        connect<window<512>>(solver_dense3.out[0], k_bias_solver3.in[0]);
        connect<parameter>(bias_solver3_rtp, k_bias_solver3.in[1]);
        connect<window<512>>(k_bias_solver3.out[0], k_lrelu_solver3.in[0]);

        connect<window<512>>(k_lrelu_solver3.out[0], k_rollconcat1.in[0]);

        dimensions(k_rollconcat1.in[0]) = {HIDDEN_SIZE};
        dimensions(k_rollconcat1.out[0]) = {ROLL_CONCAT_TOTAL};

        roll_concat_buffer1 = shared_buffer<float>::create({ROLL_CONCAT_TOTAL}, 1, TP_CASC_LEN_LAYER3);

        connect<>(k_rollconcat1.out[0], roll_concat_buffer1.in[0]);
        write_access(roll_concat_buffer1.in[0]) = tiling({
            .buffer_dimension = {ROLL_CONCAT_TOTAL},
            .tiling_dimension = {ROLL_CONCAT_TOTAL},
            .offset = {0}
        });

        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            connect<parameter>(matrixA_solver4_rtp[i], solver_dense4.matrixA[i]);
        }

        for (int i = 0; i < TP_CASC_LEN_LAYER3; ++i) {
            connect<>(roll_concat_buffer1.out[i], solver_dense4.inB[i]);
            read_access(roll_concat_buffer1.out[i]) = tiling({
                .buffer_dimension = {ROLL_CONCAT_TOTAL},
                .tiling_dimension = {ROLL_CONCAT_TILE_SPAN},
                .offset = {static_cast<int>(i * ROLL_CONCAT_TILE_SPAN)}
            });
        }

        connect<window<512>>(solver_dense4.out[0], k_bias_solver4.in[0]);
        connect<parameter>(bias_solver4_rtp, k_bias_solver4.in[1]);
        connect<window<512>>(k_bias_solver4.out[0], k_lrelu_solver4.in[0]);
        connect<window<512>>(k_lrelu_solver4.out[0], k_wsplit_solver3.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_solver5_rtp[i], solver_dense5.matrixA[i]);
        }
        connect<window<256>>(k_wsplit_solver3.out[0], solver_dense5.inB[0]);
        connect<window<256>>(k_wsplit_solver3.out[1], solver_dense5.inB[1]);

        connect<window<512>>(solver_dense5.out[0], k_bias_solver5.in[0]);
        connect<parameter>(bias_solver5_rtp, k_bias_solver5.in[1]);
        connect<window<512>>(k_bias_solver5.out[0], k_lrelu_solver5.in[0]);
        connect<window<512>>(k_lrelu_solver5.out[0], k_wsplit_solver4.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_solver6_rtp[i], solver_dense6.matrixA[i]);
        }
        connect<window<256>>(k_wsplit_solver4.out[0], solver_dense6.inB[0]);
        connect<window<256>>(k_wsplit_solver4.out[1], solver_dense6.inB[1]);

        connect<window<512>>(solver_dense6.out[0], k_bias_solver6.in[0]);
        connect<parameter>(bias_solver6_rtp, k_bias_solver6.in[1]);
        connect<window<512>>(k_bias_solver6.out[0], k_lrelu_solver6.in[0]);
        connect<window<512>>(k_lrelu_solver6.out[0], k_wsplit_solver5.in[0]);

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_solver7_rtp[i], solver_dense7.matrixA[i]);
        }
        connect<window<256>>(k_wsplit_solver5.out[0], solver_dense7.inB[0]);
        connect<window<256>>(k_wsplit_solver5.out[1], solver_dense7.inB[1]);

        connect<window<512>>(solver_dense7.out[0], k_bias_solver7.in[0]);
        connect<parameter>(bias_solver7_rtp, k_bias_solver7.in[1]);
        connect<window<512>>(k_bias_solver7.out[0], k_lrelu_solver7.in[0]);

        connect<parameter>(matrixA_output0_rtp, output_dense0.matrixA[0]);
        connect<window<512>>(k_lrelu_solver7.out[0], output_dense0.inB[0]);
        connect<window<128>>(output_dense0.out[0], layer_out.in[0]);




        // ---- AIE-ML soft placement for aieml9  -------------------------------------

        // 0) I/O: keep PLIO-near compute in the south band (rows 0–2) for short shims.
        //    (Optional) If you know your PLIO shim row, keep the first band close.

        // 1) EMBED block (dense8x128 → bias → LReLU → split → dense128x128)
        location<kernel>(k_bias_embed0) = tile( 3,2);
        location<kernel>(k_lrelu_embed0) = tile( 3,3);
        location<kernel>(k_wsplit_embed0) = tile( 3,4);

        // Put the second dense (TP_CASC_LEN_LAYER2=2) in its own column band
        location<kernel>(k_bias_embed1) = tile( 6,5);
        location<kernel>(k_lrelu_embed1) = tile( 6,6);

        // 2) ROLL-CONCAT + SHARED BUFFER near the *start* of solver0 to minimize hops
        location<kernel>(k_rollconcat) = tile( 8,3);


        // 3) SOLVER0: dense768x128 (TP_CASC_LEN_LAYER3=12). Give it a **single-column**
        // vertical runway with slack in rows. Anchoring the head helps the placer chain.
        // Bias+LReLU + splitter right next door (same column or neighbor column)
        location<kernel>(k_bias_solver0)   = tile(11,4);
        location<kernel>(k_lrelu_solver0)  = tile(11,5);
        location<kernel>(k_wsplit_solver0) = tile(11,6);

        // 4) SOLVER1/2/3: each dense128x128 (TP_CASC_LEN_LAYER2=2). Give each a column
        // band; keep their bias/LReLU + split neighbors co-located for short windows.
        location<kernel>(k_bias_solver1)   = tile(15,3);
        location<kernel>(k_lrelu_solver1)  = tile(15,4);
        location<kernel>(k_wsplit_solver1) = tile(15,5);

        location<kernel>(k_bias_solver2)   = tile(19,3);
        location<kernel>(k_lrelu_solver2)  = tile(19,4);
        location<kernel>(k_wsplit_solver2) = tile(19,5);

        location<kernel>(k_bias_solver3)   = tile(23,3);
        location<kernel>(k_lrelu_solver3)  = tile(23,4);

        location<kernel>(k_rollconcat1)     = tile(26,4);

        location<kernel>(k_bias_solver4)   = tile(29,3);
        location<kernel>(k_lrelu_solver4)  = tile(29,4);
        location<kernel>(k_wsplit_solver3) = tile(29,5);

        location<kernel>(k_bias_solver5)   = tile(33,3);
        location<kernel>(k_lrelu_solver5)  = tile(33,4);
        location<kernel>(k_wsplit_solver4) = tile(33,5);

        location<kernel>(k_bias_solver6)   = tile(37,3);
        location<kernel>(k_lrelu_solver6)  = tile(37,4);
        location<kernel>(k_wsplit_solver5) = tile(37,5);

        location<kernel>(k_bias_solver7)   = tile(41,3);
        location<kernel>(k_lrelu_solver7)  = tile(41,4);

    }
};
