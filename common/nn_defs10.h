#pragma once

typedef std::int16_t d_type;

// Core layer sizes
constexpr int INPUT_SIZE = 8;
constexpr int HIDDEN_SIZE = 128;
constexpr int OUTPUT_SIZE = 128;

constexpr int EMBED_DENSE0_CASC_LEN = 1;
constexpr int EMBED_DENSE1_CASC_LEN = 2;
constexpr int EMBED_DENSE0_BIAS_SIZE = HIDDEN_SIZE;
constexpr int EMBED_DENSE1_BIAS_SIZE = OUTPUT_SIZE;

constexpr unsigned bytes_per_vector(unsigned element_count) {
    return element_count * static_cast<unsigned>(sizeof(float));
}
// Shared sizing helpers
static_assert(HIDDEN_SIZE % 2 == 0,
    "HIDDEN_SIZE must be divisible by 2 for even split");
constexpr int HIDDEN_SPLIT_SIZE = HIDDEN_SIZE / 2;