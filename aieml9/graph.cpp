#include "graph.h"
#include "data_paths.h"
#include "nn_defs.h"
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

NeuralNetworkGraph g;

#if defined(__AIESIM__) || defined(__X86SIM__)
int main() {
  auto loadValues = [](const std::string& path, std::size_t expectedCount) -> std::vector<float> {
    std::ifstream file(path);
    if (!file.is_open()) {
      std::cerr << "Error: Could not open file '" << path << "'" << std::endl;
      return {};
    }

    std::vector<float> values;
    values.reserve(expectedCount);
    float value = 0.0f;
    while (file >> value) {
      values.push_back(value);
    }

    if (values.size() != expectedCount) {
      std::cerr << "Error: Expected " << expectedCount << " values from '" << path
                << "', got " << values.size() << std::endl;
      return {};
    }
    return values;
  };

  g.init();
  const std::string basePath = std::string(DATA_DIR) + "/";

  // Stage 1 weights and bias updates ---------------------------------------
  {
    const auto weights = loadValues(basePath + EMBED_DENSE0_WEIGHTS, EMBED_DENSE0_WEIGHTS_SIZE);
    if (weights.empty()) {
      return -1;
    }
    g.update(g.embed_matrixA_rtp, weights.data(), EMBED_DENSE0_WEIGHTS_SIZE);
  }

  {
    const auto bias = loadValues(basePath + EMBED_DENSE0_BIAS, EMBED_DENSE0_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.embed_bias0_rtp, bias.data(), EMBED_DENSE0_BIAS_SIZE);
  }

  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_STAGE1_LAYER1; ++cascIdx) {
    const std::string weightPath = basePath + EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto weights = loadValues(weightPath, EMBED_DENSE1_WEIGHTS_PART_SIZE);
    if (weights.empty()) {
      return -1;
    }
    g.update(g.embed_matrixA1_rtp[cascIdx], weights.data(), EMBED_DENSE1_WEIGHTS_PART_SIZE);
  }

  {
    const auto bias = loadValues(basePath + EMBED_DENSE1_BIAS, EMBED_DENSE1_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.embed_bias1_rtp, bias.data(), EMBED_DENSE1_BIAS_SIZE);
  }

  // Stage 2 bias updates ----------------------------------------------------
  {
    const auto bias = loadValues(basePath + SUBSOLVER0_DENSE0_BIAS, SUBSOLVER0_DENSE0_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.solver_bias0_rtp, bias.data(), SUBSOLVER0_DENSE0_BIAS_SIZE);
  }

  {
    const auto bias = loadValues(basePath + SUBSOLVER0_DENSE1_BIAS, SUBSOLVER0_DENSE1_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.solver_bias1_rtp, bias.data(), SUBSOLVER0_DENSE1_BIAS_SIZE);
  }

  {
    const auto bias = loadValues(basePath + SUBSOLVER0_DENSE2_BIAS, SUBSOLVER0_DENSE2_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.solver_bias2_rtp, bias.data(), SUBSOLVER0_DENSE2_BIAS_SIZE);
  }

  {
    const auto bias = loadValues(basePath + SUBSOLVER0_DENSE3_BIAS, SUBSOLVER0_DENSE3_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.solver_bias3_rtp, bias.data(), SUBSOLVER0_DENSE3_BIAS_SIZE);
  }

  // Stage 3 weight updates --------------------------------------------------
  {
    const auto weights = loadValues(basePath + OUTPUT_DENSE0_WEIGHTS, OUTPUT_DENSE0_WEIGHTS_SIZE);
    if (weights.empty()) {
      return -1;
    }
    g.update(g.output_matrixA_rtp, weights.data(), OUTPUT_DENSE0_WEIGHTS_SIZE);
  }

  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
