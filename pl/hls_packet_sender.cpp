/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"
#include "packet_ids_c.h"

static const unsigned int pktType = 0;
static const int PACKET_NUM = 6; // How many kernels do packet switching
static const int PACKET_LEN = 8; // Length for a packet

// Macro values are generated in packet_ids_c.h
static const unsigned int packet_ids[PACKET_NUM] = {Datain0_0, Datain0_1, Datain0_2, Datain0_3, 4, 5};

ap_uint<32> generateHeader(unsigned int pktType, unsigned int ID) {
    #pragma HLS inline
    ap_uint<32> header = 0;
    header(7, 0) = ID;
    header(11, 8) = 0;
    header(14, 12) = pktType;
    header[15] = 0;
    header(20, 16) = -1; // source row
    header(27, 21) = -1; // source column
    header(30, 28) = 0;
    header[31] = header(30, 0).xor_reduce() ? (ap_uint<1>)0 : (ap_uint<1>)1;
    return header;
}

void hls_packet_sender(
    hls::stream<ap_axiu<32, 0, 0, 0>>& s0,
    hls::stream<ap_axiu<32, 0, 0, 0>>& s1,
    hls::stream<ap_axiu<32, 0, 0, 0>>& s2,
    hls::stream<ap_axiu<32, 0, 0, 0>>& s3,
    hls::stream<ap_axiu<32, 0, 0, 0>>& s4,
    hls::stream<ap_axiu<32, 0, 0, 0>>& s5,
    hls::stream<ap_axiu<32, 0, 0, 0>>& out,    // Stream to AI Engine (packet IDs 0-3)
    hls::stream<ap_axiu<32, 0, 0, 0>>& plout,  // Stream to packet_receiver2 (packet IDs 4-5)
    const unsigned int channel_words[PACKET_NUM],
    const unsigned int max_packets_per_channel) {
    #pragma HLS INTERFACE axis port=s0
    #pragma HLS INTERFACE axis port=s1
    #pragma HLS INTERFACE axis port=s2
    #pragma HLS INTERFACE axis port=s3
    #pragma HLS INTERFACE axis port=s4
    #pragma HLS INTERFACE axis port=s5
    #pragma HLS INTERFACE axis port=out
    #pragma HLS INTERFACE axis port=plout
    #pragma HLS INTERFACE s_axilite port=channel_words bundle=CTRL
    #pragma HLS INTERFACE s_axilite port=max_packets_per_channel bundle=CTRL
    #pragma HLS INTERFACE s_axilite port=return bundle=CTRL

    // This pragma tells HLS not to add implicit dependencies between the streams,
    // which is critical for preventing stalls.
    #pragma HLS DATAFLOW

    unsigned int remaining_words[PACKET_NUM];
    #pragma HLS ARRAY_PARTITION variable=remaining_words complete dim=1
    unsigned int remaining_packets[PACKET_NUM];
    #pragma HLS ARRAY_PARTITION variable=remaining_packets complete dim=1

    for (int i = 0; i < PACKET_NUM; i++) {
    #pragma HLS UNROLL
        const unsigned int words = channel_words[i];
        remaining_words[i] = words;
        unsigned int packets_needed = (words + PACKET_LEN - 1) / PACKET_LEN;
        // Respect the max_packets_per_channel guard while covering every word in the channel.
        remaining_packets[i] = (packets_needed < max_packets_per_channel) ? packets_needed : max_packets_per_channel;
    }

    bool channels_pending = true;
    while (channels_pending) {
        channels_pending = false;
        for (int i = 0; i < PACKET_NUM; i++) {
            if ((remaining_words[i] > 0) && (remaining_packets[i] > 0)) {
                channels_pending = true;

                unsigned int ID = packet_ids[i];
                ap_uint<32> header = generateHeader(pktType, ID); // packet header

                ap_axiu<32, 0, 0, 0> header_pkt;
                header_pkt.data = header;
                header_pkt.keep = -1;
                header_pkt.last = 0;

                // Packet IDs 0-3 stay on the AI Engine stream; IDs 4-5 are exclusive to the PL path.
                if (i < 4) {
                    out.write(header_pkt);
                } else {
                    plout.write(header_pkt);
                }

                unsigned int words_this_packet = (remaining_words[i] > PACKET_LEN) ? PACKET_LEN : remaining_words[i];

                for (unsigned int j = 0; j < words_this_packet; j++) {
                #pragma HLS PIPELINE II=1
                    ap_axiu<32, 0, 0, 0> data_pkt;
                    data_pkt.data = 0;
                    data_pkt.keep = -1;
                    data_pkt.strb = -1;
                    data_pkt.last = 0;

                    switch (i) {
                        case 0: data_pkt = s0.read(); break;
                        case 1: data_pkt = s1.read(); break;
                        case 2: data_pkt = s2.read(); break;
                        case 3: data_pkt = s3.read(); break;
                        case 4: data_pkt = s4.read(); break;
                        case 5: data_pkt = s5.read(); break;
                    }

                    data_pkt.last = (j == words_this_packet - 1) ? (ap_uint<1>)1 : (ap_uint<1>)0;

                    // Mirror the routing decision used for the packet header.
                    if (i < 4) {
                        out.write(data_pkt);
                    } else {
                        plout.write(data_pkt);
                    }
                }

                remaining_words[i] -= words_this_packet;
                remaining_packets[i]--;
            }
        }
    }
}
