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

#include "bias_relu_fused.h"


using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

constexpr unsigned WINDOW_BYTES_HIDDEN = HIDDEN_SIZE * sizeof(DATA_TYPE);
constexpr unsigned EMBED_DENSE0_WEIGHTS_TOTAL = HIDDEN_SIZE * INPUT_SIZE;


constexpr unsigned DEFAULT_FIFO_DEPTH = 8U;
constexpr unsigned GMIO_WEIGHT_BURST_BYTES = 64U;
constexpr unsigned GMIO_WEIGHT_BANDWIDTH_MBPS = 256U;
constexpr unsigned GMIO_ACTIVATION_BURST_BYTES = 64U;
constexpr unsigned GMIO_ACTIVATION_BANDWIDTH_MBPS = 256U;

// --- Alignment Logic for Kernel ---
// The AIE kernel requires the input dimension (Cols) to be a multiple of the vector size.
// Vector size is 256 bits.
constexpr unsigned VECTOR_BITS = 256;
constexpr unsigned TYPE_BITS = sizeof(DATA_TYPE) * 8;
constexpr unsigned ALIGNMENT_ELEMENTS = VECTOR_BITS / TYPE_BITS;

// Round up INPUT_SIZE to the next multiple of ALIGNMENT_ELEMENTS
// If INPUT_SIZE is 8 and DATA_TYPE is int16 (16-bit), ALIGNMENT is 16. GRAPH_INPUT_SIZE becomes 16.
// If INPUT_SIZE is 8 and DATA_TYPE is float (32-bit), ALIGNMENT is 8. GRAPH_INPUT_SIZE remains 8.
constexpr unsigned GRAPH_INPUT_SIZE = (INPUT_SIZE + ALIGNMENT_ELEMENTS - 1) / ALIGNMENT_ELEMENTS * ALIGNMENT_ELEMENTS;
// ----------------------------------

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

    // Use GRAPH_INPUT_SIZE instead of INPUT_SIZE for the template instantiation
    using embed_dense0_graph = dense_matrix_graph<HIDDEN_SIZE, GRAPH_INPUT_SIZE, EMBED_DENSE0_CASC_LEN, 1>;

class NeuralNetworkGraph : public graph {
    public:

    embed_dense0_graph          embed_dense0;
    kernel                      embed_bias_relu0;

    input_gmio                  embed_input_gmio;
    input_port                  embed_matrixA0_rtp;
    output_gmio                 embed_output_gmio;

    input_port                  embed_bias0_rtp;

    NeuralNetworkGraph() {

        const auto make_bias_relu_kernel = []() {
            kernel k = kernel::create(bias_add_leaky_relu_kernel);
            source(k)  = "bias_relu_fused.cpp";
            headers(k) = {"bias_relu_fused.h"};
            return k;
        };

        embed_input_gmio = input_gmio::create("embed_input_gmio", GMIO_ACTIVATION_BURST_BYTES, GMIO_ACTIVATION_BANDWIDTH_MBPS);
        embed_output_gmio = adf::output_gmio::create("embed_output_gmio", GMIO_ACTIVATION_BURST_BYTES, GMIO_ACTIVATION_BANDWIDTH_MBPS);

        connect<>(embed_input_gmio.out[0], embed_dense0.inB[0]);
        connect<parameter>(embed_matrixA0_rtp, async(embed_dense0.matrixA[0]));

        embed_bias_relu0 = make_bias_relu_kernel();
        runtime<ratio>(embed_bias_relu0) =  0.95;
        connect<window<WINDOW_BYTES_HIDDEN>>(embed_dense0.out[0], embed_bias_relu0.in[0]);
        connect<parameter>(embed_bias0_rtp, async(embed_bias_relu0.in[1]));
        connect<window<WINDOW_BYTES_HIDDEN>>(embed_bias_relu0.out[0], embed_output_gmio.in[0]);

    }
};