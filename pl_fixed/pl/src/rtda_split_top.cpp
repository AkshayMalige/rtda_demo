#include "rtda_split_top.h"

extern "C" void rtda_split_top(
    const float* track_data,
    float*       mean128,
    float*       result27,
    int          n_events,
    int          tracks_per_event,
    int          warmup,
    bool         reset
) {
    // depth= is a COSIM estimate, not a hardware bound -- the AXI master
    // addresses whatever the host allocated. Sized here for a 1000-event call
    // (the shipped run) so the cosim model is not absurdly smaller than reality.
    #pragma HLS INTERFACE m_axi port=track_data bundle=gmem0 depth=300000
    #pragma HLS INTERFACE m_axi port=mean128    bundle=gmem1 depth=128000
    #pragma HLS INTERFACE m_axi port=result27   bundle=gmem2 depth=27000
    #pragma HLS INTERFACE s_axilite port=n_events         bundle=control
    #pragma HLS INTERFACE s_axilite port=tracks_per_event bundle=control
    #pragma HLS INTERFACE s_axilite port=warmup           bundle=control
    #pragma HLS INTERFACE s_axilite port=reset            bundle=control
    #pragma HLS INTERFACE s_axilite port=return           bundle=control

    // The streaming roll: each track pairs with whatever physically preceded
    // it. static so that with reset=false the history runs on across event
    // boundaries AND across calls, the way the AIE's carry does. With
    // reset=true -- what every host passes -- it is zeroed per event below.
    static rtda_act_t emb_prev[HIDDEN];
    static rtda_act_t s0_prev[HIDDEN];
    static rtda_act_t s1_prev[HIDDEN];

    // float, not rtda_act_t: summing up to 50 activations of order 1 would need
    // 6 more integer bits, and the sum is only ever divided and written out.
    // ONE accumulator, reused per event rather than replicated -- covering many
    // events per call costs no extra on-chip storage.
    float acc[HIDDEN];

EventLoop:
    for (int ev = 0; ev < n_events; ev++) {
        #pragma HLS LOOP_TRIPCOUNT min=1 max=1000 avg=1000

        // Per EVENT, not per call. This is what the old one-event-per-call form
        // got for free by being a fresh call; now that one call spans many
        // events the kernel has to do it itself, or every event after the first
        // would start with the previous event's last track as its predecessor.
        if (reset) {
        ResetState:
            for (int i = 0; i < HIDDEN; i++) {
                #pragma HLS PIPELINE
                emb_prev[i] = rtda_act_t(0);
                s0_prev[i]  = rtda_act_t(0);
                s1_prev[i]  = rtda_act_t(0);
            }
        }

    InitAcc:
        for (int k = 0; k < HIDDEN; k++) {
            #pragma HLS PIPELINE
            acc[k] = 0.0f;
        }
        int counted = 0;

        // track_data is event-major: event ev starts here.
        const long ev_base = (long)ev * tracks_per_event * INPUT_SIZE;

    TrackLoop:
        for (int j = 0; j < tracks_per_event; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=50 max=50 avg=50
            hls::stream<embed_in_t> emb_in_s("emb_in_s");
            embed_in_t emb_in;
        QuantIn:
            for (int i = 0; i < INPUT_SIZE; i++) {
                #pragma HLS PIPELINE
                emb_in.data[i] = (rtda_act_t)track_data[ev_base + j * INPUT_SIZE + i];
            }
            emb_in_s.write(emb_in);

            hls::stream<hidden_t> emb_out_s("emb_out_s");
            embed_run(emb_in_s, emb_out_s);
            hidden_t emb_out = emb_out_s.read();

            // solver k takes (current stage output, previous track's stage output)
            hls::stream<hidden_t> s0c_s("s0c_s"), s0p_s("s0p_s"), s0_out_s("s0_out_s");
            hidden_t prev0;
        Prev0:
            for (int i = 0; i < HIDDEN; i++) {
                #pragma HLS PIPELINE
                prev0.data[i] = emb_prev[i];
            }
            s0c_s.write(emb_out);
            s0p_s.write(prev0);
            solver0_run(s0c_s, s0p_s, s0_out_s);
            hidden_t s0_out = s0_out_s.read();

            hls::stream<hidden_t> s1c_s("s1c_s"), s1p_s("s1p_s"), s1_out_s("s1_out_s");
            hidden_t prev1;
        Prev1:
            for (int i = 0; i < HIDDEN; i++) {
                #pragma HLS PIPELINE
                prev1.data[i] = s0_prev[i];
            }
            s1c_s.write(s0_out);
            s1p_s.write(prev1);
            solver1_run(s1c_s, s1p_s, s1_out_s);
            hidden_t s1_out = s1_out_s.read();

            hls::stream<hidden_t> s2c_s("s2c_s"), s2p_s("s2p_s"), s2_out_s("s2_out_s");
            hidden_t prev2;
        Prev2:
            for (int i = 0; i < HIDDEN; i++) {
                #pragma HLS PIPELINE
                prev2.data[i] = s1_prev[i];
            }
            s2c_s.write(s1_out);
            s2p_s.write(prev2);
            solver2_run(s2c_s, s2p_s, s2_out_s);
            hidden_t s2_out = s2_out_s.read();

        Shift:
            for (int i = 0; i < HIDDEN; i++) {
                #pragma HLS PIPELINE
                emb_prev[i] = emb_out.data[i];
                s0_prev[i]  = s0_out.data[i];
                s1_prev[i]  = s1_out.data[i];
            }

            // warmup is a runtime argument: warmup=3 gives the tracks-3..49 mean
            // that is comparable to the circular-roll reference, warmup=0 the
            // all-50 mean the AIE hardware produces. See rtda_split_top.h.
            // j is the index WITHIN the event, so this skips the head of every
            // event -- not just the head of the call.
            if (j >= warmup) {
            Accumulate:
                for (int k = 0; k < HIDDEN; k++) {
                    #pragma HLS PIPELINE
                    acc[k] += (float)s2_out.data[k];
                }
                counted++;
            }
        }

        const float inv = (counted > 0) ? 1.0f / (float)counted : 1.0f;

        hls::stream<hidden_t> mean_s("mean_s");
        hidden_t mean_v;
    Mean:
        for (int k = 0; k < HIDDEN; k++) {
            #pragma HLS PIPELINE
            const float m = acc[k] * inv;
            mean128[(long)ev * HIDDEN + k] = m;  // the primary output, full float
            mean_v.data[k] = (rtda_act_t)m;      // quantized copy for the output dense
        }
        mean_s.write(mean_v);

        hls::stream<out27_t> out_s("out_s");
        output_run(mean_s, out_s);
        out27_t out_v = out_s.read();

    Result:
        for (int k = 0; k < OUT_DIM; k++) {
            #pragma HLS PIPELINE
            result27[(long)ev * OUT_DIM + k] = (float)out_v.data[k];
        }
    }
}
