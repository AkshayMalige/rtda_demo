#pragma once
#include <adf.h>
#include "nn_defs.h"

void packet_to_stream_kernel(input_pktstream *in, output_stream<float> *out);