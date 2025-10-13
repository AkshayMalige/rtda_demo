#include "window_split_128_to_64x2.h"

void window_split_128_to_64x2(input_window<float>* __restrict in,
                              output_window<float>* __restrict out0,
                              output_window<float>* __restrict out1) {
    constexpr int N  = HIDDEN_SIZE;
    constexpr int H  = HIDDEN_SPLIT_SIZE;
    (void)N;
    for (int i = 0; i < H; ++i) {
        window_writeincr(out0, window_readincr(in));
    }
    for (int i = 0; i < H; ++i) {
        window_writeincr(out1, window_readincr(in));
    }
}

