// Embed proxy: wraps split_embed firmware in an isolated namespace.
// All sub-project types (input_t, result_t, config2, w2, etc.) are namespace-scoped
// to avoid ODR conflicts with other proxies that share weight variable names.
//
// The block is a DATAFLOW region over its own two dense layers and two
// activations, each a persistent process that runs for every track of the
// call. Sequentially the block cost 1615 cycles per track, which with the
// solvers pipelined internally would have made the EMBEDDING the bottleneck;
// overlapped it costs the interval of its 128x128 dense, about 1030. See
// rtda_stage.h for what the macros build and why they are macros.

#include "rtda_split_top.h"
#include "rtda_stage.h"

namespace emb_fw {
#include "../firmware/embed/defines.h"
#include "../firmware/embed/parameters.h"
}
using namespace emb_fw;

// The canonical types and the hls4ml ones are the SAME TYPE, not merely the
// same shape -- nnet::array<rtda_act_t, 6> and nnet::array<rtda_act_t, 6*1>
// name one instantiation. The entry and exit copy loops the block used to run
// were therefore copying a value onto itself, at 130 cycles a track. They are
// gone; these assertions are what stops a width change from turning that
// removal into a silent truncation.
static_assert(std::is_same<embed_in_t, input_t>::value,
              "embed_in_t and emb_fw::input_t must be the same type");
static_assert(std::is_same<hidden_t, result_t>::value,
              "hidden_t and emb_fw::result_t must be the same type");

// Forward pass matching split_embed/firmware/myproject.cpp, one process each.
RTDA_DENSE_STAGE(emb_dense2, input_t,  layer2_t, config2, w2, b2)
RTDA_ACT_STAGE  (emb_act4,   layer2_t, layer4_t, LeakyReLU_config4)
RTDA_DENSE_STAGE(emb_dense5, layer4_t, layer5_t, config5, w5, b5)
RTDA_ACT_STAGE  (emb_act7,   layer5_t, result_t, LeakyReLU_config7)

void embed_stage(hls::stream<embed_in_t>& in, hls::stream<hidden_t>& out,
                 int n_events, int tracks_per_event) {
#ifndef __SYNTHESIS__
    // Synthesis never sees this -- there the weights are compile-time arrays --
    // so the dataflow region below still begins at the first statement HLS
    // compiles, which is what keeps it canonical.
    static bool loaded = false;
    if (!loaded) {
        nnet::load_weights_from_txt<model_default_t, 768>(w2, "emb_w2.txt");
        nnet::load_weights_from_txt<model_default_t, 128>(b2, "emb_b2.txt");
        nnet::load_weights_from_txt<model_default_t, 16384>(w5, "emb_w5.txt");
        nnet::load_weights_from_txt<model_default_t, 128>(b5, "emb_b5.txt");
        loaded = true;
    }
#endif

    #pragma HLS DATAFLOW

    hls::stream<layer2_t> layer2_out("layer2_out");
    hls::stream<layer4_t> layer4_out("layer4_out");
    hls::stream<layer5_t> layer5_out("layer5_out");

    emb_dense2(in,         layer2_out, n_events, tracks_per_event);
    emb_act4  (layer2_out, layer4_out, n_events, tracks_per_event);
    emb_dense5(layer4_out, layer5_out, n_events, tracks_per_event);
    emb_act7  (layer5_out, out,        n_events, tracks_per_event);
}
