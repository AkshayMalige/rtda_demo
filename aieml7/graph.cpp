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
  auto loadWeights = [](const std::string& path, std::size_t expectedCount) -> std::vector<float> {
    std::ifstream file(path);
    if (!file.is_open()) {
      std::cerr << "Error: Could not open weight file '" << path << "'" << std::endl;
      return {};
    }

    std::vector<float> weights;
    weights.reserve(expectedCount);
    float value = 0.0f;
    while (file >> value) {
      weights.push_back(value);
    }

    if (weights.size() != expectedCount) {
      std::cerr << "Error: Expected " << expectedCount << " weights from '" << path
                << "', got " << weights.size() << std::endl;
      return {};
    }
    return weights;
  };

  g.init();

  const std::string basePath = std::string(DATA_DIR) + "/";


  // Load and update dense0 weights for each cascade leg
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER3; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense0Weights = loadWeights(weightPath, SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE);
    if (dense0Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_dense0_rtp[cascIdx],
             dense0Weights.data(),
             SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE);
  }

  // Load and update dense0 bias
  {
    const auto bias = loadWeights(basePath + SUBSOLVER0_DENSE0_BIAS, SUBSOLVER0_DENSE0_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_dense0_rtp,
             bias.data(),
             SUBSOLVER0_DENSE0_BIAS_SIZE);
  }

  // Load and update dense1 weights for each cascade leg
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER2; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE1_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense1Weights = loadWeights(weightPath, SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE);
    if (dense1Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_dense1_rtp[cascIdx],
             dense1Weights.data(),
             SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE);
  }

  // Load and update dense1 bias
  {
    const auto bias = loadWeights(basePath + SUBSOLVER0_DENSE1_BIAS, SUBSOLVER0_DENSE1_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_dense1_rtp,
             bias.data(),
             SUBSOLVER0_DENSE1_BIAS_SIZE);
  }

  // Load and update dense2 weights for each cascade leg
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER2; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE2_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense2Weights = loadWeights(weightPath, SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE);
    if (dense2Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_dense2_rtp[cascIdx],
             dense2Weights.data(),
             SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE);
  }

  // Load and update dense2 bias
  {
    const auto bias = loadWeights(basePath + SUBSOLVER0_DENSE2_BIAS, SUBSOLVER0_DENSE2_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_dense2_rtp,
             bias.data(),
             SUBSOLVER0_DENSE2_BIAS_SIZE);
  }

  // Load and update dense3 weights for each cascade leg
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER2; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE3_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense3Weights = loadWeights(weightPath, SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE);
    if (dense3Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_dense3_rtp[cascIdx],
             dense3Weights.data(),
             SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE);
  }

  // Load and update dense3 bias
  {
    const auto bias = loadWeights(basePath + SUBSOLVER0_DENSE3_BIAS, SUBSOLVER0_DENSE3_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_dense3_rtp,
             bias.data(),
             SUBSOLVER0_DENSE3_BIAS_SIZE);
  }

  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
