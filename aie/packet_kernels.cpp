#include "packet_kernels.h"

// Packet to stream converter
// Reads packetized data and outputs pure float stream (strips packet headers)
void packet_to_stream(input_pktstream* pkt_in, output_stream<float>* stream_out) {
    // Get packet ID from incoming packet
    int32_t pkt_id = getPacketid(pkt_in, 0);

    // For now, assume fixed payload length based on packet ID
    // In practice, this should be parameterized or read from packet header
    const int payload_len = 32; // Assume 32 floats per packet

    // Read payload data and forward to stream (skip packet header processing)
    for (int i = 0; i < payload_len; i++) {
        float data = readincr(pkt_in);
        writeincr(stream_out, data);
    }
}

// Stream to packet converter
// Reads pure float stream and outputs packetized data (adds packet headers)
void stream_to_packet(input_stream<float>* stream_in, output_pktstream* pkt_out) {
    // Get the packet ID for the output packet
    int32_t pkt_id = getPacketid(pkt_out, 0);

    // Assume fixed payload length for now
    const int payload_len = 32; // 32 floats per output packet

    // Write packet header
    writeHeader(pkt_out, 0, pkt_id);

    // Read data from stream and write to packet
    for (int i = 0; i < payload_len; i++) {
        float data = readincr(stream_in);
        bool is_last = (i == payload_len - 1);
        writeincr(pkt_out, data, is_last);
    }
}