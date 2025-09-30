#include "packet_to_window.h"

#include "nn_defs.h"

#include <cstdint>

using namespace adf;

namespace {

template <int OffsetWords>
void packet_to_window_kernel_impl(input_pktstream* in_pkt,
                                  output_window<float>* out_window) {
  bool tlast = false;

  // Discard the header emitted by the upstream packetiser.
  (void)readincr(in_pkt);

  // Skip the samples that belong to previous cascade legs.
  for (int i = 0; i < OffsetWords; ++i) {
    (void)readincr(in_pkt, tlast);
  }

  // Emit the portion of the payload assigned to this cascade leg.
  for (int i = 0; i < SUBSOLVER0_INPUT_PART_SIZE; ++i) {
    const int32_t payload = readincr(in_pkt, tlast);
    union {
      int32_t i;
      float f;
    } converter{payload};

    window_writeincr(out_window, converter.f);
  }

  // Drain any remaining packet payload.
  if (!tlast) {
    do {
      (void)readincr(in_pkt, tlast);
    } while (!tlast);
  }
}

}  // namespace

void packet_to_window_kernel_0(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<0>(in_pkt, out_window);
}

void packet_to_window_kernel_1(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<1 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_2(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<2 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_3(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<3 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_4(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<4 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_5(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<5 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_6(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<6 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_7(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<7 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_8(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<8 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_9(input_pktstream* in_pkt,
                               output_window<float>* out_window) {
  packet_to_window_kernel_impl<9 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_10(input_pktstream* in_pkt,
                                output_window<float>* out_window) {
  packet_to_window_kernel_impl<10 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}

void packet_to_window_kernel_11(input_pktstream* in_pkt,
                                output_window<float>* out_window) {
  packet_to_window_kernel_impl<11 * SUBSOLVER0_INPUT_PART_SIZE>(in_pkt, out_window);
}
