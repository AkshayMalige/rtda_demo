#pragma once
#include <adf.h>
#include "include.h"
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;

// ---- round up output dim to AIE float vector multiple (8) ----
constexpr unsigned roundup(unsigned v, unsigned m) { return ((v + m - 1) / m) * m; }
static constexpr unsigned VEC_FLOAT = (256 / 8) / sizeof(float); // = 8
static constexpr unsigned OUT_REAL  = 27;                         // what you want
static constexpr unsigned OUT_PAD   = roundup(OUT_REAL, VEC_FLOAT); // = 32
static constexpr unsigned IN_DIM    = 128;

using dense128x27_padded32 = matrix_vector_mul_graph<
    float, float,
    OUT_PAD,      // **must be multiple of 8**
    IN_DIM,
    TP_SHIFT, TP_RND, TP_NUM_FRAMES,
    1,            // TP_CASC_LEN
    TP_SAT, TP_SSR, TP_DIM_A_LEADING>;

class NeuralNetworkGraph : public graph {
public:
    input_plio  pl_in_dense1;
    input_plio  pl_w_dense1;
    output_plio pl_out_dense1;

    dense128x27_padded32 dense1;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        pl_in_dense1  = input_plio::create("plio_input_dense1",  plio_32_bits, (base_path + "/" + OUTPUT_INPUT_DATA).c_str());
        pl_w_dense1   = input_plio::create("plio_weights_dense1", plio_32_bits, (base_path + "/" + OUTPUT_DENSE0_WEIGHTS).c_str());
        pl_out_dense1 = output_plio::create("plio_output_dense1", plio_32_bits, (base_path + "/" + OUTPUT_DENSE0_OUTPUT).c_str());

        connect<>(pl_w_dense1.out[0], dense1.inA[0]);
        connect<>(pl_in_dense1.out[0], dense1.inB[0]);
        connect<>(dense1.out[0], pl_out_dense1.in[0]);
    }
};
