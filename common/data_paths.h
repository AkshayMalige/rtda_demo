#pragma once
#include <filesystem>
#include <string>

// Returns the absolute path to the repository-level data directory.
inline const std::string& data_directory() {
    static const std::string dir =
        (std::filesystem::absolute(std::filesystem::path(__FILE__)).parent_path()
             .parent_path() /
         "data")
            .string();
    return dir;
}

#define DATA_DIR data_directory()

#define INPUT_DATA_FILE "input_data.txt"
#define WEIGHTS_DENSE1_FILE "weights_dense1.txt"
#define WEIGHTS_DENSE2_PREFIX "weights_dense2_part"
#define LEAKY_RELU_OUTPUT_PREFIX "leakyrelu_output_part"
#define HOST_OUTPUT_FILE "host_output.txt"
