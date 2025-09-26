#include "packet_to_stream.h"

#include <aie_api/aie.hpp>
#include <cstdint>

namespace {

/**
 * @brief Converts a packet payload back into a float stream.
 *
 * The helper strips the header word emitted by the upstream packetisation
 * kernel, forwards @p frame_elems payload samples, and drains any unexpected
 * residual data until TLAST is observed to keep the interface aligned.
 */
inline void packet_payload_to_stream(adf::input_pktstream* in,
                                     adf::output_stream<float>* out,
                                     int frame_elems) {
  bool tlast = false;

  // Each iteration is expected to start with a packet header; discard it before
  // consuming the payload samples.
  readincr(in);

  for (int i = 0; i < frame_elems; ++i) {
    const int32_t raw = readincr(in, tlast);
    union {
      int32_t i;
      float   f;
    } converter{raw};
    writeincr(out, converter.f);
  }

  // Ensure the packet ended where expected to avoid desynchronisation. If the
  // payload produced an early TLAST, the loop above already consumed it; if not,
  // drain words until TLAST to realign with the next header.
  if (!tlast) {
    do {
      (void)readincr(in, tlast);
    } while (!tlast);
  }
}

}  // namespace

void packet_to_stream_kernel(adf::input_pktstream* in, adf::output_stream<float>* out) {
  packet_payload_to_stream(in, out, EMBED_DENSE0_INPUT_SIZE);
}

void packet_to_stream_hidden_kernel(adf::input_pktstream* in,
                                    adf::output_stream<float>* out) {
  packet_payload_to_stream(in, out, HIDDEN_SIZE / CASCADE_LENGTH);
}
