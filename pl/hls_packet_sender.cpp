#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"

static const int PACKET_NUM = 6;

typedef ap_axiu<32, 0, 0, 0> axis32_t;

static inline unsigned int getPacketId(ap_uint<32> header) {
#pragma HLS inline
    return header(10, 8);  // Extract routing ID from bits [10:8]
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wswitch"

// Helper: read exactly one word from channel i
static inline axis32_t read_from_ch(
    int i,
    hls::stream<axis32_t>& s0,
    hls::stream<axis32_t>& s1,
    hls::stream<axis32_t>& s2,
    hls::stream<axis32_t>& s3,
    hls::stream<axis32_t>& s4,
    hls::stream<axis32_t>& s5)
{
#pragma HLS inline
    switch(i){
        case 0: return s0.read();
        case 1: return s1.read();
        case 2: return s2.read();
        case 3: return s3.read();
        case 4: return s4.read();
        default: return s5.read();
    }
}

#pragma GCC diagnostic pop

extern "C" void hls_packet_sender(
    hls::stream<axis32_t>& s0,
    hls::stream<axis32_t>& s1,
    hls::stream<axis32_t>& s2,
    hls::stream<axis32_t>& s3,
    hls::stream<axis32_t>& s4,
    hls::stream<axis32_t>& s5,
    hls::stream<axis32_t>& out,    // → AI Engine (packets with ID 0-5)
    hls::stream<axis32_t>& plout,  // → PL (packets with ID 4-5 only)
    const unsigned int *max_packets_per_ch)
{
    // ------- Interfaces (good HLS/Versal practice) -------
    #pragma HLS INTERFACE axis port=s0
    #pragma HLS INTERFACE axis port=s1
    #pragma HLS INTERFACE axis port=s2
    #pragma HLS INTERFACE axis port=s3
    #pragma HLS INTERFACE axis port=s4
    #pragma HLS INTERFACE axis port=s5
    #pragma HLS INTERFACE axis port=out
    #pragma HLS INTERFACE axis port=plout

    #pragma HLS INTERFACE m_axi     port=max_packets_per_ch  offset=slave depth=PACKET_NUM bundle=gmem0
    #pragma HLS INTERFACE s_axilite port=max_packets_per_ch  bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control

    // Make a local copy so the tool can fully partition & schedule well
    unsigned int packets[PACKET_NUM];
    #pragma HLS ARRAY_PARTITION variable=packets complete dim=1
    load_packets: for (int i = 0; i < PACKET_NUM; ++i) {
        #pragma HLS UNROLL
        packets[i] = max_packets_per_ch[i];
    }

    // No artificial cross-stream deps; preserve streaming
    #pragma HLS DATAFLOW disable_start_propagation

    // Forward pre-packetized data from each channel to appropriate output
    channel_loop:
    for (int i = 0; i < PACKET_NUM; ++i) {
        unsigned int num_packets = packets[i];
        if (num_packets == 0) {
            continue; // Skip channels with no packets
        }

        // Process all packets from this channel
        packet_loop:
        for (unsigned int pkt = 0; pkt < num_packets; ++pkt) {
            // Read header to determine routing
            axis32_t header = read_from_ch(i, s0, s1, s2, s3, s4, s5);
            unsigned int ID = getPacketId(header.data);

            const bool to_aie = true;  // All packets (ID 0-5) go to AIE
            const bool to_pl  = (ID >= 4);  // Only ID 4-5 also go to PL

            // Forward header
            if (to_aie) {
                out.write(header);
            }
            if (to_pl) {
                plout.write(header);
            }

            // Forward payload until TLAST
            bool last_word = false;
            do {
                axis32_t payload = read_from_ch(i, s0, s1, s2, s3, s4, s5);
                last_word = payload.last;

                if (to_aie) {
                    out.write(payload);
                }
                if (to_pl) {
                    plout.write(payload);
                }
            } while (!last_word);
        }
    }
}
