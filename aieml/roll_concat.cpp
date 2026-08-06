#include "roll_concat.h"
#include <aie_api/aie.hpp>

using namespace adf;

// ---------------------------------------------------------------------------
// Vectorised element-movement helpers.
//
// This kernel performs no arithmetic, it only moves frames around, so the
// scalar element loops it used to contain were pure overhead: on AIE-ML a
// 16-bit scalar copy compiles to a 6-bundle loop (LDA.u16 / ST.s16 cannot be
// bundled together) versus 1 bundle for the 32-bit case, which is why int16
// used to be ~1.9x slower here than float. Moving 256 bits at a time makes
// both precisions ~VEC times cheaper.
//
// HIDDEN_SIZE (128) is an exact multiple of both vector widths (8 for float,
// 16 for int16), so the fixed-size copies never need a scalar tail.
// ---------------------------------------------------------------------------
namespace {

constexpr int RC_N   = HIDDEN_SIZE;                  // 128
constexpr int RC_VEC = 32 / (int)sizeof(DATA_TYPE);  // 8 (float) | 16 (int16)

static_assert(RC_N % RC_VEC == 0,
              "HIDDEN_SIZE must be a multiple of the 256-bit vector width");

// Copy RC_N elements. Both pointers must be 32-byte aligned.
inline void rc_copy(DATA_TYPE* __restrict dst, const DATA_TYPE* __restrict src)
{
    for (int i = 0; i < RC_N; i += RC_VEC)
        aie::store_v(dst + i, aie::load_v<RC_VEC>(src + i));
}

// Zero-fill `count` elements. `dst` must be 32-byte aligned. The scalar tail is
// dead code for every current call site (count is always 2*RC_N) but keeps the
// helper correct if that ever changes.
inline void rc_zero(DATA_TYPE* __restrict dst, int count)
{
    const aie::vector<DATA_TYPE, RC_VEC> z = aie::zeros<DATA_TYPE, RC_VEC>();
    int i = 0;
    for (; i + RC_VEC <= count; i += RC_VEC)
        aie::store_v(dst + i, z);
    for (; i < count; ++i)
        dst[i] = (DATA_TYPE)0;
}

// Copy RC_N elements from the input window into `dst` and report whether every
// element was zero. aie::neq(v, 0) is defined as out[i] = v[i] != 0, so an
// empty mask is exactly the old scalar `if (v != 0) all_zero = false;`.
// `&=` rather than `&&` so the loop stays branch-free.
inline bool rc_load_frame(DATA_TYPE* __restrict dst, const DATA_TYPE* __restrict src)
{
    bool all_zero = true;
    for (int i = 0; i < RC_N; i += RC_VEC) {
        const aie::vector<DATA_TYPE, RC_VEC> v = aie::load_v<RC_VEC>(src + i);
        aie::store_v(dst + i, v);
        all_zero &= aie::neq(v, (DATA_TYPE)0).empty();
    }
    return all_zero;
}

} // namespace

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
    alignas(32) static DATA_TYPE frames[2][N];                                 \
    alignas(32) static DATA_TYPE first_snapshot[N];                            \
    static int  iter_valid   = 0;                                              \
    static bool active       = false;                                          \
    static bool has_prev     = false;                                          \
    static bool wrap_pending = false;                                          \
                                                                               \
    DATA_TYPE* in_ptr  = (DATA_TYPE*)in->ptr;                                  \
    DATA_TYPE* out_ptr = (DATA_TYPE*)out0->ptr;                                \
                                                                               \
    alignas(32) DATA_TYPE cur[N];                                              \
    const bool all_zero = rc_load_frame(cur, in_ptr);                          \
                                                                               \
    auto write_zeros = [&](int count) {                                        \
        rc_zero(out_ptr, count);                                               \
        out_ptr += count;                                                      \
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
            rc_copy(frames[curr_idx], cur);                                    \
            rc_copy(first_snapshot, cur);                                      \
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
            rc_copy(out_ptr, first_snapshot);      out_ptr += N;                \
            rc_copy(out_ptr, frames[prev_idx]);    out_ptr += N;                \
            wrap_pending = false;                                              \
        } else {                                                               \
            rc_copy(out_ptr, cur);                 out_ptr += N;                \
            rc_copy(out_ptr, frames[prev_idx]);    out_ptr += N;                \
        }                                                                      \
    } else {                                                                   \
        write_zeros(2 * N);                                                    \
    }                                                                          \
                                                                               \
    rc_copy(frames[curr_idx], cur);                                            \
                                                                               \
    if (is_first_of_window) {                                                  \
        rc_copy(first_snapshot, cur);                                          \
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
