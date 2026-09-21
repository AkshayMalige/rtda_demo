// Output proxy: wraps split_output firmware in an isolated namespace.
//
// The only block that runs once per EVENT rather than once per track, so it
// is not a dataflow region: one 128->27 dense at reuse factor 128 costs 453
// cycles against the ~51,500 an event takes, and overlapping it with itself
// would save nothing. It is still a persistent process -- it loops over every
// event of the call -- because that is what lets the tail run concurrently
// with the tracks of the NEXT event still coming down the pipeline.

#include "rtda_split_top.h"
#include "rtda_stage.h"

namespace out_fw {
#include "../firmware/output/defines.h"
#include "../firmware/output/parameters.h"
}
using namespace out_fw;

// Same type, not merely the same shape -- see the note in solver0_proxy.cpp.
// The 27 deliverables are rtda_out_t, the narrow-range format; that is the
// one place in the design where the canonical type is not rtda_act_t.
static_assert(std::is_same<hidden_t, input_t>::value,
              "hidden_t and out_fw::input_t must be the same type");
static_assert(std::is_same<out27_t, result_t>::value,
              "out27_t and out_fw::result_t must be the same type");

void output_stage(hls::stream<hidden_t>& in, hls::stream<out27_t>& out,
                  int n_events) {
#ifndef __SYNTHESIS__
    static bool loaded = false;
    if (!loaded) {
        nnet::load_weights_from_txt<model_default_t, 3456>(w2, "out_w2.txt");
        nnet::load_weights_from_txt<model_default_t, 27>(b2,   "out_b2.txt");
        loaded = true;
    }
#endif

    // Forward pass matching split_output/firmware/myproject.cpp.
OutputEvent:
    for (int ev = 0; ev < n_events; ev++) {
        #pragma HLS LOOP_TRIPCOUNT min=1 max=1000 avg=1000
        nnet::dense<input_t, result_t, config2>(in, out, w2, b2);
    }
}
