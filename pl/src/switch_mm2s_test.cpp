// tb_switch_mm2s.cpp
#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <cstdint>
#include <vector>
#include <string>
#include <fstream>
#include <iostream>
#include <iomanip>
#include <sstream>
#include <cstring>
#include "../bus_ids.hpp"     // keep next to TB or adjust include path
#include "../../common/data_paths.h"

typedef ap_axiu<32, 1, 1, 8> axis_t;

extern "C" void switch_mm2s_pl(const ap_uint<32>* in,
                               hls::stream<axis_t>& out,
                               uint32_t total_words);

// ---- helpers ----
static inline uint32_t f32_to_u32(float f) { uint32_t u; std::memcpy(&u,&f,4); return u; }
static inline float    u32_to_f32(uint32_t u){ float f; std::memcpy(&f,&u,4); return f; }

static std::vector<float> read_f32_list(const std::string& path) {
  std::ifstream fin(path);
  if (!fin) { throw std::runtime_error("cannot open: " + path); }
  std::vector<float> vals; std::string line;
  while (std::getline(fin, line)) { if (line.empty()) continue; float v=0.f; std::istringstream(line) >> v; vals.push_back(v); }
  return vals;
}

static std::vector<ap_uint<32>> make_switch_packet_ddr(uint8_t bus_id, const std::vector<float>& payload_f32) {
  const uint32_t len = (uint32_t)payload_f32.size();
  std::vector<ap_uint<32>> ddr; ddr.reserve(4 + len);
  ap_uint<32> ctrl = 0; ctrl.range(7,0) = bus_id;
  ddr.push_back(ctrl);
  ddr.push_back(len);
  ddr.push_back(0);
  ddr.push_back(0);
  for (float f : payload_f32) ddr.push_back(f32_to_u32(f));
  return ddr;
}

int main(int argc, char** argv) {
  try {
    // Pick a real file from your repo; change default as needed.

    const char* data_dir = DATA_DIR;
    std::cout << "DATA_DIR resolved to: " << data_dir << std::endl;
    std::string in_path = std::string(data_dir) + "/" + EMBED_DENSE0_BIAS;
    std::ifstream fin(in_path);
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open file: " << in_path << std::endl;
        return 1;
    }

    // std::string in_path = "/home/synthara/VersalPrjs/LDRD/rtda_demo/data/embed_dense_0_bias.txt";
    if (argc >= 2) in_path = argv[1];

    const uint8_t BUS_ID = bus::BIAS0; // or bus::WEIGHTS0, etc. from bus_ids.hpp

    auto payload = read_f32_list(in_path);
    if (payload.empty()) { std::cerr << "ERROR: empty input file\n"; return 2; }

    // auto ddr = make_switch_packet_ddr(BUS_ID, payload);
    // uint32_t total_words = (uint32_t)ddr.size();

    hls::stream<axis_t> out_stream;
    // switch_mm2s_pl(ddr.data(), out_stream, total_words);

    static ap_uint<32> ddr[65536];
    auto pkt = make_switch_packet_ddr(bus::BIAS0, payload);
    for (size_t i = 0; i < pkt.size(); ++i) {
      ddr[i] = pkt[i];
    }

    uint32_t total_words = pkt.size();
    switch_mm2s_pl(ddr, out_stream, total_words);

    bool pass = true;
    std::cout << std::fixed << std::setprecision(6);
    for (size_t i=0;i<payload.size();++i){
      if (out_stream.empty()){ std::cerr<<"ERROR: output underflow @ "<<i<<"\n"; pass=false; break; }
      axis_t t = out_stream.read();
      float f  = u32_to_f32((uint32_t)t.data);
      uint8_t dest = (uint8_t)t.dest;
      std::cout<<"OUT["<<i<<"] = "<<f<<" (dest="<<(unsigned)dest<<", last="<<(unsigned)t.last<<")\n";
      if (dest != BUS_ID)   { std::cerr<<"ERROR: dest mismatch @ "<<i<<"\n"; pass=false; }
      if ((i==payload.size()-1 && t.last!=1) || (i<payload.size()-1 && t.last!=0)){
        std::cerr<<"ERROR: LAST flag mismatch @ "<<i<<"\n"; pass=false;
      }
      // strict bitwise compare (relax if needed):
      if (std::memcmp(&f, &payload[i], sizeof(float)) != 0){
        std::cerr<<"ERROR: data mismatch @ "<<i<<" got "<<f<<" want "<<payload[i]<<"\n"; pass=false;
      }
    }
    if (!out_stream.empty()){ std::cerr<<"WARN: extra data in stream\n"; pass=false; }

    std::cout << (pass ? "TB PASS\n" : "TB FAIL\n");
    return pass ? 0 : 1;
  } catch (const std::exception& e) {
    std::cerr << "EXCEPTION: " << e.what() << "\n"; return 99;
  }
}
