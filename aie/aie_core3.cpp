/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include <aie_api/aie.hpp>
#include <aie_api/aie_adf.hpp>
void aie_core3(input_pktstream *in,output_pktstream *out){
        uint32 header = readincr(in);
        writeincr(out, header, false);

        bool tlast;
        do {
                int32 tmp=readincr(in,tlast);
                writeincr(out,tmp,tlast);//Preserve TLAST from input
        } while(!tlast);
}
