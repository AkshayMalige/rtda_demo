#pragma once
// ===========================================================================
//  Turning one hls4ml layer into one dataflow PROCESS.
//
//  The design used to run one track through all fourteen dense layers and
//  then start the next track, so thirteen of the fourteen engines were idle
//  at any instant. Every engine is now a persistent process that loops over
//  every track of the call, and the processes are wired together with FIFOs
//  by `#pragma HLS DATAFLOW` -- so track j is in the output dense while track
//  j+13 is in the embedding.
//
//  WHY THESE ARE MACROS AND NOT A TEMPLATE
//  The obvious template would take the weight and bias arrays as function
//  arguments. That is exactly what nnet::dense does today and it is fine
//  there, because nnet::dense carries `#pragma HLS INLINE recursive` and the
//  argument disappears. A dataflow PROCESS is not inlined, so the same
//  argument would survive into the RTL as a memory port on a ROM that
//  `dense_resource` has already reshaped with
//  `#pragma HLS ARRAY_RESHAPE variable=weights block factor=block_factor`.
//  Reshaped arrays do not travel through function boundaries well. Naming the
//  namespace-scope arrays directly inside the process -- which is what these
//  macros do -- keeps the ROM exactly where it is today.
//
//  WHAT EACH MACRO BUILDS
//      NAME##_one(in, out)   ONE invocation, `INLINE off`.
//                            The dense's own `PIPELINE II=1 rewind` then
//                            still sits in the outermost loop of its own
//                            function, which is where `rewind` is honoured
//                            and is how the shipped design got 1027 cycles
//                            out of a reuse factor of 1024.
//      NAME(in, out, n_events, tracks_per_event)
//                            the process: the same call, once per track, for
//                            the whole kernel call.
//
//  The nested (event, track) loop shape is deliberate and is repeated in
//  EVERY process in this design, including the ones written out by hand in
//  rtda_split_top.cpp. Each process therefore knows, from its own counters
//  alone, when a new event starts -- which is what lets the roll history
//  reset itself per event with several events in flight at once, without a
//  side-band flag. It also means no process needs `n_events *
//  tracks_per_event` computed for it, so nothing but declarations and calls
//  ever appears in a dataflow region.
//
//  NOTHING HERE CHANGES ANY ARITHMETIC. Same layers, same order, same
//  operands, same types -- only when they run. `make csim` must still report
//  0.000e+00 against the native model.
// ===========================================================================

#include "rtda_split_top.h"

// The (event, track) loop that every process shares. Bounds are runtime
// arguments -- see rtda_split_top.h for why tracks_per_event is not a #define.
#define RTDA_STAGE_LOOP(BODY)                                                  \
    for (int ev = 0; ev < n_events; ev++) {                                    \
        _Pragma("HLS LOOP_TRIPCOUNT min=1 max=1000 avg=1000")                  \
        for (int j = 0; j < tracks_per_event; j++) {                           \
            _Pragma("HLS LOOP_TRIPCOUNT min=50 max=50 avg=50")                 \
            BODY;                                                              \
        }                                                                      \
    }

// One dense layer. W and B are the namespace-scope arrays hls4ml generated.
#define RTDA_DENSE_STAGE(NAME, DATA_T, RES_T, CONFIG, W, B)                    \
    static void NAME##_one(hls::stream<DATA_T> &in, hls::stream<RES_T> &out) { \
        _Pragma("HLS INLINE off")                                              \
        nnet::dense<DATA_T, RES_T, CONFIG>(in, out, W, B);                     \
    }                                                                          \
    static void NAME(hls::stream<DATA_T> &in, hls::stream<RES_T> &out,         \
                     int n_events, int tracks_per_event) {                     \
        RTDA_STAGE_LOOP(NAME##_one(in, out))                                   \
    }

// One leaky-ReLU layer. rtda::leaky_relu, not nnet::leaky_relu -- slope 0.1
// as a shift-add, see rtda_leaky.h.
#define RTDA_ACT_STAGE(NAME, DATA_T, RES_T, CONFIG)                            \
    static void NAME##_one(hls::stream<DATA_T> &in, hls::stream<RES_T> &out) { \
        _Pragma("HLS INLINE off")                                              \
        rtda::leaky_relu<DATA_T, RES_T, CONFIG>(in, out);                      \
    }                                                                          \
    static void NAME(hls::stream<DATA_T> &in, hls::stream<RES_T> &out,         \
                     int n_events, int tracks_per_event) {                     \
        RTDA_STAGE_LOOP(NAME##_one(in, out))                                   \
    }

// The two-input merge in front of each solver's first activation.
#define RTDA_ADD_STAGE(NAME, IN1_T, IN2_T, RES_T, CONFIG)                      \
    static void NAME##_one(hls::stream<IN1_T> &a, hls::stream<IN2_T> &b,       \
                           hls::stream<RES_T> &out) {                          \
        _Pragma("HLS INLINE off")                                              \
        nnet::add<IN1_T, IN2_T, RES_T, CONFIG>(a, b, out);                     \
    }                                                                          \
    static void NAME(hls::stream<IN1_T> &a, hls::stream<IN2_T> &b,             \
                     hls::stream<RES_T> &out,                                  \
                     int n_events, int tracks_per_event) {                     \
        RTDA_STAGE_LOOP(NAME##_one(a, b, out))                                 \
    }

// ---------------------------------------------------------------------------
//  The roll, as a process.
//
//  Solver k reads its own input for track j AND for track j-1 -- "each track
//  pairs with whatever physically preceded it", the streaming convention the
//  AIE design also uses (see rtda_split_top.h). The shipped design kept the
//  three histories in `static` arrays at the top level and shifted them after
//  all three solvers had run, which is a hard sequence point: nothing can
//  start on track j+1 until track j has been through the whole chain.
//
//  Here each solver owns its own one-track delay, because the value it needs
//  IS its own previous input. The process emits (current, previous) as two
//  tokens, so the delay never leaves the process and the chain stays a pure
//  feed-forward DAG -- which is what makes this design structurally incapable
//  of deadlocking whatever the FIFO depths are.
//
//  `hist` is `static` for the same reason the top-level arrays were: with
//  reset=false the history has to run on across event boundaries AND across
//  kernel calls, the way the AIE's carry does. One instantiation per solver
//  because each solver proxy is its own translation unit, so the three
//  histories cannot alias -- in C simulation and the native model as much as
//  in the RTL.
//
//  Reading hist[i] and overwriting it in the same iteration is the Prev0 and
//  Shift loops of the shipped design fused: element i is read before it is
//  written and no other element is touched, so the values are identical.
// ---------------------------------------------------------------------------
#define RTDA_ROLL_STAGE(NAME, CURR_T, PREV_T)                                  \
    static void NAME(hls::stream<hidden_t> &in, hls::stream<CURR_T> &curr,     \
                     hls::stream<PREV_T> &prev, int n_events,                  \
                     int tracks_per_event, bool reset) {                       \
        static rtda_act_t hist[HIDDEN];                                        \
        for (int ev = 0; ev < n_events; ev++) {                                \
            _Pragma("HLS LOOP_TRIPCOUNT min=1 max=1000 avg=1000")              \
            if (reset) {                                                       \
                for (int i = 0; i < HIDDEN; i++) {                             \
                    _Pragma("HLS PIPELINE")                                    \
                    hist[i] = rtda_act_t(0);                                   \
                }                                                              \
            }                                                                  \
            for (int j = 0; j < tracks_per_event; j++) {                       \
                _Pragma("HLS LOOP_TRIPCOUNT min=50 max=50 avg=50")             \
                hidden_t c = in.read();                                        \
                PREV_T p;                                                      \
                for (int i = 0; i < HIDDEN; i++) {                             \
                    _Pragma("HLS PIPELINE")                                    \
                    p.data[i] = hist[i];                                       \
                    hist[i] = c.data[i];                                       \
                }                                                              \
                curr.write(c);                                                 \
                prev.write(p);                                                 \
            }                                                                  \
        }                                                                      \
    }
