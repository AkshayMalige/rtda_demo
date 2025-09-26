// aie/packetize.hpp
#pragma once
#include <adf.h>
using namespace adf;

// Converts one window of N floats into one packet on pktstream with {id,len} metadata.
void stream_to_packet_kernel(input_stream<float>* in_stream,
                             output_pktstream* out_pkt);
