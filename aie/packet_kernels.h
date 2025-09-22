#pragma once
#include <adf.h>
#include <aie_api/aie.hpp>

using namespace adf;

// Packet to stream converter - extracts float data from packets
void packet_to_stream(input_pktstream* pkt_in, output_stream<float>* stream_out);

// Stream to packet converter - wraps float data into packets
void stream_to_packet(input_stream<float>* stream_in, output_pktstream* pkt_out);