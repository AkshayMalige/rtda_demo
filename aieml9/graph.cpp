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

  // Load and update embed dense0 weights
  {
    const auto dense0Weights = loadWeights(basePath + EMBED_DENSE0_WEIGHTS, EMBED_DENSE0_WEIGHTS_SIZE);
    if (dense0Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_embed0_rtp,
             dense0Weights.data(),
             EMBED_DENSE0_WEIGHTS_SIZE);
  }

  // Load and update embed dense0 bias
  {
    const auto bias = loadWeights(basePath + EMBED_DENSE0_BIAS, EMBED_DENSE0_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_embed0_rtp,
             bias.data(),
             EMBED_DENSE0_BIAS_SIZE);
  }

  // Load and update embed dense1 weights for each cascade
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER2; ++cascIdx) {
    const std::string weightPath = basePath + EMBED_DENSE1_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense1Weights = loadWeights(weightPath, EMBED_DENSE1_WEIGHTS_PART_SIZE);
    if (dense1Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_embed1_rtp[cascIdx],
             dense1Weights.data(),
             EMBED_DENSE1_WEIGHTS_PART_SIZE);
  }

  // Load and update embed dense1 bias
  {
    const auto bias = loadWeights(basePath + EMBED_DENSE1_BIAS, EMBED_DENSE1_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_embed1_rtp,
             bias.data(),
             EMBED_DENSE1_BIAS_SIZE);
  }

  // Load and update solver dense0 weights for each cascade leg
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER3; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense0Weights = loadWeights(weightPath, SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE);
    if (dense0Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_solver0_rtp[cascIdx],
             dense0Weights.data(),
             SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE);
  }

  // Load and update solver dense0 bias
  {
    const auto bias = loadWeights(basePath + SUBSOLVER0_DENSE0_BIAS, SUBSOLVER0_DENSE0_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_solver0_rtp,
             bias.data(),
             SUBSOLVER0_DENSE0_BIAS_SIZE);
  }

  // Load and update solver dense1 weights for each cascade leg
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER2; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE1_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense1Weights = loadWeights(weightPath, SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE);
    if (dense1Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_solver1_rtp[cascIdx],
             dense1Weights.data(),
             SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE);
  }

  // Load and update solver dense1 bias
  {
    const auto bias = loadWeights(basePath + SUBSOLVER0_DENSE1_BIAS, SUBSOLVER0_DENSE1_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_solver1_rtp,
             bias.data(),
             SUBSOLVER0_DENSE1_BIAS_SIZE);
  }

  // Load and update solver dense2 weights for each cascade leg
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER2; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE2_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense2Weights = loadWeights(weightPath, SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE);
    if (dense2Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_solver2_rtp[cascIdx],
             dense2Weights.data(),
             SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE);
  }

  // Load and update solver dense2 bias
  {
    const auto bias = loadWeights(basePath + SUBSOLVER0_DENSE2_BIAS, SUBSOLVER0_DENSE2_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_solver2_rtp,
             bias.data(),
             SUBSOLVER0_DENSE2_BIAS_SIZE);
  }

  // Load and update solver dense3 weights for each cascade leg
  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER2; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE3_WEIGHTS_PREFIX + std::to_string(cascIdx) + ".txt";
    const auto dense3Weights = loadWeights(weightPath, SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE);
    if (dense3Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_solver3_rtp[cascIdx],
             dense3Weights.data(),
             SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE);
  }

  // Load and update solver dense3 bias
  {
    const auto bias = loadWeights(basePath + SUBSOLVER0_DENSE3_BIAS, SUBSOLVER0_DENSE3_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_solver3_rtp,
             bias.data(),
             SUBSOLVER0_DENSE3_BIAS_SIZE);
  }

  // Load and update output dense weights
  {
    const auto denseWeights = loadWeights(basePath + OUTPUT_DENSE0_WEIGHTS, OUTPUT_DENSE0_WEIGHTS_SIZE);
    if (denseWeights.empty()) {
      return -1;
    }
    g.update(g.matrixA_output0_rtp,
             denseWeights.data(),
             OUTPUT_DENSE0_WEIGHTS_SIZE);
  }

  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
