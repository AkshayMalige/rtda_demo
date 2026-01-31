#pragma once

#include <vector>
#include <string>
#include <fstream>
#include <iostream>
#include <iomanip>
#include <limits>
#include <initializer_list>

// Project specific headers
#include "nn_defs10.h"
#include "data_paths.h"
#include <adf.h>

// ==================================================================================
// Generic File I/O Helpers
// ==================================================================================

template <typename T>
std::vector<T> load_values(const std::string& path, std::size_t expected_count = 0) {
    std::ifstream file(path);
    if (!file.is_open()) {
        std::cerr << "Error: Could not open file '" << path << "'" << std::endl;
        return {};
    }

    std::vector<T> values;
    if (expected_count > 0) values.reserve(expected_count);

    // Read as double to handle potential formatting mismatches (e.g., "3.0" for int target)
    // and then cast to the target type T.
    double temp_val;
    while (file >> temp_val) {
        values.push_back(static_cast<T>(temp_val));
    }
    return values;
}

template <typename T>
bool write_vector(const std::string& path, const T* values, std::size_t count) {
    std::ofstream file(path);
    if (!file.is_open()) {
        std::cerr << "Error: Could not open output file '" << path << "'" << std::endl;
        return false;
    }
    
    // Only set max_digits10 for floating point types
    if(std::numeric_limits<T>::is_iec559) {
        file << std::setprecision(std::numeric_limits<T>::max_digits10);
    }
    
    for (std::size_t i = 0; i < count; ++i) {
        file << values[i] << '\n';
    }
    return true;
}

// ==================================================================================
// ADF Graph Specific Helpers (depend on DATA_DIR and adf::)
// ==================================================================================

// Helper to construct full path and load
template <typename T = float>
std::vector<T> load_vector_from_datadir(const std::string& relative_path, std::size_t expected_count) {
    const std::string basePath = std::string(DATA_DIR) + "/";
    return load_values<T>(basePath + relative_path, expected_count);
}

// Helper to load and update ports
template <typename GraphT, typename T = float>
bool load_and_update_ports_helper(GraphT& g, const std::string& relative_path, std::size_t expected_count, std::initializer_list<adf::input_port*> ports) {
    auto values = load_vector_from_datadir<T>(relative_path, expected_count);
    if (values.empty()) {
        return false;
    }
    for (auto* port : ports) {
        // ADF update expects size in BYTES
        g.update(*port, values.data(), values.size() * sizeof(T));
    }
    return true;
}

// Helper to construct full path and write
template <typename T = float>
bool write_vector_to_datadir(const std::string& relative_path, const T* values, std::size_t count) {
    const std::string basePath = std::string(DATA_DIR) + "/";
    return write_vector<T>(basePath + relative_path, values, count);
}
