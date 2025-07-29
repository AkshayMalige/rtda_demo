#include <iostream>
#include <fstream>
#include <vector>
#include "experimental/xrt_kernel.h"
#include "experimental/xrt_graph.h"
#include "experimental/xrt_device.h"
#include "experimental/xrt_bo.h"

// Define sizes for all data buffers
#define INPUT_DATA_SIZE 128
#define OUTPUT_DATA_SIZE 128
#define WEIGHTS_DATA_SIZE (128 * 8) 

// Helper function to read a file into a vector
std::vector<float> read_file_to_vector(const std::string& filename, int size) {
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
    if (data.size() != size) {
        throw std::runtime_error("ERROR: File " + filename + " does not contain the expected number of elements.");
    }
    return data;
}

int main(int argc, char** argv) {
    if (argc != 4) {
        std::cout << "Usage: " << argv[0] << " <aie.xclbin> <input.txt> <weights.txt>" << std::endl;
        return 1;
    }

    std::string xclbinFilename = argv[1];
    std::string inputTxtFilename = argv[2];
    std::string weightsTxtFilename = argv[3];

    try {
        xrt::device device(0);
        xrt::xclbin xclbin(xclbinFilename);
        auto xclbin_uuid = device.load_xclbin(xclbin);

        // --- 1. Read input files ---
        auto input_data = read_file_to_vector(inputTxtFilename, INPUT_DATA_SIZE);
        auto weights_data = read_file_to_vector(weightsTxtFilename, WEIGHTS_DATA_SIZE);

        // --- 2. Allocate all buffers on device (inputs and output) ---
        xrt::bo input_buffer = xrt::bo(device, input_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo weights_buffer = xrt::bo(device, weights_data.size() * sizeof(float), xrt::bo::flags::normal, 0);
        xrt::bo output_buffer = xrt::bo(device, OUTPUT_DATA_SIZE * sizeof(float), xrt::bo::flags::normal, 0);

        // Write input data to device buffers
        input_buffer.write(input_data.data());
        weights_buffer.write(weights_data.data());
        input_buffer.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        weights_buffer.sync(XCL_BO_SYNC_BO_TO_DEVICE);

        // --- 3. Get Handles to all components ---
        xrt::kernel mm2s_data_krnl = xrt::kernel(device, xclbin_uuid, "mm2s_data_inst");
        xrt::kernel mm2s_weights_krnl = xrt::kernel(device, xclbin_uuid, "mm2s_weights_inst");
        xrt::kernel relu_krnl = xrt::kernel(device, xclbin_uuid, "leaky_relu_pl");
        xrt::graph aie_graph = xrt::graph(device, xclbin_uuid, "g");

        // --- 4. Start consumers ---
        auto relu_run = xrt::run(relu_krnl);
        // Set the output buffer (arg 1) and size (arg 2) for the leaky_relu kernel
        relu_run.set_arg(1, output_buffer);
        relu_run.set_arg(2, OUTPUT_DATA_SIZE);
        relu_run.start();

        aie_graph.run(1);

        // --- 5. Start producers ---
        auto mm2s_weights_run = xrt::run(mm2s_weights_krnl);
        mm2s_weights_run.set_arg(0, weights_buffer);
        mm2s_weights_run.set_arg(2, WEIGHTS_DATA_SIZE);
        mm2s_weights_run.start();

        auto mm2s_data_run = xrt::run(mm2s_data_krnl);
        mm2s_data_run.set_arg(0, input_buffer);
        mm2s_data_run.set_arg(2, INPUT_DATA_SIZE);
        mm2s_data_run.start();

        // --- 6. Wait for all kernels to complete ---
        std::cout << "Waiting for kernels to complete..." << std::endl;
        mm2s_data_run.wait();
        mm2s_weights_run.wait();
        relu_run.wait(); // Wait for the relu kernel to finish writing
        std::cout << "Execution finished." << std::endl;

        // --- 7. Read back and verify results ---
        std::cout << "Reading output data from device..." << std::endl;
        std::vector<float> host_output_data(OUTPUT_DATA_SIZE);
        output_buffer.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        output_buffer.read(host_output_data.data());

        // Print first few values for verification
        std::cout << "Verification: First 5 output values:" << std::endl;
        for (int i = 0; i < 5; ++i) {
            std::cout << host_output_data[i] << std::endl;
        }

    } catch (const std::exception& e) {
        std::cerr << "ERROR: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}