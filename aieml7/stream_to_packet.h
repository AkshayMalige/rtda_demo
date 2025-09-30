#pragma once

#include <adf.h>

using namespace adf;

// Packetises one frame of SUBSOLVER0_INPUT_SIZE float samples into a single
// packet on the ADF packet stream network.
void stream_to_packet_kernel(input_stream<float>* in_stream,
                             output_pktstream* out_pkt);
