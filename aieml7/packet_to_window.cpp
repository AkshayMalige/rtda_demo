#include "packet_to_window.h"

#include "nn_defs.h"

#include <cstdint>

using namespace adf;

void packet_to_window_kernel(input_pktstream* in_pkt,
                             output_window<float>* out_window) {
  bool tlast = false;

  // Discard the header emitted by the upstream packetiser.
  (void)readincr(in_pkt);

  for (int i = 0; i < SUBSOLVER0_INPUT_PART_SIZE; ++i) {
    const int32_t payload = readincr(in_pkt, tlast);
    union {
      int32_t i;
      float f;
    } converter{payload};

    window_writeincr(out_window, converter.f);
  }

  if (!tlast) {
    do {
      (void)readincr(in_pkt, tlast);
    } while (!tlast);
  }
}
