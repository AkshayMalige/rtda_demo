#pragma once

#include <adf.h>

#include "nn_defs.h"

/**
 * @brief Packetises hidden-layer activations for cascade fan-out.
 *
 * The kernel consumes @c HIDDEN_SIZE floating-point activations from the
 * LeakyReLU output stream, wraps them into @c CASCADE_LENGTH packets, and emits
 * them on a packet stream such that each cascade branch receives
 * @c HIDDEN_SIZE / CASCADE_LENGTH samples.
 */
void hidden_stream_to_packet_kernel(adf::input_stream<float>* in_stream,
                                    adf::output_pktstream* out_pkt);
