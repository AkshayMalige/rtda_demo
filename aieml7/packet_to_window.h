#pragma once

#include <adf.h>

using namespace adf;

using packet_to_window_fn =
    void (*)(input_pktstream* in_pkt, output_window<float>* out_window);

// Returns a kernel function specialised for the requested cascade branch.
packet_to_window_fn select_packet_to_window_kernel(unsigned part_index);
