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
#include <string>
#include <limits>
#include "experimental/xrt_graph.h"
#include "experimental/xrt_kernel.h"

using namespace std;

int main(int argc, char* argv[]) {
        constexpr int channel_count = 6;
        const std::array<std::string, channel_count> primary_files = {
                "data/embed_input.txt",
                "data/embed_input_1.txt",
                "data/embed_input_2.txt",
                "data/embed_input_3.txt",
                "data/embed_input_4.txt",
                "data/embed_input_5.txt"
        };
        const std::array<std::string, channel_count> fallback_files = {
                "data/embed_input_0.txt",
                "",
                "",
                "",
                "",
                ""
        };

	if(argc != 2) {
		std::cout << "Usage: " << argv[0] <<" <xclbin>" << std::endl;
		return EXIT_FAILURE;
    	}
    	char* xclbinFilename = argv[1];
	
        int ret=0;
        int match=0;

        std::array<std::string, channel_count> used_input_files = primary_files;
        std::array<std::vector<float>, channel_count> channel_values;
        std::array<uint32_t, channel_count> words_per_channel{};
        std::array<std::size_t, channel_count> buffer_words{};

        for(int ch=0; ch<channel_count; ++ch) {
                std::ifstream input_stream(used_input_files[ch]);
                if(!input_stream.is_open() && !fallback_files[ch].empty()) {
                        input_stream.open(fallback_files[ch]);
                        if(input_stream.is_open()) {
                                used_input_files[ch] = fallback_files[ch];
                        }
                }

                if(!input_stream.is_open()) {
                        std::cerr << "Failed to open " << primary_files[ch];
                        if(!fallback_files[ch].empty()) {
                                std::cerr << " or " << fallback_files[ch];
                        }
                        std::cerr << std::endl;
                        return EXIT_FAILURE;
                }

                float value = 0.0f;
                while(input_stream >> value) {
                        channel_values[ch].push_back(value);
                }

                if(input_stream.fail() && !input_stream.eof()) {
                        std::cerr << "Failed to parse floating-point data from "
                                  << used_input_files[ch] << std::endl;
                        return EXIT_FAILURE;
                }

                if(input_stream.bad()) {
                        std::cerr << "Error while reading " << used_input_files[ch] << std::endl;
                        return EXIT_FAILURE;
                }

                if(channel_values[ch].size() > std::numeric_limits<uint32_t>::max()) {
                        std::cerr << "Input file " << used_input_files[ch]
                                  << " contains too many entries" << std::endl;
                        return EXIT_FAILURE;
                }

                words_per_channel[ch] = static_cast<uint32_t>(channel_values[ch].size());
                buffer_words[ch] = std::max<std::size_t>(static_cast<std::size_t>(1),
                                                        static_cast<std::size_t>(words_per_channel[ch]));
        }

        for(int ch=0; ch<channel_count; ++ch) {
                std::cout << "Channel " << ch << " source: " << used_input_files[ch]
                          << " (" << words_per_channel[ch] << " words)" << std::endl;
        }

        unsigned int total_packet_num = 0;
        unsigned int total_packet_num2 = 0;
        for(int ch=0; ch<channel_count; ++ch) {
                if(words_per_channel[ch] == 0u) {
                        continue;
                }

                if(ch < 4) {
                        ++total_packet_num;
                } else {
                        ++total_packet_num2;
                }
        }

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

        std::array<xrtBufferHandle, channel_count> out_bos{};
        std::array<xrtBufferHandle, channel_count> in_bos{};
        std::array<float*, channel_count> host_outputs{};
        std::array<float*, channel_count> host_inputs{};

        for(int ch=0; ch<channel_count; ++ch) {
                const std::size_t float_count = buffer_words[ch];
                const std::size_t byte_count = float_count * sizeof(float);

                out_bos[ch] = xrtBOAlloc(dhdl, byte_count, 0, /*BANK=*/0);
                host_outputs[ch] = reinterpret_cast<float*>(xrtBOMap(out_bos[ch]));
                std::fill(host_outputs[ch], host_outputs[ch] + float_count, 0.0f);

                in_bos[ch] = xrtBOAlloc(dhdl, byte_count, 0, /*BANK=*/0);
                host_inputs[ch] = reinterpret_cast<float*>(xrtBOMap(in_bos[ch]));
                std::fill(host_inputs[ch], host_inputs[ch] + float_count, 0.0f);

                if(!channel_values[ch].empty()) {
                        std::copy(channel_values[ch].begin(), channel_values[ch].end(), host_inputs[ch]);
                }
        }

        std::cout<<" memory allocation complete"<<std::endl;
	
        // start output kernels
        const std::array<const char*, channel_count> s2mm_kernel_names = {
                "s2mm:{s2mm_1}",
                "s2mm:{s2mm_2}",
                "s2mm:{s2mm_3}",
                "s2mm:{s2mm_4}",
                "s2mm:{s2mm_5}",
                "s2mm:{s2mm_6}"
        };
        std::array<xrtKernelHandle, channel_count> s2mm_kernels{};
        std::array<xrtRunHandle, channel_count> s2mm_runs{};

        for(int ch=0; ch<channel_count; ++ch) {
                s2mm_kernels[ch] = xrtPLKernelOpen(dhdl, uuid, s2mm_kernel_names[ch]);
                s2mm_runs[ch] = xrtRunOpen(s2mm_kernels[ch]);
                xrtRunSetArg(s2mm_runs[ch], 0, out_bos[ch]);
                xrtRunSetArg(s2mm_runs[ch], 2, words_per_channel[ch]);
                xrtRunStart(s2mm_runs[ch]);
        }

        xrtKernelHandle hls_packet_receiver_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver:{hls_packet_receiver_1}");
        xrtRunHandle hls_packet_receiver_r = xrtRunOpen(hls_packet_receiver_k);
        xrtRunSetArg(hls_packet_receiver_r, 5, total_packet_num);
        xrtRunStart(hls_packet_receiver_r);
        std::cout<<" output kernel complete"<<std::endl;

        xrtKernelHandle hls_packet_receiver_k2 = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver2:{hls_packet_receiver_2}");
        xrtRunHandle hls_packet_receiver_r2 = xrtRunOpen(hls_packet_receiver_k2);
        xrtRunSetArg(hls_packet_receiver_r2, 3, total_packet_num2);
        xrtRunStart(hls_packet_receiver_r2);
        std::cout<<" output kernel2 complete"<<std::endl;

        // start input kernels
        const std::array<const char*, channel_count> mm2s_kernel_names = {
                "mm2s:{mm2s_1}",
                "mm2s:{mm2s_2}",
                "mm2s:{mm2s_3}",
                "mm2s:{mm2s_4}",
                "mm2s:{mm2s_5}",
                "mm2s:{mm2s_6}"
        };
        std::array<xrtKernelHandle, channel_count> mm2s_kernels{};
        std::array<xrtRunHandle, channel_count> mm2s_runs{};

        for(int ch=0; ch<channel_count; ++ch) {
                mm2s_kernels[ch] = xrtPLKernelOpen(dhdl, uuid, mm2s_kernel_names[ch]);
                mm2s_runs[ch] = xrtRunOpen(mm2s_kernels[ch]);
                xrtRunSetArg(mm2s_runs[ch], 0, in_bos[ch]);
                xrtRunSetArg(mm2s_runs[ch], 2, words_per_channel[ch]);
                xrtRunStart(mm2s_runs[ch]);
        }
        xrtKernelHandle hls_packet_sender_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_sender");
        xrtRunHandle hls_packet_sender_r = xrtRunOpen(hls_packet_sender_k);
        for(int ch=0; ch<channel_count; ++ch) {
                xrtRunSetArg(hls_packet_sender_r, 8 + ch, words_per_channel[ch]);
        }
        xrtRunStart(hls_packet_sender_r);
        std::cout<<" input kernel complete"<<std::endl;

        // start graph
        auto graph = xrtGraphOpen(dhdl, uuid, "gr");
        if(!graph){
                std::cerr << "Failed to open graph mygraph" << std::endl;
                return EXIT_FAILURE;
        }
        xrtGraphRun(graph, 2);
        std::cout<<" graph run complete"<<std::endl;

        // wait for all runs to complete
        for(int ch=0; ch<channel_count; ++ch) {
                std::cout << "waiting for mm2s_r" << ch + 1 << std::endl;
                xrtRunWait(mm2s_runs[ch]);
        }
        std::cout << "waiting for hls_packet_sender_r" << std::endl;
        xrtRunWait(hls_packet_sender_r);
        for(int ch=0; ch<channel_count; ++ch) {
                std::cout << "waiting for s2mm_r" << ch + 1 << std::endl;
                xrtRunWait(s2mm_runs[ch]);
        }
        std::cout << "waiting for hls_packet_receiver_r" << std::endl;
        xrtRunWait(hls_packet_receiver_r);
        std::cout << "waiting for hls_packet_receiver_r2" << std::endl;
        xrtRunWait(hls_packet_receiver_r2);
        std::cout<<" run wait complete"<<std::endl;

        // post-processing data;
        for(int channel = 0; channel < channel_count; ++channel) {
                const std::size_t channel_words = static_cast<std::size_t>(words_per_channel[channel]);
                for(std::size_t i = 0; i < channel_words; ++i){
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
        for(int ch=0; ch<channel_count; ++ch) {
                xrtRunClose(s2mm_runs[ch]);
        }
        xrtRunClose(hls_packet_receiver_r);
        xrtRunClose(hls_packet_receiver_r2);
        for(int ch=0; ch<channel_count; ++ch) {
                xrtKernelClose(s2mm_kernels[ch]);
        }
        xrtKernelClose(hls_packet_receiver_k);
        xrtKernelClose(hls_packet_receiver_k2);
        for(int ch=0; ch<channel_count; ++ch) {
                xrtRunClose(mm2s_runs[ch]);
        }
        xrtRunClose(hls_packet_sender_r);
        for(int ch=0; ch<channel_count; ++ch) {
                xrtKernelClose(mm2s_kernels[ch]);
        }
        xrtKernelClose(hls_packet_sender_k);
        for(int ch=0; ch<channel_count; ++ch) {
                xrtBOFree(out_bos[ch]);
                xrtBOFree(in_bos[ch]);
        }
        xrtGraphWait(graph, 0);
        xrtGraphEnd(graph, 0);
        xrtGraphClose(graph);
        xrtDeviceClose(dhdl);
	
	std::cout << "TEST " << (match ? "FAILED" : "PASSED") << std::endl; 
	return (match ? EXIT_FAILURE :  EXIT_SUCCESS);
}
