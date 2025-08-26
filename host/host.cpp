#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <stdexcept>
#include <cstring>

#include "experimental/xrt_kernel.h"
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

// Send a packet through the switch and demux kernels and print its values.
static void send_packet(xrt::device& device,
                        xrt::kernel& switch_kernel,
                        xrt::kernel& demux_kernel,
                        const std::vector<float>& data,
                        std::uint8_t bus_id,
                        DataKind kind) {
  std::vector<std::uint32_t> words;
  append_packet(words, data, bus_id, kind);

  xrt::bo bo(device, words.size() * sizeof(std::uint32_t), xrt::bo::flags::normal, 0);
  bo.write(words.data(), words.size() * sizeof(std::uint32_t), 0);
  bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);

  auto demux_run = xrt::run(demux_kernel);
  demux_run.start();

  auto run = xrt::run(switch_kernel);
  run.set_arg(0, bo);
  run.set_arg(2, words.size());
  run.start();
  run.wait();

  demux_run.wait();

  for (float f : data)
    std::cout << f << '\n';
}

int main(int argc, char** argv) {
  if (argc < 2) {
    std::cout << "Usage: " << argv[0] << " <a.xclbin>\n";
    return 1;
  }

  const std::string xclbinFilename = argv[1];
  const std::string base_path = DATA_DIR;

  try {
    xrt::device device(0);
    xrt::xclbin xclbin(xclbinFilename);
    auto uuid = device.load_xclbin(xclbin);

    xrt::kernel switch_kernel(device, uuid, "switch_mm2s_pl:{mm2s_switch}");
    xrt::kernel demux_kernel(device, uuid, "demux_8_pl:{demux}");

    auto din = read_file_to_vector(base_path + "/" + EMBED_INPUT_DATA,
                                   EMBED_DENSE0_INPUT_SIZE);
    send_packet(device, switch_kernel, demux_kernel, din, bus::DIN, KIND_INPUT);

    auto w0 = read_file_to_vector(base_path + "/" + EMBED_DENSE0_WEIGHTS,
                                  EMBED_DENSE0_WEIGHTS_SIZE);
    send_packet(device, switch_kernel, demux_kernel, w0, bus::WEIGHTS0, KIND_WEIGHT);

    auto w1a = read_file_to_vector(base_path + "/" +
                                   EMBED_DENSE1_WEIGHTS_PREFIX + std::string("0.txt"),
                                   EMBED_DENSE1_WEIGHTS_PART_SIZE);
    send_packet(device, switch_kernel, demux_kernel, w1a, bus::WEIGHTS1_A, KIND_WEIGHT);

    auto w1b = read_file_to_vector(base_path + "/" +
                                   EMBED_DENSE1_WEIGHTS_PREFIX + std::string("1.txt"),
                                   EMBED_DENSE1_WEIGHTS_PART_SIZE);
    send_packet(device, switch_kernel, demux_kernel, w1b, bus::WEIGHTS1_B, KIND_WEIGHT);

    auto b0 = read_file_to_vector(base_path + "/" + EMBED_DENSE0_BIAS,
                                  EMBED_DENSE0_BIAS_SIZE);
    send_packet(device, switch_kernel, demux_kernel, b0, bus::BIAS0, KIND_BIAS);

    auto b1 = read_file_to_vector(base_path + "/" + EMBED_DENSE1_BIAS,
                                  EMBED_DENSE1_BIAS_SIZE);
    send_packet(device, switch_kernel, demux_kernel, b1, bus::BIAS1, KIND_BIAS);

  } catch (const std::exception& e) {
    std::cerr << "ERROR: " << e.what() << std::endl;
    return 1;
  }

  return 0;
}
