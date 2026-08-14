#include "roll_concat_batch.h"

void roll_concat_batch(adf::input_buffer<float>& __restrict in,
                       adf::output_buffer<float>& __restrict out)
{
    // 256-bit vector = 8 floats. FEAT is 128, an exact multiple, so no tail.
    constexpr int TRACKS = RCB_TRACKS;
    constexpr int FEAT   = RCB_FEAT;
    constexpr int VEC = 8;
    static_assert(FEAT % VEC == 0, "FEAT must be a multiple of the 256-bit vector width");

    // Last track of the previous block. Zero on the first block, which is why
    // track 0 of the event pairs with zeros rather than wrapping to track 49.
    alignas(32) static float carry[FEAT] = {};

    const float* __restrict pi = in.data();
    float* __restrict po = out.data();

    for (int t = 0; t < TRACKS; ++t) {
        const float* cur  = pi + t * FEAT;
        const float* prev = (t == 0) ? carry : (pi + (t - 1) * FEAT);
        float* dst = po + t * 2 * FEAT;

        for (int f = 0; f < FEAT; f += VEC)
            aie::store_v(dst + f, aie::load_v<VEC>(cur + f));
        for (int f = 0; f < FEAT; f += VEC)
            aie::store_v(dst + FEAT + f, aie::load_v<VEC>(prev + f));
    }

    // Hand the block's last track to the next invocation. Must come after the
    // loop: for TRACKS == 1 the read above still needs the old value.
    const float* last = pi + (TRACKS - 1) * FEAT;
    for (int f = 0; f < FEAT; f += VEC)
        aie::store_v(carry + f, aie::load_v<VEC>(last + f));
}
