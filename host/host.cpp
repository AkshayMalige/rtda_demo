// host.cpp — single-sink (s2mm_4) with exact kernel names from linker.cfg
// Build (Petalinux):
//   aarch64-linux-gnu-g++ -Wall -std=c++17 -Wno-int-to-pointer-cast \
//     --sysroot=/opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux \
//     -I$(SYSROOT)/usr/include/xrt -I$(SYSROOT)/usr/include \
//     -I./ -I./src/ -I../common -I/aietools/include -I/include \
//     -DDATA_DIR='"/home/synthara/VersalPrjs/LDRD/data"' \
//     -c host.cpp -o host.o
//   aarch64-linux-gnu-g++ host.o --sysroot=$(SYSROOT) \
//     -L$(SYSROOT)/usr/lib -L$(SYSROOT)/lib -L$(SYSROOT)/lib64 \
//     -Wl,--no-as-needed -lxrt_coreutil -lxrt_core -luuid -lpthread -o system_host
//
// Run: ./system_host system_hw_emu.xclbin

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <sstream>
#include <stdexcept>
#include <cstring>
#include <iomanip>

#include "experimental/xrt_device.h"
#include "experimental/xrt_kernel.h"
#include "experimental/xrt_bo.h"

#include "../common/data_paths.h"  // optional; kept for your tree

// -------------------------- Helpers --------------------------
static inline uint32_t f32_to_u32(float f) { uint32_t u; std::memcpy(&u, &f, 4); return u; }

static std::vector<float> read_f32_list(const std::string& path) {
  std::ifstream fin(path);
  if (!fin) throw std::runtime_error("cannot open: " + path);
  std::vector<float> vals; std::string line;
  while (std::getline(fin, line)) {
    if (line.empty()) continue;
    float v = 0.f; std::istringstream(line) >> v;
    vals.push_back(v);
  }
  return vals;
}

// switch packet: [0]=ctrl([7:0]=bus_id), [1]=len, [2]=0, [3]=0, [4..]=payload(u32)
static std::vector<uint32_t>
make_switch_packet_ddr(uint8_t bus_id, const std::vector<float>& payload_f32) {
  const uint32_t len = static_cast<uint32_t>(payload_f32.size());
  std::vector<uint32_t> ddr; ddr.reserve(4 + len);
  ddr.push_back(static_cast<uint32_t>(bus_id));
  ddr.push_back(len);
  ddr.push_back(0);
  ddr.push_back(0);
  for (float f : payload_f32) ddr.push_back(f32_to_u32(f));
  return ddr;
}

int main(int argc, char** argv) {
  try {
    if (argc < 2) {
      std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
      return 1;
    }
    const std::string xclbin_path = argv[1];

    // --------- Input file ----------
    // const std::string data_file = std::string(DATA_DIR) + "/" + EMBED_DENSE0_BIAS;
    const std::string data_file = "./data/embed_dense_0_bias.txt";
    auto payload = read_f32_list(data_file);
    if (payload.empty())
      throw std::runtime_error("Input file is empty: " + data_file);

    // ------------------------------- XRT ------------------------------
    xrt::device dev{0};
    auto uuid = dev.load_xclbin(xclbin_path);

    // ---- Exact kernel names from linker.cfg ----
    xrt::kernel k_mm2s{dev, uuid.get(), "switch_mm2s_pl:{switch_mm2s}"};
    xrt::kernel k_demux{dev, uuid.get(), "demux_8_pl:{demux}"};
    xrt::kernel k_s2mm{dev, uuid.get(), "s2mm_pl:{s2mm_4}"};

    // Route only to out4 → s2mm_4
    constexpr uint8_t BUS_ID = 4;
    auto pkt_u32 = make_switch_packet_ddr(BUS_ID, payload);
    const uint32_t total_words = static_cast<uint32_t>(pkt_u32.size());

    // ---- Memory banks (match CU arg0 groups) ----
    auto mm2s_gid = k_mm2s.group_id(0);
    auto s2mm_gid = k_s2mm.group_id(0);
    if (mm2s_gid < 0) throw std::runtime_error("mm2s arg0 not mapped to a memory bank");
    if (s2mm_gid < 0) throw std::runtime_error("s2mm_4 arg0 not mapped to a memory bank");
    xrt::memory_group mm2s_bank = static_cast<xrt::memory_group>(mm2s_gid);
    xrt::memory_group s2mm_bank = static_cast<xrt::memory_group>(s2mm_gid);

    // ---- Host buffers ----
    const size_t pkt_bytes = pkt_u32.size() * sizeof(uint32_t);
    // xrt::bo bo_pkt{dev, pkt_bytes, XRT_BO_FLAGS_NONE, mm2s_bank};
    xrt::bo bo_pkt(dev, pkt_bytes, xrt::bo::flags::normal, 0);
    std::memcpy(bo_pkt.map<void*>(), pkt_u32.data(), pkt_bytes);
    bo_pkt.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    const size_t out_bytes = payload.size() * sizeof(float);
    // xrt::bo bo_out{dev, out_bytes, XRT_BO_FLAGS_NONE, s2mm_bank};
    xrt::bo bo_out(dev, out_bytes, xrt::bo::flags::normal, 65535);
    bo_out.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    // ---- Run sequence ----
    xrt::run r_demux{k_demux}; r_demux.start();

    xrt::run r_s2mm{k_s2mm};
    r_s2mm.set_arg(0, bo_out);
    r_s2mm.set_arg(1, static_cast<int>(payload.size())); // expected float count
    r_s2mm.start();

    xrt::run r_mm2s{k_mm2s};
    r_mm2s.set_arg(0, bo_pkt);
    r_mm2s.set_arg(1, total_words); // header + payload words
    r_mm2s.start();

    r_mm2s.wait();
    r_s2mm.wait();
    r_demux.wait();

    // ---- Readback ----
    bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    const float* out_f32 = bo_out.map<float*>();

    std::cout << "Sink CU: s2mm_4 (TDEST=4)\n";
    std::cout << std::fixed << std::setprecision(6);
    for (size_t i = 0; i < payload.size(); ++i) {
      std::cout << "OUT[" << i << "] = " << out_f32[i] << "\n";
    }
    std::cout << "DONE.\n";
    return 0;
  } catch (const std::exception& e) {
    std::cerr << "EXCEPTION: " << e.what() << "\n";
    return 99;
  }
}
