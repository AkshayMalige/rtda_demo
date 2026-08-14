// Solver1 proxy: wraps split_solver1 firmware in an isolated namespace.

#include "rtda_split_top.h"

namespace s1_fw {
#include "../firmware/solver1/defines.h"
#include "../firmware/solver1/parameters.h"
}

void solver1_run(hls::stream<hidden_t>& curr, hls::stream<hidden_t>& prev, hls::stream<hidden_t>& out) {
    using namespace s1_fw;

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

    hidden_t hc = curr.read(), hp = prev.read();
    input_t  li_curr; input2_t li_prev;
    for (int i = 0; i < HIDDEN; i++) { li_curr.data[i] = hc.data[i]; li_prev.data[i] = hp.data[i]; }

    hls::stream<input_t>   s_curr("s_curr");   s_curr.write(li_curr);
    hls::stream<input2_t>  s_prev("s_prev");   s_prev.write(li_prev);
    hls::stream<layer3_t>  layer3_out("layer3_out");
    hls::stream<layer5_t>  layer5_out("layer5_out");
    hls::stream<layer7_t>  layer7_out("layer7_out");
    hls::stream<layer8_t>  layer8_out("layer8_out");
    hls::stream<layer9_t>  layer9_out("layer9_out");
    hls::stream<layer11_t> layer11_out("layer11_out");
    hls::stream<layer12_t> layer12_out("layer12_out");
    hls::stream<layer14_t> layer14_out("layer14_out");
    hls::stream<layer15_t> layer15_out("layer15_out");
    hls::stream<result_t>  s_out("s_out");

    nnet::dense<input_t,  layer3_t, config3>(s_curr, layer3_out, w3, b3);
    nnet::dense<input2_t, layer5_t, config5>(s_prev, layer5_out, w5, b5);
    nnet::add<layer3_t, layer5_t, layer7_t, config7>(layer3_out, layer5_out, layer7_out);
    rtda::leaky_relu<layer7_t, layer8_t, LeakyReLU_config8>(layer7_out, layer8_out);
    nnet::dense<layer8_t,  layer9_t,  config9> (layer8_out,  layer9_out,  w9,  b9);
    rtda::leaky_relu<layer9_t, layer11_t, LeakyReLU_config11>(layer9_out, layer11_out);
    nnet::dense<layer11_t, layer12_t, config12>(layer11_out, layer12_out, w12, b12);
    rtda::leaky_relu<layer12_t, layer14_t, LeakyReLU_config14>(layer12_out, layer14_out);
    nnet::dense<layer14_t, layer15_t, config15>(layer14_out, layer15_out, w15, b15);
    rtda::leaky_relu<layer15_t, result_t, LeakyReLU_config17>(layer15_out, s_out);

    result_t lo = s_out.read();
    hidden_t ho;
    for (int i = 0; i < HIDDEN; i++) ho.data[i] = lo.data[i];
    out.write(ho);
}
