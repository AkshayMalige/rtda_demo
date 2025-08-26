#include <ap_axi_sdata.h>
#include <ap_int.h>
#include <cassert>
#include <cstring>
#include <fstream>
#include <hls_stream.h>
#include <iostream>
#include <vector>
#include <string>

#include "../bus_ids.hpp"
#include "../../common/data_paths.h"

// axis_t definition matches switch_mm2s_pl.cpp
using axis_t = ap_axiu<32,1,1,8>; // data,user,id,dest

#ifndef MEM_DEPTH
#define MEM_DEPTH 1024
#endif

extern "C" void switch_mm2s_pl(const ap_uint<32>* in,
                                hls::stream<axis_t>& out,
                                uint32_t total_words);
extern "C" void demux_8_pl(hls::stream<axis_t>& in,
                            hls::stream<axis_t>& out0,
                            hls::stream<axis_t>& out1,
                            hls::stream<axis_t>& out2,
                            hls::stream<axis_t>& out3,
                            hls::stream<axis_t>& out4,
                            hls::stream<axis_t>& out5,
                            hls::stream<axis_t>& out6,
                            hls::stream<axis_t>& out7);

enum DataKind : ap_uint<8> { KIND_INPUT=0, KIND_WEIGHT=1, KIND_BIAS=2 };

struct WeightsHdr {
  ap_uint<32> ctrl;
  ap_uint<32> len;
  ap_uint<32> r0;
  ap_uint<32> r1;
  WeightsHdr(ap_uint<8> bus_id, DataKind kind, ap_uint<32> length_words)
      : ctrl((0u << 24) | (ap_uint<32>(kind) << 16) | ap_uint<32>(bus_id)),
        len(length_words), r0(0), r1(0) {}
};

static std::vector<ap_uint<32>> load_data(const std::string& fn, int count) {
  std::vector<ap_uint<32>> words;
  std::ifstream file(fn);
  float f;
  for (int i = 0; i < count && (file >> f); ++i) {
    ap_uint<32> w;
    std::memcpy(&w, &f, sizeof(float));
    words.push_back(w);
  }
  return words;
}

static void append_packet(std::vector<ap_uint<32>>& dst,
                          const std::vector<ap_uint<32>>& data,
                          ap_uint<8> bus_id,
                          DataKind kind) {
  WeightsHdr h(bus_id, kind, data.size());
  dst.push_back(h.ctrl);
  dst.push_back(h.len);
  dst.push_back(h.r0);
  dst.push_back(h.r1);
  for (auto w : data)
    dst.push_back(w);
}

static bool check_stream(hls::stream<axis_t>& s,
                         const std::vector<ap_uint<32>>& exp) {
  for (size_t i = 0; i < exp.size(); ++i) {
    assert(!s.empty());
    axis_t v = s.read();
    bool last = (i == exp.size() - 1);
    if (v.data != exp[i] || v.last != last)
      return false;
    assert(v.dest == 0);
  }
  return s.empty();
}

int main() {
  auto din = load_data(std::string(DATA_DIR) + "/" + EMBED_INPUT_DATA, 3);
  auto w0  = load_data(std::string(DATA_DIR) + "/" + EMBED_DENSE0_WEIGHTS, 3);
  auto b0  = load_data(std::string(DATA_DIR) + "/" + EMBED_DENSE0_BIAS, 2);

  std::vector<ap_uint<32>> words;
  append_packet(words, din, bus::DIN,      KIND_INPUT);
  append_packet(words, w0,  bus::WEIGHTS0, KIND_WEIGHT);
  append_packet(words, b0,  bus::BIAS0,    KIND_BIAS);

  const uint32_t total_words = words.size();
  static ap_uint<32> mem[MEM_DEPTH] = {0};
  for (uint32_t i = 0; i < total_words; ++i)
    mem[i] = words[i];

  hls::stream<axis_t> mm2s_out;
  switch_mm2s_pl(mem, mm2s_out, total_words);

  bool pass = true;
  hls::stream<axis_t> out0, out1, out2, out3, out4, out5, out6, out7;

  demux_8_pl(mm2s_out, out0, out1, out2, out3, out4, out5, out6, out7);
  pass &= check_stream(out0, din);
  pass &= out1.empty() && out2.empty() && out3.empty() && out4.empty() &&
          out5.empty() && out6.empty() && out7.empty();

  demux_8_pl(mm2s_out, out0, out1, out2, out3, out4, out5, out6, out7);
  pass &= check_stream(out1, w0);
  pass &= out0.empty() && out2.empty() && out3.empty() && out4.empty() &&
          out5.empty() && out6.empty() && out7.empty();

  demux_8_pl(mm2s_out, out0, out1, out2, out3, out4, out5, out6, out7);
  pass &= check_stream(out4, b0);
  pass &= out0.empty() && out1.empty() && out2.empty() && out3.empty() &&
          out5.empty() && out6.empty() && out7.empty();

  if (pass && mm2s_out.empty()) {
    std::cout << "Test PASSED" << std::endl;
    return 0;
  } else {
    std::cout << "Test FAILED" << std::endl;
    return 1;
  }
}
