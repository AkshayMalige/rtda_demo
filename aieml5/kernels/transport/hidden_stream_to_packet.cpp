#include "kernels/transport/hidden_stream_to_packet.h"

#include "kernels/transport/packet_helpers.hpp"

#include <adf.h>

using namespace adf;

void hidden_stream_to_packet_kernel(input_stream<float>* in_stream,
                                    output_pktstream*   out_pkt) {
  aieml5::kernels::transport::packetize_stream<HIDDEN_SIZE, CASCADE_LENGTH>(
      in_stream, out_pkt);
}
