// tb_demux_8_pl.cpp  (super simple)
#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include "../../common/data_paths.h"

typedef ap_axiu<32,1,1,8> axis_t;

extern "C" {
void demux_8_pl(hls::stream<axis_t>& in,
                hls::stream<axis_t>& out0,
                hls::stream<axis_t>& out1,
                hls::stream<axis_t>& out2,
                hls::stream<axis_t>& out3,
                hls::stream<axis_t>& out4,
                hls::stream<axis_t>& out5,
                hls::stream<axis_t>& out6,
                hls::stream<axis_t>& out7);
}

// bitcast helpers
static inline ap_uint<32> f2u(float f){ union{float f; uint32_t u;} v; v.f=f; return v.u; }
static inline float u2f(ap_uint<32> u){ union{float f; uint32_t u;} v; v.u=(uint32_t)u; return v.f; }

static std::vector<float> read_floats(const std::string& path, size_t N){
    std::ifstream fin(path);
    if(!fin){ std::cerr<<"ERROR: cannot open "<<path<<"\n"; exit(1); }
    std::vector<float> v; v.reserve(N);
    float x; while(fin>>x){ v.push_back(x); if(v.size()==N) break; }
    return v;
}

int main(){
    const int N = 128;           // number of samples to read/drive
    const ap_uint<3> TDEST = 6; // route to channel 3

    const char* data_dir = DATA_DIR;
    std::cout << "DATA_DIR resolved to: " << data_dir << std::endl;
    std::string path = std::string(data_dir) + "/" + EMBED_DENSE0_BIAS;
    std::ifstream fin(path);
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open file: " << path << std::endl;
        return 1;
    }


    // load first N floats from your bias file
    // std::string path = std::string("/home/synthara/VersalPrjs/LDRD/rtda_demo/data/") + EMBED_DENSE0_BIAS;
    auto data = read_floats(path, N);

    // streams
    hls::stream<axis_t> in;
    hls::stream<axis_t> out0,out1,out2,out3,out4,out5,out6,out7;

    // drive packet
    for(int i=0;i<N;i++){
        axis_t t;
        t.data = f2u(data[i]);
        t.keep = -1; t.strb = -1;
        t.user = 0; t.id=0;
        t.dest = TDEST;
        t.last = (i==N-1);
        in.write(t);
    }

    // run DUT once
    demux_8_pl(in,out0,out1,out2,out3,out4,out5,out6,out7);

    // pick output channel
    hls::stream<axis_t>* outs[8] = {&out0,&out1,&out2,&out3,&out4,&out5,&out6,&out7};
    hls::stream<axis_t>& out = *outs[(int)TDEST];

    // print what came back
    int i=0;
    while(!out.empty()){
        axis_t o = out.read();
        float f = u2f(o.data);
        std::cout << "Value["<<i<<"] = " << f
                  << "  Channel=" << (int)TDEST
                  << (o.last ? "  <-- TLAST\n" : "\n");
        i++;
    }

    std::cout << "PASS\n";
    return 0;
}
