#include "pkt_to_stream_with_routing.h"
#include <aie_api/aie.hpp>
#include <cstdint>

void pkt_to_stream_with_routing(input_pktstream *in, output_stream<float> *out) {
    while (true) {
        // Check packet ID using getPacketid API
        uint32_t packet_id = getPacketid(in, 0);

        if (packet_id == 0) {  // Only process packets for dense1
            bool tlast = false;

            // Read and discard packet header word
            readincr(in);

            // Convert EMBED_DENSE0_INPUT_SIZE floats from packet to stream
            for (int i = 0; i < EMBED_DENSE0_INPUT_SIZE; ++i) {
                int32_t raw = readincr(in, tlast);
                union {
                    int32_t i;
                    float f;
                } converter{raw};
                writeincr(out, converter.f);
            }

            // Ensure the packet ended where expected to avoid desynchronization
            if (!tlast) {
                do {
                    int32_t raw = readincr(in, tlast);
                } while (!tlast);
            }
        } else {
            // Discard packets that don't match our target ID
            bool tlast = false;
            do {
                readincr(in, tlast);
            } while (!tlast);
        }
    }
}