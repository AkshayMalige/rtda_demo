#include "pkt_to_stream.h"
#include <aie_api/aie.hpp>
#include <cstdint>

void pkt_to_stream(input_pktstream *in, output_stream<float> *out) {
  constexpr int frame_elems = EMBED_DENSE0_INPUT_SIZE;

  while (true) {
    bool tlast = false;

    // Each iteration is expected to start with a packet header.
    // Discard the header word before consuming the payload samples.
    readincr(in);

    for (int i = 0; i < frame_elems; ++i) {
      int32_t raw = readincr(in, tlast);
      union {
        int32_t i;
        float f;
      } converter{raw};
      writeincr(out, converter.f);
    }

    // Ensure the packet ended where expected to avoid desynchronisation.
    if (!tlast) {
      do {
        int32_t raw = readincr(in, tlast);
        union {
          int32_t i;
          float f;
        } converter{raw};
        writeincr(out, converter.f);
      } while (!tlast);
    }
  }
}
