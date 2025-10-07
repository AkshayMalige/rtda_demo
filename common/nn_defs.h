#pragma once

constexpr int INPUT_SIZE = 8;
constexpr int HIDDEN_SIZE = 128;
constexpr int OUTPUT_SIZE = 128;
constexpr float LEAKY_SLOPE = 0.1f;
constexpr int CASCADE_LENGTH = 2;
constexpr int ROLL_CONC_SUBSET_SIZE = 6;

// Shared sizing helpers ---------------------------------------------------
constexpr int HIDDEN_SPLIT_FACTOR = 2;
static_assert(HIDDEN_SPLIT_FACTOR > 0, "HIDDEN_SPLIT_FACTOR must be positive");
static_assert(HIDDEN_SIZE % HIDDEN_SPLIT_FACTOR == 0,
              "HIDDEN_SIZE must be divisible by HIDDEN_SPLIT_FACTOR");
constexpr int HIDDEN_SPLIT_SIZE = HIDDEN_SIZE / HIDDEN_SPLIT_FACTOR;

constexpr unsigned BYTES_PER_ELEMENT = static_cast<unsigned>(sizeof(float));
constexpr unsigned bytes_per_vector(unsigned element_count) {
    return element_count * BYTES_PER_ELEMENT;
}

// Stage cascade lengths ---------------------------------------------------
constexpr int EMBED_DENSE0_CASC_LEN = 1;
constexpr int EMBED_DENSE1_CASC_LEN = CASCADE_LENGTH;

constexpr int EMBED_DENSE0_INPUT_SIZE = INPUT_SIZE;
constexpr int EMBED_DENSE0_WEIGHTS_SIZE = HIDDEN_SIZE * INPUT_SIZE;
constexpr int EMBED_DENSE0_BIAS_SIZE = HIDDEN_SIZE;
constexpr int EMBED_DENSE1_WEIGHTS_PART_SIZE = OUTPUT_SIZE * HIDDEN_SIZE / CASCADE_LENGTH;
constexpr int EMBED_DENSE1_BIAS_SIZE = OUTPUT_SIZE;
constexpr int EMBED_FINAL_OUTPUT_SIZE = OUTPUT_SIZE;
constexpr int EMBED_DENSE2_INPUT_SIZE = 768;
constexpr int EMBED_DENSE2_WEIGHTS_PARTS = 6;
constexpr int EMBED_DENSE2_WEIGHTS_PART_SIZE =
    OUTPUT_SIZE * (EMBED_DENSE2_INPUT_SIZE / EMBED_DENSE2_WEIGHTS_PARTS);

// SUBSOLVER0 graph sizes ---------------------------------------------------
constexpr int SUBSOLVER0_INPUT_SIZE = 768;
constexpr int SUBSOLVER0_INPUT_PARTS = 12;
constexpr int SUBSOLVER0_INPUT_PART_SIZE = SUBSOLVER0_INPUT_SIZE / SUBSOLVER0_INPUT_PARTS;
constexpr int SUBSOLVER0_DENSE0_INPUT_SIZE = SUBSOLVER0_INPUT_SIZE;
constexpr int SUBSOLVER0_DENSE0_WEIGHTS_SIZE = HIDDEN_SIZE * SUBSOLVER0_DENSE0_INPUT_SIZE;
constexpr int SUBSOLVER0_DENSE0_WEIGHTS_PART_SIZE = HIDDEN_SIZE * SUBSOLVER0_INPUT_PART_SIZE;
constexpr int SUBSOLVER0_DENSE0_BIAS_SIZE = HIDDEN_SIZE;
constexpr int SUBSOLVER0_LAYER_WEIGHTS_PARTS = 2;
constexpr int SUBSOLVER0_LAYER_WEIGHTS_PART_SIZE = OUTPUT_SIZE * (HIDDEN_SIZE / SUBSOLVER0_LAYER_WEIGHTS_PARTS);
constexpr int SUBSOLVER0_LAYER_BIAS_SIZE = OUTPUT_SIZE;
constexpr int SUBSOLVER0_DENSE1_WEIGHTS_SIZE = HIDDEN_SIZE * HIDDEN_SIZE;
constexpr int SUBSOLVER0_DENSE1_WEIGHTS_PART_SIZE = SUBSOLVER0_LAYER_WEIGHTS_PART_SIZE;
constexpr int SUBSOLVER0_DENSE1_BIAS_SIZE = SUBSOLVER0_LAYER_BIAS_SIZE;
constexpr int SUBSOLVER0_DENSE2_WEIGHTS_SIZE = HIDDEN_SIZE * HIDDEN_SIZE;
constexpr int SUBSOLVER0_DENSE2_WEIGHTS_PART_SIZE = SUBSOLVER0_LAYER_WEIGHTS_PART_SIZE;
constexpr int SUBSOLVER0_DENSE2_BIAS_SIZE = SUBSOLVER0_LAYER_BIAS_SIZE;
constexpr int SUBSOLVER0_DENSE3_WEIGHTS_SIZE = HIDDEN_SIZE * HIDDEN_SIZE;
constexpr int SUBSOLVER0_DENSE3_WEIGHTS_PART_SIZE = SUBSOLVER0_LAYER_WEIGHTS_PART_SIZE;
constexpr int SUBSOLVER0_DENSE3_BIAS_SIZE = SUBSOLVER0_LAYER_BIAS_SIZE;
constexpr int SUBSOLVER0_FINAL_OUTPUT_SIZE = OUTPUT_SIZE;

constexpr int SOLVER_DENSE0_CASC_LEN = SUBSOLVER0_INPUT_PARTS;
constexpr int SOLVER_DENSEX_CASC_LEN = SUBSOLVER0_LAYER_WEIGHTS_PARTS;

// OUTPUT graph sizes -------------------------------------------------------
constexpr int OUTPUT_DENSE0_INPUT_SIZE = HIDDEN_SIZE;
constexpr int OUTPUT_DENSE0_OUT_PAD = 32;
constexpr int OUTPUT_DENSE0_WEIGHTS_SIZE = OUTPUT_DENSE0_OUT_PAD * HIDDEN_SIZE;
constexpr int OUTPUT_DENSE0_BIAS_SIZE = 32;
constexpr int OUTPUT_FINAL_OUTPUT_SIZE = 32;

constexpr int OUTPUT_DENSE0_CASC_LEN = 1;

// Derived tiling facts ----------------------------------------------------
constexpr int ROLL_CONCAT_TOTAL = ROLL_CONC_SUBSET_SIZE * HIDDEN_SIZE;
static_assert(ROLL_CONCAT_TOTAL % SUBSOLVER0_INPUT_PARTS == 0,
              "ROLL_CONCAT_TOTAL must be divisible by SUBSOLVER0_INPUT_PARTS");
constexpr int ROLL_CONCAT_TILE_SPAN = ROLL_CONCAT_TOTAL / SUBSOLVER0_INPUT_PARTS;
static_assert((SUBSOLVER0_INPUT_PARTS % 2) == 0,
              "SUBSOLVER0_INPUT_PARTS must be even to share buffers evenly");
constexpr int SUBSOLVER0_CASC_PER_BUFFER = SUBSOLVER0_INPUT_PARTS / 2;

// Shim bindings -----------------------------------------------------------
constexpr int AIEML9_INPUT_SHIM = 6;
constexpr int AIEML9_OUTPUT_SHIM = 27;

// Helper for solver duplication -------------------------------------------
constexpr int SOLVER_BRANCHES = 2;

static constexpr int FLOATS_PER_D768_LEG = 8192;      // 32 KB
static constexpr int D768_LEGS_PER_BANK  = 6;         // fanout per memory tile
static constexpr int FLOATS_PER_D128_PART= 8192;      // 32 KB (128x128 split into 2 parts)
static constexpr int D128_TOTAL_PARTS    = 6;         // 3 layers × 2 parts
