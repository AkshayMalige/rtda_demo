#include "roll_concat.h"
#include <aie_api/aie.hpp>

using namespace adf;

void roll_concat_kernel(adf::input_buffer<float>& __restrict in,
                        adf::output_buffer<float>& __restrict out0) {
    constexpr int N  = HIDDEN_SIZE;
    constexpr int tH = 4; // wrap threshold
    constexpr int K  = 2;

    static float frames[2][N];
    static float first_frame[N];   // keep first frame of each window
    static int iter = 0;
    static bool has_prev = false;
    static bool first_saved = false;

    auto in_it  = aie::begin(in);
    auto out_it = aie::begin(out0);

    const int curr_idx = iter % 2;
    const int prev_idx = (iter + 1) % 2;

    // Read new frame first
    for (int i = 0; i < N; ++i)
        frames[curr_idx][i] = *in_it++;

    // Save first frame of the window
    if ((iter % tH) == 0) {
        for (int i = 0; i < N; ++i)
            first_frame[i] = frames[curr_idx][i];
        first_saved = true;
    }

    if (has_prev) {
        if (((iter + 1) % tH) == 0 && first_saved) {
            // wrap-back pair at window end: [last, first]
            for (int i = 0; i < N; ++i)
                *out_it++ = frames[prev_idx][i];
            for (int i = 0; i < N; ++i)
                *out_it++ = first_frame[i];
        } else {
            // normal [prev, curr]
            for (int i = 0; i < N; ++i)
                *out_it++ = frames[prev_idx][i];
            for (int i = 0; i < N; ++i)
                *out_it++ = frames[curr_idx][i];
        }
    }

    has_prev = true;
    iter++;
}
