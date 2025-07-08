#include <adf.h>
#include "../kernels.h"

using namespace adf;

void dense_1(input_window<float>* in, output_window<float>* out) {

    aie::vector<float, VEC_WIDTH_D1> data[INPUT_SIZE / VEC_WIDTH_D1];
    for (int i = 0; i < INPUT_SIZE / VEC_WIDTH_D1; i++) {
        // data[i] = aie::load_v<VEC_WIDTH_D1>(in);
        data[i] = window_readincr_v<VEC_WIDTH_D1>(in);

    }

    static float weights[HIDDEN_SIZE][INPUT_SIZE];
    static float bias[HIDDEN_SIZE];

    for (int o = 0; o < HIDDEN_SIZE; o++) {
        bias[o] = 0.1f;
        for (int i = 0; i < INPUT_SIZE; i++) {
            weights[o][i] = 0.01f * (o + i);
        }
    }

    for (int o = 0; o < HIDDEN_SIZE; o++) {
        aie::accum<acc32, VEC_WIDTH_D1> acc = aie::zeros<acc32, VEC_WIDTH_D1>();

        for (int i = 0; i < INPUT_SIZE / VEC_WIDTH_D1; i++) {
            aie::vector<float, VEC_WIDTH_D1> w = aie::load_v<VEC_WIDTH_D1>(&weights[o][i * VEC_WIDTH_D1]);
            acc = aie::mac(acc, data[i], w);
        }

        float out_val = bias[o] + aie::reduce_add(acc);
        window_writeincr(out, out_val);
    }
}