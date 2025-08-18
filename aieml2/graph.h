#pragma once
#include <adf.h>
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "include.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

// =============================================================================
// Automatic Cascade Length Calculator (unchanged)
// =============================================================================
namespace aie_params {
static constexpr unsigned int AIE_ML_MEM_SIZE_BYTES = 64 * 1024;

constexpr unsigned int calculate_casc_len(
    unsigned int dim_m,
    unsigned int dim_k,
    unsigned int sizeof_data_type) {
  unsigned long long numerator = 2ULL * dim_m * dim_k * sizeof_data_type;
  unsigned int min_len = (numerator + AIE_ML_MEM_SIZE_BYTES - 1) / AIE_ML_MEM_SIZE_BYTES;
  unsigned int best_len = dim_k;
  for (unsigned int i = min_len; i <= dim_k; ++i) {
    if (dim_k % i == 0) { best_len = i; break; }
  }
  return best_len;
}
} // namespace aie_params

// =============================================================================
// Graph Configuration (mostly unchanged)
// =============================================================================
static constexpr unsigned int M = 128; // Output Size for 768x128
static constexpr unsigned int K = 768; // Input  Size for 768x128

static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;

// --- AUTO-CALCULATED CASCADE LENGTHS ---
static constexpr unsigned int TP_CASC_LEN_768 = aie_params::calculate_casc_len(M, K, sizeof(float));
// Assumes OUTPUT_SIZE == 128 and HIDDEN_SIZE == 128 are provided by include.h (as in your code)
static constexpr unsigned int TP_CASC_LEN_128 = aie_params::calculate_casc_len(OUTPUT_SIZE, HIDDEN_SIZE, sizeof(float));

// Kernels
using dense768x128 = matrix_vector_mul_graph<
    float, float,
    M, K,
    TP_SHIFT, TP_RND, TP_NUM_FRAMES, TP_CASC_LEN_768, TP_SAT, TP_SSR, TP_DIM_A_LEADING>;

using dense128x128 = matrix_vector_mul_graph<
    float, float,
    OUTPUT_SIZE, HIDDEN_SIZE,
    TP_SHIFT, TP_RND, TP_NUM_FRAMES, TP_CASC_LEN_128, TP_SAT, TP_SSR, TP_DIM_A_LEADING>;

// =============================================================================
// Graph: 768x128 -> 128x128 -> 128x128 -> 128x128
// Each layer reads inputs/weights from files via PLIO (as you requested).
// =============================================================================
class NeuralNetworkGraph : public graph {
public:
  // Layer 1: 768x128
  input_plio  pl_in_768[TP_CASC_LEN_768];
  input_plio  pl_w_768[TP_CASC_LEN_768];
  output_plio pl_out_768;

  // Layer 2: 128x128
  input_plio  pl_in_128_L2[TP_CASC_LEN_128];
  input_plio  pl_w_128_L2[TP_CASC_LEN_128];
  output_plio pl_out_128_L2;

  // Layer 3: 128x128 (NEW)
  input_plio  pl_in_128_L3[TP_CASC_LEN_128];
  input_plio  pl_w_128_L3[TP_CASC_LEN_128];
  output_plio pl_out_128_L3;

  // Layer 4: 128x128 (NEW)
  input_plio  pl_in_128_L4[TP_CASC_LEN_128];
  input_plio  pl_w_128_L4[TP_CASC_LEN_128];
  output_plio pl_out_128_L4;

  // Kernels
  dense768x128 dense768;
  dense128x128 dense128_L2;
  dense128x128 dense128_L3;
  dense128x128 dense128_L4;

  NeuralNetworkGraph() {
    std::string base_path = DATA_DIR;

    // ----------------------------
    // Layer 1: 768x128
    // Inputs: SUBSOLVER0_INPUT_DATA_PREFIX{i}.txt
    // Weights: SUBSOLVER0_DENSE0_WEIGHTS_PREFIX{i}.txt
    // Output: SUBSOLVER0_DENSE0_OUTPUT
    // ----------------------------
    for (int i = 0; i < (int)TP_CASC_LEN_768; ++i) {
      std::string in_file = base_path + "/" + SUBSOLVER0_INPUT_DATA_PREFIX        + std::to_string(i) + ".txt";
      std::string w_file  = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX    + std::to_string(i) + ".txt";
      pl_in_768[i] = input_plio::create( ("plio_in_768_" + std::to_string(i)).c_str(), plio_32_bits, in_file.c_str() );
      pl_w_768[i]  = input_plio::create( ("plio_w_768_"  + std::to_string(i)).c_str(), plio_32_bits, w_file.c_str() );
      connect<>(pl_in_768[i].out[0], dense768.inB[i]);
      connect<>(pl_w_768[i].out[0],  dense768.inA[i]);
    }
    pl_out_768 = output_plio::create("plio_out_768", plio_32_bits,
                                     (base_path + "/" + SUBSOLVER0_DENSE0_OUTPUT).c_str());
    connect<>(dense768.out[0], pl_out_768.in[0]);

    // ----------------------------
    // Layer 2: 128x128
    // Inputs: SUBSOLVER0_LEAKYRELU_0_PREFIX{i}.txt
    // Weights: SUBSOLVER0_DENSE1_WEIGHTS_PREFIX{i}.txt
    // Output: SUBSOLVER0_DENSE1_OUTPUT
    // ----------------------------
    for (int i = 0; i < (int)TP_CASC_LEN_128; ++i) {
      std::string in_file = base_path + "/" + SUBSOLVER0_LEAKYRELU_0_PREFIX       + std::to_string(i) + ".txt";
      std::string w_file  = base_path + "/" + SUBSOLVER0_DENSE1_WEIGHTS_PREFIX    + std::to_string(i) + ".txt";
      pl_in_128_L2[i] = input_plio::create( ("plio_in_128_L2_" + std::to_string(i)).c_str(), plio_32_bits, in_file.c_str() );
      pl_w_128_L2[i]  = input_plio::create( ("plio_w_128_L2_"  + std::to_string(i)).c_str(), plio_32_bits, w_file.c_str() );
      connect<>(pl_in_128_L2[i].out[0], dense128_L2.inB[i]);
      connect<>(pl_w_128_L2[i].out[0],  dense128_L2.inA[i]);
    }
    pl_out_128_L2 = output_plio::create("plio_out_128_L2", plio_32_bits,
                                        (base_path + "/" + SUBSOLVER0_DENSE1_OUTPUT).c_str());
    connect<>(dense128_L2.out[0], pl_out_128_L2.in[0]);

    // ----------------------------
    // Layer 3: 128x128 (NEW)
    // Inputs: SUBSOLVER0_LEAKYRELU_1_PREFIX{i}.txt     <-- define in include.h if not present
    // Weights: SUBSOLVER0_DENSE2_WEIGHTS_PREFIX{i}.txt <-- define in include.h if not present
    // Output: SUBSOLVER0_DENSE2_OUTPUT                 <-- define in include.h if not present
    // ----------------------------
    for (int i = 0; i < (int)TP_CASC_LEN_128; ++i) {
      std::string in_file = base_path + "/" + SUBSOLVER0_LEAKYRELU_1_PREFIX       + std::to_string(i) + ".txt";
      std::string w_file  = base_path + "/" + SUBSOLVER0_DENSE2_WEIGHTS_PREFIX    + std::to_string(i) + ".txt";
      pl_in_128_L3[i] = input_plio::create( ("plio_in_128_L3_" + std::to_string(i)).c_str(), plio_32_bits, in_file.c_str() );
      pl_w_128_L3[i]  = input_plio::create( ("plio_w_128_L3_"  + std::to_string(i)).c_str(), plio_32_bits, w_file.c_str() );
      connect<>(pl_in_128_L3[i].out[0], dense128_L3.inB[i]);
      connect<>(pl_w_128_L3[i].out[0],  dense128_L3.inA[i]);
    }
    pl_out_128_L3 = output_plio::create("plio_out_128_L3", plio_32_bits,
                                        (base_path + "/" + SUBSOLVER0_DENSE2_OUTPUT).c_str());
    connect<>(dense128_L3.out[0], pl_out_128_L3.in[0]);

    // ----------------------------
    // Layer 4: 128x128 (NEW)
    // Inputs: SUBSOLVER0_LEAKYRELU_2_PREFIX{i}.txt     <-- define in include.h if not present
    // Weights: SUBSOLVER0_DENSE3_WEIGHTS_PREFIX{i}.txt <-- define in include.h if not present
    // Output: SUBSOLVER0_DENSE3_OUTPUT                 <-- define in include.h if not present
    // ----------------------------
    for (int i = 0; i < (int)TP_CASC_LEN_128; ++i) {
      std::string in_file = base_path + "/" + SUBSOLVER0_LEAKYRELU_2_PREFIX       + std::to_string(i) + ".txt";
      std::string w_file  = base_path + "/" + SUBSOLVER0_DENSE3_WEIGHTS_PREFIX    + std::to_string(i) + ".txt";
      pl_in_128_L4[i] = input_plio::create( ("plio_in_128_L4_" + std::to_string(i)).c_str(), plio_32_bits, in_file.c_str() );
      pl_w_128_L4[i]  = input_plio::create( ("plio_w_128_L4_"  + std::to_string(i)).c_str(), plio_32_bits, w_file.c_str() );
      connect<>(pl_in_128_L4[i].out[0], dense128_L4.inB[i]);
      connect<>(pl_w_128_L4[i].out[0],  dense128_L4.inA[i]);
    }
    pl_out_128_L4 = output_plio::create("plio_out_128_L4", plio_32_bits,
                                        (base_path + "/" + SUBSOLVER0_DENSE3_OUTPUT).c_str());
    connect<>(dense128_L4.out[0], pl_out_128_L4.in[0]);
  }
};
