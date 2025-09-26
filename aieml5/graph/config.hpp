#pragma once

#include <array>
#include <cstddef>

#include "data_paths.h"
#include "graph/types.hpp"
#include "nn_defs.h"

namespace aieml5::graph::config {

struct StageDescriptor {
  StageKind    kind;
  const char*  name;
  int          fanout;
  int          cascade;
  int          rtp_ports;
  int          frame_elems;
};

struct DenseWeightDescriptor {
  std::size_t  stage_index;
  const char*  single_file;
  const char*  file_prefix;
  std::size_t  weights_per_port;
};

constexpr std::array<StageDescriptor, 5> kStageDescriptors = {{
    {StageKind::PacketFanout, "ingress_packet", 1, 0, 0, EMBED_DENSE0_INPUT_SIZE},
    {StageKind::Dense, "dense0", 1, 1, 1, 0},
    {StageKind::Activation, "activation0", 1, 0, 0, 0},
    {StageKind::PacketFanout, "hidden_packet_fanout", CASCADE_LENGTH, 0, 0, HIDDEN_SIZE},
    {StageKind::Dense, "dense1", 1, CASCADE_LENGTH, CASCADE_LENGTH, 0},
}};

constexpr std::array<DenseWeightDescriptor, 2> kDenseWeights = {{
    {1, EMBED_DENSE0_WEIGHTS, nullptr, EMBED_DENSE0_WEIGHTS_SIZE},
    {4, nullptr, EMBED_DENSE1_WEIGHTS_PREFIX, EMBED_DENSE1_WEIGHTS_PART_SIZE},
}};

constexpr std::size_t DenseStageCount = [] {
  std::size_t count = 0;
  for (const auto& stage : kStageDescriptors) {
    if (stage.kind == StageKind::Dense) {
      ++count;
    }
  }
  return count;
}();

constexpr std::size_t DensePortCount = [] {
  std::size_t total = 0;
  for (const auto& stage : kStageDescriptors) {
    if (stage.kind == StageKind::Dense) {
      total += static_cast<std::size_t>(stage.cascade);
    }
  }
  return total;
}();

constexpr const DenseWeightDescriptor* find_dense_weight(std::size_t stage_index) {
  for (const auto& entry : kDenseWeights) {
    if (entry.stage_index == stage_index) {
      return &entry;
    }
  }
  return nullptr;
}

}  // namespace aieml5::graph::config
