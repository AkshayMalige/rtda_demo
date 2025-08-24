#include <iostream>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

typedef float data_t;
typedef hls::axis<data_t,0,0,4> axis_t;

extern "C" void axis_switch_pl(hls::stream<axis_t>& s_in,
                                hls::stream<axis_t>& out0,
                                hls::stream<axis_t>& out1,
                                hls::stream<axis_t>& out2,
                                hls::stream<axis_t>& out3,
                                hls::stream<axis_t>& out4,
                                hls::stream<axis_t>& out5);

int main() {
    hls::stream<axis_t> in;
    hls::stream<axis_t> out0, out1, out2, out3, out4, out5;
    for(int i=0;i<6;++i){
        axis_t val; val.data=i; val.dest=i;
        in.write(val);
    }
    axis_switch_pl(in,out0,out1,out2,out3,out4,out5);
    bool pass=true;
    hls::stream<axis_t>* outs[6]={&out0,&out1,&out2,&out3,&out4,&out5};
    for(int i=0;i<6;++i){
        if(outs[i]->empty()){std::cerr<<"Output "<<i<<" empty\n"; pass=false; continue;}
        axis_t val=outs[i]->read();
        if(val.data!=i){std::cerr<<"Mismatch at output "<<i<<"\n"; pass=false;}
        if(!outs[i]->empty()){std::cerr<<"Extra data at output "<<i<<"\n"; pass=false;}
    }
    if(pass) std::cout<<"Test PASSED"<<std::endl;
    else std::cout<<"Test FAILED"<<std::endl;
    return pass?0:1;
}
