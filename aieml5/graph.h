#pragma once

#include <adf.h>

#include <array>
#include <string>
#include <string_view>
#include <tuple>
#include <utility>

#include "data_paths.h"
#include "graph/config.hpp"
#include "graph/layers.hpp"
#include "kernels/dense/all.hpp"
#include "nn_defs.h"

using namespace adf;
using namespace xf::dsp::aie::blas::matrix_vector_mul;

static constexpr unsigned int TP_RND = rnd_floor;
static constexpr unsigned int TP_SHIFT = 0;
static constexpr unsigned int TP_NUM_FRAMES = 1;
static constexpr unsigned int TP_SAT = 0;
static constexpr unsigned int TP_SSR = 1;
static constexpr unsigned int TP_DIM_A_LEADING = 1;
static constexpr unsigned int TP_USE_MATRIX_RELOAD = 1;
static constexpr unsigned int TP_API = 1;
static constexpr unsigned int TP_DUAL_IP = 0;
static constexpr unsigned int TP_NUM_OUTPUTS = 1;

using dense8x128 = matrix_vector_mul_graph<
    float,
    float,
    HIDDEN_SIZE,
    INPUT_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    1,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_USE_MATRIX_RELOAD,
    TP_API,
    TP_DUAL_IP,
    TP_NUM_OUTPUTS>;

using dense128x128 = matrix_vector_mul_graph<
    float,
    float,
    OUTPUT_SIZE,
    HIDDEN_SIZE,
    TP_SHIFT,
    TP_RND,
    TP_NUM_FRAMES,
    CASCADE_LENGTH,
    TP_SAT,
    TP_SSR,
    TP_DIM_A_LEADING,
    TP_USE_MATRIX_RELOAD,
    TP_API,
    TP_DUAL_IP,
    TP_NUM_OUTPUTS>;

namespace aieml5::graph::detail {

using IngressPacketStage = PacketFanoutStage<stream_to_packet_kernel, packet_to_stream_kernel, 1>;
using Dense0Stage = DenseLayer<dense8x128, 1>;
using Activation0Stage = ActivationLayer<leaky_relu_kernel>;
using HiddenFanoutStage = PacketFanoutStage<hidden_stream_to_packet_kernel, packet_to_stream_hidden_kernel, CASCADE_LENGTH>;
using Dense1Stage = DenseLayer<dense128x128, CASCADE_LENGTH>;

using StagePipeline = std::tuple<IngressPacketStage, Dense0Stage, Activation0Stage, HiddenFanoutStage, Dense1Stage>;

template <std::size_t Index>
using StageType = std::tuple_element_t<Index, StagePipeline>;

template <typename Func, std::size_t... Indices>
constexpr void for_each_index_impl(std::index_sequence<Indices...>, Func&& func) {
  (func(std::integral_constant<std::size_t, Indices>{}), ...);
}

template <std::size_t Count, typename Func>
constexpr void for_each_index(Func&& func) {
  for_each_index_impl(std::make_index_sequence<Count>{}, std::forward<Func>(func));
}

template <std::size_t Index>
constexpr void validate_stage_descriptor() {
  using Stage = StageType<Index>;
  constexpr auto descriptor = config::kStageDescriptors[Index];
  static_assert(StageTraits<Stage>::kind == descriptor.kind, "Stage type mismatch");
  if constexpr (descriptor.kind == StageKind::PacketFanout) {
    static_assert(StageTraits<Stage>::outputs == static_cast<std::size_t>(descriptor.fanout),
                  "Packet fan-out mismatch");
  } else if constexpr (descriptor.kind == StageKind::Dense) {
    static_assert(StageTraits<Stage>::inputs == static_cast<std::size_t>(descriptor.cascade),
                  "Dense cascade length mismatch");
    static_assert(StageTraits<Stage>::rtp_ports == static_cast<std::size_t>(descriptor.rtp_ports),
                  "Dense RTP port count mismatch");
  }
}

constexpr bool ValidateStages() {
  for_each_index<std::tuple_size_v<StagePipeline>>([](auto index_const) {
    validate_stage_descriptor<index_const>();
  });
  return true;
}

}  // namespace aieml5::graph::detail

static_assert(aieml5::graph::detail::ValidateStages(), "Stage configuration must match descriptors");

struct DenseStageRuntimeInfo {
  std::string_view name;
  input_port*      ports;
  std::size_t      port_count;
  std::string_view weight_file;
  std::string_view weight_prefix;
  std::size_t      weights_per_port;
};

class NeuralNetworkGraph : public graph {
 public:
  NeuralNetworkGraph();

  const std::array<DenseStageRuntimeInfo, aieml5::graph::config::DenseStageCount>& dense_layers() const {
    return dense_layers_;
  }

  input_plio  input_data;
  output_plio output_data;

 private:
  using StagePipeline = aieml5::graph::detail::StagePipeline;
  static constexpr std::size_t StageCount = std::tuple_size_v<StagePipeline>;

  template <std::size_t Index>
  auto& stage() {
    return std::get<Index>(stages_);
  }

  template <std::size_t Index>
  const auto& stage() const {
    return std::get<Index>(stages_);
  }

  template <std::size_t Index>
  void connect_stage_pair();

  void connect_pipeline();
  void initialise_dense_info();

  StagePipeline stages_{};
  std::array<DenseStageRuntimeInfo, aieml5::graph::config::DenseStageCount> dense_layers_{};
};

inline NeuralNetworkGraph::NeuralNetworkGraph() {
  std::string base_path = DATA_DIR;
  input_data = input_plio::create(
      "input_data", plio_32_bits, (base_path + "/" + EMBED_INPUT_DATA).c_str());
  output_data = output_plio::create(
      "output_data", plio_32_bits, (base_path + "/" + EMBED_DENSE1_OUTPUT).c_str());

  using FirstStage = aieml5::graph::detail::StageType<0>;
  connect<stream>(input_data.out[0],
                  aieml5::graph::StageTraits<FirstStage>::input(stage<0>(), 0));

  connect_pipeline();

  using LastStage = aieml5::graph::detail::StageType<StageCount - 1>;
  connect<stream>(
      aieml5::graph::StageTraits<LastStage>::output(stage<StageCount - 1>(), 0),
      output_data.in[0]);

  initialise_dense_info();
}

template <std::size_t Index>
inline void NeuralNetworkGraph::connect_stage_pair() {
  using CurrentStage = aieml5::graph::detail::StageType<Index>;
  using NextStage = aieml5::graph::detail::StageType<Index + 1>;
  auto& current = stage<Index>();
  auto& next = stage<Index + 1>();

  constexpr std::size_t output_count = aieml5::graph::StageTraits<CurrentStage>::outputs;
  constexpr std::size_t input_count = aieml5::graph::StageTraits<NextStage>::inputs;
  static_assert(output_count == input_count, "Adjacent stage interface mismatch");

  for (std::size_t i = 0; i < output_count; ++i) {
    connect<stream>(aieml5::graph::StageTraits<CurrentStage>::output(current, i),
                    aieml5::graph::StageTraits<NextStage>::input(next, i));
  }
}

inline void NeuralNetworkGraph::connect_pipeline() {
  aieml5::graph::detail::for_each_index<StageCount - 1>([this](auto index_const) {
    connect_stage_pair<index_const>();
  });
}

inline void NeuralNetworkGraph::initialise_dense_info() {
  std::size_t dense_index = 0;
  aieml5::graph::detail::for_each_index<StageCount>([&](auto index_const) {
    constexpr std::size_t index = index_const;
    using Stage = aieml5::graph::detail::StageType<index>;
    constexpr auto descriptor = aieml5::graph::config::kStageDescriptors[index];

    if constexpr (aieml5::graph::StageTraits<Stage>::kind == aieml5::graph::StageKind::Dense) {
      auto& stage_instance = stage<index>();
      DenseStageRuntimeInfo info{};
      info.name = descriptor.name;
      info.ports = &aieml5::graph::StageTraits<Stage>::matrix_port(stage_instance, 0);
      info.port_count = aieml5::graph::StageTraits<Stage>::rtp_ports;

      if (const auto* weights = aieml5::graph::config::find_dense_weight(index)) {
        if (weights->single_file != nullptr) {
          info.weight_file = weights->single_file;
        }
        if (weights->file_prefix != nullptr) {
          info.weight_prefix = weights->file_prefix;
        }
        info.weights_per_port = weights->weights_per_port;
      }

      dense_layers_[dense_index++] = info;
    }
  });
}

