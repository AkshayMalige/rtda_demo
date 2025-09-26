#include "graph.h"
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

  for (const auto& layer : g.dense_layers()) {
    if (layer.port_count == 0) {
      continue;
    }

    if (!layer.weight_file.empty()) {
      const std::string weightPath = basePath + std::string(layer.weight_file);
      const auto        weights = loadWeights(weightPath, layer.weights_per_port);
      if (weights.empty()) {
        return -1;
      }
      g.update(layer.ports[0], weights.data(), layer.weights_per_port);
      continue;
    }

    if (!layer.weight_prefix.empty()) {
      for (std::size_t portIdx = 0; portIdx < layer.port_count; ++portIdx) {
        const std::string weightPath = basePath + std::string(layer.weight_prefix) +
                                       std::to_string(portIdx) + ".txt";
        const auto weights = loadWeights(weightPath, layer.weights_per_port);
        if (weights.empty()) {
          return -1;
        }
        g.update(layer.ports[portIdx], weights.data(), layer.weights_per_port);
      }
      continue;
    }

    std::cerr << "Warning: dense layer '" << layer.name
              << "' has no weight source configured" << std::endl;
  }

  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
