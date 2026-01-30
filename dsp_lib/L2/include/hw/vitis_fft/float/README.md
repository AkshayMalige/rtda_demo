# DSP Library – L2 FFT (Floating Point)

This folder mirrors the single-precision floating-point FFT interfaces from the AMD Vitis DSP library. Even though the shipping AI Engine design focuses on dense layers and never instantiates these kernels, we vendor the headers so the build is self-contained and future DSP experiments remain straightforward.

## Project Usage

- Included through `DSPLIB_PATH` during both AI Engine compilation and simulation.
- Safe to leave untouched; replace them only when updating to a newer official DSPlib drop.

## License

 Copyright (C) 2019-2022, Xilinx, Inc.
 Copyright (C) 2022-2025, Advanced Micro Devices, Inc.

Terms and Conditions <https://www.amd.com/en/corporate/copyright>
