
#pragma once
#define INPUT_SIZE   6
#define HIDDEN_SIZE  128
#define OUTPUT_SIZE  128
#define LEAKY_SLOPE  0.1f
#define VEC_WIDTH_D1 4
#define VEC_WIDTH_D2 4
#define VEC_WIDTH   4    // 8-lane FP32 SIMD
#define FUSE_WIDTH  4    // 4 vectors in flight  → 32 neurons
#define INPUT_SIZE2   128
