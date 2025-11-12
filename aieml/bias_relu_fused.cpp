#include "bias_relu_fused.h"
#include <aie_api/aie.hpp>

void bias_add_leaky_relu_kernel(input_window<float>* __restrict in,
                                output_window<float>* __restrict out,
                                const float (&bias)[HIDDEN_SIZE]) {
    const int N = window_size(in);
    chess_assert(N == HIDDEN_SIZE);

    const float* __restrict in_ptr  = reinterpret_cast<const float*>(in->ptr);
    float* __restrict out_ptr       = reinterpret_cast<float*>(out->ptr);

    constexpr int VEC = 8;
    const auto slope_vec = aie::broadcast<float, VEC>(LEAKY_SLOPE);

    // chess_prepare_for_pipelining
    for (int idx = 0; idx < HIDDEN_SIZE; idx += VEC) {
        const auto x = aie::load_v<VEC>(in_ptr + idx);
        const auto b = aie::load_v<VEC>(bias + idx);
        const auto y = aie::add(x, b);
        const auto scaled = aie::mul(y, slope_vec).to_vector<float>(0);
        const auto z = aie::max(y, scaled);
        aie::store_v(out_ptr + idx, z);
    }

    window_incr(in, HIDDEN_SIZE);
    window_incr(out, HIDDEN_SIZE);
}
