#pragma once
#include <adf.h>
#include "data_paths.h"
#include "matrix_vector_mul_graph.hpp"
#include "aie_api/aie_adf.hpp"
#include "nn_defs.h"
#if USE_PRELOADED_WEIGHTS
#include <array>
#endif

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
// Assumes OUTPUT_SIZE == 128 and HIDDEN_SIZE == 128 are provided by nn_defs.h (as in your code)
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
  // Layer 0: 768x128
  input_plio  layer0_in[TP_CASC_LEN_768];
  output_plio layer0_out;

  // Layer 1: 128x128
  input_plio  layer1_in[TP_CASC_LEN_128];
  output_plio layer1_out;

  // Layer 2: 128x128 (NEW)
  input_plio  layer2_in[TP_CASC_LEN_128];
  output_plio layer2_out;

  // Layer 3: 128x128 (NEW)
  input_plio  layer3_in[TP_CASC_LEN_128];
  output_plio layer3_out;

  // Kernels
  dense768x128 dense768;
  dense128x128 dense128_L2;
  dense128x128 dense128_L3;
  dense128x128 dense128_L4;

#if !USE_PRELOADED_WEIGHTS
  input_plio  layer0_weights[TP_CASC_LEN_768];
  input_plio  layer1_weights[TP_CASC_LEN_128];
  input_plio  layer2_weights[TP_CASC_LEN_128];
  input_plio  layer3_weights[TP_CASC_LEN_128];
#else
  // Local weight buffers
  adf::parameter::array<float, SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE> layer0_weights[TP_CASC_LEN_768];
  adf::parameter::array<float, SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE> layer1_weights[TP_CASC_LEN_128];
  adf::parameter::array<float, SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE> layer2_weights[TP_CASC_LEN_128];
  adf::parameter::array<float, SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE> layer3_weights[TP_CASC_LEN_128];
  input_port weight_stream;

  void init_weights() {
    for (int p = 0; p < (int)TP_CASC_LEN_768; ++p)
      for (float &w : layer0_weights[p]) { w = weight_stream.read(); }
    for (int p = 0; p < (int)TP_CASC_LEN_128; ++p)
      for (float &w : layer1_weights[p]) { w = weight_stream.read(); }
    for (int p = 0; p < (int)TP_CASC_LEN_128; ++p)
      for (float &w : layer2_weights[p]) { w = weight_stream.read(); }
    for (int p = 0; p < (int)TP_CASC_LEN_128; ++p)
      for (float &w : layer3_weights[p]) { w = weight_stream.read(); }
  }
#endif

  NeuralNetworkGraph() {
    std::string base_path = DATA_DIR;

    // ----------------------------
    // Layer 0: 768x128
    // Inputs: SUBSOLVER0_INPUT_DATA_PREFIX{i}.txt
    // Weights: SUBSOLVER0_DENSE0_WEIGHTS_PREFIX{i}.txt
    // Output: SUBSOLVER0_DENSE0_OUTPUT
    // ----------------------------
    for (int i = 0; i < (int)TP_CASC_LEN_768; ++i) {
      std::string in_file = base_path + "/" + SUBSOLVER0_INPUT_DATA_PREFIX        + std::to_string(i) + ".txt";
      layer0_in[i] = input_plio::create(("layer0_in_" + std::to_string(i)).c_str(), plio_32_bits, in_file.c_str());
#if !USE_PRELOADED_WEIGHTS
        std::string w_file  = base_path + "/" + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX    + std::to_string(i) + ".txt";
        layer0_weights[i] = input_plio::create(("layer0_weights_" + std::to_string(i)).c_str(), plio_32_bits, w_file.c_str());
        connect<>(layer0_weights[i].out[0], dense768.inA[i]);
#else
        connect<parameter>(layer0_weights[i], dense768.inA[i]);
#endif
      connect<>(layer0_in[i].out[0], dense768.inB[i]);
    }
    layer0_out = output_plio::create("layer0_out", plio_32_bits,
                                     (base_path + "/" + SUBSOLVER0_DENSE0_OUTPUT).c_str());
    connect<>(dense768.out[0], layer0_out.in[0]);

    // ----------------------------
    // Layer 1: 128x128
    // Inputs: SUBSOLVER0_LEAKYRELU_0_PREFIX{i}.txt
    // Weights: SUBSOLVER0_DENSE1_WEIGHTS_PREFIX{i}.txt
    // Output: SUBSOLVER0_DENSE1_OUTPUT
    // ----------------------------
    for (int i = 0; i < (int)TP_CASC_LEN_128; ++i) {
      std::string in_file = base_path + "/" + SUBSOLVER0_LEAKYRELU_0_PREFIX       + std::to_string(i) + ".txt";
      layer1_in[i] = input_plio::create(("layer1_in_" + std::to_string(i)).c_str(), plio_32_bits, in_file.c_str());
#if !USE_PRELOADED_WEIGHTS
        std::string w_file  = base_path + "/" + SUBSOLVER0_DENSE1_WEIGHTS_PREFIX    + std::to_string(i) + ".txt";
        layer1_weights[i] = input_plio::create(("layer1_weights_" + std::to_string(i)).c_str(), plio_32_bits, w_file.c_str());
        connect<>(layer1_weights[i].out[0], dense128_L2.inA[i]);
#else
        connect<parameter>(layer1_weights[i], dense128_L2.inA[i]);
#endif
      connect<>(layer1_in[i].out[0], dense128_L2.inB[i]);
    }
    layer1_out = output_plio::create("layer1_out", plio_32_bits,
                                     (base_path + "/" + SUBSOLVER0_DENSE1_OUTPUT).c_str());
    connect<>(dense128_L2.out[0], layer1_out.in[0]);

    // ----------------------------
    // Layer 2: 128x128 (NEW)
    // Inputs: SUBSOLVER0_LEAKYRELU_1_PREFIX{i}.txt     <-- define in nn_defs.h if not present
    // Weights: SUBSOLVER0_DENSE2_WEIGHTS_PREFIX{i}.txt <-- define in nn_defs.h if not present
    // Output: SUBSOLVER0_DENSE2_OUTPUT                 <-- define in nn_defs.h if not present
    // ----------------------------
    for (int i = 0; i < (int)TP_CASC_LEN_128; ++i) {
      std::string in_file = base_path + "/" + SUBSOLVER0_LEAKYRELU_1_PREFIX       + std::to_string(i) + ".txt";
      layer2_in[i] = input_plio::create(("layer2_in_" + std::to_string(i)).c_str(), plio_32_bits, in_file.c_str());
#if !USE_PRELOADED_WEIGHTS
        std::string w_file  = base_path + "/" + SUBSOLVER0_DENSE2_WEIGHTS_PREFIX    + std::to_string(i) + ".txt";
        layer2_weights[i] = input_plio::create(("layer2_weights_" + std::to_string(i)).c_str(), plio_32_bits, w_file.c_str());
        connect<>(layer2_weights[i].out[0], dense128_L3.inA[i]);
#else
        connect<parameter>(layer2_weights[i], dense128_L3.inA[i]);
#endif
      connect<>(layer2_in[i].out[0], dense128_L3.inB[i]);
    }
    layer2_out = output_plio::create("layer2_out", plio_32_bits,
                                     (base_path + "/" + SUBSOLVER0_DENSE2_OUTPUT).c_str());
    connect<>(dense128_L3.out[0], layer2_out.in[0]);

    // ----------------------------
    // Layer 3: 128x128 (NEW)
    // Inputs: SUBSOLVER0_LEAKYRELU_2_PREFIX{i}.txt     <-- define in nn_defs.h if not present
    // Weights: SUBSOLVER0_DENSE3_WEIGHTS_PREFIX{i}.txt <-- define in nn_defs.h if not present
    // Output: SUBSOLVER0_DENSE3_OUTPUT                 <-- define in nn_defs.h if not present
    // ----------------------------
    for (int i = 0; i < (int)TP_CASC_LEN_128; ++i) {
      std::string in_file = base_path + "/" + SUBSOLVER0_LEAKYRELU_2_PREFIX       + std::to_string(i) + ".txt";
      layer3_in[i] = input_plio::create(("layer3_in_" + std::to_string(i)).c_str(), plio_32_bits, in_file.c_str());
#if !USE_PRELOADED_WEIGHTS
        std::string w_file  = base_path + "/" + SUBSOLVER0_DENSE3_WEIGHTS_PREFIX    + std::to_string(i) + ".txt";
        layer3_weights[i] = input_plio::create(("layer3_weights_" + std::to_string(i)).c_str(), plio_32_bits, w_file.c_str());
        connect<>(layer3_weights[i].out[0], dense128_L4.inA[i]);
#else
        connect<parameter>(layer3_weights[i], dense128_L4.inA[i]);
#endif
      connect<>(layer3_in[i].out[0], dense128_L4.inB[i]);
    }
    layer3_out = output_plio::create("layer3_out", plio_32_bits,
                                     (base_path + "/" + SUBSOLVER0_DENSE3_OUTPUT).c_str());
    connect<>(dense128_L4.out[0], layer3_out.in[0]);
  }

  void init() {
    graph::init();
#if USE_PRELOADED_WEIGHTS
    init_weights();
#endif
  }
};

