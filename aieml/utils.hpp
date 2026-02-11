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
// Data Padding Helpers
// ==================================================================================

// Pads a row-major matrix where each row is extended from 'original_cols' to 'target_cols' with zeros.
template <typename T>
std::vector<T> pad_matrix_rows(const std::vector<T>& input, size_t rows, size_t original_cols, size_t target_cols) {
    if (target_cols <= original_cols) return input;

    std::vector<T> padded;
    padded.reserve(rows * target_cols);
    
    size_t padding_per_row = target_cols - original_cols;

    for (size_t r = 0; r < rows; ++r) {
        size_t row_start = r * original_cols;
        // Safety check
        if (row_start + original_cols > input.size()) break;

        // Copy original row data
        for (size_t c = 0; c < original_cols; ++c) {
            padded.push_back(input[row_start + c]);
        }
        // Add padding
        for (size_t p = 0; p < padding_per_row; ++p) {
            padded.push_back(static_cast<T>(0));
        }
    }
    return padded;
}

// Pads a stream of transactions. Each transaction of 'original_block_size' is padded to 'target_block_size'.
template <typename T>
std::vector<T> pad_transaction_stream(const std::vector<T>& input, size_t original_block_size, size_t target_block_size) {
    if (target_block_size <= original_block_size) return input;

    size_t num_transactions = input.size() / original_block_size;
    size_t padding_per_block = target_block_size - original_block_size;

    std::vector<T> padded;
    padded.reserve(num_transactions * target_block_size);

    for (size_t i = 0; i < num_transactions; ++i) {
        size_t start_idx = i * original_block_size;
        for (size_t j = 0; j < original_block_size; ++j) {
            padded.push_back(input[start_idx + j]);
        }
        for (size_t p = 0; p < padding_per_block; ++p) {
            padded.push_back(static_cast<T>(0));
        }
    }
    return padded;
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
        // ADF update expects size in ELEMENT COUNT (framework multiplies by sizeof internally)
        g.update(*port, values.data(), values.size());
    }
    return true;
}

// Helper to construct full path and write
template <typename T = float>
bool write_vector_to_datadir(const std::string& relative_path, const T* values, std::size_t count) {
    const std::string basePath = std::string(DATA_DIR) + "/";
    return write_vector<T>(basePath + relative_path, values, count);
}