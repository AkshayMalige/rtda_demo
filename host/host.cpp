// host_switch.cpp
// ---------------------------------------------------------------------------
// Simple host to exercise the switch_mm2s → demux_8 → s2mm data‑mover chain.
//    1. read float values from a text file
//    2. build a “switch packet” (header + payload) for the chosen AXI channel
//    3. launch switch_mm2s, demux_8 and eight s2mm CUs
//    4. print the values returned by whichever s2mm received data
// ---------------------------------------------------------------------------

#include <cstring>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

#include "experimental/xrt_bo.h"
#include "experimental/xrt_device.h"
#include "experimental/xrt_kernel.h"

#include "../common/data_paths.h"
#include "../pl/bus_ids.hpp" // keep next to TB or adjust include path

// ---------------------------------------------------------------------------
// Utilities reused from switch_mm2s_test.cpp
// ---------------------------------------------------------------------------

// Read a whitespace separated list of floats from disk.
static std::vector<float> read_f32_list(const std::string &file) {
  std::ifstream fin(file);
  if (!fin)
    throw std::runtime_error("Cannot open " + file);

  std::vector<float> vals;
  float v{};
  while (fin >> v)
    vals.push_back(v);
  return vals;
}

// Build the memory image consumed by switch_mm2s_pl.
// The first two 32‑bit words form a header: [dest][length]
static std::vector<uint32_t>
make_switch_packet_ddr(const std::vector<float> &vals, uint8_t dest) {
  std::vector<uint32_t> pkt;
  pkt.reserve(vals.size() + 2);
  pkt.push_back(dest);        // TDEST
  pkt.push_back(vals.size()); // payload length

  for (float f : vals) {
    uint32_t w;
    std::memcpy(&w, &f, sizeof(w));
    pkt.push_back(w);
  }
  return pkt;
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

int main(int argc, char *argv[]) {
  if (argc != 2) {
    std::cout << "Usage: " << argv[0] << " <xclbin>\n";
    return 1;
  }

  std::string xclbin_file = argv[1];
//   std::string data_file = std::string(DATA_DIR) + "/" + EMBED_DENSE0_BIAS;
  std::string data_file = "./data/embed_dense_0_bias.txt";

  uint8_t dest = 3;

  // -----------------------------------------------------------------------
  // Prepare host data
  // -----------------------------------------------------------------------
  auto data = read_f32_list(data_file);
  auto packet = make_switch_packet_ddr(data, dest);

  // -----------------------------------------------------------------------
  // Load xclbin and acquire kernel handles
  // -----------------------------------------------------------------------
  xrt::device dev(0);
  auto uuid = dev.load_xclbin(xrt::xclbin{xclbin_file});

  xrt::kernel sw_k(dev, uuid, "switch_mm2s_pl:{switch_mm2s}");
  xrt::kernel demux_k(dev, uuid, "demux_8_pl:{demux}");

  std::vector<xrt::kernel> s2mm_k;
  for (int i = 0; i < 8; ++i)
    s2mm_k.emplace_back(dev, uuid,
                        ("s2mm_pl:{s2mm_" + std::to_string(i) + "}").c_str());

  // -----------------------------------------------------------------------
  // Buffer allocation
  // -----------------------------------------------------------------------
  xrt::bo pkt_bo(dev, packet.size() * sizeof(uint32_t), xrt::bo::flags::normal,
                 sw_k.group_id(0));
  pkt_bo.write(packet.data());
  pkt_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);

  std::vector<xrt::bo> out_bos;
  for (int i = 0; i < 8; ++i)
    out_bos.emplace_back(dev, data.size() * sizeof(float),
                         xrt::bo::flags::normal, s2mm_k[i].group_id(0));

  // -----------------------------------------------------------------------
  // Launch kernels
  // -----------------------------------------------------------------------
  std::vector<xrt::run> s2mm_runs;
  s2mm_runs.reserve(8);
  for (int i = 0; i < 8; ++i) {
    xrt::run r{s2mm_k[i]};
    r.set_arg(0, out_bos[i]);
    r.set_arg(1, data.size());
    r.start();
    s2mm_runs.push_back(std::move(r));
  }

  xrt::run demux_run{demux_k};
  demux_run.start();

  xrt::run switch_run{sw_k};
  switch_run.set_arg(0, pkt_bo);
  switch_run.set_arg(1, packet.size());
  switch_run.start();

  switch_run.wait();
  demux_run.wait();
  for (auto &r : s2mm_runs)
    r.wait();

  // -----------------------------------------------------------------------
  // Retrieve and print results
  // -----------------------------------------------------------------------
  for (int ch = 0; ch < 8; ++ch) {
    out_bos[ch].sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    std::vector<float> out(data.size());
    out_bos[ch].read(out.data());

    bool valid = false;
    for (float v : out)
      if (v != 0.0f) {
        valid = true;
        break;
      }

    if (valid) {
      std::cout << "AXI channel " << ch << " received:\n";
      for (float v : out)
        std::cout << "  " << v << '\n';
    }
  }

  return 0;
}
