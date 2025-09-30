#pragma once

#include <adf.h>

using namespace adf;

// Signature shared by all packet-to-window kernel entry points.
using PacketToWindowKernelFn =
    void (*)(input_pktstream* in_pkt, output_window<float>* out_window);

// Converts a packet payload into a window containing SUBSOLVER0_INPUT_PART_SIZE
// float samples expected by the dense layer cascade leg.  Multiple entry points
// are generated so that each cascade leg can skip a different portion of the
// payload before producing its window.
void packet_to_window_kernel_0(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_1(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_2(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_3(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_4(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_5(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_6(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_7(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_8(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_9(input_pktstream* in_pkt,
                               output_window<float>* out_window);
void packet_to_window_kernel_10(input_pktstream* in_pkt,
                                output_window<float>* out_window);
void packet_to_window_kernel_11(input_pktstream* in_pkt,
                                output_window<float>* out_window);

// Returns the packet-to-window kernel associated with the specified cascade
// index.  Marked inline so that both host and AI Engine compilation units can
// reference the selector without requiring a separate definition.
inline PacketToWindowKernelFn select_packet_to_window_kernel(unsigned index) {
  switch (index) {
    case 0:  return packet_to_window_kernel_0;
    case 1:  return packet_to_window_kernel_1;
    case 2:  return packet_to_window_kernel_2;
    case 3:  return packet_to_window_kernel_3;
    case 4:  return packet_to_window_kernel_4;
    case 5:  return packet_to_window_kernel_5;
    case 6:  return packet_to_window_kernel_6;
    case 7:  return packet_to_window_kernel_7;
    case 8:  return packet_to_window_kernel_8;
    case 9:  return packet_to_window_kernel_9;
    case 10: return packet_to_window_kernel_10;
    case 11: return packet_to_window_kernel_11;
    default: return nullptr;
  }
}
