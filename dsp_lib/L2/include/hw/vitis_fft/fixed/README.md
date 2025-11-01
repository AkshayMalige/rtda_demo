# DSP Library – L2 FFT (Fixed Point)

These headers are pulled directly from AMD's Vitis DSP library and expose the fixed-point variants of the hierarchical FFT blocks. Our AI Engine inference graph does not currently instantiate these kernels, but the headers stay in-tree so the build can compile against a consistent DSPlib snapshot without fetching external dependencies.

## Project Usage

- `set_envs.sh` exports `DSPLIB_PATH` to this repository so both AIE simulation and hardware builds resolve the headers.
- You can safely leave the contents untouched; any upgrades should come from the official DSPlib release to maintain licensing and API compatibility.

## License

 Copyright (C) 2019-2022, Xilinx, Inc.
 Copyright (C) 2022-2025, Advanced Micro Devices, Inc.

Terms and Conditions <https://www.amd.com/en/corporate/copyright>
