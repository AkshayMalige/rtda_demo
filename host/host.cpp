// host.cpp — run as: ./system_host <a.xclbin>
// Build: g++ -std=gnu++17 host.cpp -o system_host -lxrt_coreutil
#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <cstdint>
#include <cstring>
#include <iomanip>
#include <algorithm>

#include <xrt/xrt_device.h>
#include <xrt/xrt_kernel.h>
#include <xrt/xrt_bo.h>
#include <xrt/xrt_uuid.h>

// --- If you have bus_ids.hpp, include it and pick a bus/channel from it.
// --- Otherwise just change BUS_ID below to 0..255 (demux channel = BUS_ID & 7).
// #include "../pl/bus_ids.hpp"
static constexpr int BUS_ID = 6;  // <- choose the destination/channel you want

// Fixed test file on target filesystem:
static const char* kDataFile = "./data/embed_dense_0_bias.txt";

// ---------- helpers: read floats and pack switch_mm2s header ----------
static inline uint32_t f32_to_u32(float f){ uint32_t u; std::memcpy(&u,&f,4); return u; }

static std::vector<float> read_f32_list(const std::string& path) {
  std::ifstream fin(path);
  if (!fin) { throw std::runtime_error("cannot open: " + path); }
  std::vector<float> vals; std::string line;
  while (std::getline(fin, line)) {
    if (line.empty()) continue;
    float v = 0.f; std::istringstream iss(line); iss >> v;
    if (!iss.fail()) vals.push_back(v);
  }
  return vals;
}

// [ctrl,len,0,0] + payload, ctrl[7:0] = TDEST
static std::vector<uint32_t>
make_switch_packet_words(uint8_t bus_id, const std::vector<float>& payload) {
  const uint32_t len = (uint32_t)payload.size();
  std::vector<uint32_t> w; w.reserve(4 + len);
  uint32_t ctrl = 0; ctrl |= (uint32_t)bus_id;
  w.push_back(ctrl);
  w.push_back(len);
  w.push_back(0);
  w.push_back(0);
  for (float f : payload) w.push_back(f32_to_u32(f));
  return w;
}

static inline std::vector<std::string> s2mm_names() {
  return {"s2mm_0","s2mm_1","s2mm_2","s2mm_3","s2mm_4","s2mm_5","s2mm_6","s2mm_7"};
}

int main(int argc, char** argv) try {
  if (argc < 2) {
    std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
    return 1;
  }
  std::string xclbin_path = argv[1];

  // --- read data, build packet ---
  auto floats = read_f32_list(kDataFile);
  if (floats.empty()) throw std::runtime_error(std::string("no data in: ") + kDataFile);
  const uint8_t tdest = (uint8_t)(BUS_ID & 0xFF);
  const unsigned demux_ch = (unsigned)(tdest & 7);
  auto words = make_switch_packet_words(tdest, floats);

  std::cout << "xclbin : " << xclbin_path << "\n"
            << "file   : " << kDataFile << "\n"
            << "values : " << floats.size() << "\n"
            << "TDEST  : " << (int)tdest << " (demux channel " << demux_ch << ")\n";

  // --- device/xclbin ---
  xrt::device dev{0};
  xrt::xclbin xb{xclbin_path};
  auto uuid = dev.load_xclbin(xb);

  // instance names from linker_switch.cfg
  xrt::kernel k_mm2s{dev, uuid, "switch_mm2s"};  // switch_mm2s_pl(in, total_words)
  xrt::kernel k_demux{dev, uuid, "demux"};       // demux_8_pl()

  std::vector<xrt::kernel> ks2;
  for (auto& nm : s2mm_names()) { try { ks2.emplace_back(dev, uuid, nm); } catch(...){} }
  if (ks2.empty()) throw std::runtime_error("no s2mm_* instances found");

  unsigned target = std::min<unsigned>(demux_ch, ks2.size()-1);

  // --- BOs ---
  auto in_bo = xrt::bo{dev, words.size()*sizeof(uint32_t), k_mm2s.group_id(0)};
  in_bo.write(words.data());
  in_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);

  std::vector<xrt::bo> out_bo; out_bo.reserve(ks2.size());
  for (size_t i=0;i<ks2.size();++i) {
    size_t n = (i==target) ? floats.size() : 1;
    out_bo.emplace_back(dev, n*sizeof(float), ks2[i].group_id(0));
  }

  // --- runs (avoid variadic operator(); use set_arg + start) ---
  // s2mm_pl(mem, size) — non-target size=0 so it returns immediately
  std::vector<xrt::run> r_s2mm; r_s2mm.reserve(ks2.size());
  for (size_t i=0;i<ks2.size();++i) {
    r_s2mm.emplace_back(ks2[i]);
    r_s2mm.back().set_arg(0, out_bo[i]);                      // mem
    int size = (i==target) ? (int)floats.size() : 0;          // size
    r_s2mm.back().set_arg(1, size);
    r_s2mm.back().start();
  }

  xrt::run r_demux{k_demux}; r_demux.start();                 // no args
  xrt::run r_mm2s{k_mm2s};
  r_mm2s.set_arg(0, in_bo);                                   // in_ptr
  r_mm2s.set_arg(1, (uint32_t)words.size());                  // total_words
  r_mm2s.start();

  r_mm2s.wait();
  r_demux.wait();
  r_s2mm[target].wait();

  // --- read back & print ---
  std::vector<float> out(floats.size(), 0.f);
  if (!out.empty()) {
    out_bo[target].sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    out_bo[target].read(out.data());
  }

  std::cout << std::fixed << std::setprecision(6);
  for (size_t i=0;i<out.size();++i)
    std::cout << "OUT[" << i << "] = " << out[i]
              << "  (axi-channel=" << demux_ch << ")\n";

  std::cout << "DONE\n";
  return 0;

} catch (const std::exception& e) {
  std::cerr << "ERROR: " << e.what() << "\n";
  return 1;
}
