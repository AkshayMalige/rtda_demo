/*
Copyright (C) 2023, Advanced Micro Devices, Inc. All rights reserved.
SPDX-License-Identifier: MIT
*/
#include <stdlib.h>
#include <algorithm>
#include <array>
#include <cstddef>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <unistd.h>
#include <complex>
#include <vector>
#include "experimental/xrt_graph.h"
#include "experimental/xrt_kernel.h"

using namespace std;

int main(int argc, char* argv[]) {
        constexpr int channel_count = 6;
        constexpr unsigned int PACKET_LEN = 8;
        // Per-channel word counts (packet IDs 0-5). Shorter channels validate TLAST-driven termination.
        const std::array<unsigned int, channel_count> channel_words = {16, 13, 5, 8, 16, 6};

        auto packets_for_words = [](unsigned int words) -> unsigned int {
                return (words + PACKET_LEN - 1) / PACKET_LEN;
        };

        // Use the largest packet requirement so the sender can drain every channel without
        // hitting the max_packets_per_channel ceiling.
        unsigned int max_packets_per_channel = 0;
        for (unsigned int words : channel_words) {
                unsigned int channel_packets = packets_for_words(words);
                if (channel_packets > max_packets_per_channel) {
                        max_packets_per_channel = channel_packets;
                }
        }

        unsigned int total_packets_ai = 0;
        for (int idx = 0; idx < 4; ++idx) {
                total_packets_ai += packets_for_words(channel_words[idx]);
        }

        unsigned int total_packets_pl = 0;
        for (int idx = 4; idx < channel_count; ++idx) {
                total_packets_pl += packets_for_words(channel_words[idx]);
        }

        const std::size_t max_channel_words = *std::max_element(channel_words.begin(), channel_words.end());

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

        std::array<xrtBufferHandle, channel_count> out_bos;
        std::array<xrtBufferHandle, channel_count> in_bos;
        std::array<float*, channel_count> host_outputs;
        std::array<float*, channel_count> host_inputs;
        const std::array<const char*, channel_count> s2mm_kernel_names = {
                "s2mm:{s2mm_1}", "s2mm:{s2mm_2}", "s2mm:{s2mm_3}",
                "s2mm:{s2mm_4}", "s2mm:{s2mm_5}", "s2mm:{s2mm_6}"
        };
        const std::array<const char*, channel_count> mm2s_kernel_names = {
                "mm2s:{mm2s_1}", "mm2s:{mm2s_2}", "mm2s:{mm2s_3}",
                "mm2s:{mm2s_4}", "mm2s:{mm2s_5}", "mm2s:{mm2s_6}"
        };
        for (int channel = 0; channel < channel_count; ++channel) {
                const unsigned int words = channel_words[channel];
                if (words == 0u) {
                        std::cerr << "channel_words[" << channel << "] must be greater than zero" << std::endl;
                        return EXIT_FAILURE;
                }

                const std::size_t byte_count = static_cast<std::size_t>(words) * sizeof(float);
                out_bos[channel] = xrtBOAlloc(dhdl, byte_count, 0, /*BANK=*/0);
                host_outputs[channel] = reinterpret_cast<float*>(xrtBOMap(out_bos[channel]));
                in_bos[channel] = xrtBOAlloc(dhdl, byte_count, 0, /*BANK=*/0);
                host_inputs[channel] = reinterpret_cast<float*>(xrtBOMap(in_bos[channel]));
        }

        std::ifstream input_file;
        input_file.open("./data/embed_input.txt");

        if(!input_file.is_open()) {
                std::cerr << "Failed to open data/embed_input.txt" << std::endl;
                return EXIT_FAILURE;
        }

        std::vector<float> file_values;
        float value = 0.0f;
        while(input_file >> value) {
                file_values.push_back(value);
        }

        if(input_file.fail() && !input_file.eof()) {
                std::cerr << "Failed to parse floating-point data from data/embed_input.txt" << std::endl;
                return EXIT_FAILURE;
        }

        if(input_file.bad()) {
                std::cerr << "Error while reading data/embed_input.txt" << std::endl;
                return EXIT_FAILURE;
        }

        if(file_values.empty()) {
                std::cerr << "Input file data/embed_input.txt did not contain any values" << std::endl;
                return EXIT_FAILURE;
        }

        if (file_values.size() < max_channel_words) {
                std::cerr << "Input file data/embed_input.txt contains " << file_values.size()
                          << " values; expected at least " << max_channel_words << std::endl;
                return EXIT_FAILURE;
        }

        for (int channel = 0; channel < channel_count; ++channel) {
                std::copy(file_values.begin(),
                          file_values.begin() + channel_words[channel],
                          host_inputs[channel]);
                std::fill_n(host_outputs[channel], channel_words[channel], 0.0f);
        }

        std::cout << "memory allocation complete" << std::endl;
	
        // start output kernels
        std::array<xrtKernelHandle, channel_count> s2mm_kernels;
        std::array<xrtRunHandle, channel_count> s2mm_runs;
        for (int channel = 0; channel < channel_count; ++channel) {
                s2mm_kernels[channel] = xrtPLKernelOpen(dhdl, uuid, s2mm_kernel_names[channel]);
                s2mm_runs[channel] = xrtRunOpen(s2mm_kernels[channel]);
                xrtRunSetArg(s2mm_runs[channel], 0, out_bos[channel]);
                xrtRunSetArg(s2mm_runs[channel], 2, channel_words[channel]);
                xrtRunStart(s2mm_runs[channel]);
        }

        xrtKernelHandle hls_packet_receiver_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver:{hls_packet_receiver_1}");
        xrtRunHandle hls_packet_receiver_r = xrtRunOpen(hls_packet_receiver_k);
        xrtRunSetArg(hls_packet_receiver_r, 5, total_packets_ai);
        xrtRunStart(hls_packet_receiver_r);
        std::cout << "output kernel complete" << std::endl;

        xrtKernelHandle hls_packet_receiver_k2 = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver2:{hls_packet_receiver_2}");
        xrtRunHandle hls_packet_receiver_r2 = xrtRunOpen(hls_packet_receiver_k2);
        xrtRunSetArg(hls_packet_receiver_r2, 3, total_packets_pl);
        xrtRunStart(hls_packet_receiver_r2);
        std::cout << "output kernel2 complete" << std::endl;

        // start input kernels
        std::array<xrtKernelHandle, channel_count> mm2s_kernels;
        std::array<xrtRunHandle, channel_count> mm2s_runs;
        for (int channel = 0; channel < channel_count; ++channel) {
                mm2s_kernels[channel] = xrtPLKernelOpen(dhdl, uuid, mm2s_kernel_names[channel]);
                mm2s_runs[channel] = xrtRunOpen(mm2s_kernels[channel]);
                xrtRunSetArg(mm2s_runs[channel], 0, in_bos[channel]);
                xrtRunSetArg(mm2s_runs[channel], 2, channel_words[channel]);
                xrtRunStart(mm2s_runs[channel]);
        }
        xrtKernelHandle hls_packet_sender_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_sender");
        xrtRunHandle hls_packet_sender_r = xrtRunOpen(hls_packet_sender_k);
        constexpr unsigned int sender_channel_words_arg_start = 8;
        for (int channel = 0; channel < channel_count; ++channel) {
                xrtRunSetArg(
                        hls_packet_sender_r,
                        sender_channel_words_arg_start + channel,
                        channel_words[channel]);
        }
        xrtRunSetArg(
                hls_packet_sender_r,
                sender_channel_words_arg_start + channel_count,
                max_packets_per_channel);
        xrtRunStart(hls_packet_sender_r);
        std::cout << "input kernel complete" << std::endl;

        // start graph
        auto graph = xrtGraphOpen(dhdl, uuid, "gr");
        if(!graph){
                std::cerr << "Failed to open graph mygraph" << std::endl;
                return EXIT_FAILURE;
        }
        xrtGraphRun(graph, 2);
        std::cout << "graph run complete" << std::endl;

        // wait for all runs to complete
        for (int channel = 0; channel < channel_count; ++channel) {
                std::cout << "waiting for mm2s_r" << channel + 1 << std::endl;
                xrtRunWait(mm2s_runs[channel]);
        }
        std::cout << "waiting for hls_packet_sender_r" << std::endl;
        xrtRunWait(hls_packet_sender_r);
        for (int channel = 0; channel < channel_count; ++channel) {
                std::cout << "waiting for s2mm_r" << channel + 1 << std::endl;
                xrtRunWait(s2mm_runs[channel]);
        }
        std::cout << "waiting for hls_packet_receiver_r" << std::endl;
        xrtRunWait(hls_packet_receiver_r);
        std::cout << "waiting for hls_packet_receiver_r2" << std::endl;
        xrtRunWait(hls_packet_receiver_r2);
        std::cout << "run wait complete" << std::endl;

        // post-processing data;
        for(int channel = 0; channel < channel_count; ++channel) {
                for(unsigned int i = 0; i < channel_words[channel]; ++i) {
                        float actual = host_outputs[channel][i];
                        float expected = host_inputs[channel][i];
                        uint32_t actual_bits = 0;
                        uint32_t expected_bits = 0;
                        std::memcpy(&actual_bits, &actual, sizeof(float));
                        std::memcpy(&expected_bits, &expected, sizeof(float));
                        if(actual_bits!=expected_bits){
                                match=1;
                                auto old_precision = std::cout.precision();
                                std::cout<<std::setprecision(10)
                                         <<"Mismatch host_out"<<channel+1<<"["<<i<<"]="
                                         <<actual<<" (0x"<<std::hex<<actual_bits<<std::dec
                                         <<") expected "<<expected<<" (0x"<<std::hex
                                         <<expected_bits<<std::dec<<")"<<std::endl;
                                std::cout.precision(old_precision);
                        }
                }
        }

        // release memory
        for (int channel = 0; channel < channel_count; ++channel) {
                xrtRunClose(s2mm_runs[channel]);
        }
        xrtRunClose(hls_packet_receiver_r);
        xrtRunClose(hls_packet_receiver_r2);
        for (int channel = 0; channel < channel_count; ++channel) {
                xrtKernelClose(s2mm_kernels[channel]);
        }
        xrtKernelClose(hls_packet_receiver_k);
        xrtKernelClose(hls_packet_receiver_k2);
        for (int channel = 0; channel < channel_count; ++channel) {
                xrtRunClose(mm2s_runs[channel]);
        }
        xrtRunClose(hls_packet_sender_r);
        for (int channel = 0; channel < channel_count; ++channel) {
                xrtKernelClose(mm2s_kernels[channel]);
        }
        xrtKernelClose(hls_packet_sender_k);
        for (int channel = 0; channel < channel_count; ++channel) {
                xrtBOFree(out_bos[channel]);
        }
        for (int channel = 0; channel < channel_count; ++channel) {
                xrtBOFree(in_bos[channel]);
        }
        xrtGraphWait(graph, 0);
        xrtGraphEnd(graph, 0);
        xrtGraphClose(graph);
        xrtDeviceClose(dhdl);
	
	std::cout << "TEST " << (match ? "FAILED" : "PASSED") << std::endl; 
	return (match ? EXIT_FAILURE :  EXIT_SUCCESS);
}
