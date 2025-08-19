 #include <iostream>
#include <fstream>
#include <vector>
#include "experimental/xrt_kernel.h"
#include "experimental/xrt_graph.h"
#include "experimental/xrt_device.h"
#include "experimental/xrt_bo.h"
#include "data_paths.h"
#include "nn_defs.h"

// Load text files containing floats into a vector
static std::vector<float> read_file_to_vector(const std::string& filename, int size) {
    std::vector<float> data;
    data.reserve(size);
    std::ifstream file(filename);
    if (!file.is_open()) {
        throw std::runtime_error("ERROR: Could not open file " + filename);
    }
    float val;
    while (file >> val) {
        data.push_back(val);
    }
    file.close();
    if (data.size() != size) {
        throw std::runtime_error("ERROR: File " + filename + " does not contain the expected " + std::to_string(size) + " elements.");
    }
    return data;
}

int main(int argc, char** argv) {
    if (argc != 2) {
        std::cout << "Usage: " << argv[0] << " <a.xclbin>" << std::endl;
        return 1;
    }

    std::string xclbinFilename = argv[1];

    // std::string base_path = DATA_DIR;
    std::string base_path = "./data";
    std::string inputDataFile      = base_path + "/" + EMBED_INPUT_DATA;
    std::string weights1File       = base_path + "/" + EMBED_DENSE0_WEIGHTS;
    std::string weights2_part0File = base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + "0.txt";
    std::string weights2_part1File = base_path + "/" + EMBED_DENSE1_WEIGHTS_PREFIX + "1.txt";
    std::string bias1File          = base_path + "/" + EMBED_DENSE0_BIAS;
    std::string bias2File          = base_path + "/" + EMBED_DENSE1_BIAS;
    const std::string outputFile   = base_path + "/" + EMBED_HOST_OUTPUT;

    try {
        xrt::device device(0);
        xrt::xclbin xclbin(xclbinFilename);
        auto xclbin_uuid = device.load_xclbin(xclbin);

        // Load inputs and weights
        auto input_data          = read_file_to_vector(inputDataFile, EMBED_DENSE0_INPUT_SIZE);
        auto weights1_data       = read_file_to_vector(weights1File, EMBED_DENSE0_WEIGHTS_SIZE);
        auto weights2_part0_data = read_file_to_vector(weights2_part0File, EMBED_DENSE1_WEIGHTS_PART_SIZE);
        auto weights2_part1_data = read_file_to_vector(weights2_part1File, EMBED_DENSE1_WEIGHTS_PART_SIZE);
        auto bias1_data          = read_file_to_vector(bias1File, EMBED_DENSE0_BIAS_SIZE);
        auto bias2_data          = read_file_to_vector(bias2File, EMBED_DENSE1_BIAS_SIZE);

        // Allocate device buffers
        xrt::bo input_buf          = xrt::bo(device, input_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo weights1_buf       = xrt::bo(device, weights1_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo weights2_part0_buf = xrt::bo(device, weights2_part0_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo weights2_part1_buf = xrt::bo(device, weights2_part1_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo bias1_buf          = xrt::bo(device, bias1_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo bias2_buf          = xrt::bo(device, bias2_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo output_buf         = xrt::bo(device, EMBED_FINAL_OUTPUT_SIZE * sizeof(float), xrt::bo::flags::normal, 0);

        input_buf.write(input_data.data());
        weights1_buf.write(weights1_data.data());
        weights2_part0_buf.write(weights2_part0_data.data());
        weights2_part1_buf.write(weights2_part1_data.data());
        bias1_buf.write(bias1_data.data());
        bias2_buf.write(bias2_data.data());
        input_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        weights1_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        weights2_part0_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        weights2_part1_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        bias1_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        bias2_buf.sync(XCL_BO_SYNC_BO_TO_DEVICE);

        // Acquire kernel and graph handles
        xrt::kernel mm2s_data       = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_din}");
        xrt::kernel mm2s_weights1   = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_weights1}");
        xrt::kernel mm2s_weights2_0 = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_weights2_0}");
        xrt::kernel mm2s_weights2_1 = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_weights2_1}");
        xrt::kernel mm2s_bias1      = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_bias1}");
        xrt::kernel mm2s_bias2      = xrt::kernel(device, xclbin_uuid, "mm2s_pl:{mm2s_bias2}");
        xrt::kernel relu            = xrt::kernel(device, xclbin_uuid, "leaky_relu_pl:{relu}");
        xrt::kernel relu2           = xrt::kernel(device, xclbin_uuid, "leaky_relu_pl:{relu2}");
        xrt::kernel splitter        = xrt::kernel(device, xclbin_uuid, "leaky_splitter_pl:{splitter}");
        xrt::kernel s2mm            = xrt::kernel(device, xclbin_uuid, "s2mm_pl:{s2mm_out}");
        xrt::graph aie_graph        = xrt::graph(device, xclbin_uuid, "g");

        // Start consumer kernels
        auto s2mm_run = xrt::run(s2mm);
        s2mm_run.set_arg(1, output_buf);
        s2mm_run.set_arg(2, EMBED_FINAL_OUTPUT_SIZE);
        s2mm_run.start();

        auto relu2_run = xrt::run(relu2);
        relu2_run.start();

        auto relu_run = xrt::run(relu);
        relu_run.start();

        auto splitter_run = xrt::run(splitter);
        splitter_run.start();

        // Launch the AI Engine graph
        aie_graph.run();

        // Start producer kernels
        auto mm2s_weights1_run = xrt::run(mm2s_weights1);
        mm2s_weights1_run.set_arg(0, weights1_buf);
        mm2s_weights1_run.set_arg(2, EMBED_DENSE0_WEIGHTS_SIZE);
        mm2s_weights1_run.start();

        auto mm2s_weights2_0_run = xrt::run(mm2s_weights2_0);
        mm2s_weights2_0_run.set_arg(0, weights2_part0_buf);
        mm2s_weights2_0_run.set_arg(2, EMBED_DENSE1_WEIGHTS_PART_SIZE);
        mm2s_weights2_0_run.start();

        auto mm2s_weights2_1_run = xrt::run(mm2s_weights2_1);
        mm2s_weights2_1_run.set_arg(0, weights2_part1_buf);
        mm2s_weights2_1_run.set_arg(2, EMBED_DENSE1_WEIGHTS_PART_SIZE);
        mm2s_weights2_1_run.start();

        auto mm2s_bias1_run = xrt::run(mm2s_bias1);
        mm2s_bias1_run.set_arg(0, bias1_buf);
        mm2s_bias1_run.set_arg(2, EMBED_DENSE0_BIAS_SIZE);
        mm2s_bias1_run.start();

        auto mm2s_bias2_run = xrt::run(mm2s_bias2);
        mm2s_bias2_run.set_arg(0, bias2_buf);
        mm2s_bias2_run.set_arg(2, EMBED_DENSE1_BIAS_SIZE);
        mm2s_bias2_run.start();

        auto mm2s_data_run = xrt::run(mm2s_data);
        mm2s_data_run.set_arg(0, input_buf);
        mm2s_data_run.set_arg(2, EMBED_DENSE0_INPUT_SIZE);
        mm2s_data_run.start();

        // Wait for completion
        mm2s_data_run.wait();
        s2mm_run.wait();

        // Retrieve results
        std::vector<float> host_output_data(EMBED_FINAL_OUTPUT_SIZE);
        output_buf.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        output_buf.read(host_output_data.data());

        std::ofstream out(outputFile);
        for (int i = 0; i < EMBED_FINAL_OUTPUT_SIZE; ++i) {
            std::cout << host_output_data[i] << std::endl;
            out << host_output_data[i] << std::endl;
        }
        out.close();

    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}
