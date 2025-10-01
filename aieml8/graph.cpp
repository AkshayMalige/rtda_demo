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

  // Load and update dense0 weights
  {
    const auto dense0Weights = loadWeights(basePath + OUTPUT_DENSE0_WEIGHTS, OUTPUT_DENSE0_WEIGHTS_SIZE);
    if (dense0Weights.empty()) {
      return -1;
    }
    g.update(g.matrixA_dense0_rtp, dense0Weights.data(), OUTPUT_DENSE0_WEIGHTS_SIZE);
  }



  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
