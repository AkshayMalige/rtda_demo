#pragma once
#include <adf.h>
#include "nn_defs.h"

using namespace adf;

void pkt_to_stream_with_routing(input_pktstream *in, output_stream<float> *out);