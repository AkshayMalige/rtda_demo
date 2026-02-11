#include "roll_concat.h"
#include <aie_api/aie.hpp>

using namespace adf;

// Macro generates a complete, independent function with its own static state.
// This guarantees separate statics per solver instance in x86sim where all
// kernels share the same address space.
#define DEFINE_ROLL_CONCAT(FUNC_NAME)                                          \
void FUNC_NAME(input_window<DATA_TYPE>* __restrict in,                         \
               output_window<DATA_TYPE>* __restrict out0) {                    \
    constexpr int N  = HIDDEN_SIZE;                                            \
    constexpr int tH = 50;                                                     \
    constexpr int K  = 2;                                                      \
                                                                               \
    static DATA_TYPE frames[2][N];                                             \
    static DATA_TYPE first_snapshot[N];                                        \
    static int  iter_valid   = 0;                                              \
    static bool active       = false;                                          \
    static bool has_prev     = false;                                          \
    static bool wrap_pending = false;                                          \
                                                                               \
    DATA_TYPE* in_ptr  = (DATA_TYPE*)in->ptr;                                  \
    DATA_TYPE* out_ptr = (DATA_TYPE*)out0->ptr;                                \
                                                                               \
    DATA_TYPE cur[N];                                                          \
    bool all_zero = true;                                                      \
    for (int i = 0; i < N; ++i) {                                              \
        DATA_TYPE v = *in_ptr++;                                               \
        cur[i] = v;                                                            \
        if (v != (DATA_TYPE)0) all_zero = false;                               \
    }                                                                          \
                                                                               \
    auto write_zeros = [&](int count) {                                        \
        for (int i = 0; i < count; ++i) *out_ptr++ = (DATA_TYPE)0;            \
    };                                                                         \
                                                                               \
    if (!active) {                                                             \
        if (all_zero) {                                                        \
            write_zeros(2 * N);                                                \
            window_incr(in, N);                                                \
            window_incr(out0, 2 * N);                                          \
            return;                                                            \
        } else {                                                               \
            const int curr_idx = iter_valid % 2;                               \
            for (int i = 0; i < N; ++i) {                                      \
                frames[curr_idx][i] = cur[i];                                  \
                first_snapshot[i]   = cur[i];                                  \
            }                                                                  \
            active   = true;                                                   \
            has_prev = true;                                                   \
            iter_valid++;                                                      \
            if ((iter_valid % tH) == 0) wrap_pending = true;                   \
            write_zeros(2 * N);                                                \
            window_incr(in, N);                                                \
            window_incr(out0, 2 * N);                                          \
            return;                                                            \
        }                                                                      \
    }                                                                          \
                                                                               \
    if (all_zero) {                                                            \
        write_zeros(2 * N);                                                    \
        window_incr(in, N);                                                    \
        window_incr(out0, 2 * N);                                              \
        return;                                                                \
    }                                                                          \
                                                                               \
    const int curr_idx = iter_valid % 2;                                       \
    const int prev_idx = (iter_valid + 1) % 2;                                 \
    const bool is_first_of_window = ((iter_valid % tH) == 0);                  \
                                                                               \
    if (has_prev) {                                                            \
        if (wrap_pending) {                                                    \
            for (int i = 0; i < N; ++i) *out_ptr++ = first_snapshot[i];        \
            for (int i = 0; i < N; ++i) *out_ptr++ = frames[prev_idx][i];     \
            wrap_pending = false;                                              \
        } else {                                                               \
            for (int i = 0; i < N; ++i) *out_ptr++ = cur[i];                  \
            for (int i = 0; i < N; ++i) *out_ptr++ = frames[prev_idx][i];     \
        }                                                                      \
    } else {                                                                   \
        write_zeros(2 * N);                                                    \
    }                                                                          \
                                                                               \
    for (int i = 0; i < N; ++i) frames[curr_idx][i] = cur[i];                 \
                                                                               \
    if (is_first_of_window) {                                                  \
        for (int i = 0; i < N; ++i) first_snapshot[i] = cur[i];               \
    }                                                                          \
                                                                               \
    iter_valid++;                                                              \
    if ((iter_valid % tH) == 0) wrap_pending = true;                           \
                                                                               \
    window_incr(in, N);                                                        \
    window_incr(out0, 2 * N);                                                  \
}

DEFINE_ROLL_CONCAT(roll_concat_kernel)
DEFINE_ROLL_CONCAT(roll_concat_kernel_1)
DEFINE_ROLL_CONCAT(roll_concat_kernel_2)
