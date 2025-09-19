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

// === Reusable file loader ====================================================
// Read up to `max_words` 32-bit floats (one per line recommended) from `path`.
// Returns the number of words read (<= max_words) and writes the values into
// `out`. If the file can't be opened or has no parsable floats, returns 0.
static std::size_t read_f32_lines_capped(const std::string& path,
                                         std::vector<float>& out,
                                         std::size_t max_words)
{
  out.clear();
  out.reserve(max_words);

  std::ifstream in(path);
  if (!in.is_open()) {
    std::cerr << path << " does not exist or can't be opened.\n";
    return 0;
  }

  float v = 0.0f;
  while (out.size() < max_words && (in >> v)) {
    out.push_back(v);
  }
  return out.size();
}
// ============================================================================

int main(int argc, char* argv[]) {
  constexpr int channel_count = 6;

  // ===== Buffer capacity (BYTES) and word capacity (FLOATS) per channel =====
  // Old pattern `packet_num * 32` artificially capped capacity to 16 floats
  // (2 packets * 32 bytes / 4 B). Replace with explicit capacity in FLOAT WORDS.
  //
  // Choose a safe capacity for your use-cases; can be larger if DDR allows.
  // Kernels will still only *use* N words (<= capacity) that you specify.
  const int max_words_per_channel = 1024;                 // capacity in floats
  const int mem_size              = max_words_per_channel * sizeof(float); // bytes
  static_assert(sizeof(float) == 4, "host expects 32-bit float payloads");

  if (argc != 2) {
    std::cout << "Usage: " << argv[0] << " <xclbin>" << std::endl;
    return EXIT_FAILURE;
  }
  char* xclbinFilename = argv[1];

  // === Open device and xclbin ===
  auto dhdl = xrtDeviceOpen(0); // device index=0
  if (!dhdl) {
    std::cerr << "Device open error\n";
    return EXIT_FAILURE;
  }
  if (int ret = xrtDeviceLoadXclbinFile(dhdl, xclbinFilename)) {
    std::cerr << "Xclbin load failed, ret=" << ret << "\n";
    return EXIT_FAILURE;
  }
  xuid_t uuid;
  xrtDeviceGetXclbinUUID(dhdl, uuid);

  // === Allocate per-channel BOs (inputs & outputs) ===
  // Each channel gets a BO of size `mem_size` bytes (capacity = max_words_per_channel floats).
  // We'll only *use* N words (<= capacity) as dictated by per-channel lengths.
  xrtBufferHandle out_bo1 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle out_bo2 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle out_bo3 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle out_bo4 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle out_bo5 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle out_bo6 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);

  xrtBufferHandle in_bo1 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle in_bo2 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle in_bo3 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle in_bo4 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle in_bo5 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);
  xrtBufferHandle in_bo6 = xrtBOAlloc(dhdl, mem_size, 0, /*BANK=*/0);

  // === Map BOs ===
  float* host_out1 = reinterpret_cast<float*>(xrtBOMap(out_bo1));
  float* host_out2 = reinterpret_cast<float*>(xrtBOMap(out_bo2));
  float* host_out3 = reinterpret_cast<float*>(xrtBOMap(out_bo3));
  float* host_out4 = reinterpret_cast<float*>(xrtBOMap(out_bo4));
  float* host_out5 = reinterpret_cast<float*>(xrtBOMap(out_bo5));
  float* host_out6 = reinterpret_cast<float*>(xrtBOMap(out_bo6));

  float* host_in1 = reinterpret_cast<float*>(xrtBOMap(in_bo1));
  float* host_in2 = reinterpret_cast<float*>(xrtBOMap(in_bo2));
  float* host_in3 = reinterpret_cast<float*>(xrtBOMap(in_bo3));
  float* host_in4 = reinterpret_cast<float*>(xrtBOMap(in_bo4));
  float* host_in5 = reinterpret_cast<float*>(xrtBOMap(in_bo5));
  float* host_in6 = reinterpret_cast<float*>(xrtBOMap(in_bo6));

  std::array<float*, channel_count> host_inputs  = {host_in1, host_in2, host_in3,
                                                    host_in4, host_in5, host_in6};
  std::array<float*, channel_count> host_outputs = {host_out1, host_out2, host_out3,
                                                    host_out4, host_out5, host_out6};
  std::array<xrtBufferHandle, channel_count> input_bos  = {in_bo1, in_bo2, in_bo3, in_bo4, in_bo5, in_bo6};
  std::array<xrtBufferHandle, channel_count> output_bos = {out_bo1, out_bo2, out_bo3, out_bo4, out_bo5, out_bo6};

  // === Per-channel payload lengths (in WORDS) communicated to the packetizer ===
  // `max_words_host[i]` = N_i (0 allowed; sender will skip IDs with N_i == 0)
  uint32_t max_words_host[channel_count] = {0,0,0,0,0,0};

  // ===== FILE → BUFFER LOADING =================================================
  // Capacity per channel (WORDS): max_words_per_channel
  // We only *use* nwords_effective words read from disk (<= capacity).
  // For now, broadcast same file to all channels; easy to switch to per-channel files.
  std::size_t nwords_effective = 0;
  {
    std::vector<float> file_words;
    nwords_effective = read_f32_lines_capped("./data/embed_input.txt",
                                             file_words,
                                             static_cast<std::size_t>(max_words_per_channel));
    if (nwords_effective == 0) {
      std::cerr << "No float values found in ./data/embed_input.txt; using zeros\n";
    }

    // Zero-fill every channel's buffer to avoid stale data beyond nwords_effective
    for (auto* dest : host_inputs) {
      std::fill(dest, dest + max_words_per_channel, 0.0f);
      std::copy(file_words.begin(), file_words.begin() + nwords_effective, dest);
    }
  }
  // ============================================================================
  const uint32_t words_per_packet = static_cast<uint32_t>(nwords_effective); // used by mm2s/s2mm

  // Broadcast the same N to all channels (change per-channel as needed)
  for (int i = 0; i < channel_count; ++i) {
    max_words_host[i] = words_per_packet;   // set 0 to skip a channel entirely
  }

  // Flush input buffers to device
  for (int i = 0; i < channel_count; ++i)
    xrtBOCacheFlush(input_bos[i], 0, mem_size);

  // Zero/flush outputs
  for (int i = 0; i < channel_count; ++i) {
    std::fill(host_outputs[i], host_outputs[i] + max_words_per_channel, 0.0f);
    xrtBOCacheFlush(output_bos[i], 0, mem_size);
  }

  // === Open kernels ===
  xrtKernelHandle mm2s_k1 = xrtPLKernelOpen(dhdl, uuid, "mm2s");
  xrtKernelHandle s2mm_k1 = xrtPLKernelOpen(dhdl, uuid, "s2mm");
  xrtKernelHandle mm2s_k2 = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_1}");
  xrtKernelHandle s2mm_k2 = xrtPLKernelOpen(dhdl, uuid, "s2mm:{s2mm_1}");

  xrtKernelHandle hls_packet_sender_k   = xrtPLKernelOpen(dhdl, uuid, "hls_packet_sender");
  xrtKernelHandle hls_packet_receiver_k = xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver");
  xrtKernelHandle hls_packet_receiver_k2= xrtPLKernelOpen(dhdl, uuid, "hls_packet_receiver2");

  // === Open AIE graph (single graph only; graph2 removed) ===
  auto graph = xrtGraphOpen(dhdl, uuid, "g");

  // ===== Program receivers (drainers) and s2mm first =====
  xrtRunHandle s2mm_r1 = xrtRunOpen(s2mm_k1);
  xrtRunHandle s2mm_r2 = xrtRunOpen(s2mm_k2);

  // s2mm args: (bo, offset, words_per_packet)
  xrtRunSetArg(s2mm_r1, 0, output_bos[0]);
  xrtRunSetArg(s2mm_r1, 1, 0);
  xrtRunSetArg(s2mm_r1, 2, words_per_packet);

  xrtRunSetArg(s2mm_r2, 0, output_bos[1]);
  xrtRunSetArg(s2mm_r2, 1, 0);
  xrtRunSetArg(s2mm_r2, 2, words_per_packet);

  xrtRunHandle hls_packet_receiver_r  = xrtRunOpen(hls_packet_receiver_k);
  xrtRunHandle hls_packet_receiver_r2 = xrtRunOpen(hls_packet_receiver_k2);

  // Compute total packet counts from per-channel N (IDs 0..3 → AIE, 4..5 → PL).
  uint32_t total_packet_num  = 0U;
  uint32_t total_packet_num2 = 0U;
  for (int i = 0; i < channel_count; ++i) {
    if (max_words_host[i] > 0U) {
      if (i < 4) ++total_packet_num;
      else       ++total_packet_num2;
    }
  }
  std::cout << "AIE packets: " << total_packet_num
            << "  PL packets: " << total_packet_num2 << std::endl;

  // hls_packet_receiver (AIE domain) expected packet count
  xrtRunSetArg(hls_packet_receiver_r, 5, total_packet_num);
  std::cout << "output kernel (AIE receiver) programmed" << std::endl;

  // hls_packet_receiver2 (PL domain) expected packet count
  xrtRunSetArg(hls_packet_receiver_r2, 3, total_packet_num2);
  std::cout << "output kernel2 (PL receiver) programmed" << std::endl;

  // ===== Program inputs (sources) =====
  xrtKernelHandle mm2s_k1a = xrtPLKernelOpen(dhdl, uuid, "mm2s:{mm2s_0}");
  xrtRunHandle    mm2s_r1  = xrtRunOpen(mm2s_k1a);
  xrtRunHandle    mm2s_r2  = xrtRunOpen(mm2s_k2);

  // mm2s args: (bo, offset, words_per_packet)
  xrtRunSetArg(mm2s_r1, 0, input_bos[0]);
  xrtRunSetArg(mm2s_r1, 1, 0);
  xrtRunSetArg(mm2s_r1, 2, words_per_packet);

  xrtRunSetArg(mm2s_r2, 0, input_bos[1]);
  xrtRunSetArg(mm2s_r2, 1, 0);
  xrtRunSetArg(mm2s_r2, 2, words_per_packet);

  // Packet sender: frames [HEADER][N payload], TLAST on last, one packet per ID with N>0.
  xrtRunHandle hls_packet_sender_r = xrtRunOpen(hls_packet_sender_k);

  // Args:
  //  0..5 : six input BOs (raw payloads per ID; mm2s reads these)
  //  6    : words_per_packet (legacy path for mm2s/s2mm sizing)
  //  7    : start_id (usually 0)
  //  8    : BO with 6 x uint32_t max_words_per_ch[] (true N per ID; 0 skips)
  xrtRunSetArg(hls_packet_sender_r, 0, input_bos[0]);
  xrtRunSetArg(hls_packet_sender_r, 1, input_bos[1]);
  xrtRunSetArg(hls_packet_sender_r, 2, input_bos[2]);
  xrtRunSetArg(hls_packet_sender_r, 3, input_bos[3]);
  xrtRunSetArg(hls_packet_sender_r, 4, input_bos[4]);
  xrtRunSetArg(hls_packet_sender_r, 5, input_bos[5]);
  xrtRunSetArg(hls_packet_sender_r, 6, words_per_packet);
  xrtRunSetArg(hls_packet_sender_r, 7, 0); // start ID

  // Host → device BO for max_words_per_ch[6]
  xrtBufferHandle max_words_bo = xrtBOAlloc(dhdl, channel_count * sizeof(uint32_t), 0, /*BANK=*/0);
  auto* max_words_dev = reinterpret_cast<uint32_t*>(xrtBOMap(max_words_bo));
  std::memcpy(max_words_dev, max_words_host, channel_count * sizeof(uint32_t));
  xrtBOCacheFlush(max_words_bo, 0, channel_count * sizeof(uint32_t));
  xrtRunSetArg(hls_packet_sender_r, 8, max_words_bo);

  // ===== Run order: drainers → graphs → sources =====
  xrtRunStart(s2mm_r1);
  xrtRunStart(s2mm_r2);

  xrtRunStart(hls_packet_receiver_r);
  xrtRunStart(hls_packet_receiver_r2);

  // Single AIE graph (graph2 removed)
  xrtGraphRun(graph, 1);

  xrtRunStart(mm2s_r1);
  xrtRunStart(mm2s_r2);
  xrtRunStart(hls_packet_sender_r);

  // ===== Wait for completion =====
  xrtRunWait(mm2s_r1);
  std::cout << "input kernel complete" << std::endl;

  xrtRunWait(mm2s_r2);
  std::cout << "input kernel2 complete" << std::endl;

  xrtRunWait(hls_packet_sender_r);
  std::cout << "hls_packet_sender complete" << std::endl;

  xrtRunWait(hls_packet_receiver_r);
  std::cout << "output kernel complete" << std::endl;

  xrtRunWait(hls_packet_receiver_r2);
  std::cout << "output kernel2 complete" << std::endl;

  xrtGraphEnd(graph);

  // Invalidate outputs for host readback
  for (int i = 0; i < channel_count; ++i)
    xrtBOCacheInvalidate(output_bos[i], 0, mem_size);

  // Optional: print a small dump to sanity-check
  const int dump_n = std::min<int>(16, max_words_per_channel);
  for (int ch = 0; ch < channel_count; ++ch) {
    std::cout << "CH" << ch << " :";
    for (int i = 0; i < dump_n; ++i)
      std::cout << " " << host_outputs[ch][i];
    std::cout << std::endl;
  }

  // ===== Cleanup =====
  xrtRunClose(mm2s_r1);
  xrtRunClose(mm2s_r2);
  xrtRunClose(s2mm_r1);
  xrtRunClose(s2mm_r2);
  xrtRunClose(hls_packet_sender_r);
  xrtRunClose(hls_packet_receiver_r);
  xrtRunClose(hls_packet_receiver_r2);

  xrtGraphClose(graph);

  xrtPLKernelClose(mm2s_k1);
  xrtPLKernelClose(mm2s_k2);
  xrtPLKernelClose(s2mm_k1);
  xrtPLKernelClose(s2mm_k2);
  xrtPLKernelClose(hls_packet_sender_k);
  xrtPLKernelClose(hls_packet_receiver_k);
  xrtPLKernelClose(hls_packet_receiver_k2);

  for (int i = 0; i < channel_count; ++i) {
    xrtBOFree(input_bos[i]);
    xrtBOFree(output_bos[i]);
  }
  xrtBOFree(max_words_bo);

  xrtDeviceClose(dhdl);
  return 0;
}
