#include "graph.h"
#include "data_paths.h"
#include "nn_defs.h"
#include <fstream>
#include <iomanip>
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

  const std::string basePath = std::string(DATA_DIR) + "/";


  const std::string weightStreamPath = basePath + SUBSOLVER0_WEIGHT_STREAM;
  const std::string biasStreamPath = basePath + SUBSOLVER0_BIAS_STREAM;

  std::ofstream weightStream(weightStreamPath);
  if (!weightStream.is_open()) {
    std::cerr << "Error: Could not open weight stream file '" << weightStreamPath << "'" << std::endl;
    return -1;
  }

  std::ofstream biasStream(biasStreamPath);
  if (!biasStream.is_open()) {
    std::cerr << "Error: Could not open bias stream file '" << biasStreamPath << "'" << std::endl;
    return -1;
  }

  weightStream << std::setprecision(10);
  biasStream << std::setprecision(10);

  auto appendValues = [](std::ofstream& stream, const std::vector<float>& payload) {
    for (const float value : payload) {
      stream << value << '\n';
    }
  };

  auto appendWeightParts = [&](const std::string& prefix, int cascLen, std::size_t partSize) -> bool {
    for (int cascIdx = 0; cascIdx < cascLen; ++cascIdx) {
      const std::string weightPath = basePath + prefix + std::to_string(cascIdx) + ".txt";
      const auto weights = loadWeights(weightPath, partSize);
      if (weights.empty()) {
        return false;
      }
      appendValues(weightStream, weights);
    }
    return true;
  };

  if (!appendWeightParts(SUBSOLVER0_DENSE0_WEIGHTS_PREFIX, TP_CASC_LEN_LAYER3,
                         SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE)) {
    return -1;
  }

  if (!appendWeightParts(SUBSOLVER0_DENSE1_WEIGHTS_PREFIX, TP_CASC_LEN_LAYER2,
                         SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE)) {
    return -1;
  }

  if (!appendWeightParts(SUBSOLVER0_DENSE2_WEIGHTS_PREFIX, TP_CASC_LEN_LAYER2,
                         SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE)) {
    return -1;
  }

  if (!appendWeightParts(SUBSOLVER0_DENSE3_WEIGHTS_PREFIX, TP_CASC_LEN_LAYER2,
                         SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE)) {
    return -1;
  }

  auto appendBias = [&](const std::string& path, std::size_t expected) -> bool {
    const auto bias = loadWeights(basePath + path, expected);
    if (bias.empty()) {
      return false;
    }
    appendValues(biasStream, bias);
    return true;
  };

  if (!appendBias(SUBSOLVER0_DENSE0_BIAS, SUBSOLVER0_DENSE0_BIAS_SIZE) ||
      !appendBias(SUBSOLVER0_DENSE1_BIAS, SUBSOLVER0_DENSE1_BIAS_SIZE) ||
      !appendBias(SUBSOLVER0_DENSE2_BIAS, SUBSOLVER0_DENSE2_BIAS_SIZE) ||
      !appendBias(SUBSOLVER0_DENSE3_BIAS, SUBSOLVER0_DENSE3_BIAS_SIZE)) {
    return -1;
  }

  weightStream.close();
  biasStream.close();

  g.init();
  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
