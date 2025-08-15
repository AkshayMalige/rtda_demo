#pragma once
#include <adf.h>
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

// switch graph to operate on float16 data
using TT_DATA   = float;
using TT_WEIGHT = float;

// network dimensions
static constexpr unsigned int INPUT_SIZE  = 768;
static constexpr unsigned int OUTPUT_SIZE = 128;

// cascade length is limited by 64KB of tile memory for weights
static constexpr unsigned int TILE_BYTES          = 64 * 1024;
static constexpr unsigned int BYTES_PER_WEIGHT   = sizeof(TT_WEIGHT);
static constexpr unsigned int MAX_INPUTS_PER_TILE = TILE_BYTES / (BYTES_PER_WEIGHT * OUTPUT_SIZE);
static constexpr unsigned int TP_CASC_LEN_768         = (INPUT_SIZE + MAX_INPUTS_PER_TILE - 1) / MAX_INPUTS_PER_TILE;
static_assert(INPUT_SIZE % TP_CASC_LEN_768 == 0, "Input size must divide cascade length");

static constexpr unsigned int TP_SHIFT          = 0;
static constexpr unsigned int TP_RND            = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES     = 1;
static constexpr unsigned int TP_SAT            = 0;
static constexpr unsigned int TP_SSR            = 1;
static constexpr unsigned int TP_DIM_A_LEADING  = 1;

using dense768x128 = matrix_vector_mul_graph<
    TT_WEIGHT, TT_DATA,
    OUTPUT_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    TP_CASC_LEN_768,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING>;

class SingleDenseGraph : public graph {
public:
    input_plio  pl_in[TP_CASC_LEN_768];
    input_plio  pl_w[TP_CASC_LEN_768];
    output_plio pl_out;
    dense768x128 dense;

    SingleDenseGraph() {
        std::string base_path = DATA_DIR;
        for (int i = 0; i < TP_CASC_LEN_768; ++i) {
            std::string in_file = base_path + "/input768_part" + std::to_string(i) + ".txt";
            std::string w_file  = base_path + "/weights768_part" + std::to_string(i) + ".txt";
            std::string in_name = "plio_input_" + std::to_string(i);
            std::string w_name  = "plio_weights_" + std::to_string(i);
            pl_in[i] = input_plio::create(in_name.c_str(), plio_16_bits, in_file.c_str());
            pl_w[i]  = input_plio::create(w_name.c_str(), plio_16_bits, w_file.c_str());
            connect<>(pl_in[i].out[0], dense.inB[i]);
            connect<>(pl_w[i].out[0], dense.inA[i]);
        }
        pl_out = output_plio::create("plio_output_dense", plio_16_bits,
                                     (base_path + "/dense_output_aie2.txt").c_str());
        connect<>(dense.out[0], pl_out.in[0]);
    }
};
