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
  auto loadBias = [](const std::string& path, std::size_t expectedCount) -> std::vector<float> {
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


  // Load and update dense0 bias
  {
    const auto bias = loadBias(basePath + SUBSOLVER0_DENSE0_BIAS, SUBSOLVER0_DENSE0_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_dense0_rtp,
             bias.data(),
             SUBSOLVER0_DENSE0_BIAS_SIZE);
  }

  // Load and update dense1 bias
  {
    const auto bias = loadBias(basePath + SUBSOLVER0_DENSE1_BIAS, SUBSOLVER0_DENSE1_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_dense1_rtp,
             bias.data(),
             SUBSOLVER0_DENSE1_BIAS_SIZE);
  }


  // Load and update dense2 bias
  {
    const auto bias = loadBias(basePath + SUBSOLVER0_DENSE2_BIAS, SUBSOLVER0_DENSE2_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_dense2_rtp,
             bias.data(),
             SUBSOLVER0_DENSE2_BIAS_SIZE);
  }
  // Load and update dense3 bias
  {
    const auto bias = loadBias(basePath + SUBSOLVER0_DENSE3_BIAS, SUBSOLVER0_DENSE3_BIAS_SIZE);
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
