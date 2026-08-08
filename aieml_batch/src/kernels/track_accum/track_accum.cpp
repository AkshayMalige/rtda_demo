#include "track_accum.h"
#if TA_OUTPUT_DENSE
#include "output_dense_aie.h"
static constexpr int TA_OUT_W = OUT_DENSE_PAD;
#else
static constexpr int TA_OUT_W = TA_FEAT;   // emit the mean itself
#endif

void track_accum(adf::input_buffer<float>& __restrict in,
                 adf::output_buffer<float>& __restrict out)
{
    constexpr int VEC = 8;                       // 256-bit vector of float
    static_assert(TA_FEAT % VEC == 0, "TA_FEAT must be a multiple of the vector width");
    static_assert(TA_OUT_W % VEC == 0, "output width must be vector-aligned");

    // Event state. Both must reset together: a stale count with a fresh sum (or
    // vice versa) silently corrupts the following event.
    alignas(32) static float sum[TA_FEAT] = {};
    static int seen = 0;

    const float* __restrict pi = in.data();
    float* __restrict po = out.data();

    // --- accumulate, dropping padding slots --------------------------------
    for (int t = 0; t < TA_TRACKS; ++t) {
        if (seen >= TA_EVENT) break;             // remaining slots are padding
        const float* row = pi + t * TA_FEAT;
        for (int f = 0; f < TA_FEAT; f += VEC)
            aie::store_v(sum + f, aie::add(aie::load_v<VEC>(sum + f), aie::load_v<VEC>(row + f)));
        ++seen;
    }

    // --- not finished: emit zeros -------------------------------------------
    if (seen < TA_EVENT) {
        const auto z = aie::zeros<float, VEC>();
        for (int j = 0; j < TA_OUT_W; j += VEC)
            aie::store_v(po + j, z);
        return;
    }

    // --- event complete: mean, then the 128->27 output dense ----------------
    // Runs once per 50 tracks: 3,456 MACs against ~13.2M for the event. Tiny in
    // MACs, but it lands entirely in one iteration and stalls the pipeline, so
    // the shape of the loop below matters more than the operation count suggests.
    alignas(32) float avg[TA_FEAT];
    const auto scale = aie::broadcast<float, VEC>(1.0f / float(TA_EVENT));
    for (int f = 0; f < TA_FEAT; f += VEC)
        aie::store_v(avg + f, aie::mul(aie::load_v<VEC>(sum + f), scale).to_vector<float>());

#if TA_OUTPUT_DENSE
    // One dot product per output: two contiguous vector loads per MAC and no
    // scalar->vector broadcast. The obvious [in][out] weight layout forces a
    // broadcast of avg[k] in the inner loop; 512 of those cost ~15 us per event,
    // more than the entire 14-layer pipeline. Hence output_dense_Wt is [out][in].
    alignas(32) float y[OUT_DENSE_PAD];
    for (int j = 0; j < OUT_DENSE_PAD; ++j) {
        aie::accum<accfloat, VEC> acc;
        acc.from_vector(aie::zeros<float, VEC>());
        for (int k = 0; k < OUT_DENSE_IN; k += VEC)
            acc = aie::mac(acc, aie::load_v<VEC>(avg + k),
                           aie::load_v<VEC>(&output_dense_Wt[j][k]));
        y[j] = aie::reduce_add(acc.template to_vector<float>()) + output_dense_B[j];
    }
    for (int j = 0; j < OUT_DENSE_PAD; j += VEC)
        aie::store_v(po + j, aie::load_v<VEC>(y + j));
#else
    // Emit the 128-wide mean; the host applies the output dense.
    for (int f = 0; f < TA_FEAT; f += VEC)
        aie::store_v(po + f, aie::load_v<VEC>(avg + f));
#endif

    // --- reset for the next event -------------------------------------------
    const auto z = aie::zeros<float, VEC>();
    for (int f = 0; f < TA_FEAT; f += VEC)
        aie::store_v(sum + f, z);
    seen = 0;
}
