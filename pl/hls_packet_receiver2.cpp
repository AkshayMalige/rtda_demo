/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include "hls_stream.h"
#include "ap_int.h"
#include "ap_axi_sdata.h"
#include "packet_ids_c.h"

static const int PACKET_NUM=2;

static const unsigned int packet_ids[PACKET_NUM]={4,5};

typedef ap_axiu<32,0,0,0> axis32_t;

unsigned int getPacketId(ap_uint<32> header){
#pragma HLS inline
        ap_uint<32> ID=0;
        ID(7,0)=header(7,0);
        return ID;
}

void hls_packet_receiver2(hls::stream<axis32_t> &in, hls::stream<axis32_t> &out0,hls::stream<axis32_t> &out1,
        const unsigned int total_num_packet){
        const int packet_limit = static_cast<int>(total_num_packet);
        for(int pkt=0; pkt<packet_limit; ++pkt){
                axis32_t header=in.read();//first word is packet header
                unsigned int ID=getPacketId(header.data);
                unsigned int channel=0;
                bool valid_channel=false;

                for(int idx=0; idx<PACKET_NUM; ++idx){
                        if(ID==packet_ids[idx]){
                                channel=idx;
                                valid_channel=true;
                                break;
                        }
                }

                bool last_word=false;
                do{
                        axis32_t tmp=in.read();
                        last_word = tmp.last;
                        if(valid_channel){
                                switch(channel){
                                case 0:out0.write(tmp);break;
                                case 1:out1.write(tmp);break;
                                default:break;
                                }
                        }
                }while(!last_word);
        }
}
