#pragma once
// ===========================================================================
//  RTDA track-alignment MLP, PL only. No AIE.
//
//  Same network, same weights (model/weights_fp32/, verified identical to the
//  AIE flow's to 5e-09) and the same streaming roll convention as the AIE
//  batched design -- so the two are directly comparable, and the only thing
//  that differs is the arithmetic.
//
//  The number format lives in rtda_fixed.h; the leaky-ReLU slope in
//  rtda_leaky.h. Neither is written literally in this file.
// ===========================================================================

#include "rtda_fixed.h"
#include "rtda_leaky.h"
#include "ap_int.h"
#include "hls_stream.h"
// For the static_asserts in the proxies that check a canonical type and the
// hls4ml type it is handed to are literally the same type, so the copy loops
// that used to convert between them can be -- and are -- gone.
#include <type_traits>

// nnet utils at global scope so the per-block proxy namespaces do not
// re-include them and collide.
#include "nnet_utils/nnet_types.h"
#include "nnet_utils/nnet_code_gen.h"
#include "nnet_utils/nnet_helpers.h"
#include "nnet_utils/nnet_activation.h"
#include "nnet_utils/nnet_activation_stream.h"
#include "nnet_utils/nnet_dense.h"
#include "nnet_utils/nnet_dense_compressed.h"
#include "nnet_utils/nnet_dense_stream.h"
#include "nnet_utils/nnet_merge.h"
#include "nnet_utils/nnet_merge_stream.h"

#define MAX_TRACKS 50      // tracks in one event -- sizes the m_axi depth
#define INPUT_SIZE 6
#define HIDDEN     128
#define OUT_DIM    27

// Canonical inter-kernel types.
typedef nnet::array<rtda_act_t, INPUT_SIZE> embed_in_t;
typedef nnet::array<rtda_act_t, HIDDEN>     hidden_t;
typedef nnet::array<rtda_out_t, OUT_DIM>    out27_t;

// ---------------------------------------------------------------------------
//  The five blocks, one per translation unit so the sub-project types
//  (input_t, result_t, config2, w2, ...) stay namespace-scoped.
//
//  Each is a PERSISTENT PROCESS, not a call: it loops over every track of the
//  whole kernel call and is itself a `#pragma HLS DATAFLOW` region over its
//  own layers. They used to take one track and return, and the top level
//  read each one's answer back before starting the next -- fourteen dense
//  engines, thirteen of them idle at any instant. See rtda_stage.h.
//
//  They take (n_events, tracks_per_event) rather than a token count so that
//  every process in the design counts events the same way and knows from its
//  own loop counters where an event begins. The solvers additionally take
//  `reset`, because each now owns the one-track delay that used to be a
//  shared static array at the top level.
// ---------------------------------------------------------------------------
void embed_stage  (hls::stream<embed_in_t>& in, hls::stream<hidden_t>& out,
                   int n_events, int tracks_per_event);
void solver0_stage(hls::stream<hidden_t>& in, hls::stream<hidden_t>& out,
                   int n_events, int tracks_per_event, bool reset);
void solver1_stage(hls::stream<hidden_t>& in, hls::stream<hidden_t>& out,
                   int n_events, int tracks_per_event, bool reset);
void solver2_stage(hls::stream<hidden_t>& in, hls::stream<hidden_t>& out,
                   int n_events, int tracks_per_event, bool reset);
// One token per EVENT, not per track: it runs on the event mean.
void output_stage (hls::stream<hidden_t>& in, hls::stream<out27_t>& out,
                   int n_events);

// ---------------------------------------------------------------------------
//  Top level.
//
//  ONE CALL COVERS n_events EVENTS. It used to cover exactly one, and the host
//  looped -- 1000 events meant 1000 kernel starts, where the AIE flow runs
//  everything in a single graph.run(). The two implementations now differ in
//  their arithmetic and their fabric, not in how the host drives them.
//
//  track_data  n_events * tracks_per_event * INPUT_SIZE floats, event-major.
//  mean128     n_events * HIDDEN floats. The event mean BEFORE the final dense,
//              one row per event. This is the primary output: it is what the
//              AIE flow's host also writes (track_means_all.txt), so the
//              analysis notebooks apply the 128->27 dense themselves and every
//              implementation is compared in exactly one place.
//  result27    n_events * OUT_DIM floats, the same thing through the output
//              dense, one row per event, for a standalone check.
//
//  tracks_per_event and warmup are RUNTIME arguments, not #defines, because the
//  two useful conventions need both:
//    warmup=3  average tracks 3..49 -- comparable to the ONNX reference, whose
//              circular roll disagrees with a streaming one on exactly the
//              first three tracks of an event.
//    warmup=0  average all 50 -- what the AIE hardware physically produces,
//              since its accumulator cannot skip the contaminated head.
//  Rebuilding the bitstream to switch between them is not acceptable when the
//  whole point is to compare against both.
//
//  reset is per EVENT, not per call:
//    reset=true   zero the roll history at the start of every event, so events
//                 are independent. This is what the hosts pass, and what
//                 warmup=3 assumes. It is also what the old one-event-per-call
//                 form did implicitly, by virtue of being a fresh call.
//    reset=false  let the history run on across event boundaries and across
//                 calls -- the AIE's never-reset carry.
//  The three histories are now one `static` array inside each solver rather
//  than three at this level (see RTDA_ROLL_STAGE in rtda_stage.h). They hold
//  the same values and carry across calls the same way -- verified bit for
//  bit against the pre-dataflow kernel, reset=false included -- but keeping
//  them out of the top level is what lets several tracks, and so two events,
//  be in flight at once without a global reset corrupting the trailing one.
// ---------------------------------------------------------------------------
extern "C" void rtda_split_top(const float* track_data,
                               float*       mean128,
                               float*       result27,
                               int          n_events,
                               int          tracks_per_event,
                               int          warmup,
                               bool         reset);
