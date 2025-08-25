#include <ap_axi_sdata.h>
#include <ap_int.h>
#include <cassert>
#include <hls_stream.h>
#include <iostream>

// axis_t definition matches demux_8_pl.cpp
typedef ap_axiu<32, 1, 1, 8> axis_t; // data,user,id,dest

extern "C" void
weights_demux_8(hls::stream<axis_t> &in, hls::stream<axis_t> &out0,
                hls::stream<axis_t> &out1, hls::stream<axis_t> &out2,
                hls::stream<axis_t> &out3, hls::stream<axis_t> &out4,
                hls::stream<axis_t> &out5, hls::stream<axis_t> &out6,
                hls::stream<axis_t> &out7);

int main() {
  hls::stream<axis_t> in;
  hls::stream<axis_t> out0, out1, out2, out3, out4, out5, out6, out7;

  const int packet_len = 3;

  // First packet routed to output 3
  for (int i = 0; i < packet_len; ++i) {
    axis_t t;
    t.data = 0x10 + i;
    t.keep = -1;
    t.last = (i == packet_len - 1);
    t.dest = 3;
    t.id = 0;
    t.user = 0;
    in.write(t);
  }

  // Second packet routed to output 7
  for (int i = 0; i < packet_len; ++i) {
    axis_t t;
    t.data = 0x20 + i;
    t.keep = -1;
    t.last = (i == packet_len - 1);
    t.dest = 7;
    t.id = 0;
    t.user = 0;
    in.write(t);
  }

  weights_demux_8(in, out0, out1, out2, out3, out4, out5, out6, out7);

  bool pass = true;

  // Check output 3
  for (int i = 0; i < packet_len; ++i) {
    assert(!out3.empty());
    axis_t v = out3.read();
    bool last = (i == packet_len - 1);
    if (v.data != (ap_uint<32>)(0x10 + i) || v.last != last)
      pass = false;
    assert(v.dest == 0);
  }
  if (!out3.empty())
    pass = false;

  // Check output 7
  for (int i = 0; i < packet_len; ++i) {
    assert(!out7.empty());
    axis_t v = out7.read();
    bool last = (i == packet_len - 1);
    if (v.data != (ap_uint<32>)(0x20 + i) || v.last != last)
      pass = false;
    assert(v.dest == 0);
  }
  if (!out7.empty())
    pass = false;

  // Other outputs should be empty
  hls::stream<axis_t> *outs[8] = {&out0, &out1, &out2, &out3,
                                  &out4, &out5, &out6, &out7};
  for (int i = 0; i < 8; ++i) {
    if (i == 3 || i == 7)
      continue;
    if (!outs[i]->empty())
      pass = false;
  }

  if (pass) {
    std::cout << "Test PASSED" << std::endl;
    return 0;
  } else {
    std::cout << "Test FAILED" << std::endl;
    return 1;
  }
}
