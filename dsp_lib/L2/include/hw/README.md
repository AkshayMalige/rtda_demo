# DSP Library Hardware Includes (L2)

This directory vendors the AMD Vitis DSP library headers that back the AI Engine build. Although the current RTDA demo executes a dense network with no PL kernels, we keep these headers so the AI Engine compiler can resolve FFT utility templates and helper data types used by the graph toolchain.

## Role In The Project

- Provides the canonical `vitis_fft` and `vitis_2dfft` building blocks for 1D/2D FFTs in both floating- and fixed-point precision.
- Served to the build through `DSPLIB_PATH` (defaulting to `<repo>/dsp_lib`) as configured by `set_envs.sh` and the top-level `Makefile`.
- Remains untouched vendor code—no custom modifications are required for the AI Engine–only flow.

If you need to upgrade to a newer DSP library release, drop the updated package here and keep `DSPLIB_PATH` pointing to this location.

## License

 Copyright (C) 2019-2022, Xilinx, Inc.
 Copyright (C) 2022-2025, Advanced Micro Devices, Inc.

Terms and Conditions <https://www.amd.com/en/corporate/copyright>
