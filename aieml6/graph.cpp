#include "graph.h"
#include "data_paths.h"
#include "nn_defs.h"

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

  {
    const auto bias = loadWeights("/home/synthara/VersalPrjs/LDRD/rtda_demo/data/embed_dense_0_bias.txt", EMBED_DENSE0_BIAS_SIZE);
    if (bias.empty()) {
      return -1;
    }
    g.update(g.bias_dense0_rtp,
             bias.data(),
             EMBED_DENSE0_BIAS_SIZE);
  }

  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif