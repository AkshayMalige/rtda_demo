/*
Copyright (C) 2023, Advanced Micro Devices, Inc.
SPDX-License-Identifier: MIT
*/
#include <stdlib.h>
#include <algorithm>
#include <array>
#include <cassert>
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

    // ===== Capacity per channel =====
    // Replace the old "packet_num * 32" trick with explicit capacity:
    // Each channel BO holds up to max_words_per_channel 32-bit floats.
    const int max_words_per_channel = 1024;                 // adjust as needed
    const int mem_size              = max_words_per_channel * sizeof(float); // bytes
    const int words_per_channel     = max_words_per_channel;

    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <xclbin>" << std::endl;
        return EXIT_FAILURE;
    }
    char* xclbinFilename = argv[1];

    int ret = 0;
    int match = 0;

    // Open device/xclbin
    auto dhdl = xrtDeviceOpen(0); // device index=0
    if (!dhdl) {
        std::cerr << "Device open error\n";
        return EXIT_FAILURE;
    }
    ret = xrtDeviceLoadXclbinFile(dhdl, xclbinFilename);
    if (ret) {
        std::cerr << "Xclbin Load fail, ret=" << ret << "\n";
        return EXIT_FAILURE;
    }
    xuid_t uuid;
    xrtDeviceGetXclbinUUID(dhdl, uuid);

    // Output BOs
    xrtBufferHandle out_bo1 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle out_bo2 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle out_bo3 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle out_bo4 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle out_bo5 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle out_bo6 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    float* host_out1 = reinterpret_cast<float*>(xrtBOMap(out_bo1));
    float* host_out2 = reinterpret_cast<float*>(xrtBOMap(out_bo2));
    float* host_out3 = reinterpret_cast<float*>(xrtBOMap(out_bo3));
    float* host_out4 = reinterpret_cast<float*>(xrtBOMap(out_bo4));
    float* host_out5 = reinterpret_cast<float*>(xrtBOMap(out_bo5));
    float* host_out6 = reinterpret_cast<float*>(xrtBOMap(out_bo6));

    // Input BOs
    xrtBufferHandle in_bo1 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle in_bo2 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle in_bo3 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle in_bo4 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle in_bo5 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    xrtBufferHandle in_bo6 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
    float* host_in1 = reinterpret_cast<float*>(xrtBOMap(in_bo1));
    float* host_in2 = reinterpret_cast<float*>(xrtBOMap(in_bo2));
    float* host_in3 = reinterpret_cast<float*>(xrtBOMap(in_bo3));
    float* host_in4 = reinterpret_cast<float*>(xrtBOMap(in_bo4));
    float* host_in5 = reinterpret_cast<float*>(xrtBOMap(in_bo5));
    float* host_in6 = reinterpret_cast<float*>(xrtBOMap(in_bo6));

    std::array<float*, channel_count>          host_inputs  = {host_in1, host_in2, host_in3, host_in4, host_in5, host_in6};
    std::array<float*, channel_count>          host_outputs = {host_out1, host_out2, host_out3, host_out4, host_out5, host_out6};
    std::array<xrtBufferHandle, channel_count> input_bos    = {in_bo1, in_bo2, in_bo3, in_bo4, in_bo5, in_bo6};
    std::array<xrtBufferHandle, channel_count> output_bos   = {out_bo1, out_bo2, out_bo3, out_bo4, out_bo5, out_bo6};

    // Per-channel payload lengths (words). 0 means "skip this ID".
    uint32_t max_words_host[channel_count];

    // -------- Simplified file reading (broadcast to all channels) --------
    size_t nwords_effective = 0;
    {
        std::ifstream in("./data/embed_model_output.txt");
        if (!in.is_open()) {
            std::cerr << "./data/embed_input.txt does not exist in this path." << std::endl;
            return EXIT_FAILURE;
        }

        std::vector<float> vals;
        vals.reserve(words_per_channel);
        float f = 0.0f;
        while (in >> f) {
            vals.push_back(f);
        }
        if (vals.empty()) {
            std::cerr << "No float values found in ./data/embed_input.txt; using zeros" << std::endl;
        }

        const std::size_t ncopy = std::min<std::size_t>(vals.size(), static_cast<std::size_t>(words_per_channel));
        nwords_effective = ncopy;  // used below and passed to kernels that need it

        for (auto* dest : host_inputs) {
            std::fill(dest, dest + words_per_channel, 0.0f);
            std::copy(vals.begin(), vals.begin() + ncopy, dest);
        }
    }
    // --------------------------------------------------------------------

    const uint32_t words_per_packet = static_cast<uint32_t>(nwords_effective);
    for (int i = 0; i < channel_count; ++i)
        max_words_host[i] = words_per_packet;   // set per-channel N here (0 allowed)

    // Sync inputs to device
    for (auto bo : input_bos)
        xrtBOSync(bo, XCL_BO_SYNC_BO_TO_DEVICE, mem_size, /*offset=*/0);

    // Zero/sync outputs
    for (int i = 0; i < channel_count; ++i) {
        std::fill(host_outputs[i], host_outputs[i] + words_per_channel, 0.0f);
        xrtBOSync(output_bos[i], XCL_BO_SYNC_BO_TO_DEVICE, mem_size, /*offset=*/0);
    }

    // === Open kernels ===
    xrtKernelHandle s2mm_k1 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_1}");
    xrtRunHandle    s2mm_r1 = xrtRunOpen(s2mm_k1);
    xrtRunSetArg(s2mm_r1, 0, out_bo1);
    xrtRunSetArg(s2mm_r1, 2, words_per_packet);

    xrtKernelHandle s2mm_k2 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_2}");
    xrtRunHandle    s2mm_r2 = xrtRunOpen(s2mm_k2);
    xrtRunSetArg(s2mm_r2, 0, out_bo2);
    xrtRunSetArg(s2mm_r2, 2, words_per_packet);

    xrtKernelHandle s2mm_k3 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_3}");
    xrtRunHandle    s2mm_r3 = xrtRunOpen(s2mm_k3);
    xrtRunSetArg(s2mm_r3, 0, out_bo3);
    xrtRunSetArg(s2mm_r3, 2, words_per_packet);

    xrtKernelHandle s2mm_k4 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_4}");
    xrtRunHandle    s2mm_r4 = xrtRunOpen(s2mm_k4);
    xrtRunSetArg(s2mm_r4, 0, out_bo4);
    xrtRunSetArg(s2mm_r4, 2, words_per_packet);

    xrtKernelHandle s2mm_k5 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_5}");
    xrtRunHandle    s2mm_r5 = xrtRunOpen(s2mm_k5);
    xrtRunSetArg(s2mm_r5, 0, out_bo5);
    xrtRunSetArg(s2mm_r5, 2, words_per_packet);

    xrtKernelHandle s2mm_k6 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_6}");
    xrtRunHandle    s2mm_r6 = xrtRunOpen(s2mm_k6);
    xrtRunSetArg(s2mm_r6, 0, out_bo6);
    xrtRunSetArg(s2mm_r6, 2, words_per_packet);

    xrtKernelHandle hls_packet_receiver_k  = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver:{hls_packet_receiver_1}");
    xrtRunHandle    hls_packet_receiver_r  = xrtRunOpen(hls_packet_receiver_k);

    xrtKernelHandle hls_packet_receiver_k2 = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver2:{hls_packet_receiver_2}");
    xrtRunHandle    hls_packet_receiver_r2 = xrtRunOpen(hls_packet_receiver_k2);

    // Count packets from max_words_host: IDs 0..3 → AIE, 4..5 → PL
    uint32_t total_packet_num  = 0U;
    uint32_t total_packet_num2 = 0U;
    for (int i = 0; i < channel_count; ++i) {
        if (max_words_host[i] > 0U) {
            if (i < 4) ++total_packet_num;
            else       ++total_packet_num2;
        }
    }
    std::cout << "AIE packets: " << total_packet_num << "  PL packets: " << total_packet_num2 << std::endl;

    xrtRunSetArg(hls_packet_receiver_r,  5, total_packet_num);
    xrtRunSetArg(hls_packet_receiver_r2, 3, total_packet_num2);

    // Input kernels (mm2s)
    xrtKernelHandle mm2s_k1 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_1}");
    xrtRunHandle    mm2s_r1 = xrtRunOpen(mm2s_k1);
    xrtRunSetArg(mm2s_r1, 0, in_bo1);
    xrtRunSetArg(mm2s_r1, 2, words_per_packet);

    xrtKernelHandle mm2s_k2 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_2}");
    xrtRunHandle    mm2s_r2 = xrtRunOpen(mm2s_k2);
    xrtRunSetArg(mm2s_r2, 0, in_bo2);
    xrtRunSetArg(mm2s_r2, 2, words_per_packet);

    xrtKernelHandle mm2s_k3 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_3}");
    xrtRunHandle    mm2s_r3 = xrtRunOpen(mm2s_k3);
    xrtRunSetArg(mm2s_r3, 0, in_bo3);
    xrtRunSetArg(mm2s_r3, 2, words_per_packet);

    xrtKernelHandle mm2s_k4 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_4}");
    xrtRunHandle    mm2s_r4 = xrtRunOpen(mm2s_k4);
    xrtRunSetArg(mm2s_r4, 0, in_bo4);
    xrtRunSetArg(mm2s_r4, 2, words_per_packet);

    xrtKernelHandle mm2s_k5 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_5}");
    xrtRunHandle    mm2s_r5 = xrtRunOpen(mm2s_k5);
    xrtRunSetArg(mm2s_r5, 0, in_bo5);
    xrtRunSetArg(mm2s_r5, 2, words_per_packet);

    xrtKernelHandle mm2s_k6 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_6}");
    xrtRunHandle    mm2s_r6 = xrtRunOpen(mm2s_k6);
    xrtRunSetArg(mm2s_r6, 0, in_bo6);
    xrtRunSetArg(mm2s_r6, 2, words_per_packet);

    // Prepare and pass 6-element N array to hls_packet_sender (arg 8)
    xrtKernelHandle hls_packet_sender_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_sender");
    xrtRunHandle    hls_packet_sender_r = xrtRunOpen(hls_packet_sender_k);

    xrtBufferHandle max_words_bo = xrtBOAlloc(dhdl, 6 * sizeof(uint32_t), 0, /*BANK=*/0);
    auto* max_words_ptr = reinterpret_cast<uint32_t*>(xrtBOMap(max_words_bo));
    std::memcpy(max_words_ptr, max_words_host, 6 * sizeof(uint32_t));
    xrtBOSync(max_words_bo, XCL_BO_SYNC_BO_TO_DEVICE, 6 * sizeof(uint32_t), /*offset*/0);

    // IMPORTANT: pass the BO at the pointer arg index (8)
    xrtRunSetArg(hls_packet_sender_r, 8, max_words_bo);

    // Open and run the AIE graph (name as in your xclbin)
    auto graph = xrtGraphOpen(dhdl, uuid, "gr");
    if (!graph) {
        std::cerr << "Failed to open graph 'gr'" << std::endl;
        return EXIT_FAILURE;
    }
    xrtGraphRun(graph, 1);

    // Startup sequence: receivers -> s2mm -> mm2s -> sender
    xrtRunStart(hls_packet_receiver_r);
    xrtRunStart(hls_packet_receiver_r2);

    xrtRunStart(s2mm_r1);
    xrtRunStart(s2mm_r2);
    xrtRunStart(s2mm_r3);
    xrtRunStart(s2mm_r4);
    xrtRunStart(s2mm_r5);
    xrtRunStart(s2mm_r6);

    xrtRunStart(mm2s_r1);
    xrtRunStart(mm2s_r2);
    xrtRunStart(mm2s_r3);
    xrtRunStart(mm2s_r4);
    xrtRunStart(mm2s_r5);
    xrtRunStart(mm2s_r6);

    xrtRunStart(hls_packet_sender_r);

    // Wait
    xrtRunWait(hls_packet_sender_r);
    xrtRunWait(mm2s_r1);
    xrtRunWait(mm2s_r2);
    xrtRunWait(mm2s_r3);
    xrtRunWait(mm2s_r4);
    xrtRunWait(mm2s_r5);
    xrtRunWait(mm2s_r6);

    xrtRunWait(hls_packet_receiver_r);
    xrtRunWait(hls_packet_receiver_r2);

    xrtRunWait(s2mm_r1);
    xrtRunWait(s2mm_r2);
    xrtRunWait(s2mm_r3);
    xrtRunWait(s2mm_r4);
    xrtRunWait(s2mm_r5);
    xrtRunWait(s2mm_r6);

    // Graph end & sync outputs back
    xrtGraphWait(graph, 0);
    for (auto bo : output_bos)
        xrtBOSync(bo, XCL_BO_SYNC_BO_FROM_DEVICE, mem_size, /*offset=*/0);

    // Quick compare (optional)
    for (int channel = 0; channel < channel_count; ++channel) {
        for (std::size_t word_idx = 0; word_idx < nwords_effective; ++word_idx) {
            float actual = host_outputs[channel][word_idx];
            float expected = host_inputs[channel][word_idx];
            uint32_t actual_bits = 0, expected_bits = 0;
            std::memcpy(&actual_bits, &actual, sizeof(float));
            std::memcpy(&expected_bits, &expected, sizeof(float));
            if (actual_bits != expected_bits) {
                match = 1;
                auto oldp = std::cout.precision();
                std::cout << std::setprecision(10)
                          << "Mismatch host_out" << (channel+1) << "[" << word_idx << "]="
                          << actual << " (0x" << std::hex << actual_bits << std::dec
                          << ") expected " << expected << " (0x" << std::hex
                          << expected_bits << std::dec << ")\n";
                std::cout.precision(oldp);
            }
        }
    }

    // Cleanup
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
    xrtBOFree(max_words_bo);

    xrtGraphEnd(graph, 0);
    xrtGraphClose(graph);
    xrtDeviceClose(dhdl);

    std::cout << "TEST " << (match ? "FAILED" : "PASSED") << std::endl;
    return (match ? EXIT_FAILURE : EXIT_SUCCESS);
}
