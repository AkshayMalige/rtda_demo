#pragma once
#include <adf.h>
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "nn_defs.h"

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
static constexpr unsigned IN_DIM    = HIDDEN_SIZE;

using dense128x27_padded32 = matrix_vector_mul_graph<
    float, float,
    OUT_PAD,      // **must be multiple of 8**
    IN_DIM,
    TP_SHIFT, TP_RND, TP_NUM_FRAMES,
    1,            // TP_CASC_LEN
    TP_SAT, TP_SSR, TP_DIM_A_LEADING>;

class NeuralNetworkGraph : public graph {
public:
    input_plio  layer0_in;
    input_plio  layer0_weights;
    output_plio layer0_out;

    dense128x27_padded32 dense1;

    NeuralNetworkGraph() {
        std::string base_path = DATA_DIR;
        layer0_in      = input_plio::create("layer0_in",  plio_32_bits, (base_path + "/" + OUTPUT_INPUT_DATA).c_str());
        layer0_weights = input_plio::create("layer0_weights", plio_32_bits, (base_path + "/" + OUTPUT_DENSE0_WEIGHTS).c_str());
        layer0_out     = output_plio::create("layer0_out", plio_32_bits, (base_path + "/" + OUTPUT_DENSE0_OUTPUT).c_str());

        connect<>(layer0_weights.out[0], dense1.inA[0]);
        connect<>(layer0_in.out[0], dense1.inB[0]);
        connect<>(dense1.out[0], layer0_out.in[0]);
    }
};
