#pragma once
#include <adf.h>
#include <aie_api/aie.hpp>
#include <cstdint>

// Resolved per-instance configuration for each emitted AIE subgraph.
// Some values are consumed directly by generated graph code, while others are mirrored here for visibility/debugging.

#define N_ITER 7

struct L1Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 16; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 1; static constexpr int CAS_NUM = 1;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 7;
  static constexpr int row_placement = 0;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 16;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 16;
  static constexpr int OUT_FEAT_SLICE = 128;
  static constexpr int RAW_IN_FEAT_SLICE = 16;
  static constexpr int RAW_OUT_FEAT_SLICE = 128;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L2Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 7;
  static constexpr int row_placement = 1;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L3Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 256; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 4; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 7;
  static constexpr int row_placement = 3;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 256;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L4Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 10;
  static constexpr int row_placement = 0;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L5Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 13;
  static constexpr int row_placement = 0;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L6Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 16;
  static constexpr int row_placement = 0;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L7Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 256; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 4; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 12;
  static constexpr int row_placement = 4;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 256;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L8Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 7;
  static constexpr int row_placement = 5;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L9Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 10;
  static constexpr int row_placement = 6;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L10Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 13;
  static constexpr int row_placement = 6;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L11Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 256; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 4; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 16;
  static constexpr int row_placement = 2;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 256;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L12Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 19;
  static constexpr int row_placement = 0;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L13Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 22;
  static constexpr int row_placement = 0;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
struct L14Cfg {
  using data_t = float;
  using weight_t = float;
  using result_t = float;
  using bias_t = float;
  static constexpr int IN_FEAT = 128; static constexpr int OUT_FEAT = 128;
  static constexpr int CAS_LENGTH = 2; static constexpr int CAS_NUM = 2;
  static constexpr bool USE_BIAS = true;
  static constexpr bool USE_RELU = true;
  // 0.0 => plain ReLU; >0 => leaky ReLU with this negative slope.
  static constexpr float LEAKY_ALPHA = 0.1f;
  static constexpr bool TRANSPOSE_INPUT = false;
  static constexpr int SHIFT = 0;
  static constexpr int M = 4, K = 8, N = 4;
  static constexpr int col_placement = 23;
  static constexpr int row_placement = 2;
  static constexpr int padded_independent_extent = 8;
  static constexpr int padded_IN_FEAT = 128;
  static constexpr int padded_OUT_FEAT = 128;
  static constexpr int IN_FEAT_SLICE = 64;
  static constexpr int OUT_FEAT_SLICE = 64;
  static constexpr int RAW_IN_FEAT_SLICE = 64;
  static constexpr int RAW_OUT_FEAT_SLICE = 64;
  using acc_scalar_t = accfloat;
  static constexpr const char* ROUNDING_TOKEN = "conv_even";
  static constexpr const char* SATURATION_TOKEN = "saturate";
#if __cplusplus >= 202002L
  static constexpr auto ROUNDING   = aie::rounding_mode::conv_even;
  static constexpr auto SATURATION = aie::saturation_mode::saturate;
#endif
};
