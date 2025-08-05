#include <adf.h>
using namespace adf;

void win2stream(input_window<float>* in, output_stream<float>* out)
{
    constexpr int SIZE = 128;
    for (int i = 0; i < SIZE; ++i) {
        float val = window_readincr(in);
        writeincr(out, val);
    }
}