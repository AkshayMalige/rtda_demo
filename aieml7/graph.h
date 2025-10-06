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
#include "window_split_768_to_512_256.h"
#include "window_split_768_to_64x12.h"
#include "window_split_512_to_256x2.h"
#include "window_split_256_to_128x2.h"
#include "roll_concat.h"
#include "bias_add.h"

#include <adf/io_buffer/io_buffer.h>      // defines adf::buffer
#include <adf/io_buffer/io_buffer_extents.h> // defines extents<...>
#include <adf/window/types.h>             // lightweight window<> definition

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
              "Roll-concat slice sizing must cover the entire frame");


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
    kernel      k_rollsplit;

    buffer      roll_concat_buffer;

    input_port bias_dense0_rtp;
    input_port bias_dense1_rtp;
    input_port bias_dense2_rtp;
    input_port bias_dense3_rtp;

    std::array<input_plio, SUBSOLVER0_INPUT_PARTS>          dense0_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS>  dense1_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS>  dense2_weight_plios;
    std::array<input_plio, SUBSOLVER0_LAYER_WEIGHTS_PARTS>  dense3_weight_plios;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer_out = output_plio::create("layer_out", plio_32_bits, (base_path + "/" + SUBSOLVER0_DENSE3_OUTPUT).c_str());

        layer0_in      = input_plio::create("layer0_in", plio_32_bits,
            (base_path + "/" + TMP_INP768).c_str());


            /////////change input file names////
        buffer wbuf_d768_leg[SUBSOLVER0_INPUT_PARTS] = {
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>()),
            buffer::create(extents<window<FLOATS_PER_D768_LEG>>())
            };

// Dense128x128 (3 layers × 2 parts)
        buffer wbuf_d128_l1_part[2] = {
            buffer::create(extents<window<FLOATS_PER_D128_PART>>()),
            buffer::create(extents<window<FLOATS_PER_D128_PART>>())
        };
        buffer wbuf_d128_l2_part[2] = {
            buffer::create(extents<window<FLOATS_PER_D128_PART>>()),
            buffer::create(extents<window<FLOATS_PER_D128_PART>>())
        };
        buffer wbuf_d128_l3_part[2] = {
            buffer::create(extents<window<FLOATS_PER_D128_PART>>()),
            buffer::create(extents<window<FLOATS_PER_D128_PART>>())
        };
        k_rollconcat0 = kernel::create(roll_concat_kernel);
        source(k_rollconcat0) = "roll_concat.cpp";
        headers(k_rollconcat0) = {"roll_concat.h"};
        runtime<ratio>(k_rollconcat0) = 1.0;

        connect(layer0_in.out[0], k_rollconcat0.in[0]);
        dimensions(k_rollconcat0.in[0]) = {HIDDEN_SIZE};
        dimensions(k_rollconcat0.out[0]) = {ROLL_CONCAT_TOTAL};

        roll_concat_buffer = buffer::create(extents<window<ROLL_CONCAT_TOTAL * sizeof(float)>>());

        connect<window<ROLL_CONCAT_TOTAL * sizeof(float)>>(k_rollconcat0.out[0], roll_concat_buffer.in[0]);

        k_rollsplit = kernel::create(window_split_768_to_64x12);
        source(k_rollsplit) = "window_split_768_to_64x12.cpp";
        headers(k_rollsplit) = {"window_split_768_to_64x12.h"};
        runtime<ratio>(k_rollsplit) = 1.0;

        connect<window<ROLL_CONCAT_TOTAL * sizeof(float)>>(roll_concat_buffer.out[0], k_rollsplit.in[0]);

        for (int i = 0; i < SUBSOLVER0_INPUT_PARTS; ++i) {
            connect<window<ROLL_CONCAT_TILE_SPAN * sizeof(float)>>(k_rollsplit.out[i], dense0.inB[i]);
        }

        for (int part = 0; part < SUBSOLVER0_INPUT_PARTS; ++part) {
            const std::string plio_name = "dense0_w_part" + std::to_string(part);
            const std::string file_path = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(part) + ".txt";
            dense0_weight_plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
            connect<window<FLOATS_PER_D768_LEG * sizeof(float)>>(dense0_weight_plios[part].out[0], wbuf_d768_leg[part].in[0]);
        }

        auto connect_layer_weights = [&](auto& plios,
                                         const char* name_prefix,
                                         const char* file_prefix,
                                         buffer (&wbuf)[SUBSOLVER0_LAYER_WEIGHTS_PARTS]) {
            for (int part = 0; part < SUBSOLVER0_LAYER_WEIGHTS_PARTS; ++part) {
                const std::string plio_name = std::string(name_prefix) + std::to_string(part);
                const std::string file_path = base_path + "/" + file_prefix + std::to_string(part) + ".txt";
                plios[part] = input_plio::create(plio_name.c_str(), plio_32_bits, file_path.c_str());
                connect<window<FLOATS_PER_D128_PART * sizeof(float)>>(plios[part].out[0], wbuf[part].in[0]);
            }
        };

        connect_layer_weights(dense1_weight_plios, "dense1_w_part", SUBSOLVER0_DENSE1_WEIGHTS_PREFIX, wbuf_d128_l1_part);
        connect_layer_weights(dense2_weight_plios, "dense2_w_part", SUBSOLVER0_DENSE2_WEIGHTS_PREFIX, wbuf_d128_l2_part);
        connect_layer_weights(dense3_weight_plios, "dense3_w_part", SUBSOLVER0_DENSE3_WEIGHTS_PREFIX, wbuf_d128_l3_part);

        // ===== locals -> DSPLib MVM matrixA ports =====
        // dense0 (12 cascade legs)
        for (int i = 0; i < 12; ++i) {
            connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (wbuf_d768_leg[i].out[0], dense0.matrixA[i]);
        }
        // dense1/2/3 (each 2 parts)
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (wbuf_d128_l1_part[0].out[0], dense1.matrixA[0]);
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (wbuf_d128_l1_part[1].out[0], dense1.matrixA[1]);
        
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (wbuf_d128_l2_part[0].out[0], dense2.matrixA[0]);
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (wbuf_d128_l2_part[1].out[0], dense2.matrixA[1]);
        
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (wbuf_d128_l3_part[0].out[0], dense3.matrixA[0]);
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (wbuf_d128_l3_part[1].out[0], dense3.matrixA[1]);
  

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
        connect<parameter>(bias_dense0_rtp, k_biasadd0.in[1]);
        connect<window<512>>(k_biasadd0.out[0], k_lrelu0.in[0]);
        connect<window<512>>(k_lrelu0.out[0], k_wsplit0.in[0]);

        connect<window<256>>(k_wsplit0.out[0], dense1.inB[0]);
        connect<window<256>>(k_wsplit0.out[1], dense1.inB[1]);

        // for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        //     connect<parameter>(matrixA_dense1_rtp[i], dense1.matrixA[i]);
        // }

        connect<window<512>>(dense1.out[0], k_biasadd1.in[0]);
        connect<parameter>(bias_dense1_rtp, k_biasadd1.in[1]);
        connect<window<512>>(k_biasadd1.out[0], k_lrelu1.in[0]);
        connect<window<512>>(k_lrelu1.out[0], k_wsplit1.in[0]);

        connect<window<256>>(k_wsplit1.out[0], dense2.inB[0]);
        connect<window<256>>(k_wsplit1.out[1], dense2.inB[1]);

        // for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        //     connect<parameter>(matrixA_dense2_rtp[i], dense2.matrixA[i]);
        // }

        connect<window<512>>(dense2.out[0], k_biasadd2.in[0]);
        connect<parameter>(bias_dense2_rtp, k_biasadd2.in[1]);
        connect<window<512>>(k_biasadd2.out[0], k_lrelu2.in[0]);
        connect<window<512>>(k_lrelu2.out[0], k_wsplit2.in[0]);

        connect<window<256>>(k_wsplit2.out[0], dense3.inB[0]);
        connect<window<256>>(k_wsplit2.out[1], dense3.inB[1]);

        connect<window<512>>(dense3.out[0], k_biasadd3.in[0]);
        connect<parameter>(bias_dense3_rtp, k_biasadd3.in[1]);
        connect<window<512>>(k_biasadd3.out[0], k_lrelu3.in[0]);

        connect<window<512>>(k_lrelu3.out[0], layer_out.in[0]);


        // auto d0_k = dense0.getKernels();
        // location<kernel>(d0_k[0]) = tile(20, 4);


        // constexpr unsigned dense2_base_col = 2;
        // constexpr unsigned dense2_row = 0;
        // auto dense2_kernels = dense2.getKernels();
        // for (unsigned i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
        //     adf::location<adf::kernel>(dense2_kernels[i]) =
        //         adf::tile(dense2_base_col + i, dense2_row);
        // }
    }
};
