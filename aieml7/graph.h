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
#include "copy_to_locals_6.h"

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

    kernel      k_copy768_lo;
    kernel      k_copy768_hi;
    kernel      k_copy128_all;

    adf::shared_buffer<float> roll_concat_buffer;

    // input_port matrixA_dense0_rtp[TP_CASC_LEN_LAYER3];
    input_port bias_dense0_rtp;
    // input_port matrixA_dense1_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_dense1_rtp;
    // input_port matrixA_dense2_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_dense2_rtp;
    // input_port matrixA_dense3_rtp[TP_CASC_LEN_LAYER2];
    input_port bias_dense3_rtp;

    buffer wbank_d768_lo;
    buffer wbank_d768_hi;
    buffer wbank_d128_all;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer_out = output_plio::create("layer_out", plio_32_bits, (base_path + "/" + SUBSOLVER0_DENSE3_OUTPUT).c_str());

        layer0_in      = input_plio::create("layer0_in", plio_32_bits,
            (base_path + "/" + TMP_INP768).c_str());


            /////////change input file names////
        input_plio preload_w768_lo  = input_plio::create("preload_w768_lo",  plio_32_bits,(base_path + "/" + PRELOAD_w768_lo).c_str()); // "data/preload_w768_lo.txt");
        input_plio preload_w768_hi  = input_plio::create("preload_w768_hi",  plio_32_bits,(base_path + "/" + PRELOAD_w768_hi).c_str()); // "data/preload_w768_hi.txt");
        input_plio preload_w128_all = input_plio::create("preload_w128_all", plio_32_bits, (base_path + "/" + PRELOAD_w128_all).c_str()); //"data/preload_w128_all.txt");
        
        wbank_d768_lo  = buffer::create(extents<window<FLOATS_PER_D768_LEG * D768_LEGS_PER_BANK>>());
        wbank_d768_hi  = buffer::create(extents<window<FLOATS_PER_D768_LEG * D768_LEGS_PER_BANK>>());
        wbank_d128_all = buffer::create(extents<window<FLOATS_PER_D128_PART * D128_TOTAL_PARTS>>());

        buffer wbuf_d768_leg[12] = {
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

        k_copy768_lo = kernel::create(copy768_lo);
        k_copy768_hi = kernel::create(copy768_hi);
        k_copy128_all= kernel::create(copy128_all);
        runtime<ratio>(k_copy768_lo)  = 0.15;
        runtime<ratio>(k_copy768_hi)  = 0.15;
        runtime<ratio>(k_copy128_all) = 0.15;



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

        connect<window<FLOATS_PER_D768_LEG * D768_LEGS_PER_BANK * sizeof(float)>> (preload_w768_lo.out[0],  wbank_d768_lo.in[0]);
        connect<window<FLOATS_PER_D768_LEG * D768_LEGS_PER_BANK * sizeof(float)>> (preload_w768_hi.out[0],  wbank_d768_hi.in[0]);
        connect<window<FLOATS_PER_D128_PART * D128_TOTAL_PARTS * sizeof(float)>>  (preload_w128_all.out[0], wbank_d128_all.in[0]);

        // ===== Bank -> copy kernels =====
        connect<window<FLOATS_PER_D768_LEG * D768_LEGS_PER_BANK * sizeof(float)>> (wbank_d768_lo.out[0],  k_copy768_lo.in[0]);
        connect<window<FLOATS_PER_D768_LEG * D768_LEGS_PER_BANK * sizeof(float)>> (wbank_d768_hi.out[0],  k_copy768_hi.in[0]);
        connect<window<FLOATS_PER_D128_PART * D128_TOTAL_PARTS * sizeof(float)>>  (wbank_d128_all.out[0], k_copy128_all.in[0]);

        // ===== copy768_lo -> locals (dense0 legs 0..5) =====
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_lo.out[0], wbuf_d768_leg[0].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_lo.out[1], wbuf_d768_leg[1].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_lo.out[2], wbuf_d768_leg[2].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_lo.out[3], wbuf_d768_leg[3].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_lo.out[4], wbuf_d768_leg[4].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_lo.out[5], wbuf_d768_leg[5].in[0]);
        
        // ===== copy768_hi -> locals (dense0 legs 6..11) =====
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_hi.out[0], wbuf_d768_leg[6].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_hi.out[1], wbuf_d768_leg[7].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_hi.out[2], wbuf_d768_leg[8].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_hi.out[3], wbuf_d768_leg[9].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_hi.out[4], wbuf_d768_leg[10].in[0]);
        connect<window<FLOATS_PER_D768_LEG * sizeof(float)>> (k_copy768_hi.out[5], wbuf_d768_leg[11].in[0]);

        // ===== copy128_all -> locals for dense1/2/3 (part 0..1) =====
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (k_copy128_all.out[0], wbuf_d128_l1_part[0].in[0]);
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (k_copy128_all.out[1], wbuf_d128_l1_part[1].in[0]);
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (k_copy128_all.out[2], wbuf_d128_l2_part[0].in[0]);
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (k_copy128_all.out[3], wbuf_d128_l2_part[1].in[0]);
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (k_copy128_all.out[4], wbuf_d128_l3_part[0].in[0]);
        connect<window<FLOATS_PER_D128_PART * sizeof(float)>> (k_copy128_all.out[5], wbuf_d128_l3_part[1].in[0]);

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

        for (int i = 0; i < TP_CASC_LEN_LAYER2; ++i) {
            connect<parameter>(matrixA_dense3_rtp[i], dense3.matrixA[i]);
        }

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
