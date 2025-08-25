#include <iostream>
#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <cassert>

// axis_t definition matches switch_mm2s_pl.cpp
typedef ap_axiu<32,1,1,8> axis_t; // data,user,id,dest

#ifndef MEM_DEPTH
#define MEM_DEPTH 1024
#endif

extern "C" void switch_mm2s_pl(const ap_uint<32>* in,
                              hls::stream<axis_t>& out,
                              uint32_t total_words);

int main() {
    const ap_uint<8> part = 1;
    const ap_uint<8> kind = 2;
    const ap_uint<8> layer_id = 3;
    const int payload_len = 3;

    ap_uint<32> payload[payload_len] = {0xdeadbeef, 0xcafebabe, 0x12345678};

    const int total_words = 4 + payload_len;
    // ap_uint<32> mem[total_words];
    static ap_uint<32> mem[MEM_DEPTH] = {0};  // must be >= pragma depth

    mem[0] = (part << 24) | (kind << 16) | (layer_id);
    mem[1] = payload_len;
    mem[2] = 0;
    mem[3] = 0;
    for (int i = 0; i < payload_len; ++i) {
        mem[4 + i] = payload[i];
    }

    hls::stream<axis_t> out;
    switch_mm2s_pl(mem, out, total_words);

    bool pass = true;
    for (int i = 0; i < payload_len; ++i) {
        assert(!out.empty());
        axis_t val = out.read();
        bool last = (i == payload_len - 1);
        if (val.data != payload[i] || val.dest != layer_id || val.last != last) {
            pass = false;
        }
        assert(val.data == payload[i]);
        assert(val.dest == layer_id);
        assert(val.last == last);
    }
    if (!out.empty()) {
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

