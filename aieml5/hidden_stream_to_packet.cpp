#include "hidden_stream_to_packet.h"

#include <adf.h>
#include <cstdint>

using namespace adf;

namespace {
constexpr unsigned kPacketType = 0;
}

void hidden_stream_to_packet_kernel(adf::input_stream<float>* in_stream,
                                    adf::output_pktstream* out_pkt) {
  constexpr int total_samples    = HIDDEN_SIZE;
  constexpr int branch_count     = CASCADE_LENGTH;
  constexpr int samples_per_part = total_samples / branch_count;

  // Iterate over each cascade branch and build a packet addressed to that
  // branch. The runtime assigns packet IDs per branch via getPacketid().
  for (int branch = 0; branch < branch_count; ++branch) {
    const uint32_t packet_id = getPacketid(out_pkt, branch);
    writeHeader(out_pkt, kPacketType, packet_id);

    // Each packet carries the subset of activations consumed by the
    // corresponding dense2 cascade lane.
    for (int i = 0; i < samples_per_part; ++i) {
      const float value = readincr(in_stream);
      union {
        float   f;
        int32_t i;
      } converter{value};

      // Only the final word of the final packet asserts TLAST so the downstream
      // pktsplitter and consumers know the frame has completed.
      const bool is_last = (branch == branch_count - 1) &&
                           (i == samples_per_part - 1);
      writeincr(out_pkt, converter.i, is_last);
    }
  }
}
