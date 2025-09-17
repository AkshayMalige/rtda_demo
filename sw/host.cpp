/*
Copyright (C) 2023, Advanced Micro Devices,
SPDX-License-Identifier: MIT
*/
#include <array>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <limits>
#include <sstream>
#include <string>
#include <vector>

#include "experimental/xrt_graph.h"
#include "experimental/xrt_kernel.h"

using namespace std;

static vector<float> load_floats_from_file(const string& path) {
    ifstream in(path);
    if (!in.is_open()) {
        cerr << "Failed to open input file: " << path << endl;
        exit(EXIT_FAILURE);
    }
    vector<float> vals;
    vals.reserve(1 << 16);

    // One 32-bit float per line; blank lines allowed.
    string line;
    while (std::getline(in, line)) {
        if (line.empty()) continue;
        float v;
        std::istringstream iss(line);
        if (!(iss >> v)) {
            cerr << "Parse error in " << path << " on line: " << line << endl;
            exit(EXIT_FAILURE);
        }
        vals.push_back(v);
    }
    if (vals.size() > numeric_limits<uint32_t>::max()) {
        cerr << "Input file " << path << " contains too many entries" << endl;
        exit(EXIT_FAILURE);
    }
    return vals;
}

int main(int argc, char* argv[]) {
    constexpr int channel_count = 6;
    const string kInputPath = "data/embed_input.txt";  // hardcoded input

    if (argc != 2) {
        cout << "Usage: " << argv[0] << " <xclbin>\n";
        return EXIT_FAILURE;
    }
    const char* xclbinFilename = argv[1];

    int ret  = 0;
    int match = 0;

    // Read once; replicate to all channels.
    const vector<float> input_values = load_floats_from_file(kInputPath);
    const uint32_t words_in_file = static_cast<uint32_t>(input_values.size());

    array<uint32_t, channel_count> words_per_channel{};
    array<size_t,   channel_count> buffer_words{};
    for (int ch = 0; ch < channel_count; ++ch) {
        words_per_channel[ch] = words_in_file;
        buffer_words[ch]      = std::max<size_t>(1, static_cast<size_t>(words_in_file));
    }

    for (int ch = 0; ch < channel_count; ++ch) {
        cout << "Channel " << ch << " source: " << kInputPath
             << " (" << words_per_channel[ch] << " words)\n";
    }

    // Count how many non-empty packets go to each receiver.
    unsigned int total_packet_num  = 0; // AIE path (ch 0..3)
    unsigned int total_packet_num2 = 0; // PL-only path (ch 4..5)
    for (int ch = 0; ch < channel_count; ++ch) {
        if (words_per_channel[ch] == 0u) continue;
        (ch < 4) ? ++total_packet_num : ++total_packet_num2;
    }

    // Device / xclbin
    auto dhdl = xrtDeviceOpen(0);
    if (!dhdl) { printf("Device open error\n"); return EXIT_FAILURE; }
    ret = xrtDeviceLoadXclbinFile(dhdl, xclbinFilename);
    if (ret) { printf("Xclbin Load fail\n"); return EXIT_FAILURE; }
    xuid_t uuid;
    xrtDeviceGetXclbinUUID(dhdl, uuid);

    // Buffers
    array<xrtBufferHandle, channel_count> out_bos{};
    array<xrtBufferHandle, channel_count> in_bos{};
    array<float*, channel_count> host_outputs{};
    array<float*, channel_count> host_inputs{};

    for (int ch = 0; ch < channel_count; ++ch) {
        const size_t float_count = buffer_words[ch];
        const size_t byte_count  = float_count * sizeof(float);

        out_bos[ch] = xrtBOAlloc(dhdl, byte_count, 0, /*BANK=*/0);
        host_outputs[ch] = reinterpret_cast<float*>(xrtBOMap(out_bos[ch]));
        std::fill(host_outputs[ch], host_outputs[ch] + float_count, 0.0f);

        in_bos[ch] = xrtBOAlloc(dhdl, byte_count, 0, /*BANK=*/0);
        host_inputs[ch] = reinterpret_cast<float*>(xrtBOMap(in_bos[ch]));
        std::fill(host_inputs[ch], host_inputs[ch] + float_count, 0.0f);

        if (!input_values.empty()) {
            std::copy(input_values.begin(), input_values.end(), host_inputs[ch]);
        }
    }
    cout << "memory allocation complete\n";

    // s2mm (outputs)
    const array<const char*, channel_count> s2mm_kernel_names = {
        "s2mm:{s2mm_1}", "s2mm:{s2mm_2}", "s2mm:{s2mm_3}",
        "s2mm:{s2mm_4}", "s2mm:{s2mm_5}", "s2mm:{s2mm_6}"
    };
    array<xrtKernelHandle, channel_count> s2mm_kernels{};
    array<xrtRunHandle,    channel_count> s2mm_runs{};

    for (int ch = 0; ch < channel_count; ++ch) {
        s2mm_kernels[ch] = xrtPLKernelOpen(dhdl, uuid, s2mm_kernel_names[ch]);
        s2mm_runs[ch]    = xrtRunOpen(s2mm_kernels[ch]);
        xrtRunSetArg(s2mm_runs[ch], 0, out_bos[ch]);
        xrtRunSetArg(s2mm_runs[ch], 2, words_per_channel[ch]); // keep your existing ABI
        xrtRunStart(s2mm_runs[ch]);
    }

    // Packet receivers (note: arg index 0 for the count)
    xrtKernelHandle hls_packet_receiver_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver:{hls_packet_receiver_1}");
    xrtRunHandle    hls_packet_receiver_r = xrtRunOpen(hls_packet_receiver_k);
    xrtRunSetArg(hls_packet_receiver_r, 0, total_packet_num);
    xrtRunStart(hls_packet_receiver_r);
    cout << "output kernel complete\n";

    xrtKernelHandle hls_packet_receiver_k2 = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver2:{hls_packet_receiver_2}");
    xrtRunHandle    hls_packet_receiver_r2 = xrtRunOpen(hls_packet_receiver_k2);
    xrtRunSetArg(hls_packet_receiver_r2, 0, total_packet_num2);
    xrtRunStart(hls_packet_receiver_r2);
    cout << "output kernel2 complete\n";

    // mm2s (inputs)
    const array<const char*, channel_count> mm2s_kernel_names = {
        "mm2s:{mm2s_1}", "mm2s:{mm2s_2}", "mm2s:{mm2s_3}",
        "mm2s:{mm2s_4}", "mm2s:{mm2s_5}", "mm2s:{mm2s_6}"
    };
    array<xrtKernelHandle, channel_count> mm2s_kernels{};
    array<xrtRunHandle,    channel_count> mm2s_runs{};

    for (int ch = 0; ch < channel_count; ++ch) {
        mm2s_kernels[ch] = xrtPLKernelOpen(dhdl, uuid, mm2s_kernel_names[ch]);
        mm2s_runs[ch]    = xrtRunOpen(mm2s_kernels[ch]);
        xrtRunSetArg(mm2s_runs[ch], 0, in_bos[ch]);
        xrtRunSetArg(mm2s_runs[ch], 2, words_per_channel[ch]); // keep your existing ABI
        xrtRunStart(mm2s_runs[ch]);
    }

    // Packet sender (only s_axilite array max_words_per_ch → arg indices 0..5)
    xrtKernelHandle hls_packet_sender_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_sender");
    xrtRunHandle    hls_packet_sender_r = xrtRunOpen(hls_packet_sender_k);
    for (int ch = 0; ch < channel_count; ++ch) {
        xrtRunSetArg(hls_packet_sender_r, ch, words_per_channel[ch]);
    }
    xrtRunStart(hls_packet_sender_r);
    cout << "input kernel complete\n";

    // AIE graph
    auto graph = xrtGraphOpen(dhdl, uuid, "gr");
    if (!graph) { cerr << "Failed to open graph gr\n"; return EXIT_FAILURE; }
    xrtGraphRun(graph, 2);
    cout << "graph run complete\n";

    // Wait for completion
    for (int ch = 0; ch < channel_count; ++ch) {
        cout << "waiting for mm2s_r" << ch + 1 << endl;
        xrtRunWait(mm2s_runs[ch]);
    }
    cout << "waiting for hls_packet_sender_r\n";
    xrtRunWait(hls_packet_sender_r);
    for (int ch = 0; ch < channel_count; ++ch) {
        cout << "waiting for s2mm_r" << ch + 1 << endl;
        xrtRunWait(s2mm_runs[ch]);
    }
    cout << "waiting for hls_packet_receiver_r\n";
    xrtRunWait(hls_packet_receiver_r);
    cout << "waiting for hls_packet_receiver_r2\n";
    xrtRunWait(hls_packet_receiver_r2);
    cout << "run wait complete\n";

    // Verify
    for (int ch = 0; ch < channel_count; ++ch) {
        const size_t channel_words = static_cast<size_t>(words_per_channel[ch]);
        for (size_t i = 0; i < channel_words; ++i) {
            float actual   = host_outputs[ch][i];
            float expected = host_inputs[ch][i];
            uint32_t ab = 0, eb = 0;
            memcpy(&ab, &actual, sizeof(float));
            memcpy(&eb, &expected, sizeof(float));
            if (ab != eb) {
                match = 1;
                auto oldp = cout.precision();
                cout << setprecision(10)
                     << "Mismatch host_out" << ch + 1 << "[" << i << "]="
                     << actual << " (0x" << hex << ab << dec
                     << ") expected " << expected << " (0x" << hex
                     << eb << dec << ")\n";
                cout.precision(oldp);
            }
        }
    }

    // Cleanup
    for (int ch = 0; ch < channel_count; ++ch) xrtRunClose(s2mm_runs[ch]);
    xrtRunClose(hls_packet_receiver_r);
    xrtRunClose(hls_packet_receiver_r2);
    for (int ch = 0; ch < channel_count; ++ch) xrtKernelClose(s2mm_kernels[ch]);
    xrtKernelClose(hls_packet_receiver_k);
    xrtKernelClose(hls_packet_receiver_k2);
    for (int ch = 0; ch < channel_count; ++ch) xrtRunClose(mm2s_runs[ch]);
    xrtRunClose(hls_packet_sender_r);
    for (int ch = 0; ch < channel_count; ++ch) xrtKernelClose(mm2s_kernels[ch]);
    xrtKernelClose(hls_packet_sender_k);
    for (int ch = 0; ch < channel_count; ++ch) { xrtBOFree(out_bos[ch]); xrtBOFree(in_bos[ch]); }

    xrtGraphWait(graph, 0);
    xrtGraphEnd(graph, 0);
    xrtGraphClose(graph);
    xrtDeviceClose(dhdl);

    cout << "TEST " << (match ? "FAILED" : "PASSED") << endl;
    return (match ? EXIT_FAILURE : EXIT_SUCCESS);
}
