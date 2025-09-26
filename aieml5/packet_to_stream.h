#pragma once

#include <adf.h>

#include "nn_defs.h"

void packet_to_stream_kernel(adf::input_pktstream* in, adf::output_stream<float>* out);
void packet_to_stream_hidden_kernel(adf::input_pktstream* in, adf::output_stream<float>* out);
