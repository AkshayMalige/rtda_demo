#include "rtda_split_top.h"

// ===========================================================================
//  The top level is a PIPELINE, not a loop nest.
//
//  It used to be: for each event, for each track, run the embedding, read its
//  answer back, run solver0, read its answer back, ... and only then start
//  the next track. One track took 17,039 cycles and an event 851,956 -- with
//  thirteen of the fourteen dense engines idle at every instant, because a
//  blocking `s.read()` is a hard sequence point and the hardware to run the
//  next track was sitting right there.
//
//  Now the eight boxes below are concurrent processes joined by FIFOs. Each
//  one loops over every track of the call, so track j is in the output dense
//  while track j+13 is still in the embedding, and the whole thing runs at
//  the interval of its SLOWEST stage rather than the sum of all of them.
//
//    feed_tracks -> embed_stage -> solver0 -> solver1 -> solver2 ->
//                   event_mean -> output_stage -> write_result
//
//  Two properties make this cheap to trust:
//
//  * NO ARITHMETIC CHANGED. Same layers, same operands, same order, same
//    types. The output must be BIT-IDENTICAL to the shipped design, and
//    `make csim` against pl_fixed/native/ -- which compiles these same
//    sources with g++ -- is the gate that says so. Anything but 0.000e+00
//    means this restructuring broke something.
//
//  * IT CANNOT DEADLOCK. The graph is a pure feed-forward DAG: every process
//    consumes exactly one token per track from each of its inputs and
//    produces exactly one on each of its outputs, and no channel ever runs
//    backwards. The roll history -- the one piece of state that does look
//    like feedback -- lives INSIDE the solver that needs it (see
//    RTDA_ROLL_STAGE in rtda_stage.h) and never crosses a channel. So the
//    FIFO depths below are a throughput knob, not a correctness one.
//
//  WHAT IS NOT IN THE DATAFLOW REGION: nothing. Everything that used to sit
//  between the loops -- zeroing the accumulator, the mean, the 128->27 dense,
//  the writes -- is now inside one of the per-event processes at the tail.
//  The region therefore contains only stream declarations and process calls,
//  which is the canonical form a dataflow region requires; a scalar computed
//  here (`n_events * tracks_per_event`, say) would break that, which is why
//  every process takes the two counts and does its own nested loop.
// ===========================================================================

// ---------------------------------------------------------------------------
//  Source. m_axi -> quantized 6-wide tokens, one per track.
//
//  Identical to the old QuantIn loop, including the cast: track_data is
//  float and the network runs in rtda_act_t. Reading it in one process in
//  address order is also what lets HLS infer a burst on gmem0.
// ---------------------------------------------------------------------------
static void feed_tracks(const float* track_data,
                        hls::stream<embed_in_t>& out,
                        int n_events, int tracks_per_event) {
FeedEvent:
    for (int ev = 0; ev < n_events; ev++) {
        #pragma HLS LOOP_TRIPCOUNT min=1 max=1000 avg=1000
        // track_data is event-major: event ev starts here.
        const long ev_base = (long)ev * tracks_per_event * INPUT_SIZE;
    FeedTrack:
        for (int j = 0; j < tracks_per_event; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=50 max=50 avg=50
            embed_in_t e;
        QuantIn:
            for (int i = 0; i < INPUT_SIZE; i++) {
                #pragma HLS PIPELINE
                e.data[i] = (rtda_act_t)track_data[ev_base + j * INPUT_SIZE + i];
            }
            out.write(e);
        }
    }
}

// ---------------------------------------------------------------------------
//  Sink, part 1: the event mean.
//
//  Consumes one token per track and emits one per event, which is where the
//  design's rate changes. `acc` is float, not rtda_act_t: summing up to 50
//  activations of order 1 would need 6 more integer bits, and the sum is only
//  ever divided and written out. ONE accumulator, reused per event.
//
//  warmup is a runtime argument: warmup=3 gives the tracks-3..49 mean that is
//  comparable to the circular-roll reference, warmup=0 the all-50 mean the
//  AIE hardware produces. See rtda_split_top.h. j is the index WITHIN the
//  event, so this skips the head of every event -- not just of the call.
//
//  The `if (j >= warmup)` is a branch inside one process, not a conditionally
//  executed task, so it costs the dataflow region nothing and needs no
//  masking: `counted` and the accumulate are exactly the shipped design's.
// ---------------------------------------------------------------------------
static void event_mean(hls::stream<hidden_t>& in,
                       float* mean128,
                       hls::stream<hidden_t>& mean_out,
                       int n_events, int tracks_per_event, int warmup) {
    float acc[HIDDEN];

MeanEvent:
    for (int ev = 0; ev < n_events; ev++) {
        #pragma HLS LOOP_TRIPCOUNT min=1 max=1000 avg=1000
    InitAcc:
        for (int k = 0; k < HIDDEN; k++) {
            #pragma HLS PIPELINE
            acc[k] = 0.0f;
        }
        int counted = 0;

    MeanTrack:
        for (int j = 0; j < tracks_per_event; j++) {
            #pragma HLS LOOP_TRIPCOUNT min=50 max=50 avg=50
            hidden_t s2_out = in.read();
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
        hidden_t mean_v;
    Mean:
        for (int k = 0; k < HIDDEN; k++) {
            #pragma HLS PIPELINE
            const float m = acc[k] * inv;
            mean128[(long)ev * HIDDEN + k] = m;  // the primary output, full float
            mean_v.data[k] = (rtda_act_t)m;      // quantized copy for the output dense
        }
        mean_out.write(mean_v);
    }
}

// ---------------------------------------------------------------------------
//  Sink, part 2: the 27 deliverables, one row per event.
// ---------------------------------------------------------------------------
static void write_result(hls::stream<out27_t>& in, float* result27,
                         int n_events) {
ResultEvent:
    for (int ev = 0; ev < n_events; ev++) {
        #pragma HLS LOOP_TRIPCOUNT min=1 max=1000 avg=1000
        out27_t out_v = in.read();
    Result:
        for (int k = 0; k < OUT_DIM; k++) {
            #pragma HLS PIPELINE
            result27[(long)ev * OUT_DIM + k] = (float)out_v.data[k];
        }
    }
}

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

    #pragma HLS DATAFLOW

    // Each bundle is touched by exactly one process -- gmem0 by feed_tracks,
    // gmem1 by event_mean, gmem2 by write_result -- so no port is shared
    // across the region.
    hls::stream<embed_in_t> s_track("s_track");
    hls::stream<hidden_t>   s_embed("s_embed");
    hls::stream<hidden_t>   s_solver0("s_solver0");
    hls::stream<hidden_t>   s_solver1("s_solver1");
    hls::stream<hidden_t>   s_solver2("s_solver2");
    hls::stream<hidden_t>   s_mean("s_mean");
    hls::stream<out27_t>    s_out27("s_out27");

    // DEPTH 2 ON EVERY 128-WIDE CHANNEL, and that is a measurement, not a
    // default. Depth 4 was tried first, on the theory that a token of slack
    // would let a fast stage run ahead of a slow one. It bought nothing --
    // csynth already reports this design running at the interval of one
    // 128x128 dense at reuse factor 1024, which is its floor -- and it cost
    // 550 BRAM_18K, taking the estimate from 47% to 89%. The binding is a
    // cliff, not a slope:
    //
    //     layer3_out_U   depth 2    0 BRAM   487 FF     <- shift registers
    //     s_curr_U       depth 4   50 BRAM   778 FF     <- "Vivado Default RAMs"
    //
    // Above two, HLS stops using shift registers and spends 50 BRAM_18K on
    // 8,192 bits. Eleven channels of that was the entire BRAM increase.
    //
    // Depth 2 is ping-pong, and it is sufficient here for a structural
    // reason: every process consumes one token per track and produces one,
    // so the slowest stage sets the pace and a deeper queue in front of it
    // only moves where the waiting happens. The narrow channels are free, so
    // they keep a little slack.
    #pragma HLS STREAM variable=s_track   depth=8
    #pragma HLS STREAM variable=s_embed   depth=2
    #pragma HLS STREAM variable=s_solver0 depth=2
    #pragma HLS STREAM variable=s_solver1 depth=2
    #pragma HLS STREAM variable=s_solver2 depth=2
    #pragma HLS STREAM variable=s_mean    depth=2
    #pragma HLS STREAM variable=s_out27   depth=4

    feed_tracks(track_data, s_track, n_events, tracks_per_event);
    embed_stage(s_track, s_embed, n_events, tracks_per_event);
    solver0_stage(s_embed,   s_solver0, n_events, tracks_per_event, reset);
    solver1_stage(s_solver0, s_solver1, n_events, tracks_per_event, reset);
    solver2_stage(s_solver1, s_solver2, n_events, tracks_per_event, reset);
    event_mean(s_solver2, mean128, s_mean, n_events, tracks_per_event, warmup);
    output_stage(s_mean, s_out27, n_events);
    write_result(s_out27, result27, n_events);
}
