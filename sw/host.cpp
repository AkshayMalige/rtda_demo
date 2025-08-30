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
        int total_packet_num2=packet_num*8;
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
	xrtBufferHandle out_bo7 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle out_bo8 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	int *host_out1 = (int*)xrtBOMap(out_bo1);
	int *host_out2 = (int*)xrtBOMap(out_bo2);
	int *host_out3 = (int*)xrtBOMap(out_bo3);
	int *host_out4 = (int*)xrtBOMap(out_bo4);
	int *host_out5 = (int*)xrtBOMap(out_bo5);
	int *host_out6 = (int*)xrtBOMap(out_bo6);
	int *host_out7 = (int*)xrtBOMap(out_bo7);
	int *host_out8 = (int*)xrtBOMap(out_bo8);
	
	// input memory
	xrtBufferHandle in_bo1 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo2 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo3 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo4 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo5 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo6 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo7 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	xrtBufferHandle in_bo8 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
	int *host_in1 = (int*)xrtBOMap(in_bo1);
	int *host_in2 = (int*)xrtBOMap(in_bo2);
	int *host_in3 = (int*)xrtBOMap(in_bo3);
	int *host_in4 = (int*)xrtBOMap(in_bo4);
	int *host_in5 = (int*)xrtBOMap(in_bo5);
	int *host_in6 = (int*)xrtBOMap(in_bo6);
	int *host_in7 = (int*)xrtBOMap(in_bo7);
	int *host_in8 = (int*)xrtBOMap(in_bo8);

	std::cout<<" memory allocation complete"<<std::endl;
	// initialize input memory
	for(int i=0;i<mem_size/sizeof(int);i++){
		*(host_in1+i)=i;
		*(host_in2+i)=2*i;
		*(host_in3+i)=3*i;
		*(host_in4+i)=4*i;
		*(host_in5+i)=5*i;
		*(host_in6+i)=6*i;
		*(host_in7+i)=7*i;
		*(host_in8+i)=8*i;
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
	xrtKernelHandle s2mm_k7 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_7}");
	xrtRunHandle s2mm_r7 = xrtRunOpen(s2mm_k7);
	xrtRunSetArg(s2mm_r7, 0, out_bo7);
	xrtRunSetArg(s2mm_r7, 2, mem_size/sizeof(int));
	xrtRunStart(s2mm_r7);
	xrtKernelHandle s2mm_k8 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_8}");
	xrtRunHandle s2mm_r8 = xrtRunOpen(s2mm_k8);
	xrtRunSetArg(s2mm_r8, 0, out_bo8);
	xrtRunSetArg(s2mm_r8, 2, mem_size/sizeof(int));
	xrtRunStart(s2mm_r8);


	xrtKernelHandle hls_packet_receiver_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver:{hls_packet_receiver_1}");
	xrtRunHandle hls_packet_receiver_r = xrtRunOpen(hls_packet_receiver_k);
	xrtRunSetArg(hls_packet_receiver_r, 5, total_packet_num);
	xrtRunStart(hls_packet_receiver_r);
	std::cout<<" output kernel complete"<<std::endl;

	xrtKernelHandle hls_packet_receiver_k2 = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver2:{hls_packet_receiver_2}");
	xrtRunHandle hls_packet_receiver_r2 = xrtRunOpen(hls_packet_receiver_k2);
        xrtRunSetArg(hls_packet_receiver_r2, 5, total_packet_num2);
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
	xrtKernelHandle mm2s_k7 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_7}");
	xrtRunHandle mm2s_r7 = xrtRunOpen(mm2s_k7);
	xrtRunSetArg(mm2s_r7, 0, in_bo7);
	xrtRunSetArg(mm2s_r7, 2, mem_size/sizeof(int));
	xrtRunStart(mm2s_r7);
	xrtKernelHandle mm2s_k8 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_8}");
	xrtRunHandle mm2s_r8 = xrtRunOpen(mm2s_k8);
	xrtRunSetArg(mm2s_r8, 0, in_bo8);
	xrtRunSetArg(mm2s_r8, 2, mem_size/sizeof(int));
	xrtRunStart(mm2s_r8);
	xrtKernelHandle hls_packet_sender_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_sender");
	xrtRunHandle hls_packet_sender_r = xrtRunOpen(hls_packet_sender_k);
	xrtRunSetArg(hls_packet_sender_r, 5, packet_num);
	xrtRunStart(hls_packet_sender_r);
	std::cout<<" input kernel complete"<<std::endl;

	// start graph
	adf::registerXRT(dhdl, uuid);
	gr.run(2);
	std::cout<<" graph run complete"<<std::endl;

	// wait for s2mm to complete
	xrtRunWait(s2mm_r1);
	xrtRunWait(s2mm_r2);
	xrtRunWait(s2mm_r3);
	xrtRunWait(s2mm_r4);
	xrtRunWait(s2mm_r5);
	xrtRunWait(s2mm_r6);
	xrtRunWait(s2mm_r7);
	xrtRunWait(s2mm_r8);
	std::cout<<" s2mm wait complete"<<std::endl;

	// post-processing data;
	for(int i=0;i<mem_size/sizeof(int);i++){	
		if(*(host_out1+i)!=*(host_in1+i)+1){
			match=1;
			std::cout<<"host_out1["<<i<<"]="<<host_out1[i]<<std::endl;
		}
		if(*(host_out2+i)!=*(host_in2+i)+2){
			match=1;
			std::cout<<"host_out2["<<i<<"]="<<host_out2[i]<<std::endl;
		}
		if(*(host_out3+i)!=*(host_in3+i)+3){
			match=1;
			std::cout<<"host_out3["<<i<<"]="<<host_out3[i]<<std::endl;
		}
		if(*(host_out4+i)!=*(host_in4+i)+4){
			match=1;
			std::cout<<"host_out4["<<i<<"]="<<host_out4[i]<<std::endl;
		}
	}

	// release memory
	xrtRunClose(s2mm_r1);
	xrtRunClose(s2mm_r2);
	xrtRunClose(s2mm_r3);
	xrtRunClose(s2mm_r4);
	xrtRunClose(s2mm_r5);
	xrtRunClose(s2mm_r6);
	xrtRunClose(s2mm_r7);
	xrtRunClose(s2mm_r8);
	xrtRunClose(hls_packet_receiver_r);
	xrtRunClose(hls_packet_receiver_r2);
	xrtKernelClose(s2mm_k1);
	xrtKernelClose(s2mm_k2);
	xrtKernelClose(s2mm_k3);
	xrtKernelClose(s2mm_k4);
	xrtKernelClose(s2mm_k5);
	xrtKernelClose(s2mm_k6);
	xrtKernelClose(s2mm_k7);
	xrtKernelClose(s2mm_k8);
	xrtKernelClose(hls_packet_receiver_k);
	xrtKernelClose(hls_packet_receiver_k2);
	xrtRunClose(mm2s_r1);
	xrtRunClose(mm2s_r2);
	xrtRunClose(mm2s_r3);
	xrtRunClose(mm2s_r4);
	xrtRunClose(mm2s_r5);
	xrtRunClose(mm2s_r6);
	xrtRunClose(mm2s_r7);
	xrtRunClose(mm2s_r8);
	xrtRunClose(hls_packet_sender_r);
	xrtKernelClose(mm2s_k1);
	xrtKernelClose(mm2s_k2);
	xrtKernelClose(mm2s_k3);
	xrtKernelClose(mm2s_k4);
	xrtKernelClose(mm2s_k5);
	xrtKernelClose(mm2s_k6);
	xrtKernelClose(mm2s_k7);
	xrtKernelClose(mm2s_k8);
	xrtKernelClose(hls_packet_sender_k);
	xrtBOFree(out_bo1);
	xrtBOFree(out_bo2);
	xrtBOFree(out_bo3);
	xrtBOFree(out_bo4);
	xrtBOFree(in_bo1);
	xrtBOFree(in_bo2);
	xrtBOFree(in_bo3);
	xrtBOFree(in_bo4);
	gr.end();
	xrtDeviceClose(dhdl);
	
	std::cout << "TEST " << (match ? "FAILED" : "PASSED") << std::endl; 
	return (match ? EXIT_FAILURE :  EXIT_SUCCESS);
}
