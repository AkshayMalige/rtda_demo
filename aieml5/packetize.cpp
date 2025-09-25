#include "packetize.h"
#include "nn_defs.h"




#include <adf.h>
using namespace adf;

constexpr unsigned PKT_TYPE = 0;                 // your tag
constexpr unsigned LEN      = EMBED_DENSE0_INPUT_SIZE;

void packetize_kernel(input_stream<float>*  in_stream,
                      output_pktstream*     out_pkt) {
  // Discover the router-assigned packet ID for this output branch
  unsigned id = getPacketid(out_pkt, /*index*/ 0);

  // Emit the packet header (ID + type). This is the metadata getPacketid() observes downstream.
  writeHeader(out_pkt, PKT_TYPE, id);

  // Stream out LEN float32 samples; mark the last one with TLAST
  for (unsigned i = 0; i < LEN; ++i) {
    float    x = readincr(in_stream);
    int32_t  w = *reinterpret_cast<int32_t*>(&x);    // bit-cast float -> 32-bit word
    bool     last = (i == LEN - 1);
    writeincr(out_pkt, w, last);
  }
}
