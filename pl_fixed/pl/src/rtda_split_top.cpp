#include "rtda_split_top.h"

extern "C" void rtda_split_top(
    float* track_data,
    float* result,
    int    n_tracks,
    bool   reset
) {
    #pragma HLS INTERFACE m_axi port=track_data bundle=gmem0 depth=300
    #pragma HLS INTERFACE m_axi port=result     bundle=gmem1 depth=27
    #pragma HLS INTERFACE s_axilite port=n_tracks bundle=control
    #pragma HLS INTERFACE s_axilite port=reset    bundle=control
    #pragma HLS INTERFACE s_axilite port=return   bundle=control

    // Stateful BRAMs — persist across kernel calls (reset with reset=true)
    static ap_fixed<16,6> emb_prev[HIDDEN];
    static ap_fixed<16,6> s0_prev[HIDDEN];
    static ap_fixed<16,6> s1_prev[HIDDEN];

    if (reset) {
        for (int i = 0; i < HIDDEN; i++) {
            emb_prev[i] = ap_fixed<16,6>(0);
            s0_prev[i]  = ap_fixed<16,6>(0);
            s1_prev[i]  = ap_fixed<16,6>(0);
        }
    }

    // Accumulator in float to avoid overflow across 47 post-warmup tracks
    float acc[HIDDEN];
    for (int k = 0; k < HIDDEN; k++) acc[k] = 0.0f;
    int post_warmup = 0;

    for (int j = 0; j < n_tracks; j++) {
        // Quantize track input float → ap_fixed<16,6>
        hls::stream<embed_in_t> emb_in_s("emb_in_s");
        embed_in_t emb_in;
        for (int i = 0; i < INPUT_SIZE; i++)
            emb_in.data[i] = (ap_fixed<16,6>)track_data[j * INPUT_SIZE + i];
        emb_in_s.write(emb_in);

        // Embed block
        hls::stream<hidden_t> emb_out_s("emb_out_s");
        embed_run(emb_in_s, emb_out_s);
        hidden_t emb_out = emb_out_s.read();

        // Solver0: curr=emb_out, prev=emb_prev
        hls::stream<hidden_t> s0c_s("s0c_s"), s0p_s("s0p_s");
        hidden_t prev0;
        for (int i = 0; i < HIDDEN; i++) prev0.data[i] = emb_prev[i];
        s0c_s.write(emb_out);
        s0p_s.write(prev0);
        hls::stream<hidden_t> s0_out_s("s0_out_s");
        solver0_run(s0c_s, s0p_s, s0_out_s);
        hidden_t s0_out = s0_out_s.read();

        // Solver1: curr=s0_out, prev=s0_prev
        hls::stream<hidden_t> s1c_s("s1c_s"), s1p_s("s1p_s");
        hidden_t prev1;
        for (int i = 0; i < HIDDEN; i++) prev1.data[i] = s0_prev[i];
        s1c_s.write(s0_out);
        s1p_s.write(prev1);
        hls::stream<hidden_t> s1_out_s("s1_out_s");
        solver1_run(s1c_s, s1p_s, s1_out_s);
        hidden_t s1_out = s1_out_s.read();

        // Solver2: curr=s1_out, prev=s1_prev
        hls::stream<hidden_t> s2c_s("s2c_s"), s2p_s("s2p_s");
        hidden_t prev2;
        for (int i = 0; i < HIDDEN; i++) prev2.data[i] = s1_prev[i];
        s2c_s.write(s1_out);
        s2p_s.write(prev2);
        hls::stream<hidden_t> s2_out_s("s2_out_s");
        solver2_run(s2c_s, s2p_s, s2_out_s);
        hidden_t s2_out = s2_out_s.read();

        // Update state for next track
        for (int i = 0; i < HIDDEN; i++) {
            emb_prev[i] = emb_out.data[i];
            s0_prev[i]  = s0_out.data[i];
            s1_prev[i]  = s1_out.data[i];
        }

        // Post-warmup accumulation
        if (j >= WARMUP) {
            for (int k = 0; k < HIDDEN; k++)
                acc[k] += (float)s2_out.data[k];
            post_warmup++;
        }
    }

    // Mean of post-warmup solver2 outputs
    float inv = (post_warmup > 0) ? 1.0f / (float)post_warmup : 1.0f;
    hls::stream<hidden_t> mean_s("mean_s");
    hidden_t mean_v;
    for (int k = 0; k < HIDDEN; k++)
        mean_v.data[k] = (ap_fixed<16,6>)(acc[k] * inv);
    mean_s.write(mean_v);

    // Output layer: 128 → 27
    hls::stream<out27_t> out_s("out_s");
    output_run(mean_s, out_s);
    out27_t out_v = out_s.read();

    for (int k = 0; k < OUT_DIM; k++)
        result[k] = (float)out_v.data[k];
}
