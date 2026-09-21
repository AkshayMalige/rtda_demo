// Solver1 proxy: wraps split_solver1 firmware in an isolated namespace.
//
// The block is a DATAFLOW region over its own five dense layers, the merge
// and the four activations, plus the one-track roll delay it needs. Each is a
// persistent process running for every track of the call, so the block's
// interval is that of ONE 128x128 dense (~1030 cycles) rather than the sum of
// five (4968). See rtda_stage.h for the macros and for why the delay lives
// here instead of at the top level.

#include "rtda_split_top.h"
#include "rtda_stage.h"

namespace s1_fw {
#include "../firmware/solver1/defines.h"
#include "../firmware/solver1/parameters.h"
}
using namespace s1_fw;

// hidden_t == input_t == input2_t == result_t: all name the single type
// nnet::array<ap_fixed<RTDA_W,RTDA_I,...>, 128>. The entry and exit copy
// loops this block used to run were copying a value onto itself at 130 cycles
// a track; they are gone, and these assertions are what stops a width change
// from turning that removal into a silent truncation.
static_assert(std::is_same<hidden_t, input_t>::value,
              "hidden_t and s1_fw::input_t must be the same type");
static_assert(std::is_same<hidden_t, input2_t>::value,
              "hidden_t and s1_fw::input2_t must be the same type");
static_assert(std::is_same<hidden_t, result_t>::value,
              "hidden_t and s1_fw::result_t must be the same type");

// The roll: (track j, track j-1) of this block's own input.
RTDA_ROLL_STAGE(s1_roll, input_t, input2_t)

// Forward pass matching split_solver1/firmware/myproject.cpp, one process each.
RTDA_DENSE_STAGE(s1_dense3,  input_t,   layer3_t,  config3,  w3,  b3)
RTDA_DENSE_STAGE(s1_dense5,  input2_t,  layer5_t,  config5,  w5,  b5)
RTDA_ADD_STAGE  (s1_add7,    layer3_t,  layer5_t,  layer7_t, config7)
RTDA_ACT_STAGE  (s1_act8,    layer7_t,  layer8_t,  LeakyReLU_config8)
RTDA_DENSE_STAGE(s1_dense9,  layer8_t,  layer9_t,  config9,  w9,  b9)
RTDA_ACT_STAGE  (s1_act11,   layer9_t,  layer11_t, LeakyReLU_config11)
RTDA_DENSE_STAGE(s1_dense12, layer11_t, layer12_t, config12, w12, b12)
RTDA_ACT_STAGE  (s1_act14,   layer12_t, layer14_t, LeakyReLU_config14)
RTDA_DENSE_STAGE(s1_dense15, layer14_t, layer15_t, config15, w15, b15)
RTDA_ACT_STAGE  (s1_act17,   layer15_t, result_t,  LeakyReLU_config17)

void solver1_stage(hls::stream<hidden_t>& in, hls::stream<hidden_t>& out,
                   int n_events, int tracks_per_event, bool reset) {
#ifndef __SYNTHESIS__
    static bool loaded = false;
    if (!loaded) {
        nnet::load_weights_from_txt<model_default_t, 16384>(w3,  "s1_w3.txt");
        nnet::load_weights_from_txt<model_default_t, 128>(b3,    "s1_b3.txt");
        nnet::load_weights_from_txt<model_default_t, 16384>(w5,  "s1_w5.txt");
        nnet::load_weights_from_txt<bias5_t, 128>(b5,            "s1_b5.txt");
        nnet::load_weights_from_txt<model_default_t, 16384>(w9,  "s1_w9.txt");
        nnet::load_weights_from_txt<model_default_t, 128>(b9,    "s1_b9.txt");
        nnet::load_weights_from_txt<model_default_t, 16384>(w12, "s1_w12.txt");
        nnet::load_weights_from_txt<model_default_t, 128>(b12,   "s1_b12.txt");
        nnet::load_weights_from_txt<model_default_t, 16384>(w15, "s1_w15.txt");
        nnet::load_weights_from_txt<model_default_t, 128>(b15,   "s1_b15.txt");
        loaded = true;
    }
#endif

    #pragma HLS DATAFLOW

    hls::stream<input_t>   s_curr("s_curr");
    hls::stream<input2_t>  s_prev("s_prev");
    hls::stream<layer3_t>  layer3_out("layer3_out");
    hls::stream<layer5_t>  layer5_out("layer5_out");
    hls::stream<layer7_t>  layer7_out("layer7_out");
    hls::stream<layer8_t>  layer8_out("layer8_out");
    hls::stream<layer9_t>  layer9_out("layer9_out");
    hls::stream<layer11_t> layer11_out("layer11_out");
    hls::stream<layer12_t> layer12_out("layer12_out");
    hls::stream<layer14_t> layer14_out("layer14_out");
    hls::stream<layer15_t> layer15_out("layer15_out");

    // s_curr and s_prev are the one fork in the graph: s1_roll writes both,
    // the two first-layer denses drain one each, and the merge rejoins them.
    // Both branches carry exactly one token per track, so neither dense can
    // starve and the fork needs no slack. Depth 2 and not 4: see the note in
    // rtda_split_top.cpp -- depth 4 put these two channels in BRAM, 50
    // BRAM_18K each, for no throughput at all.
    #pragma HLS STREAM variable=s_curr depth=2
    #pragma HLS STREAM variable=s_prev depth=2

    s1_roll(in, s_curr, s_prev, n_events, tracks_per_event, reset);

    s1_dense3 (s_curr,     layer3_out,  n_events, tracks_per_event);
    s1_dense5 (s_prev,     layer5_out,  n_events, tracks_per_event);
    s1_add7   (layer3_out, layer5_out, layer7_out, n_events, tracks_per_event);
    s1_act8   (layer7_out, layer8_out,  n_events, tracks_per_event);
    s1_dense9 (layer8_out, layer9_out,  n_events, tracks_per_event);
    s1_act11  (layer9_out, layer11_out, n_events, tracks_per_event);
    s1_dense12(layer11_out, layer12_out, n_events, tracks_per_event);
    s1_act14  (layer12_out, layer14_out, n_events, tracks_per_event);
    s1_dense15(layer14_out, layer15_out, n_events, tracks_per_event);
    s1_act17  (layer15_out, out,         n_events, tracks_per_event);
}
