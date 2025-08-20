#include <hls_stream.h>
#include <ap_int.h>
#include <iostream>
#include "../../common/nn_defs.h"


typedef float data_t;

void roll_concat(hls::stream<data_t> &in, hls::stream<data_t> &out) {
#pragma HLS INTERFACE axis port=in
#pragma HLS INTERFACE axis port=out
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS ARRAY_PARTITION variable=buffer complete dim=1

    data_t buffer[HIDDEN_SIZE];

    // Read input vector
    for (int i = 0; i < HIDDEN_SIZE; i++) {
#pragma HLS PIPELINE II=1
        buffer[i] = in.read();
    }

    // Emit ROLL_CONC_SUBSET_SIZE shifted versions
    for (int shift = 0; shift < ROLL_CONC_SUBSET_SIZE; shift++) {
        for (int i = 0; i < HIDDEN_SIZE; i++) {
#pragma HLS PIPELINE II=1
            int idx = (i + shift) % HIDDEN_SIZE;
            out.write(buffer[idx]);
        }
    }
}
