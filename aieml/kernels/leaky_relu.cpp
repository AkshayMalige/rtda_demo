// leaky_relu.cpp
#include <adf.h>
#include <aie_api/aie.hpp>
#include "../kernels.h"

using namespace aie;

// void leaky_relu(
//     input_window<float>  *in_win,
//     output_window<float> *out_win
// ) {
//   constexpr float α = LEAKY_SLOPE;
//   for (int i = 0; i < HIDDEN_SIZE; i += VEC_WIDTH_D2) {
//     // auto v = window_readincr_v< vector<float,VEC_WIDTH> >(in_win);
//     auto v = window_readincr_v<VEC_WIDTH_D2>(in_win);
//     vector<float,VEC_WIDTH_D2> o;
//     // elementwise compare + multiply
//     for (int j = 0; j < VEC_WIDTH_D2; ++j) {
//       float x = v[j];
//       o[j] = (x > 0.0f) ? x : α * x;
//     }
//     writeincr_v(out_win, o);
//   }
// }

void leaky_relu(input_window<float>* in, output_window<float>* out) {
    for (int i = 0; i < HIDDEN_SIZE / VEC_WIDTH_D2; i++) {
        aie::vector<float, VEC_WIDTH_D2> vin = window_readincr_v<VEC_WIDTH_D2>(in);
        aie::mask<VEC_WIDTH_D2> pos_mask = vin > aie::broadcast<float, VEC_WIDTH_D2>(0.0f);
        aie::vector<float, VEC_WIDTH_D2> vout = aie::select(vin * LEAKY_SLOPE, vin, pos_mask);
        aie::store_v(out, vout);  // ✅ Correct function
    }
}