#include "kernels/transport/packet_to_stream.h"

#include "kernels/transport/packet_helpers.hpp"

void packet_to_stream_kernel(input_pktstream* in, output_stream<float>* out) {
  aieml5::kernels::transport::depacketize_stream<EMBED_DENSE0_INPUT_SIZE>(
      in, out);
}

void packet_to_stream_hidden_kernel(input_pktstream* in,
                                    output_stream<float>* out) {
  aieml5::kernels::transport::depacketize_stream<
      HIDDEN_SIZE / CASCADE_LENGTH>(in, out);
}
