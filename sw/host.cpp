/*
Copyright (C) 2023, Advanced Micro Devices, Inc.
SPDX-License-Identifier: MIT
*/
#include <algorithm>
#include <array>
#include <cstddef>
#include <cstdlib>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>
#include <vector>

#include "experimental/xrt_graph.h"
#include "experimental/xrt_kernel.h"

#include "packet_utils.h"

namespace {

constexpr std::size_t channel_count = 6;
constexpr std::array<uint32_t, channel_count> channel_ids{{0U, 1U, 2U, 3U, 4U, 5U}};
constexpr uint32_t pkt_type = 0U;

struct ChannelMetadata {
    uint32_t      id = 0U;
    uint32_t      payload_len = 0U;
    const float*  expected = nullptr;
    float*        actual = nullptr;
};

struct OutputStreamInfo {
    const char* instance = nullptr;
    std::vector<uint32_t> channel_ids;
};

struct OutputStreamRuntime {
    OutputStreamInfo info;
    std::size_t      word_count = 0U;
    std::size_t      alloc_words = 0U;
    xrtBufferHandle  bo = nullptr;
    uint32_t*        host_ptr = nullptr;
    xrtKernelHandle  kernel = nullptr;
    xrtRunHandle     run = nullptr;
};

std::size_t compute_words_for_stream(const OutputStreamInfo& info, const std::array<ChannelMetadata, channel_count>& metadata) {
    std::size_t total = 0U;
    for (uint32_t id : info.channel_ids) {
        if (id >= metadata.size())
            continue;
        const auto payload_len = metadata[id].payload_len;
        if (payload_len == 0U)
            continue;
        total += 1U + payload_len;
    }
    return total;
}

struct ParseReport {
    bool parity_error = false;
    bool truncated    = false;
};

ParseReport parse_stream(const std::array<ChannelMetadata, channel_count>& metadata,
                         const uint32_t* words,
                         std::size_t word_count,
                         std::array<uint32_t, channel_count>& offsets)
{
    ParseReport report{};
    std::size_t idx = 0U;
    while (idx < word_count) {
        const uint32_t header = words[idx++];
        if (!packet_utils::header_has_valid_parity(header)) {
            report.parity_error = true;
        }

        const uint32_t id          = header & 0xFFU;
        const uint32_t payload_len = (header >> 16) & 0x0FFFU;

        if (idx + payload_len > word_count) {
            report.truncated = true;
            break;
        }

        if (id < metadata.size()) {
            auto& offset             = offsets[id];
            const uint32_t write_pos = offset;
            float* dest              = metadata[id].actual;
            const uint32_t expected  = metadata[id].payload_len;
            const uint32_t copy_base = write_pos < expected ? write_pos : expected;
            const uint32_t available = expected > copy_base ? (expected - copy_base) : 0U;
            const uint32_t copy_len  = std::min(payload_len, available);

            for (uint32_t j = 0U; j < copy_len; ++j) {
                float value = 0.0f;
                std::memcpy(&value, &words[idx + j], sizeof(uint32_t));
                if (dest) {
                    dest[copy_base + j] = value;
                }
            }

            offset = write_pos + payload_len;
        }

        idx += payload_len;
    }

    return report;
}

} // namespace

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <xclbin>" << std::endl;
        return EXIT_FAILURE;
    }

    const std::string xclbin_filename = argv[1];

    constexpr std::size_t max_words_per_channel = 1024U;

    std::array<std::vector<float>, channel_count> channel_inputs;
    std::array<std::vector<float>, channel_count> channel_outputs;

    std::vector<float> file_values;
    {
        std::ifstream in("./data/embed_model_output.txt");
        if (!in.is_open()) {
            std::cerr << "./data/embed_model_output.txt does not exist in this path." << std::endl;
            return EXIT_FAILURE;
        }
        float value = 0.0f;
        while (in >> value) {
            file_values.push_back(value);
        }
    }

    const std::size_t source_words = std::min<std::size_t>(file_values.size(), max_words_per_channel);
    if (source_words == 0U) {
        std::cerr << "No float values found in ./data/embed_model_output.txt" << std::endl;
        return EXIT_FAILURE;
    }

    for (std::size_t idx = 0U; idx < channel_count; ++idx) {
        channel_inputs[idx].assign(file_values.begin(), file_values.begin() + source_words);
        channel_outputs[idx].assign(source_words, 0.0f);
    }

    std::array<ChannelMetadata, channel_count> metadata{};
    for (std::size_t idx = 0U; idx < channel_ids.size(); ++idx) {
        const uint32_t id = channel_ids[idx];
        const std::size_t len = channel_inputs[idx].size();
        metadata[id].id          = id;
        metadata[id].payload_len = static_cast<uint32_t>(len);
        metadata[id].expected    = len ? channel_inputs[idx].data() : nullptr;
        metadata[id].actual      = len ? channel_outputs[idx].data() : nullptr;
    }

    std::vector<packet_utils::PayloadView> payload_views;
    payload_views.reserve(channel_ids.size());
    for (uint32_t id : channel_ids) {
        const auto& meta = metadata[id];
        payload_views.push_back(packet_utils::PayloadView{meta.id, meta.expected, meta.payload_len});
    }

    const std::vector<uint32_t> input_words = packet_utils::pack_packets(payload_views, pkt_type);
    const std::size_t total_input_words = input_words.size();

    if (total_input_words == 0U) {
        std::cerr << "All payloads are empty; nothing to transmit." << std::endl;
        return EXIT_FAILURE;
    }

    auto device_handle = xrtDeviceOpen(0);
    if (!device_handle) {
        std::cerr << "Device open error\n";
        return EXIT_FAILURE;
    }
    if (int ret = xrtDeviceLoadXclbinFile(device_handle, xclbin_filename.c_str())) {
        std::cerr << "Xclbin Load fail, ret=" << ret << "\n";
        xrtDeviceClose(device_handle);
        return EXIT_FAILURE;
    }

    xuid_t uuid;
    xrtDeviceGetXclbinUUID(device_handle, uuid);

    const std::vector<OutputStreamInfo> output_streams = {
        {"s2mm:{s2mm_1}", {0U, 1U, 2U, 3U}},
        {"s2mm:{s2mm_2}", {4U, 5U}},
    };

    std::vector<OutputStreamRuntime> output_runtime;
    output_runtime.reserve(output_streams.size());
    for (const auto& info : output_streams) {
        OutputStreamRuntime runtime;
        runtime.info = info;
        runtime.word_count = compute_words_for_stream(info, metadata);
        runtime.alloc_words = std::max<std::size_t>(runtime.word_count, std::size_t{1});
        runtime.bo = xrtBOAlloc(device_handle, runtime.alloc_words * sizeof(uint32_t), 0, 0);
        runtime.host_ptr = reinterpret_cast<uint32_t*>(xrtBOMap(runtime.bo));
        std::fill(runtime.host_ptr, runtime.host_ptr + runtime.alloc_words, 0U);
        if (runtime.word_count > 0U) {
            xrtBOSync(runtime.bo, XCL_BO_SYNC_BO_TO_DEVICE, runtime.word_count * sizeof(uint32_t), 0);
        }
        runtime.kernel = xrtPLKernelOpen(device_handle, uuid, runtime.info.instance);
        runtime.run    = xrtRunOpen(runtime.kernel);
        xrtRunSetArg(runtime.run, 0, runtime.bo);
        xrtRunSetArg(runtime.run, 2, static_cast<int>(runtime.word_count));
        output_runtime.push_back(runtime);
    }

    const std::size_t input_alloc_words = std::max<std::size_t>(total_input_words, std::size_t{1});
    xrtBufferHandle input_bo = xrtBOAlloc(device_handle, input_alloc_words * sizeof(uint32_t), 0, 0);
    auto* host_input_words   = reinterpret_cast<uint32_t*>(xrtBOMap(input_bo));
    std::fill(host_input_words, host_input_words + input_alloc_words, 0U);
    std::copy(input_words.begin(), input_words.end(), host_input_words);
    xrtBOSync(input_bo, XCL_BO_SYNC_BO_TO_DEVICE, total_input_words * sizeof(uint32_t), 0);

    auto mm2s_kernel = xrtPLKernelOpen(device_handle, uuid, "mm2s:{mm2s_1}");
    auto mm2s_run    = xrtRunOpen(mm2s_kernel);
    xrtRunSetArg(mm2s_run, 0, input_bo);
    xrtRunSetArg(mm2s_run, 2, static_cast<int>(total_input_words));

    auto graph = xrtGraphOpen(device_handle, uuid, "gr");
    if (!graph) {
        std::cerr << "Failed to open graph 'gr'" << std::endl;
        for (auto& runtime : output_runtime) {
            xrtRunClose(runtime.run);
            xrtKernelClose(runtime.kernel);
            xrtBOFree(runtime.bo);
        }
        xrtRunClose(mm2s_run);
        xrtKernelClose(mm2s_kernel);
        xrtBOFree(input_bo);
        xrtDeviceClose(device_handle);
        return EXIT_FAILURE;
    }

    xrtGraphRun(graph, 1);

    for (auto& runtime : output_runtime) {
        xrtRunStart(runtime.run);
    }

    xrtRunStart(mm2s_run);

    xrtRunWait(mm2s_run);

    for (auto& runtime : output_runtime) {
        xrtRunWait(runtime.run);
    }

    xrtGraphWait(graph, 0);

    for (auto& runtime : output_runtime) {
        if (runtime.word_count > 0U) {
            xrtBOSync(runtime.bo, XCL_BO_SYNC_BO_FROM_DEVICE, runtime.word_count * sizeof(uint32_t), 0);
        }
    }

    std::array<uint32_t, channel_count> observed_words{};
    ParseReport aggregate_report{};
    for (const auto& runtime : output_runtime) {
        if (runtime.word_count == 0U)
            continue;
        const ParseReport report = parse_stream(metadata, runtime.host_ptr, runtime.word_count, observed_words);
        aggregate_report.parity_error = aggregate_report.parity_error || report.parity_error;
        aggregate_report.truncated    = aggregate_report.truncated    || report.truncated;
    }

    int mismatch = 0;
    if (aggregate_report.parity_error) {
        std::cerr << "Parity mismatch detected while parsing output stream(s)." << std::endl;
        mismatch = 1;
    }
    if (aggregate_report.truncated) {
        std::cerr << "Truncated packet detected in output stream(s)." << std::endl;
        mismatch = 1;
    }

    for (std::size_t idx = 0U; idx < channel_ids.size(); ++idx) {
        const uint32_t id = channel_ids[idx];
        const auto& meta = metadata[id];
        if (meta.payload_len == 0U)
            continue;

        if (observed_words[id] != meta.payload_len) {
            std::cerr << "Channel " << id << " expected " << meta.payload_len
                      << " words but observed " << observed_words[id] << std::endl;
            mismatch = 1;
        }

        for (uint32_t word_idx = 0U; word_idx < meta.payload_len; ++word_idx) {
            const float expected = meta.expected[word_idx];
            const float actual   = meta.actual[word_idx];
            uint32_t expected_bits = 0U;
            uint32_t actual_bits   = 0U;
            std::memcpy(&expected_bits, &expected, sizeof(float));
            std::memcpy(&actual_bits, &actual, sizeof(float));
            if (expected_bits != actual_bits) {
                mismatch = 1;
                auto oldp = std::cout.precision();
                std::cout << std::setprecision(10)
                          << "Mismatch channel " << id << "[" << word_idx << "]="
                          << actual << " (0x" << std::hex << actual_bits << std::dec
                          << ") expected " << expected << " (0x" << std::hex
                          << expected_bits << std::dec << ")\n";
                std::cout.precision(oldp);
            }
        }
    }

    for (auto& runtime : output_runtime) {
        xrtRunClose(runtime.run);
        xrtKernelClose(runtime.kernel);
        xrtBOFree(runtime.bo);
    }

    xrtRunClose(mm2s_run);
    xrtKernelClose(mm2s_kernel);
    xrtBOFree(input_bo);

    xrtGraphEnd(graph, 0);
    xrtGraphClose(graph);
    xrtDeviceClose(device_handle);

    std::cout << "TEST " << (mismatch ? "FAILED" : "PASSED") << std::endl;
    return mismatch ? EXIT_FAILURE : EXIT_SUCCESS;
}
