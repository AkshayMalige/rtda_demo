#include "graph.h"
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

NeuralNetworkGraph g;

#if defined(__AIESIM__) || defined(__X86SIM__)
int main() {
  g.init();

  // Load weights from file for RTP
  std::string weight_file = std::string(DATA_DIR) + "/" + EMBED_DENSE0_WEIGHTS;
  std::ifstream file(weight_file);
  std::vector<float> weights;
  float weight;

  if (!file.is_open()) {
    std::cerr << "\n\n!!!!!!Error: Could not open weight file " << weight_file << "!!!!!!!!\\n" << std::endl;
    return -1;
  }

  while (file >> weight && weights.size() < EMBED_DENSE0_WEIGHTS_SIZE) {
    weights.push_back(weight);
  }
  file.close();

  if (weights.size() != EMBED_DENSE0_WEIGHTS_SIZE) {
    std::cerr << "Error: Expected " << EMBED_DENSE0_WEIGHTS_SIZE << " weights, got " << weights.size() << std::endl;
    return -1;
  }

  // Update RTP with weight data
  g.update(g.matrixA_rtp, weights.data(), EMBED_DENSE0_WEIGHTS_SIZE);

  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
