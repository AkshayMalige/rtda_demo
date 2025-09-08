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
    hls::stream<ap_axiu<32, 0, 0, 0>>& out,    // Stream to AI Engine
    hls::stream<ap_axiu<32, 0, 0, 0>>& plout,  // Stream to packet_receiver2
    const unsigned int num) {
    
    // This pragma tells HLS not to add implicit dependencies between the streams,
    // which is critical for preventing stalls.
    #pragma HLS DATAFLOW

    for (unsigned int iter = 0; iter < num; iter++) {
        for (int i = 0; i < PACKET_NUM; i++) {
            unsigned int ID = packet_ids[i];
            ap_uint<32> header = generateHeader(pktType, ID); // packet header
            
            ap_axiu<32, 0, 0, 0> header_pkt;
            header_pkt.data = header;
            header_pkt.keep = -1;
            header_pkt.last = 0;

            // Write header to PL first so that PL kernels
            // receive data even if the AI Engine back-pressures
            // the sender. Packets with IDs 4 and 5 are meant only
            // for the PL, so avoid writing them to the AI Engine
            // output stream.
            plout.write(header_pkt);
            if (i < 4) {
                out.write(header_pkt);
            }

            for (int j = 0; j < PACKET_LEN; j++) { // packet data
                ap_axiu<32, 0, 0, 0> data_pkt;

                // 1. Read the data ONCE from the appropriate input stream
                switch (i) {
                    case 0: data_pkt = s0.read(); break;
                    case 1: data_pkt = s1.read(); break;
                    case 2: data_pkt = s2.read(); break;
                    case 3: data_pkt = s3.read(); break;
                    case 4: data_pkt = s4.read(); break;
                    case 5: data_pkt = s5.read(); break;
                }

                if (j == PACKET_LEN - 1) {
                    data_pkt.last = 1; // last word in a packet has TLAST=1
                } else {
                    data_pkt.last = 0;
                }

                // 2. Write the data to PL first; only the first
                // four packet IDs are forwarded to the AI Engine
                // to match the pktsplit<4> configuration in the AIE graph.
                plout.write(data_pkt);
                if (i < 4) {
                    out.write(data_pkt);
                }
            }
        }
    }
}