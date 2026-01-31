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


using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

constexpr unsigned WINDOW_BYTES_HIDDEN = HIDDEN_SIZE * sizeof(DATA_TYPE);
constexpr unsigned EMBED_DENSE0_WEIGHTS_TOTAL = HIDDEN_SIZE * INPUT_SIZE;


constexpr unsigned DEFAULT_FIFO_DEPTH = 8U;
constexpr unsigned GMIO_WEIGHT_BURST_BYTES = 64U;
constexpr unsigned GMIO_WEIGHT_BANDWIDTH_MBPS = 256U;
constexpr unsigned GMIO_ACTIVATION_BURST_BYTES = 64U;
constexpr unsigned GMIO_ACTIVATION_BANDWIDTH_MBPS = 256U;

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

    using embed_dense0_graph = dense_matrix_graph<HIDDEN_SIZE, INPUT_SIZE, EMBED_DENSE0_CASC_LEN, 1>;

class NeuralNetworkGraph : public graph {
    public:

    embed_dense0_graph          embed_dense0;
    input_gmio                  embed_input_gmio;
    input_port                  embed_matrixA0_rtp;
    output_gmio                 embed_output_gmio;

    NeuralNetworkGraph() {

        embed_input_gmio = input_gmio::create("embed_input_gmio", GMIO_ACTIVATION_BURST_BYTES, GMIO_ACTIVATION_BANDWIDTH_MBPS);
        embed_output_gmio = adf::output_gmio::create("embed_output_gmio", GMIO_ACTIVATION_BURST_BYTES, GMIO_ACTIVATION_BANDWIDTH_MBPS);

        connect<>(embed_input_gmio.out[0], embed_dense0.inB[0]);
        connect<parameter>(embed_matrixA0_rtp, async(embed_dense0.matrixA[0]));
        connect<window<WINDOW_BYTES_HIDDEN>>(embed_dense0.out[0], embed_output_gmio.in[0]);

    }
};