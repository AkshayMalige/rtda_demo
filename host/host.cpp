// host.cpp — minimal & robust for switch_mm2s_pl → demux_8_pl → s2mm_pl[x8]
// Build + run commands are at the bottom of this file.

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <sstream>
#include <stdexcept>
#include <cstring>
#include <iomanip>
#include <limits>

#include "experimental/xrt_device.h"
#include "experimental/xrt_kernel.h"
#include "experimental/xrt_bo.h"

// If your tree defines DATA_DIR in data_paths.h, you can include it.
// Otherwise pass -DDATA_DIR='"/abs/path/to/data"' in CXXFLAGS.
#ifdef __has_include
#  if __has_include("data_paths.h")
#    include "data_paths.h"
#  endif
#endif
#ifndef DATA_DIR
#  define DATA_DIR "/home/synthara/VersalPrjs/LDRD/data"
#endif

// -------- helpers (reused) --------
static inline uint32_t f32_to_u32(float f){ uint32_t u; std::memcpy(&u,&f,4); return u; }

static std::vector<float> read_f32_list(const std::string& path){
  std::ifstream fin(path);
  if(!fin) throw std::runtime_error("cannot open: " + path);
  std::vector<float> vals; std::string line;
  while(std::getline(fin,line)){
    if(line.empty()) continue;
    float v=0.f; std::istringstream(line) >> v;
    vals.push_back(v);
  }
  return vals;
}

// switch packet in DDR: [0]=ctrl([7:0]=bus_id), [1]=len, [2]=0, [3]=0, [4..]=payload(u32 of f32)
static std::vector<uint32_t>
make_switch_packet_ddr(uint8_t bus_id, const std::vector<float>& payload_f32){
  const uint32_t len = static_cast<uint32_t>(payload_f32.size());
  std::vector<uint32_t> d; d.reserve(4 + len);
  d.push_back(static_cast<uint32_t>(bus_id & 0xFF));
  d.push_back(len);
  d.push_back(0);
  d.push_back(0);
  for(float f : payload_f32) d.push_back(f32_to_u32(f));
  return d;
}

int main(int argc, char** argv){
  try{
    if(argc < 2){
      std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
      return 1;
    }
    const std::string xclbin_path = argv[1];

    // ---- Hardcoded input & channel ----
    // const std::string filename = "embed_dense_0_bias.txt";          // change if you like
    // const std::string data_file = std::string(DATA_DIR) + "/" + filename;
    const std::string data_file = "./data/embed_dense_0_bias.txt";
    const uint8_t     BUS_ID    = 4;                                 // maps to s2mm_4 via demux

    // ---- Load data ----
    auto payload = read_f32_list(data_file);
    if(payload.empty()) throw std::runtime_error("Input file is empty: " + data_file);

    // ---- Build packet for switch_mm2s ----
    auto pkt_u32      = make_switch_packet_ddr(BUS_ID, payload);
    const uint32_t nw = static_cast<uint32_t>(pkt_u32.size());       // header(4) + payload

    // ---- XRT setup ----
    xrt::device dev{0};
    auto uuid = dev.load_xclbin(xclbin_path);

    // MUST match linker_demux.cfg aliases exactly:
    xrt::kernel k_mm2s{dev, uuid.get(), "switch_mm2s_pl:{switch_mm2s}"};
    xrt::kernel k_demux{dev, uuid.get(), "demux_8_pl:{demux}"};
    xrt::kernel k_s2mm {dev, uuid.get(), "s2mm_pl:{s2mm_4}"};                  // matches BUS_ID=4

    // ---- Correct memory banks via group_id(0) ----
    const int mm2s_gid = k_mm2s.group_id(0);
    const int s2mm_gid = k_s2mm.group_id(0);

    // Query the number of memory banks on the device.
    // The XRT API expects the query to use the `xrt::info::device`
    // namespace, not `xrt::device::info` which was used previously and
    // caused compilation to fail on recent XRT releases.
    const auto nbanks = dev.get_info<xrt::info::device::num_banks>();
    auto is_valid_bank = [nbanks](int gid) {
      return gid >= 0 && gid < static_cast<int>(nbanks) && gid != 0xFFFF;
    };
    if(!is_valid_bank(mm2s_gid))
      throw std::runtime_error("mm2s arg0 not mapped to a valid memory bank");
    if(!is_valid_bank(s2mm_gid))
      throw std::runtime_error("s2mm arg0 not mapped to a valid memory bank");

    xrt::memory_group mm2s_bank = static_cast<xrt::memory_group>(mm2s_gid);
    xrt::memory_group s2mm_bank = static_cast<xrt::memory_group>(s2mm_gid);

    // ---- Buffers ----
    const size_t pkt_bytes = pkt_u32.size() * sizeof(uint32_t);
    xrt::bo bo_pkt{dev, pkt_bytes, XRT_BO_FLAGS_NONE, mm2s_bank};
    std::memcpy(bo_pkt.map<void*>(), pkt_u32.data(), pkt_bytes);
    bo_pkt.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    const size_t out_bytes = payload.size() * sizeof(float);
    xrt::bo bo_out{dev, out_bytes, XRT_BO_FLAGS_NONE, s2mm_bank};
    bo_out.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    // ---- Run order: demux → s2mm_4 → mm2s ----
    xrt::run r_demux{k_demux}; r_demux.start();

    xrt::run r_s2mm{k_s2mm};
    r_s2mm.set_arg(0, bo_out);
    r_s2mm.set_arg(1, static_cast<int>(payload.size()));  // EXACT payload count (no header)
    r_s2mm.start();

    xrt::run r_mm2s{k_mm2s};
    r_mm2s.set_arg(0, bo_pkt);
    r_mm2s.set_arg(1, nw);                                // header + payload words
    r_mm2s.start();

    r_mm2s.wait();
    r_s2mm.wait();
    r_demux.wait();

    // ---- Readback ----
    bo_out.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    const float* out = bo_out.map<float*>();

    std::cout << "BUS_ID (TDEST) sent = " << (unsigned)BUS_ID << "\n";
    std::cout << std::fixed << std::setprecision(6);
    for(size_t i=0;i<payload.size();++i)
      std::cout << "OUT["<<i<<"] = " << out[i] << "\n";
    std::cout << "DONE.\n";
    return 0;
  }
  catch(const std::exception& e){
    std::cerr << "EXCEPTION: " << e.what() << "\n";
    return 99;
  }
}
