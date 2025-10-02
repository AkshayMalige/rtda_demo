#include "graph.h"
#include "data_paths.h"
#include "nn_defs.h"
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

NeuralNetworkGraph g;

#if defined(__AIESIM__) || defined(__X86SIM__)
namespace {

bool appendPart(const std::string& path,
                std::size_t expectedCount,
                std::vector<float>& stream) {
  std::ifstream file(path);
  if (!file.is_open()) {
    std::cerr << "Error: Could not open file '" << path << "'" << std::endl;
    return false;
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
    return false;
  }

  stream.insert(stream.end(), values.begin(), values.end());
  return true;
}

bool writeStream(const std::string& path, const std::vector<float>& data) {
  std::ofstream out(path);
  if (!out.is_open()) {
    std::cerr << "Error: Could not open output stream '" << path << "'" << std::endl;
    return false;
  }

  for (float value : data) {
    out << value << '\n';
  }
  return true;
}

} // namespace

int main() {
  const std::string basePath = std::string(DATA_DIR) + "/";
  const std::string weightsStreamPath = basePath + SUBSOLVER0_DENSE_WEIGHTS_STREAM;
  const std::string biasStreamPath = basePath + SUBSOLVER0_DENSE_BIASES_STREAM;

  std::vector<float> weightStream;
  weightStream.reserve(TOTAL_WEIGHT_FLOATS);
  std::vector<float> biasStream;
  biasStream.reserve(TOTAL_BIAS_FLOATS);

  for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER3; ++cascIdx) {
    const std::string weightPath = basePath + SUBSOLVER0_DENSE0_WEIGHTS_PREFIX +
                                   std::to_string(cascIdx) + ".txt";
    if (!appendPart(weightPath, SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE, weightStream)) {
      return -1;
    }
  }

  auto appendLayer = [&](const std::string& prefix, std::size_t expectedCount) -> bool {
    for (int cascIdx = 0; cascIdx < TP_CASC_LEN_LAYER2; ++cascIdx) {
      const std::string weightPath = basePath + prefix + std::to_string(cascIdx) + ".txt";
      if (!appendPart(weightPath, expectedCount, weightStream)) {
        return false;
      }
    }
    return true;
  };

  if (!appendLayer(SUBSOLVER0_DENSE1_WEIGHTS_PREFIX, SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE)) {
    return -1;
  }
  if (!appendLayer(SUBSOLVER0_DENSE2_WEIGHTS_PREFIX, SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE)) {
    return -1;
  }
  if (!appendLayer(SUBSOLVER0_DENSE3_WEIGHTS_PREFIX, SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE)) {
    return -1;
  }

  if (weightStream.size() != TOTAL_WEIGHT_FLOATS) {
    std::cerr << "Error: concatenated weight stream size mismatch (expected "
              << TOTAL_WEIGHT_FLOATS << ", got " << weightStream.size() << ")" << std::endl;
    return -1;
  }

  if (!appendPart(basePath + SUBSOLVER0_DENSE0_BIAS, SUBSOLVER0_DENSE0_BIAS_SIZE, biasStream)) {
    return -1;
  }
  if (!appendPart(basePath + SUBSOLVER0_DENSE1_BIAS, SUBSOLVER0_DENSE1_BIAS_SIZE, biasStream)) {
    return -1;
  }
  if (!appendPart(basePath + SUBSOLVER0_DENSE2_BIAS, SUBSOLVER0_DENSE2_BIAS_SIZE, biasStream)) {
    return -1;
  }
  if (!appendPart(basePath + SUBSOLVER0_DENSE3_BIAS, SUBSOLVER0_DENSE3_BIAS_SIZE, biasStream)) {
    return -1;
  }

  if (biasStream.size() != TOTAL_BIAS_FLOATS) {
    std::cerr << "Error: concatenated bias stream size mismatch (expected "
              << TOTAL_BIAS_FLOATS << ", got " << biasStream.size() << ")" << std::endl;
    return -1;
  }

  if (!writeStream(weightsStreamPath, weightStream)) {
    return -1;
  }
  if (!writeStream(biasStreamPath, biasStream)) {
    return -1;
  }

  g.init();
  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
