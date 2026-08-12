#include "roll_concat_batch.h"

void roll_concat_batch(adf::input_buffer<bfloat16>& __restrict in,
                       adf::output_buffer<bfloat16>& __restrict out)
{
    // 256-bit vector = 16 bfloat16. FEAT is 128, an exact multiple, so no tail.
    // Pure data movement: no arithmetic here, so bf16 costs nothing in accuracy
    // and halves the bytes moved per track versus the float32 build.
    constexpr int TRACKS = RCB_TRACKS;
    constexpr int FEAT   = RCB_FEAT;
    constexpr int VEC = 16;
    static_assert(FEAT % VEC == 0, "FEAT must be a multiple of the 256-bit vector width");

    // Last track of the previous block. Zero on the first block, which is why
    // track 0 of the event pairs with zeros rather than wrapping to track 49.
    alignas(32) static bfloat16 carry[FEAT] = {};

    const bfloat16* __restrict pi = in.data();
    bfloat16* __restrict po = out.data();

    for (int t = 0; t < TRACKS; ++t) {
        const bfloat16* cur  = pi + t * FEAT;
        const bfloat16* prev = (t == 0) ? carry : (pi + (t - 1) * FEAT);
        bfloat16* dst = po + t * 2 * FEAT;

        for (int f = 0; f < FEAT; f += VEC)
            aie::store_v(dst + f, aie::load_v<VEC>(cur + f));
        for (int f = 0; f < FEAT; f += VEC)
            aie::store_v(dst + FEAT + f, aie::load_v<VEC>(prev + f));
    }

    // Hand the block's last track to the next invocation. Must come after the
    // loop: for TRACKS == 1 the read above still needs the old value.
    const bfloat16* last = pi + (TRACKS - 1) * FEAT;
    for (int f = 0; f < FEAT; f += VEC)
        aie::store_v(carry + f, aie::load_v<VEC>(last + f));
}
