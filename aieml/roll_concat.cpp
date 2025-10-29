#include "roll_concat.h"
#include <aie_api/aie.hpp>

using namespace adf;

void roll_concat_kernel(adf::input_buffer<float>& __restrict in,
                        adf::output_buffer<float>& __restrict out0) {
    constexpr int N  = HIDDEN_SIZE;   // e.g. 128
    constexpr int tH = 4;             // wrap threshold (counts only valid frames)
    constexpr int K  = 2;             // concat(prev, curr) -> 2*N outputs

    // Two-frame circular buffer + snapshot of "first frame of current window"
    static float frames[2][N];
    static float first_snapshot[N];

    // State over valid (non-zero) frames only
    static int  iter_valid   = 0;     // increments only on non-zero frames
    static bool active       = false; // true after first non-zero arrives
    static bool has_prev     = false; // true after at least one valid stored
    static bool wrap_pending = false; // next valid emits wrap pair using snapshot

    auto in_it  = aie::begin(in);
    auto out_it = aie::begin(out0);

    // Read one input frame and detect all-zero
    float cur[N];
    bool all_zero = true;
    for (int i = 0; i < N; ++i) {
        float v = *in_it++;
        cur[i] = v;
        if (v != 0.0f) all_zero = false;
    }

    auto write_zeros = [&](int count){ for (int i = 0; i < count; ++i) *out_it++ = 0.0f; };

    // INACTIVE: output zeros until first non-zero arrives
    if (!active) {
        if (all_zero) {
            write_zeros(2 * N);
            return;
        } else {
            // First non-zero frame: store it, set snapshot (first-of-window),
            // but still output zeros this call (need a pair next time)
            const int curr_idx = iter_valid % 2; // 0 on first valid
            for (int i = 0; i < N; ++i) {
                frames[curr_idx][i] = cur[i];
                first_snapshot[i]   = cur[i]; // <-- snapshot first-of-window
            }
            active   = true;
            has_prev = true;
            iter_valid++;
            if ((iter_valid % tH) == 0) wrap_pending = true;

            write_zeros(2 * N);
            return;
        }
    }

    // ACTIVE
    // If a zero frame appears, do not advance state; keep outputs zero
    if (all_zero) {
        write_zeros(2 * N);
        return;
    }

    // Determine indices before we increment iter_valid
    const int curr_idx = iter_valid % 2;
    const int prev_idx = (iter_valid + 1) % 2;
    const bool is_first_of_window = ((iter_valid % tH) == 0);

    if (has_prev) {
        if (wrap_pending) {
            // Emit wrap pair using the *previous window's* first frame snapshot
            for (int i = 0; i < N; ++i) *out_it++ = frames[prev_idx][i];   // last of prev window
            for (int i = 0; i < N; ++i) *out_it++ = first_snapshot[i];     // first of prev window
            wrap_pending = false;
        } else {
            // Normal pair [prev, curr]
            for (int i = 0; i < N; ++i) *out_it++ = frames[prev_idx][i];
            for (int i = 0; i < N; ++i) *out_it++ = cur[i];
        }
    } else {
        // Defensive (shouldn’t occur once active)
        write_zeros(2 * N);
    }

    // Save current valid frame
    for (int i = 0; i < N; ++i) frames[curr_idx][i] = cur[i];

    // If this is the first frame of a new window, update snapshot *after* using the old one
    if (is_first_of_window) {
        for (int i = 0; i < N; ++i) first_snapshot[i] = cur[i];
    }

    // Advance valid counter and manage wrap scheduling
    iter_valid++;
    if ((iter_valid % tH) == 0) {
        // We've just completed a window; next valid frame will emit wrap with snapshot
        wrap_pending = true;
    }
}