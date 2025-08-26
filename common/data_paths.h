// Path resolution ---------------------------------------------------------
#pragma once
#include <cstdlib>

#ifndef DATA_DIR
#define DATA_DIR (std::getenv("DATA_DIR") ? std::getenv("DATA_DIR") : "../data")
#endif

// EMBED graph files -------------------------------------------------------
#define EMBED_INPUT_DATA            "embed_input.txt"
#define EMBED_DENSE0_WEIGHTS        "embed_dense_0_weights.txt"
#define EMBED_DENSE1_WEIGHTS_PREFIX "embed_dense_1_weights_part"
#define EMBED_DENSE0_BIAS           "embed_dense_0_bias.txt"
#define EMBED_DENSE1_BIAS           "embed_dense_1_bias.txt"
