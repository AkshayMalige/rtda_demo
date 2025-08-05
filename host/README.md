# Host Application

## Overview
`host.cpp` orchestrates the execution of the ML inference pipeline on the Versal platform. The application loads an `xclbin` bitstream, reads input and weight files from the local `data/` directory, allocates device buffers, and coordinates the PL kernels and AIE graph using the XRT C++ API. Data is streamed to the design through multiple `mm2s` kernels, intermediate results pass through two leaky ReLU stages and a splitter in the programmable logic, and final outputs are collected via an `s2mm` kernel for verification.

### Dependencies
- XRT headers and libraries for C++17 (experimental API)
- Cross-compilation sysroot for PetaLinux (default: `/opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux`)
- Data files: `input_data.txt`, `weights_dense1.txt`, `weights_dense2_part0.txt`, `weights_dense2_part1.txt`

## Build
The provided `Makefile` cross-compiles the host application for AArch64.

```bash
cd host
make                    # builds `system_host`
make clean               # removes build artifacts
```

You may override `SYSROOT` to match your PetaLinux installation:

```bash
make SYSROOT=/path/to/sysroot
```

Ensure the cross-compiler (`aarch64-linux-gnu-g++`) and XRT development files are available in the environment.

## Runtime
Run the executable on a Versal device running PetaLinux with XRT support:

```bash
./system_host a.xclbin
```

`host.cpp` starts consumer kernels (`s2mm`, two `leaky_relu` instances, `splitter`), launches the AIE graph, then drives producer kernels (`mm2s` instances) to stream inputs and weights. The application waits for completion and dumps the first few results to standard output. The hardware design must expose matching kernel instance names in the `xclbin` (e.g., `mm2s_pl:{mm2s_din}`, `g` for the AIE graph).