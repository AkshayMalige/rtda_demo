/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"
#include "packet_ids_c.h"

static const int PACKET_NUM = 4;

static const unsigned int packet_ids[PACKET_NUM] = {Dataout0_0, Dataout0_1, Dataout0_2, Dataout0_3};

unsigned int getPacketId(ap_uint<32> header){
#pragma HLS inline
	ap_uint<32> ID=0;
	ID(7,0)=header(7,0);
	return ID;
}

void hls_packet_receiver(hls::stream<ap_axiu<32,0,0,0>> &in,
                         hls::stream<ap_axiu<32,0,0,0>> &out0,
                         hls::stream<ap_axiu<32,0,0,0>> &out1,
                         hls::stream<ap_axiu<32,0,0,0>> &out2,
                         hls::stream<ap_axiu<32,0,0,0>> &out3,
                         const unsigned int total_num_packet) {
        // total_num_packet is the expected sum of packets for packet IDs 0-3.
        for (unsigned int iter = 0; iter < total_num_packet; iter++) {
                ap_axiu<32,0,0,0> header = in.read(); // first word is packet header
                unsigned int ID = getPacketId(header.data);

                int channel = -1;
                for (int idx = 0; idx < PACKET_NUM; ++idx) {
                        if (packet_ids[idx] == ID) {
                                channel = idx;
                                break;
                        }
                }

                ap_axiu<32,0,0,0> tmp;
                do {
                        tmp = in.read();
                        if (channel == 0) {
                                out0.write(tmp);
                        } else if (channel == 1) {
                                out1.write(tmp);
                        } else if (channel == 2) {
                                out2.write(tmp);
                        } else if (channel == 3) {
                                out3.write(tmp);
                        }
                } while (!tmp.last);
        }
}
