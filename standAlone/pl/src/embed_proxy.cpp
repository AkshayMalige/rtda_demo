// Embed proxy: wraps split_embed firmware in an isolated namespace.
// All sub-project types (input_t, result_t, config2, w2, etc.) are namespace-scoped
// to avoid ODR conflicts with other proxies that share weight variable names.

#include "rtda_split_top.h"  // global nnet includes + canonical types

namespace emb_fw {
#include "../../../hls_projects/split_embed/firmware/defines.h"
#include "../../../hls_projects/split_embed/firmware/parameters.h"
}

void embed_run(hls::stream<embed_in_t>& in, hls::stream<hidden_t>& out) {
    using namespace emb_fw;

#ifndef __SYNTHESIS__
    static bool loaded = false;
    if (!loaded) {
        nnet::load_weights_from_txt<model_default_t, 768>(w2, "emb_w2.txt");
        nnet::load_weights_from_txt<model_default_t, 128>(b2, "emb_b2.txt");
        nnet::load_weights_from_txt<model_default_t, 16384>(w5, "emb_w5.txt");
        nnet::load_weights_from_txt<model_default_t, 128>(b5, "emb_b5.txt");
        loaded = true;
    }
#endif

    // embed_in_t (6-wide) == input_t (6-wide): direct copy
    embed_in_t ci = in.read();
    input_t li;
    for (int i = 0; i < INPUT_SIZE; i++) li.data[i] = ci.data[i];

    hls::stream<input_t>  s_in("s_in");   s_in.write(li);
    hls::stream<layer2_t> layer2_out("layer2_out");
    hls::stream<layer4_t> layer4_out("layer4_out");
    hls::stream<layer5_t> layer5_out("layer5_out");
    hls::stream<result_t> s_out("s_out");

    // Forward pass matching split_embed/firmware/myproject.cpp
    nnet::dense<input_t, layer2_t, config2>(s_in, layer2_out, w2, b2);
    nnet::leaky_relu<layer2_t, model_default_t, layer4_t, LeakyReLU_config4>(layer2_out, 0.125, layer4_out);
    nnet::dense<layer4_t, layer5_t, config5>(layer4_out, layer5_out, w5, b5);
    nnet::leaky_relu<layer5_t, model_default_t, result_t, LeakyReLU_config7>(layer5_out, 0.125, s_out);

    // result_t (128-wide) == hidden_t (128-wide)
    result_t lo = s_out.read();
    hidden_t ho;
    for (int i = 0; i < HIDDEN; i++) ho.data[i] = lo.data[i];
    out.write(ho);
}
