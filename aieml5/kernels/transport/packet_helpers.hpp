#pragma once

#include <adf.h>
#include <cstdint>
#include <cstring>

namespace aieml5::kernels::transport {

template <int FrameElems, int Branches>
inline void packetize_stream(adf::input_stream<float>* in_stream,
                             adf::output_pktstream*     out_pkt) {
  static_assert(FrameElems > 0, "Frame size must be positive");
  static_assert(Branches > 0, "Branches must be positive");
  static_assert(FrameElems % Branches == 0,
                "Frame elements must divide evenly across branches");

  constexpr unsigned kPacketType = 0;
  constexpr int      samples_per_branch = FrameElems / Branches;

  for (int branch = 0; branch < Branches; ++branch) {
    const uint32_t packet_id = adf::getPacketid(out_pkt, branch);
    adf::writeHeader(out_pkt, kPacketType, packet_id);

    for (int i = 0; i < samples_per_branch; ++i) {
      const float value = adf::readincr(in_stream);
      int32_t     word  = 0;
      std::memcpy(&word, &value, sizeof(float));
      const bool    is_last = (i == samples_per_branch - 1);
      adf::writeincr(out_pkt, word, is_last);
    }
  }
}

template <int FrameElems>
inline void depacketize_stream(adf::input_pktstream*   in,
                               adf::output_stream<float>* out) {
  static_assert(FrameElems > 0, "Frame size must be positive");

  bool tlast = false;

  (void)adf::readincr(in);

  for (int i = 0; i < FrameElems; ++i) {
    const int32_t raw = adf::readincr(in, tlast);
    float         value = 0.0f;
    std::memcpy(&value, &raw, sizeof(float));
    adf::writeincr(out, value);
  }

  while (!tlast) {
    (void)adf::readincr(in, tlast);
  }
}

}  // namespace aieml5::kernels::transport
