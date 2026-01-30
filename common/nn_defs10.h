#pragma once

typedef std::int16_t d_type;

// Core layer sizes
constexpr int INPUT_SIZE = 16;
constexpr int HIDDEN_SIZE = 128;
constexpr int OUTPUT_SIZE = 256;

constexpr int EMBED_DENSE0_CASC_LEN = 1;

constexpr unsigned bytes_per_vector(unsigned element_count) {
    return element_count * static_cast<unsigned>(sizeof(float));
}