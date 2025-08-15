#pragma once
#include <adf.h>
#include "include.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "aie_api/aie.hpp"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;
using namespace aie;

static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;
static constexpr unsigned int TP_CASC_LEN_LAYER2 = 1;

using dense8x128 = matrix_vector_mul_graph<
    float16, float16,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;

using dense128x128 = matrix_vector_mul_graph<
    float16, float16,
    OUTPUT_SIZE,
    HIDDEN_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_LAYER2,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;
// Graph connects dense1 and dense2; leaky ReLU is handled in PL
class NeuralNetworkGraph : public graph {
public:
    input_plio  pl_in_dense1;
    input_plio  pl_w_dense1;
    output_plio pl_out_dense1;

    dense8x128   dense1;
    dense128x128 dense2;

    input_plio  pl_in_dense2;
    input_plio  pl_w_dense2;
    output_plio pl_out_dense2;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        pl_in_dense1  = input_plio::create("plio_input_dense1", plio_16_bits,
                                          (base_path + "/" + EMBED_INPUT_DATA).c_str());
        pl_w_dense1   = input_plio::create("plio_weights_dense1", plio_16_bits,
                                          (base_path + "/" + EMBED_DENSE0_WEIGHTS).c_str());
        pl_out_dense1 = output_plio::create("plio_output_dense1", plio_16_bits,
                                          (base_path + "/dense1_output_aie.txt").c_str());

        connect<>(pl_w_dense1.out[0], dense1.inA[0]);
        connect<>(pl_in_dense1.out[0], dense1.inB[0]);
        connect<>(dense1.out[0], pl_out_dense1.in[0]);

        std::string in_file = base_path + "/" + EMBED_LEAKYRELU0_OUTPUT_PREFIX + "0.txt";
        std::string w_file  = base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + "0.txt";

        pl_in_dense2 = input_plio::create("plio_input_dense2", plio_16_bits, in_file.c_str());
        pl_w_dense2  = input_plio::create("plio_weights_dense2", plio_16_bits, w_file.c_str());

        connect<>(pl_in_dense2.out[0], dense2.inB[0]);
        connect<>(pl_w_dense2.out[0], dense2.inA[0]);

        pl_out_dense2 = output_plio::create("plio_output_dense2", plio_16_bits);
        connect<>(dense2.out[0], pl_out_dense2.in[0]);
    }
};