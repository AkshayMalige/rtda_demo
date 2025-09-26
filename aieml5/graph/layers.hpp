#pragma once

#include <adf.h>

#include <array>
#include <cstddef>
#include <utility>

#include "graph/types.hpp"
#include "kernels/activations/all.hpp"
#include "kernels/dense/all.hpp"
#include "kernels/transport/all.hpp"

namespace aieml5::graph {

namespace detail {

template <auto KernelFn>
struct KernelMetadata;

template <>
struct KernelMetadata<stream_to_packet_kernel> {
  static constexpr const char* source = "kernels/transport/stream_to_packet.cpp";
  static constexpr const char* header = "kernels/transport/stream_to_packet.h";
};

template <>
struct KernelMetadata<hidden_stream_to_packet_kernel> {
  static constexpr const char* source = "kernels/transport/hidden_stream_to_packet.cpp";
  static constexpr const char* header = "kernels/transport/hidden_stream_to_packet.h";
};

template <>
struct KernelMetadata<packet_to_stream_kernel> {
  static constexpr const char* source = "kernels/transport/packet_to_stream.cpp";
  static constexpr const char* header = "kernels/transport/packet_to_stream.h";
};

template <>
struct KernelMetadata<packet_to_stream_hidden_kernel> {
  static constexpr const char* source = "kernels/transport/packet_to_stream.cpp";
  static constexpr const char* header = "kernels/transport/packet_to_stream.h";
};

template <>
struct KernelMetadata<leaky_relu_kernel> {
  static constexpr const char* source = "kernels/activations/leaky_relu.cpp";
  static constexpr const char* header = "kernels/activations/leaky_relu.h";
};

}  // namespace detail

template <auto PacketKernel, auto DepacketKernel, int Branches>
class PacketFanoutStage : public adf::graph {
  static_assert(Branches > 0, "Packet fan-out must have at least one branch");

 public:
  PacketFanoutStage() {
    packetizer_ = adf::kernel::create(PacketKernel);
    adf::source(packetizer_) = detail::KernelMetadata<PacketKernel>::source;
    adf::headers(packetizer_) = {detail::KernelMetadata<PacketKernel>::header};
    adf::runtime<adf::ratio>(packetizer_) = 1.0;

    splitter_ = adf::pktsplit<Branches>::create();

    for (int branch = 0; branch < Branches; ++branch) {
      depacketizers_[branch] = adf::kernel::create(DepacketKernel);
      adf::source(depacketizers_[branch]) =
          detail::KernelMetadata<DepacketKernel>::source;
      adf::headers(depacketizers_[branch]) =
          {detail::KernelMetadata<DepacketKernel>::header};
      adf::runtime<adf::ratio>(depacketizers_[branch]) = 1.0;

      adf::connect<adf::pktstream>(splitter_.out[branch],
                                   depacketizers_[branch].in[0]);
      adf::connect<adf::stream>(depacketizers_[branch].out[0], outputs_[branch]);
    }

    adf::connect<adf::stream>(input_, packetizer_.in[0]);
    adf::connect<adf::pktstream>(packetizer_.out[0], splitter_.in[0]);
  }

  adf::port<input>& input() { return input_; }
  adf::port<output>& output(std::size_t index) { return outputs_[index]; }

  static constexpr std::size_t branch_count = Branches;

 private:
  adf::kernel                         packetizer_;
  std::array<adf::kernel, Branches>   depacketizers_{};
  adf::pktsplit<Branches>             splitter_;
  adf::port<input>                    input_;
  std::array<adf::port<output>, Branches> outputs_{};
};

template <typename DenseGraphType, int CascLen>
class DenseLayer : public adf::graph {
  static_assert(CascLen > 0, "Dense layer must have at least one cascade lane");

 public:
  DenseLayer() {
    static_assert(DenseGraphType::getTotalRtpPorts() == CascLen,
                  "Graph template configuration must match cascade length");

    for (int lane = 0; lane < CascLen; ++lane) {
      adf::connect<adf::stream>(inputs_[lane], dense_.inB[lane]);
      adf::connect<adf::parameter>(matrixA_[lane], dense_.matrixA[lane]);
    }
    adf::connect<adf::stream>(dense_.out[0], output_);
  }

  adf::port<input>& input(std::size_t index) { return inputs_[index]; }
  adf::port<output>& output() { return output_; }
  adf::input_port& matrix_port(std::size_t index) { return matrixA_[index]; }

  static constexpr std::size_t casc_len   = CascLen;
  static constexpr std::size_t rtp_ports  = CascLen;

 private:
  DenseGraphType                    dense_;
  std::array<adf::port<input>, CascLen> inputs_{};
  adf::port<output>                     output_;
  std::array<adf::input_port, CascLen>  matrixA_{};
};

template <auto ActivationKernel>
class ActivationLayer : public adf::graph {
 public:
  ActivationLayer() {
    kernel_ = adf::kernel::create(ActivationKernel);
    adf::source(kernel_) = detail::KernelMetadata<ActivationKernel>::source;
    adf::headers(kernel_) = {detail::KernelMetadata<ActivationKernel>::header};
    adf::runtime<adf::ratio>(kernel_) = 1.0;

    adf::connect<adf::stream>(input_, kernel_.in[0]);
    adf::connect<adf::stream>(kernel_.out[0], output_);
  }

  adf::port<input>& input() { return input_; }
  adf::port<output>& output() { return output_; }

 private:
  adf::kernel       kernel_;
  adf::port<input>  input_;
  adf::port<output> output_;
};

template <typename Stage>
struct StageTraits;

template <auto PacketKernel, auto DepacketKernel, int Branches>
struct StageTraits<PacketFanoutStage<PacketKernel, DepacketKernel, Branches>> {
  static constexpr StageKind kind       = StageKind::PacketFanout;
  static constexpr std::size_t inputs   = 1;
  static constexpr std::size_t outputs  = Branches;
  static constexpr std::size_t rtp_ports = 0;

  static adf::port<input>& input(PacketFanoutStage<PacketKernel, DepacketKernel, Branches>& stage,
                                 std::size_t /*index*/) {
    return stage.input();
  }

  static adf::port<output>& output(
      PacketFanoutStage<PacketKernel, DepacketKernel, Branches>& stage,
      std::size_t index) {
    return stage.output(index);
  }
};

template <typename DenseGraphType, int CascLen>
struct StageTraits<DenseLayer<DenseGraphType, CascLen>> {
  static constexpr StageKind kind       = StageKind::Dense;
  static constexpr std::size_t inputs   = CascLen;
  static constexpr std::size_t outputs  = 1;
  static constexpr std::size_t rtp_ports = CascLen;

  static adf::port<input>& input(DenseLayer<DenseGraphType, CascLen>& stage,
                                 std::size_t index) {
    return stage.input(index);
  }

  static adf::port<output>& output(DenseLayer<DenseGraphType, CascLen>& stage,
                                   std::size_t /*index*/) {
    return stage.output();
  }

  static adf::input_port& matrix_port(DenseLayer<DenseGraphType, CascLen>& stage,
                                      std::size_t index) {
    return stage.matrix_port(index);
  }
};

template <auto ActivationKernel>
struct StageTraits<ActivationLayer<ActivationKernel>> {
  static constexpr StageKind kind       = StageKind::Activation;
  static constexpr std::size_t inputs   = 1;
  static constexpr std::size_t outputs  = 1;
  static constexpr std::size_t rtp_ports = 0;

  static adf::port<input>& input(ActivationLayer<ActivationKernel>& stage,
                                 std::size_t /*index*/) {
    return stage.input();
  }

  static adf::port<output>& output(ActivationLayer<ActivationKernel>& stage,
                                   std::size_t /*index*/) {
    return stage.output();
  }
};

}  // namespace aieml5::graph
