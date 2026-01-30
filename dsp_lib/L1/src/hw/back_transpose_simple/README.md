# DSP Library – Back Transpose (Simple)

`back_transpose_simple` is part of AMD's Vitis DSPlib and remains vendor-supplied code. The AI Engine inference design ships this module so the graph can reference the original SSR stream utilities if we experiment with alternative data layouts. The production graph currently implements its own window splitters and does not instantiate this kernel, but keeping it in-tree means you can rebuild historical configurations without fetching the DSPlib again.

## Original Behaviour (for reference)

For `SSR = 4` and `POINT_SIZE = 64`, the transpose reorders four super-sampled input streams so the merged output lists all samples from stream 0, then stream 1, and so on.

- Input stream 0: `0 4 8 12 … 60`
- Input stream 1: `1 5 9 13 … 61`
- Input stream 2: `2 6 10 14 … 62`
- Input stream 3: `3 7 11 15 … 63`

Outputs:

- Output stream 0: `0 16 32 48 1 17 …`
- Output stream 1: `4 20 36 52 5 21 …`
- Output stream 2: `8 24 40 56 9 25 …`
- Output stream 3: `12 28 44 60 13 29 …`

## License

 Copyright (C) 2019-2022, Xilinx, Inc.
 Copyright (C) 2022-2025, Advanced Micro Devices, Inc.
Terms and Conditions <https://www.amd.com/en/corporate/copyright>
