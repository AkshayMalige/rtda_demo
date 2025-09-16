/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
void aie_core2(input_pktstream *in,output_pktstream *out){
        uint32 header = readincr(in);
        writeincr(out, header, false);

        bool tlast;
        for(int i=0;i<8;i++){
                int32 tmp=readincr(in,tlast);
                writeincr(out,tmp,tlast);//Preserve TLAST from input
        }
}
