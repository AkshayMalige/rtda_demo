// rtda_top.cpp
// Processes one event: 50 tracks x 6 features -> 27-dim output.
//
// myproject_stateful() wraps the hls4ml-generated myproject() and owns the
// three state BRAM arrays (emb_prev, s0_prev, s1_prev) as static locals --
// exactly like the AIE roll_concat_kernel uses 'static DATA_TYPE frames[2][N]'.
// No state ever reaches an external port.
//
// rtda_top() external interface:
//   IN  track_stream -- 50 x input_t  (nnet::array<float,6> per track, AXI-S)
//   OUT result_out   -- 1  x result_t  (27 floats in data[0..26], AXI-S)
//   IN  reset        -- pulse high before the first track of each new event

#include "firmware/myproject.h"
#include <cstring>

#define N_TRACKS  50
#define HIDDEN    128
#define OUT_DIM   27
#define WARMUP    3

// Output-layer weights (128x27) and bias (27).
// Simulation: loaded from data/*.txt on first call.
// Synthesis:  initialise from ap_uint ROM or expose via AXI-lite slave.
static float OUT_W[HIDDEN][OUT_DIM];
static float OUT_B[OUT_DIM];

#ifndef __SYNTHESIS__
#include <fstream>
#include <stdexcept>
static void _load_output_weights(const char* data_dir) {
    std::ifstream fw(std::string(data_dir) + "/output_weights.txt");
    std::ifstream fb(std::string(data_dir) + "/output_bias.txt");
    if (!fw || !fb) throw std::runtime_error("Cannot open output_weights/bias.txt");
    for (int k = 0; k < HIDDEN;  k++)
        for (int d = 0; d < OUT_DIM; d++) fw >> OUT_W[k][d];
    for (int d = 0; d < OUT_DIM; d++) fb >> OUT_B[d];
}
static bool _weights_loaded = false;
#endif

// -------------------------------------------------------------------------
// myproject_stateful()
// Stateful shell: owns emb_prev/s0_prev/s1_prev as on-chip BRAM.
// Called once per track. State never leaves this function.
// -------------------------------------------------------------------------
static void myproject_stateful(
    hls::stream<input_t>  &track_in,
    hls::stream<result_t> &s2_out,
    bool reset
) {
    static input8_t  emb_prev;  // emb_out of previous track -> state0
    static input24_t s0_prev;   // s0_out  of previous track -> state1
    static input40_t s1_prev;   // s1_out  of previous track -> state2
#pragma HLS ARRAY_PARTITION variable=emb_prev.data complete
#pragma HLS ARRAY_PARTITION variable=s0_prev.data  complete
#pragma HLS ARRAY_PARTITION variable=s1_prev.data  complete

    if (reset) {
        for (int i = 0; i < HIDDEN; i++) {
#pragma HLS UNROLL
            emb_prev.data[i] = 0.0f;
            s0_prev.data[i]  = 0.0f;
            s1_prev.data[i]  = 0.0f;
        }
    }

    // Pack stored state into streams for myproject()
    hls::stream<input8_t>  st0;  st0.write(emb_prev);
    hls::stream<input24_t> st1;  st1.write(s0_prev);
    hls::stream<input40_t> st2;  st2.write(s1_prev);

    // Capture the three intermediate outputs to update state next call
    hls::stream<layer7_t>  emb_buf;  // emb_out[j]
    hls::stream<layer23_t> s0_buf;   // s0_out[j]
    hls::stream<layer39_t> s1_buf;   // s1_out[j]

    myproject(track_in, st0, st1, st2, s2_out, emb_buf, s0_buf, s1_buf);

    // Update internal BRAM state -- stays on-chip, never leaves
    emb_prev = emb_buf.read();
    s0_prev  = s0_buf.read();
    s1_prev  = s1_buf.read();
}

// -------------------------------------------------------------------------
// rtda_top() -- top-level HLS kernel
// -------------------------------------------------------------------------
void rtda_top(
    hls::stream<input_t>  &track_stream,
    hls::stream<result_t> &result_out,
    bool                   reset,
    const char*            data_dir
) {
#pragma HLS INTERFACE axis       port=track_stream
#pragma HLS INTERFACE axis       port=result_out
#pragma HLS INTERFACE ap_ctrl_hs port=return
#pragma HLS INTERFACE ap_none    port=reset
#pragma HLS INTERFACE ap_none    port=data_dir

#ifndef __SYNTHESIS__
    if (!_weights_loaded) { _load_output_weights(data_dir); _weights_loaded = true; }
#endif

    float acc[HIDDEN];
#pragma HLS ARRAY_PARTITION variable=acc complete
    for (int i = 0; i < HIDDEN; i++) acc[i] = 0.0f;

    for (int j = 0; j < N_TRACKS; j++) {
        hls::stream<result_t> s2_buf;
        // State feedback is entirely inside myproject_stateful().
        // From here it looks like a simple one-in one-out call.
        myproject_stateful(track_stream, s2_buf, reset && (j == 0));
        result_t s2 = s2_buf.read();
        if (j >= WARMUP)
            for (int k = 0; k < HIDDEN; k++)
#pragma HLS UNROLL
                acc[k] += s2.data[k];
    }

    float mean_s2[HIDDEN];
#pragma HLS ARRAY_PARTITION variable=mean_s2 complete
    for (int k = 0; k < HIDDEN; k++)
#pragma HLS UNROLL
        mean_s2[k] = acc[k] / float(N_TRACKS - WARMUP);

    result_t final_out;
    for (int d = 0; d < OUT_DIM; d++) {
        float sum = OUT_B[d];
        for (int k = 0; k < HIDDEN; k++)
            sum += mean_s2[k] * OUT_W[k][d];
        final_out.data[d] = sum;
    }
    for (int d = OUT_DIM; d < HIDDEN; d++) final_out.data[d] = 0.0f;
    result_out.write(final_out);
}
