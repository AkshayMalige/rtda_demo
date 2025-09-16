/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include <stdlib.h>
#include <fstream>
#include <iostream>
#include <unistd.h>
#include <complex>
#include "adf/adf_api/XRTConfig.h"
#include "experimental/xrt_kernel.h"

#include "graph.cpp"

using namespace adf;
using namespace std;

int main(int argc, char* argv[]) {
        int packet_num=2;
        int total_packet_num=packet_num*4;
        int total_packet_num2=packet_num*6; // six packets per iteration
        int mem_size=packet_num*32;

	if(argc != 2) {
		std::cout << "Usage: " << argv[0] <<" <xclbin>" << std::endl;
		return EXIT_FAILURE;
    	}
    	char* xclbinFilename = argv[1];
	
	int ret=0;
	int match=0;
	// Open xclbin
	auto dhdl = xrtDeviceOpen(0);//device index=0
	if(!dhdl){
		printf("Device open error\n");
	}	
	ret=xrtDeviceLoadXclbinFile(dhdl,xclbinFilename);	
	if(ret){
		printf("Xclbin Load fail\n");
    	}
	xuid_t uuid;
	xrtDeviceGetXclbinUUID(dhdl, uuid);

	// output memory
	xrtBufferHandle out_bo1 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle out_bo2 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle out_bo3 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle out_bo4 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle out_bo5 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle out_bo6 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
        int *host_out1 = (int*)xrtBOMap(out_bo1);
        int *host_out2 = (int*)xrtBOMap(out_bo2);
        int *host_out3 = (int*)xrtBOMap(out_bo3);
        int *host_out4 = (int*)xrtBOMap(out_bo4);
        int *host_out5 = (int*)xrtBOMap(out_bo5);
        int *host_out6 = (int*)xrtBOMap(out_bo6);
	
	// input memory
	xrtBufferHandle in_bo1 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo2 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo3 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo4 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo5 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo6 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
        int *host_in1 = (int*)xrtBOMap(in_bo1);
        int *host_in2 = (int*)xrtBOMap(in_bo2);
        int *host_in3 = (int*)xrtBOMap(in_bo3);
        int *host_in4 = (int*)xrtBOMap(in_bo4);
        int *host_in5 = (int*)xrtBOMap(in_bo5);
        int *host_in6 = (int*)xrtBOMap(in_bo6);

	std::cout<<" memory allocation complete"<<std::endl;
	// initialize input memory
	for(int i=0;i<mem_size/sizeof(int);i++){
                *(host_in1+i)=i;
                *(host_in2+i)=2*i;
                *(host_in3+i)=3*i;
                *(host_in4+i)=4*i;
                *(host_in5+i)=5*i;
                *(host_in6+i)=6*i;
        }
	
	// start output kernels
	xrtKernelHandle s2mm_k1 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_1}");
	xrtRunHandle s2mm_r1 = xrtRunOpen(s2mm_k1);
	xrtRunSetArg(s2mm_r1, 0, out_bo1);
	xrtRunSetArg(s2mm_r1, 2, mem_size/sizeof(int));
	xrtRunStart(s2mm_r1);
	xrtKernelHandle s2mm_k2 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_2}");
	xrtRunHandle s2mm_r2 = xrtRunOpen(s2mm_k2);
	xrtRunSetArg(s2mm_r2, 0, out_bo2);
	xrtRunSetArg(s2mm_r2, 2, mem_size/sizeof(int));
	xrtRunStart(s2mm_r2);
	xrtKernelHandle s2mm_k3 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_3}");
	xrtRunHandle s2mm_r3 = xrtRunOpen(s2mm_k3);
	xrtRunSetArg(s2mm_r3, 0, out_bo3);
	xrtRunSetArg(s2mm_r3, 2, mem_size/sizeof(int));
	xrtRunStart(s2mm_r3);
	xrtKernelHandle s2mm_k4 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_4}");
	xrtRunHandle s2mm_r4 = xrtRunOpen(s2mm_k4);
	xrtRunSetArg(s2mm_r4, 0, out_bo4);
	xrtRunSetArg(s2mm_r4, 2, mem_size/sizeof(int));
	xrtRunStart(s2mm_r4);
	xrtKernelHandle s2mm_k5 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_5}");
	xrtRunHandle s2mm_r5 = xrtRunOpen(s2mm_k5);
	xrtRunSetArg(s2mm_r5, 0, out_bo5);
	xrtRunSetArg(s2mm_r5, 2, mem_size/sizeof(int));
	xrtRunStart(s2mm_r5);
	xrtKernelHandle s2mm_k6 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_6}");
	xrtRunHandle s2mm_r6 = xrtRunOpen(s2mm_k6);
	xrtRunSetArg(s2mm_r6, 0, out_bo6);
	xrtRunSetArg(s2mm_r6, 2, mem_size/sizeof(int));
	xrtRunStart(s2mm_r6);


	xrtKernelHandle hls_packet_receiver_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver:{hls_packet_receiver_1}");
	xrtRunHandle hls_packet_receiver_r = xrtRunOpen(hls_packet_receiver_k);
	xrtRunSetArg(hls_packet_receiver_r, 5, total_packet_num);
	xrtRunStart(hls_packet_receiver_r);
	std::cout<<" output kernel complete"<<std::endl;

	xrtKernelHandle hls_packet_receiver_k2 = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver2:{hls_packet_receiver_2}");
        xrtRunHandle hls_packet_receiver_r2 = xrtRunOpen(hls_packet_receiver_k2);
        xrtRunSetArg(hls_packet_receiver_r2, 3, total_packet_num2); // six packets per iteration
        xrtRunStart(hls_packet_receiver_r2);
	std::cout<<" output kernel2 complete"<<std::endl;

	// start input kernels
	xrtKernelHandle mm2s_k1 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_1}");
	xrtRunHandle mm2s_r1 = xrtRunOpen(mm2s_k1);
	xrtRunSetArg(mm2s_r1, 0, in_bo1);
	xrtRunSetArg(mm2s_r1, 2, mem_size/sizeof(int));
	xrtRunStart(mm2s_r1);
	xrtKernelHandle mm2s_k2 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_2}");
	xrtRunHandle mm2s_r2 = xrtRunOpen(mm2s_k2);
	xrtRunSetArg(mm2s_r2, 0, in_bo2);
	xrtRunSetArg(mm2s_r2, 2, mem_size/sizeof(int));
	xrtRunStart(mm2s_r2);
	xrtKernelHandle mm2s_k3 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_3}");
	xrtRunHandle mm2s_r3 = xrtRunOpen(mm2s_k3);
	xrtRunSetArg(mm2s_r3, 0, in_bo3);
	xrtRunSetArg(mm2s_r3, 2, mem_size/sizeof(int));
	xrtRunStart(mm2s_r3);
	xrtKernelHandle mm2s_k4 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_4}");
	xrtRunHandle mm2s_r4 = xrtRunOpen(mm2s_k4);
	xrtRunSetArg(mm2s_r4, 0, in_bo4);
	xrtRunSetArg(mm2s_r4, 2, mem_size/sizeof(int));
	xrtRunStart(mm2s_r4);
	
	xrtKernelHandle mm2s_k5 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_5}");
	xrtRunHandle mm2s_r5 = xrtRunOpen(mm2s_k5);
	xrtRunSetArg(mm2s_r5, 0, in_bo5);
	xrtRunSetArg(mm2s_r5, 2, mem_size/sizeof(int));
	xrtRunStart(mm2s_r5);
	xrtKernelHandle mm2s_k6 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_6}");
	xrtRunHandle mm2s_r6 = xrtRunOpen(mm2s_k6);
	xrtRunSetArg(mm2s_r6, 0, in_bo6);
	xrtRunSetArg(mm2s_r6, 2, mem_size/sizeof(int));
	xrtRunStart(mm2s_r6);
        xrtKernelHandle hls_packet_sender_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_sender");
	xrtRunHandle hls_packet_sender_r = xrtRunOpen(hls_packet_sender_k);
        xrtRunSetArg(hls_packet_sender_r, 8, packet_num);
	xrtRunStart(hls_packet_sender_r);
	std::cout<<" input kernel complete"<<std::endl;

	// start graph
        adf::registerXRT(dhdl, uuid);
        gr.run(2);
        std::cout<<" graph run complete"<<std::endl;

        // wait for all runs to complete
        std::cout << "waiting for mm2s_r1" << std::endl;
        xrtRunWait(mm2s_r1);
        std::cout << "waiting for mm2s_r2" << std::endl;
        xrtRunWait(mm2s_r2);
        std::cout << "waiting for mm2s_r3" << std::endl;
        xrtRunWait(mm2s_r3);
        std::cout << "waiting for mm2s_r4" << std::endl;
        xrtRunWait(mm2s_r4);
        std::cout << "waiting for mm2s_r5" << std::endl;
        xrtRunWait(mm2s_r5);
        std::cout << "waiting for mm2s_r6" << std::endl;
        xrtRunWait(mm2s_r6);
        std::cout << "waiting for hls_packet_sender_r" << std::endl;
        xrtRunWait(hls_packet_sender_r);
        std::cout << "waiting for s2mm_r1" << std::endl;
        xrtRunWait(s2mm_r1);
        std::cout << "waiting for s2mm_r2" << std::endl;
        xrtRunWait(s2mm_r2);
        std::cout << "waiting for s2mm_r3" << std::endl;
        xrtRunWait(s2mm_r3);
        std::cout << "waiting for s2mm_r4" << std::endl;
        xrtRunWait(s2mm_r4);
        std::cout << "waiting for s2mm_r5" << std::endl;
        xrtRunWait(s2mm_r5);
        std::cout << "waiting for s2mm_r6" << std::endl;
        xrtRunWait(s2mm_r6);
        std::cout << "waiting for hls_packet_receiver_r" << std::endl;
        xrtRunWait(hls_packet_receiver_r);
        std::cout << "waiting for hls_packet_receiver_r2" << std::endl;
        xrtRunWait(hls_packet_receiver_r2);
        std::cout<<" run wait complete"<<std::endl;

        // post-processing data;
        for(int i=0;i<mem_size/sizeof(int);i++){
                if(*(host_out1+i)!=*(host_in1+i)){
                        match=1;
                        std::cout<<"Mismatch host_out1["<<i<<"]="<<host_out1[i]
                                 <<" expected "<<host_in1[i]<<std::endl;
                }
                if(*(host_out2+i)!=*(host_in2+i)){
                        match=1;
                        std::cout<<"Mismatch host_out2["<<i<<"]="<<host_out2[i]
                                 <<" expected "<<host_in2[i]<<std::endl;
                }
                if(*(host_out3+i)!=*(host_in3+i)){
                        match=1;
                        std::cout<<"Mismatch host_out3["<<i<<"]="<<host_out3[i]
                                 <<" expected "<<host_in3[i]<<std::endl;
                }
                if(*(host_out4+i)!=*(host_in4+i)){
                        match=1;
                        std::cout<<"Mismatch host_out4["<<i<<"]="<<host_out4[i]
                                 <<" expected "<<host_in4[i]<<std::endl;
                }
                if(*(host_out5+i)!=*(host_in5+i)){
                        match=1;
                        std::cout<<"Mismatch host_out5["<<i<<"]="<<host_out5[i]
                                 <<" expected "<<host_in5[i]<<std::endl;
                }
                if(*(host_out6+i)!=*(host_in6+i)){
                        match=1;
                        std::cout<<"Mismatch host_out6["<<i<<"]="<<host_out6[i]
                                 <<" expected "<<host_in6[i]<<std::endl;
                }
        }

        // release memory
        xrtRunClose(s2mm_r1);
        xrtRunClose(s2mm_r2);
	xrtRunClose(s2mm_r3);
	xrtRunClose(s2mm_r4);
	xrtRunClose(s2mm_r5);
	xrtRunClose(s2mm_r6);
        xrtRunClose(hls_packet_receiver_r);
	xrtRunClose(hls_packet_receiver_r2);
	xrtKernelClose(s2mm_k1);
	xrtKernelClose(s2mm_k2);
	xrtKernelClose(s2mm_k3);
	xrtKernelClose(s2mm_k4);
	xrtKernelClose(s2mm_k5);
	xrtKernelClose(s2mm_k6);
        xrtKernelClose(hls_packet_receiver_k);
	xrtKernelClose(hls_packet_receiver_k2);
	xrtRunClose(mm2s_r1);
	xrtRunClose(mm2s_r2);
	xrtRunClose(mm2s_r3);
	xrtRunClose(mm2s_r4);
	xrtRunClose(mm2s_r5);
	xrtRunClose(mm2s_r6);
        xrtRunClose(hls_packet_sender_r);
	xrtKernelClose(mm2s_k1);
	xrtKernelClose(mm2s_k2);
	xrtKernelClose(mm2s_k3);
	xrtKernelClose(mm2s_k4);
	xrtKernelClose(mm2s_k5);
	xrtKernelClose(mm2s_k6);
        xrtKernelClose(hls_packet_sender_k);
        xrtBOFree(out_bo1);
        xrtBOFree(out_bo2);
        xrtBOFree(out_bo3);
        xrtBOFree(out_bo4);
        xrtBOFree(out_bo5);
        xrtBOFree(out_bo6);
        xrtBOFree(in_bo1);
        xrtBOFree(in_bo2);
        xrtBOFree(in_bo3);
        xrtBOFree(in_bo4);
        xrtBOFree(in_bo5);
        xrtBOFree(in_bo6);
        gr.end();
        xrtDeviceClose(dhdl);
	
	std::cout << "TEST " << (match ? "FAILED" : "PASSED") << std::endl; 
	return (match ? EXIT_FAILURE :  EXIT_SUCCESS);
}
