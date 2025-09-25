#pragma once
#include <adf.h>
#include "nn_defs.h"

void pkt_to_stream(input_pktstream *in, output_stream<float> *out);