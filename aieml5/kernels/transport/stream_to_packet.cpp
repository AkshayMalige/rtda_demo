#include "kernels/transport/stream_to_packet.h"

#include "kernels/transport/packet_helpers.hpp"
#include "nn_defs.h"

#include <adf.h>

using namespace adf;

void stream_to_packet_kernel(input_stream<float>* in_stream,
                             output_pktstream*    out_pkt) {
  aieml5::kernels::transport::packetize_stream<EMBED_DENSE0_INPUT_SIZE, 1>(
      in_stream, out_pkt);
}
