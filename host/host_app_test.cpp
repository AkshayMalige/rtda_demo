#include <cassert>
#include <cstring>
#include <fstream>
#include <iostream>
#include <vector>
#include <string>

#include "weights_bus.hpp"
#include "../pl/bus_ids.hpp"
#include "../common/data_paths.h"

static std::vector<float> read_file_to_vector(const std::string& fn, int count) {
  std::vector<float> vals;
  std::ifstream file(fn);
  float v;
  for (int i = 0; i < count && (file >> v); ++i)
    vals.push_back(v);
  return vals;
}

int main() {
  auto data = read_file_to_vector(std::string(DATA_DIR) + "/" + EMBED_INPUT_DATA, 3);
  std::vector<std::uint32_t> words;
  append_packet(words, data, bus::DIN, KIND_INPUT);
  for (float f : data)
    std::cout << f << "\n";
  std::cout << "Words: " << words.size() << std::endl;
  assert(words.size() == 4 + data.size());
  return 0;
}
