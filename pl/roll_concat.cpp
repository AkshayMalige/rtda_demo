#include <hls_stream.h>
#include <ap_int.h>
#include <iostream>

#define FEATURE_SIZE 128
#define SUBSET_SIZE 6
#define OUTPUT_SIZE (FEATURE_SIZE * SUBSET_SIZE)

typedef float data_t;

void roll_concat(hls::stream<data_t> &in, hls::stream<data_t> &out) {
#pragma HLS INTERFACE axis port=in
#pragma HLS INTERFACE axis port=out
#pragma HLS INTERFACE ap_ctrl_none port=return
#pragma HLS ARRAY_PARTITION variable=buffer complete dim=1

    data_t buffer[FEATURE_SIZE];

    // Read input vector
    for (int i = 0; i < FEATURE_SIZE; i++) {
#pragma HLS PIPELINE II=1
        buffer[i] = in.read();
    }

    // Emit SUBSET_SIZE shifted versions
    for (int shift = 0; shift < SUBSET_SIZE; shift++) {
        for (int i = 0; i < FEATURE_SIZE; i++) {
#pragma HLS PIPELINE II=1
            int idx = (i + shift) % FEATURE_SIZE;
            out.write(buffer[idx]);
        }
    }
}

/*
x = [x0, x1, x2, ..., x127]     # Input vector from LeakyReLU

     ┌────────────┐
     │  Slice(0)  │ → [x0, x1, ..., x127]
     └────────────┘
           ↓
     ┌────────────┐
     │  Slice(1)  │ → [x1, x2, ..., x0]
     └────────────┘
           ↓
     ┌────────────┐
     │  Slice(2)  │ → [x2, x3, ..., x1]
     └────────────┘
           ⋮
     ┌────────────┐
     │  Slice(5)  │ → [x5, x6, ..., x4]
     └────────────┘

 →→→ All outputs are passed to →→→  ┌──────────────┐
                                    │   Concat     │
                                    └──────────────┘
                                        ↓
                         Final vector: [x0..x127, x1..x0, x2..x1, ..., x5..x4]
                                        Size = 128 × 6 = 768

*/