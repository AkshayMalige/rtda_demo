// Path resolution ---------------------------------------------------------
#pragma once
#include <cstdlib>

#ifndef DATA_DIR
#define DATA_DIR (std::getenv("DATA_DIR") ? std::getenv("DATA_DIR") : "./data")
#endif


// EMBED graph files --------------------------------------------------

#define EMBED_INPUT_DATA            "embed_input.txt"
#define EMBED_DENSE0_WEIGHTS        "embed_dense_0_weights.txt"
#define AIEML10_OUTPUT_FILE         "aieml10_output_aie.txt"
#define EMBED_HOST_OUTPUT           "host_output.txt"

