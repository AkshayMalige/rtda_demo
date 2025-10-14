// Path resolution ---------------------------------------------------------
#pragma once
#include <cstdlib>

#ifndef DATA_DIR
#define DATA_DIR (std::getenv("DATA_DIR") ? std::getenv("DATA_DIR") : "../data")
#endif


// EMBED graph files --------------------------------------------------

#define EMBED_INPUT_DATA            "embed_input.txt"
#define EMBED_DENSE0_WEIGHTS        "embed_dense_0_weights.txt"

#define EMBED_DENSE1_WEIGHTS_PREFIX "embed_dense_1_weights_part"

#define EMBED_DENSE0_BIAS           "embed_dense_0_bias.txt"
#define EMBED_DENSE1_BIAS           "embed_dense_1_bias.txt"

// SUBSOLVER-0 graph files --------------------------------------------------

#define SUBSOLVER0_DENSE0_WEIGHTS_PREFIX "solver_0_dense_0_weights_part"
#define SUBSOLVER0_DENSE1_WEIGHTS_PREFIX "solver_0_dense_1_weights_part"
#define SUBSOLVER0_DENSE2_WEIGHTS_PREFIX "solver_0_dense_2_weights_part"
#define SUBSOLVER0_DENSE3_WEIGHTS_PREFIX "solver_0_dense_3_weights_part"
#define SUBSOLVER0_DENSE0_BIAS         "solver_0_dense_0_bias.txt"
#define SUBSOLVER0_DENSE1_BIAS         "solver_0_dense_1_bias.txt"
#define SUBSOLVER0_DENSE2_BIAS         "solver_0_dense_2_bias.txt"
#define SUBSOLVER0_DENSE3_BIAS         "solver_0_dense_3_bias.txt"

// SUBSOLVER-1 graph files --------------------------------------------------

#define SUBSOLVER1_DENSE0_WEIGHTS_PREFIX "solver_0_dense_0_weights_part"
#define SUBSOLVER1_DENSE1_WEIGHTS_PREFIX "solver_0_dense_1_weights_part"
#define SUBSOLVER1_DENSE2_WEIGHTS_PREFIX "solver_0_dense_2_weights_part"
#define SUBSOLVER1_DENSE3_WEIGHTS_PREFIX "solver_0_dense_3_weights_part"
#define SUBSOLVER1_DENSE0_BIAS         "solver_0_dense_0_bias.txt"
#define SUBSOLVER1_DENSE1_BIAS         "solver_0_dense_1_bias.txt"
#define SUBSOLVER1_DENSE2_BIAS         "solver_0_dense_2_bias.txt"
#define SUBSOLVER1_DENSE3_BIAS         "solver_0_dense_3_bias.txt"

// SUBSOLVER-2 graph files --------------------------------------------------

#define SUBSOLVER2_DENSE0_WEIGHTS_PREFIX "solver_0_dense_0_weights_part"
#define SUBSOLVER2_DENSE1_WEIGHTS_PREFIX "solver_0_dense_1_weights_part"
#define SUBSOLVER2_DENSE2_WEIGHTS_PREFIX "solver_0_dense_2_weights_part"
#define SUBSOLVER2_DENSE3_WEIGHTS_PREFIX "solver_0_dense_3_weights_part"
#define SUBSOLVER2_DENSE0_BIAS         "solver_0_dense_0_bias.txt"
#define SUBSOLVER2_DENSE1_BIAS         "solver_0_dense_1_bias.txt"
#define SUBSOLVER2_DENSE2_BIAS         "solver_0_dense_2_bias.txt"
#define SUBSOLVER2_DENSE3_BIAS         "solver_0_dense_3_bias.txt"

// OUTPUT graph files --------------------------------------------------

#define OUTPUT_DENSE0_WEIGHTS       "output_dense_0_weights.txt"

#define EMBED_HOST_OUTPUT           "host_output.txt"

#define AIEML10_OUTPUT_FILE         "aieml10_output_aie.txt"
