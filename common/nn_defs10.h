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

constexpr int SUBSOLVER0_INPUT_SIZE = 256;
constexpr int SUBSOLVER0_INPUT_PARTS = 4;
constexpr int SUBSOLVER0_DENSE0_BIAS_SIZE = HIDDEN_SIZE;
constexpr int SUBSOLVER0_DENSE1_BIAS_SIZE = HIDDEN_SIZE;
constexpr int SUBSOLVER0_DENSE2_BIAS_SIZE = HIDDEN_SIZE;
constexpr int SUBSOLVER0_DENSE3_BIAS_SIZE = HIDDEN_SIZE;
constexpr int SUBSOLVER0_LAYER_WEIGHTS_PARTS = 2;
constexpr int SOLVER_DENSE0_CASC_LEN = SUBSOLVER0_INPUT_PARTS; // 4
constexpr int SOLVER_DENSEX_CASC_LEN = SUBSOLVER0_LAYER_WEIGHTS_PARTS; // 2

// Roll-concat: produce 2 x HIDDEN_SIZE
constexpr int ROLL_CONC_SUBSET_SIZE = 2;
constexpr int ROLL_CONCAT_TOTAL = ROLL_CONC_SUBSET_SIZE * HIDDEN_SIZE; // 256
static_assert(ROLL_CONCAT_TOTAL % SUBSOLVER0_INPUT_PARTS == 0,
              "ROLL_CONCAT_TOTAL must be divisible by SUBSOLVER0_INPUT_PARTS");
constexpr int ROLL_CONCAT_TILE_SPAN = ROLL_CONCAT_TOTAL / SUBSOLVER0_INPUT_PARTS; // 64

constexpr float LEAKY_SLOPE = 0.1f;
constexpr int TRACK_AVERAGE_THRESHOLD = 50;
static_assert(TRACK_AVERAGE_THRESHOLD > 0, "TRACK_AVERAGE_THRESHOLD must be positive");

// Output dense layer dimensions (applied on host after track_average_pl)
constexpr int OUTPUT_DENSE_IN_SIZE  = HIDDEN_SIZE; // 128
constexpr int OUTPUT_DENSE_OUT_SIZE = 27;