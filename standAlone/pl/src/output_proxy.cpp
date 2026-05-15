// Output proxy: wraps split_output firmware in an isolated namespace.

#include "rtda_split_top.h"

namespace out_fw {
#include "../../../hls_projects/split_output/firmware/defines.h"
#include "../../../hls_projects/split_output/firmware/parameters.h"
}

void output_run(hls::stream<hidden_t>& in, hls::stream<out27_t>& out) {
    using namespace out_fw;

#ifndef __SYNTHESIS__
    static bool loaded = false;
    if (!loaded) {
        nnet::load_weights_from_txt<model_default_t, 3456>(w2, "out_w2.txt");
        nnet::load_weights_from_txt<model_default_t, 27>(b2,   "out_b2.txt");
        loaded = true;
    }
#endif

    // hidden_t (128-wide) == input_t (128-wide)
    hidden_t hi = in.read();
    input_t li;
    for (int i = 0; i < HIDDEN; i++) li.data[i] = hi.data[i];

    hls::stream<input_t>  s_in("s_in");  s_in.write(li);
    hls::stream<result_t> s_out("s_out");

    // Forward pass matching split_output/firmware/myproject.cpp
    nnet::dense<input_t, result_t, config2>(s_in, s_out, w2, b2);

    // result_t (27-wide) == out27_t (27-wide)
    result_t lo = s_out.read();
    out27_t ho;
    for (int i = 0; i < OUT_DIM; i++) ho.data[i] = lo.data[i];
    out.write(ho);
}
