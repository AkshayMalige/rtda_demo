#include "stream_to_packet.h"

#include "nn_defs.h"

#include <cstdint>

using namespace adf;

namespace {
constexpr unsigned kPacketType = 0;
}

void stream_to_packet_kernel(input_stream<float>* in_stream,
                             output_pktstream* out_pkt) {
  const uint32_t pkt_id = getPacketid(out_pkt, /*index=*/0);
  writeHeader(out_pkt, kPacketType, pkt_id);

  for (int i = 0; i < SUBSOLVER0_INPUT_SIZE; ++i) {
    const float sample = readincr(in_stream);
    const bool is_last = (i == SUBSOLVER0_INPUT_SIZE - 1);

    union {
      float f;
      int32_t i;
    } converter{sample};

    writeincr(out_pkt, converter.i, is_last);
  }
}
