// Path resolution ---------------------------------------------------------
#pragma once
#include <cstdlib>

#ifndef DATA_DIR
#define DATA_DIR (std::getenv("DATA_DIR") ? std::getenv("DATA_DIR") : "../data")
#endif

// EMBED graph files -------------------------------------------------------
#define EMBED_INPUT_DATA            "embed_input.txt"
#define EMBED_DENSE0_WEIGHTS        "embed_dense_0_weights.txt"
#define EMBED_DENSE0_OUTPUT         "embed_dense_0_output_aie.txt"
#define EMBED_LEAKYRELU0_OUTPUT_PREFIX "embed_leakyrelu_0_output_part"
#define EMBED_DENSE1_WEIGHTS_PREFIX "embed_dense_1_weights_part"
#define EMBED_DENSE2_WEIGHTS_PREFIX "embed_dense_2_weights_part"
#define EMBED_DENSE1_OUTPUT         "embed_dense_1_output_aie.txt"
#define DUMMY_OUTPUT         "dummy_output_aie.txt"

#define EMBED_DENSE0_BIAS           "embed_dense_0_bias.txt"
#define EMBED_DENSE1_BIAS           "embed_dense_1_bias.txt"
#define EMBED_MODEL_OUTPUT           "embed_model_output.txt"


// SUBSOLVER0 graph files --------------------------------------------------
#define SUBSOLVER0_INPUT_DATA_PREFIX   "solver_0_input_part"
#define SUBSOLVER0_DENSE0_WEIGHTS_PREFIX "solver_0_dense_0_weights_part"
#define SUBSOLVER0_DENSE0_OUTPUT       "solver_0_dense_0_output_aie.txt"
#define SUBSOLVER0_LEAKYRELU_0_PREFIX  "solver_0_leakyrelu_0_output_part"
#define SUBSOLVER0_DENSE1_WEIGHTS_PREFIX "solver_0_dense_1_weights_part"
#define SUBSOLVER0_DENSE1_OUTPUT       "solver_0_dense_1_output_aie.txt"
#define SUBSOLVER0_LEAKYRELU_1_PREFIX  "solver_0_leakyrelu_1_output_part"
#define SUBSOLVER0_DENSE2_WEIGHTS_PREFIX "solver_0_dense_2_weights_part"
#define SUBSOLVER0_DENSE2_OUTPUT       "solver_0_dense_2_output_aie.txt"
#define SUBSOLVER0_LEAKYRELU_2_PREFIX  "solver_0_leakyrelu_2_output_part"
#define SUBSOLVER0_DENSE3_WEIGHTS_PREFIX "solver_0_dense_3_weights_part"
#define SUBSOLVER0_DENSE3_OUTPUT       "solver_0_dense_3_output_aie.txt"
#define SUBSOLVER0_DENSE0_BIAS         "solver_0_dense_0_bias.txt"
#define SUBSOLVER0_DENSE1_BIAS         "solver_0_dense_1_bias.txt"
#define SUBSOLVER0_DENSE2_BIAS         "solver_0_dense_2_bias.txt"
#define SUBSOLVER0_DENSE3_BIAS         "solver_0_dense_3_bias.txt"
#define SUBSOLVER0_HOST_OUTPUT         "solver_0_host_output.txt"

// OUTPUT graph files ------------------------------------------------------
#define OUTPUT_INPUT_DATA           "output_input.txt"
#define OUTPUT_DENSE0_WEIGHTS       "output_dense_0_weights.txt"
#define OUTPUT_DENSE0_OUTPUT        "output_dense_0_output_aie.txt"
#define OUTPUT_DENSE0_BIAS          "output_dense_0_bias.txt"
#define OUTPUT_HOST_OUTPUT          "output_host_output.txt"

// Miscellaneous -----------------------------------------------------------
#define EMBED_HOST_OUTPUT           "host_output.txt"

