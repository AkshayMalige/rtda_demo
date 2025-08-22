#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

static const int NUM_OUTPUTS = 17;

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 5> axis_t;  // enable 5‑bit DEST field

extern "C" {
void axis_switch_pl(hls::stream<axis_t> &in, hls::stream<axis_t> out[NUM_OUTPUTS]) {
#pragma HLS INTERFACE axis port=in
#pragma HLS INTERFACE axis port=out
#pragma HLS INTERFACE s_axilite port=return bundle=control
#pragma HLS ARRAY_PARTITION variable=out complete

    bool last = false;
    while (!last) {
#pragma HLS PIPELINE II=1
        axis_t val = in.read();
        ap_uint<5> dest = val.dest;
        if (dest < NUM_OUTPUTS) {
            switch (dest) {
            case 0:
                out[0].write(val);
                break;
            case 1:
                out[1].write(val);
                break;
            case 2:
                out[2].write(val);
                break;
            case 3:
                out[3].write(val);
                break;
            case 4:
                out[4].write(val);
                break;
            case 5:
                out[5].write(val);
                break;
            case 6:
                out[6].write(val);
                break;
            case 7:
                out[7].write(val);
                break;
            case 8:
                out[8].write(val);
                break;
            case 9:
                out[9].write(val);
                break;
            case 10:
                out[10].write(val);
                break;
            case 11:
                out[11].write(val);
                break;
            case 12:
                out[12].write(val);
                break;
            case 13:
                out[13].write(val);
                break;
            case 14:
                out[14].write(val);
                break;
            case 15:
                out[15].write(val);
                break;
            case 16:
                out[16].write(val);
                break;
            default:
                break;
            }
        }
        last = val.last;
    }
}
}
