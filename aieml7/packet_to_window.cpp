#include "packet_to_window.h"

#include "nn_defs.h"

#include <cstdint>

using namespace adf;

namespace detail {

template <int PART_INDEX>
void packet_to_window_kernel_impl(input_pktstream* in_pkt,
                                  output_window<float>* out_window) {
  static_assert(PART_INDEX >= 0, "Cascade index must be non-negative");
  static_assert(SUBSOLVER0_INPUT_SIZE % SUBSOLVER0_INPUT_PART_SIZE == 0,
                "Input size must be divisible by part size");

  bool tlast = false;

  // Discard the header emitted by the upstream packetiser.
  (void)readincr(in_pkt);

  constexpr int kWordsToSkip =
      PART_INDEX * SUBSOLVER0_INPUT_PART_SIZE;

  for (int i = 0; i < kWordsToSkip; ++i) {
    (void)readincr(in_pkt, tlast);
  }

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

}  // namespace detail

#define DEFINE_PACKET_TO_WINDOW_KERNEL(IDX)                                      \
  void packet_to_window_kernel_##IDX(input_pktstream* in_pkt,                   \
                                     output_window<float>* out_window) {        \
    detail::packet_to_window_kernel_impl<IDX>(in_pkt, out_window);              \
  }

DEFINE_PACKET_TO_WINDOW_KERNEL(0);
DEFINE_PACKET_TO_WINDOW_KERNEL(1);
DEFINE_PACKET_TO_WINDOW_KERNEL(2);
DEFINE_PACKET_TO_WINDOW_KERNEL(3);
DEFINE_PACKET_TO_WINDOW_KERNEL(4);
DEFINE_PACKET_TO_WINDOW_KERNEL(5);
DEFINE_PACKET_TO_WINDOW_KERNEL(6);
DEFINE_PACKET_TO_WINDOW_KERNEL(7);
DEFINE_PACKET_TO_WINDOW_KERNEL(8);
DEFINE_PACKET_TO_WINDOW_KERNEL(9);
DEFINE_PACKET_TO_WINDOW_KERNEL(10);
DEFINE_PACKET_TO_WINDOW_KERNEL(11);

#undef DEFINE_PACKET_TO_WINDOW_KERNEL

constexpr packet_to_window_fn kPacketToWindowKernels[] = {
    packet_to_window_kernel_0,  packet_to_window_kernel_1,
    packet_to_window_kernel_2,  packet_to_window_kernel_3,
    packet_to_window_kernel_4,  packet_to_window_kernel_5,
    packet_to_window_kernel_6,  packet_to_window_kernel_7,
    packet_to_window_kernel_8,  packet_to_window_kernel_9,
    packet_to_window_kernel_10, packet_to_window_kernel_11};

packet_to_window_fn select_packet_to_window_kernel(unsigned part_index) {
  if (part_index >= (sizeof(kPacketToWindowKernels) /
                     sizeof(kPacketToWindowKernels[0]))) {
    return nullptr;
  }
  return kPacketToWindowKernels[part_index];
}
