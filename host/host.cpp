#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <stdexcept>
#include <cstring>

#include "experimental/xrt_kernel.h"
#include "experimental/xrt_graph.h"
#include "experimental/xrt_device.h"
#include "experimental/xrt_bo.h"

#include "data_paths.h"
#include "nn_defs.h"
#include "../pl/bus_ids.hpp"
#include "weights_bus.hpp"

// Load text files containing floats into a vector
static std::vector<float> read_file_to_vector(const std::string& filename, int size) {
  std::vector<float> data;
  data.reserve(size);
  std::ifstream file(filename);
  if (!file.is_open()) {
    throw std::runtime_error("ERROR: Could not open file " + filename);
  }
  float val;
  while (file >> val) { data.push_back(val); }
  file.close();
  if ((int)data.size() != size) {
    throw std::runtime_error("ERROR: File " + filename +
                             " does not contain the expected " + std::to_string(size) + " elements.");
  }
  return data;
}

// Build weight and bias packets for the aieml graph.
static std::vector<std::uint32_t> build_weights_aieml(const std::string& base_path) {
  std::vector<std::uint32_t> words;

  auto w0 = read_file_to_vector(base_path + "/" + EMBED_DENSE0_WEIGHTS,
                                EMBED_DENSE0_WEIGHTS_SIZE);
  append_packet(words, w0, bus::WEIGHTS0, KIND_WEIGHT);

  auto w1a = read_file_to_vector(base_path + "/" +
                                 EMBED_DENSE1_WEIGHTS_PREFIX + std::string("0.txt"),
                                 EMBED_DENSE1_WEIGHTS_PART_SIZE);
  append_packet(words, w1a, bus::WEIGHTS1_A, KIND_WEIGHT);

  auto w1b = read_file_to_vector(base_path + "/" +
                                 EMBED_DENSE1_WEIGHTS_PREFIX + std::string("1.txt"),
                                 EMBED_DENSE1_WEIGHTS_PART_SIZE);
  append_packet(words, w1b, bus::WEIGHTS1_B, KIND_WEIGHT);

  auto b0 = read_file_to_vector(base_path + "/" + EMBED_DENSE0_BIAS,
                                EMBED_DENSE0_BIAS_SIZE);
  append_packet(words, b0, bus::BIAS0, KIND_BIAS);

  auto b1 = read_file_to_vector(base_path + "/" + EMBED_DENSE1_BIAS,
                                EMBED_DENSE1_BIAS_SIZE);
  append_packet(words, b1, bus::BIAS1, KIND_BIAS);

  return words;
}

// Stream pre-built packets through the switch kernel.
static void preload_weights_aieml(xrt::device& device,
                                  xrt::kernel& switch_kernel,
                                  const std::vector<std::uint32_t>& words) {
  xrt::bo bo(device, words.size() * sizeof(std::uint32_t), xrt::bo::flags::normal, 0);
  bo.write(words.data(), words.size() * sizeof(std::uint32_t), 0);
  bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);

  auto run = xrt::run(switch_kernel);
  run.set_arg(0, bo);
  run.set_arg(2, words.size());
  run.start();
  run.wait();
}

int main(int argc, char** argv) {
  if (argc < 2) {
    std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
    return 1;
  }

  const std::string xclbinFilename = argv[1];
  const std::string base_path = "./data";

  try {
    xrt::device device(0);
    xrt::xclbin xclbin(xclbinFilename);
    auto uuid = device.load_xclbin(xclbin);

    auto weight_words = build_weights_aieml(base_path);

    // Build packetised input buffer
    auto input_data = read_file_to_vector(base_path + "/" + EMBED_INPUT_DATA,
                                          EMBED_DENSE0_INPUT_SIZE);
    std::vector<std::uint32_t> input_words;
    append_packet(input_words, input_data, bus::DIN, KIND_INPUT);

    xrt::bo input_bo(device, input_words.size() * sizeof(std::uint32_t), xrt::bo::flags::normal, 0);
    input_bo.write(input_words.data(), input_words.size() * sizeof(std::uint32_t), 0);
    input_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);

    xrt::bo output_buf(device, EMBED_FINAL_OUTPUT_SIZE * sizeof(float), xrt::bo::flags::normal, 0);

    // Kernel handles
    xrt::kernel switch_kernel(device, uuid, "switch_mm2s_pl:{mm2s_switch}");
    xrt::kernel demux_kernel(device, uuid, "demux_8_pl:{demux}");
    xrt::kernel relu_kernel(device, uuid, "leaky_relu_pl:{relu}");
    xrt::kernel relu2_kernel(device, uuid, "leaky_relu_pl:{relu2}");
    xrt::kernel splitter_kernel(device, uuid, "leaky_splitter_pl:{splitter}");
    xrt::kernel s2mm_kernel(device, uuid, "s2mm_pl:{s2mm_out}");
    xrt::graph  aie_graph(device, uuid, "g");

    // Initialize AI Engine graph before any data movement
    aie_graph.init();

    unsigned int demux_words = weight_words.size() + input_words.size();
    // Start demux first, then other consumer kernels
    auto demux_run = xrt::run(demux_kernel);
    demux_run.set_arg(9, demux_words);
    demux_run.start();

    auto s2mm_run = xrt::run(s2mm_kernel);
    s2mm_run.set_arg(1, output_buf);
    s2mm_run.set_arg(2, EMBED_FINAL_OUTPUT_SIZE);
    s2mm_run.start();

    auto relu_run = xrt::run(relu_kernel);
    relu_run.set_arg(3, HIDDEN_SIZE);
    relu_run.start();

    auto relu2_run = xrt::run(relu2_kernel);
    relu2_run.set_arg(3, HIDDEN_SIZE);
    relu2_run.start();

    auto split_run = xrt::run(splitter_kernel);
    split_run.start();

    // Preload weights and biases before starting the graph
    preload_weights_aieml(device, switch_kernel, weight_words);

    // Run AIE graph
    aie_graph.run(1);

    // Stream input data once the graph is running
    auto input_run = xrt::run(switch_kernel);
    input_run.set_arg(0, input_bo);
    input_run.set_arg(2, input_words.size());
    input_run.start();

    input_run.wait();
    aie_graph.wait();
    aie_graph.end();
    s2mm_run.wait();
    relu_run.wait();
    relu2_run.wait();
    split_run.wait();
    demux_run.wait();

    // Retrieve results
    std::vector<float> host_output_data(EMBED_FINAL_OUTPUT_SIZE);
    output_buf.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
    output_buf.read(host_output_data.data());

    std::ofstream out(base_path + "/" + EMBED_HOST_OUTPUT);
    for (int i = 0; i < EMBED_FINAL_OUTPUT_SIZE; ++i) {
      std::cout << host_output_data[i] << '\n';
      out << host_output_data[i] << '\n';
    }

  } catch (const std::exception& e) {
    std::cerr << "ERROR: " << e.what() << std::endl;
    return 1;
  }

  return 0;
}

