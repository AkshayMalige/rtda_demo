#pragma once
#include <adf.h>
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

static constexpr unsigned int INPUT_SIZE = 768;
static constexpr unsigned int OUTPUT_SIZE = 128;
static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_CASC_LEN = 12;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;

using dense768x128 = matrix_vector_mul_graph<
    float, float,
    OUTPUT_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;

class SingleDenseGraph : public graph {
public:
    input_plio  pl_in[TP_CASC_LEN];
    input_plio  pl_w[TP_CASC_LEN];
    output_plio pl_out;
    dense768x128 dense;

    SingleDenseGraph() {
        std::string base_path = DATA_DIR;
        for (int i = 0; i < TP_CASC_LEN; ++i) {
            std::string in_file = base_path + "/input768_part" + std::to_string(i) + ".txt";
            std::string w_file  = base_path + "/weights768_part" + std::to_string(i) + ".txt";
            std::string in_name = "plio_input_" + std::to_string(i);
            std::string w_name  = "plio_weights_" + std::to_string(i);
            pl_in[i] = input_plio::create(in_name.c_str(), plio_32_bits, in_file.c_str());
            pl_w[i]  = input_plio::create(w_name.c_str(), plio_32_bits, w_file.c_str());
            connect<>(pl_in[i].out[0], dense.inB[i]);
            connect<>(pl_w[i].out[0], dense.inA[i]);
        }
        pl_out = output_plio::create("plio_output_dense", plio_32_bits,
                                     (base_path + "/dense_output_aie2.txt").c_str());
        connect<>(dense.out[0], pl_out.in[0]);
    }
};
