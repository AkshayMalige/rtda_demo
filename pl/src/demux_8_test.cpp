#include <ap_axi_sdata.h>
#include <ap_int.h>
#include <cassert>
#include <cstring>
#include <fstream>
#include <hls_stream.h>
#include <iostream>
#include <vector>

#include "../bus_ids.hpp"

// axis_t definition matches demux_8_pl.cpp
using axis_t = ap_axiu<32,1,1,8>; // data,user,id,dest

extern "C" void demux_8_pl(hls::stream<axis_t>& in,
                            hls::stream<axis_t>& out0,
                            hls::stream<axis_t>& out1,
                            hls::stream<axis_t>& out2,
                            hls::stream<axis_t>& out3,
                            hls::stream<axis_t>& out4,
                            hls::stream<axis_t>& out5,
                            hls::stream<axis_t>& out6,
                            hls::stream<axis_t>& out7);

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

static bool run_packet(const std::vector<ap_uint<32>>& data, ap_uint<8> dest) {
  hls::stream<axis_t> in, out0, out1, out2, out3, out4, out5, out6, out7;

  for (size_t i = 0; i < data.size(); ++i) {
    axis_t t{};
    t.data = data[i];
    t.keep = -1;
    t.strb = -1;
    t.dest = dest;
    t.last = (i == data.size() - 1);
    in.write(t);
  }

  demux_8_pl(in, out0, out1, out2, out3, out4, out5, out6, out7);

  hls::stream<axis_t>* outs[8] = {&out0,&out1,&out2,&out3,&out4,&out5,&out6,&out7};
  bool pass = true;

  for (int i = 0; i < 8; ++i) {
    if (i == dest) {
      for (size_t j = 0; j < data.size(); ++j) {
        assert(!outs[i]->empty());
        axis_t v = outs[i]->read();
        bool last = (j == data.size() - 1);
        if (v.data != data[j] || v.last != last)
          pass = false;
        assert(v.dest == 0);
      }
      if (!outs[i]->empty())
        pass = false;
    } else {
      if (!outs[i]->empty())
        pass = false;
    }
  }
  return pass;
}

int main() {
  bool pass = true;
  pass &= run_packet(load_data("solver_0_input_part0.txt", 3), bus::DIN);
  pass &= run_packet(load_data("solver_0_dense_0_weights_part0.txt", 3), bus::WEIGHTS0);
  pass &= run_packet(load_data("solver_0_dense_0_bias.txt", 2), bus::BIAS0);

  if (pass) {
    std::cout << "Test PASSED" << std::endl;
    return 0;
  } else {
    std::cout << "Test FAILED" << std::endl;
    return 1;
  }
}
