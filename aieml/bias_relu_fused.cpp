#include "bias_relu_fused.h"
#include <aie_api/aie.hpp>
#include <type_traits>

void bias_add_leaky_relu_kernel(input_window<DATA_TYPE>* __restrict in,
                                output_window<DATA_TYPE>* __restrict out,
                                const DATA_TYPE (&bias)[HIDDEN_SIZE]) {
    const int N = window_size(in);
    chess_assert(N == HIDDEN_SIZE);

    const DATA_TYPE* __restrict in_ptr  = reinterpret_cast<const DATA_TYPE*>(in->ptr);
    DATA_TYPE* __restrict out_ptr       = reinterpret_cast<DATA_TYPE*>(out->ptr);

    constexpr int VEC = 32 / sizeof(DATA_TYPE); // 256-bit vector

    constexpr int shift = std::is_same_v<DATA_TYPE, float> ? 0 : 15;
    const DATA_TYPE slope_val = []() {
        if constexpr (std::is_same_v<DATA_TYPE, float>) {
            return (DATA_TYPE)LEAKY_SLOPE;
        } else {
            return (DATA_TYPE)(LEAKY_SLOPE * (1 << 15));
        }
    }();

    const auto slope_vec = aie::broadcast<DATA_TYPE, VEC>(slope_val);

    // chess_prepare_for_pipelining
    for (int idx = 0; idx < HIDDEN_SIZE; idx += VEC) {
        const auto x = aie::load_v<VEC>(in_ptr + idx);
        const auto b = aie::load_v<VEC>(bias + idx);
        const auto y = aie::add(x, b);
        
        if constexpr (std::is_same_v<DATA_TYPE, float>) {
            const auto scaled = aie::mul(y, slope_vec).to_vector<DATA_TYPE>();
            const auto z = aie::max(y, scaled);
            aie::store_v(out_ptr + idx, z);
        } else {
            // int16 case
            const auto scaled = aie::mul(y, slope_vec).template to_vector<DATA_TYPE>(shift);
            const auto z = aie::max(y, scaled);
            aie::store_v(out_ptr + idx, z);
        }
    }

    window_incr(in, HIDDEN_SIZE);
    window_incr(out, HIDDEN_SIZE);
}
