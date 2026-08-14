# DSP Library – L1 FFT Includes

The level-1 FFT interfaces from AMD's Vitis DSPlib are mirrored here. They remain part of the repository so AI Engine compilation succeeds even on clean machines with no external DSPlib installation.

## Project Usage

- Pulled in through `DSPLIB_PATH` when building or simulating the AI Engine graph.
- Not touched by the dense network at runtime, yet kept to enable quick experiments with standard DSPlib kernels.

## License

 Copyright (C) 2019-2022, Xilinx, Inc.
 Copyright (C) 2022-2025, Advanced Micro Devices, Inc.

Terms and Conditions <https://www.amd.com/en/corporate/copyright>
