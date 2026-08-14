#pragma once
#include "ap_fixed.h"
#include "ap_int.h"
#include "hls_stream.h"

// Include all nnet utils at global scope so proxy namespaces don't re-include them
#include "nnet_utils/nnet_types.h"
#include "nnet_utils/nnet_code_gen.h"
#include "nnet_utils/nnet_helpers.h"
#include "nnet_utils/nnet_activation.h"
#include "nnet_utils/nnet_activation_stream.h"
#include "nnet_utils/nnet_dense.h"
#include "nnet_utils/nnet_dense_compressed.h"
#include "nnet_utils/nnet_dense_stream.h"
#include "nnet_utils/nnet_merge.h"
#include "nnet_utils/nnet_merge_stream.h"

#define N_TRACKS   50
#define INPUT_SIZE 6
#define HIDDEN     128
#define OUT_DIM    27
#define WARMUP     3

// Canonical inter-kernel types
typedef nnet::array<ap_fixed<16,6>, INPUT_SIZE> embed_in_t;
typedef nnet::array<ap_fixed<16,6>, HIDDEN>     hidden_t;
typedef nnet::array<ap_fixed<16,6>, OUT_DIM>    out27_t;

// Proxy function declarations (each defined in its own TU to isolate sub-project types)
void embed_run  (hls::stream<embed_in_t>&, hls::stream<hidden_t>&);
void solver0_run(hls::stream<hidden_t>&, hls::stream<hidden_t>&, hls::stream<hidden_t>&);
void solver1_run(hls::stream<hidden_t>&, hls::stream<hidden_t>&, hls::stream<hidden_t>&);
void solver2_run(hls::stream<hidden_t>&, hls::stream<hidden_t>&, hls::stream<hidden_t>&);
void output_run (hls::stream<hidden_t>&, hls::stream<out27_t>&);

// Top-level kernel
extern "C" void rtda_split_top(float* track_data, float* result, int n_tracks, bool reset);
