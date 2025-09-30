#pragma once

#include <adf.h>

using namespace adf;

// Converts a packet payload into a window containing SUBSOLVER0_INPUT_PART_SIZE
// float samples expected by the dense layer cascade leg.
void packet_to_window_kernel(input_pktstream* in_pkt,
                             output_window<float>* out_window);
