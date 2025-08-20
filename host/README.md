# Host Application

## Overview
`host.cpp` orchestrates the execution of the ML inference pipeline on the Versal platform. The application loads an `xclbin` bitstream, reads input and weight files from the parent `../data/` directory, allocates device buffers, and coordinates the PL kernels and AIE graph using the XRT C++ API. Based on the `--graph` argument, the host populates kernel lists and buffer sizes for `aieml`, `aieml2`, or `aieml3` and streams the required data through `mm2s` kernels. Intermediate results pass through leaky ReLU and splitter stages in the programmable logic, and final outputs are collected via an `s2mm` kernel for verification.

### Dependencies
- XRT headers and libraries for C++17 (experimental API)
- Cross-compilation sysroot for PetaLinux (default: `/opt/petalinux/2024.2/sysroots/cortexa72-cortexa53-xilinx-linux`)
- Data files defined in [`common/data_paths.h`](../common/data_paths.h)

File names for inputs, weights, and outputs are centralized in
[`common/data_paths.h`](../common/data_paths.h).  Set the `DATA_DIR`
environment variable to point the host application to the directory
containing these files (defaults to `../data`).

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
Run the executable on a Versal device running PetaLinux with XRT support.  Select which graph to drive using `--graph` (defaults to `aieml`):

```bash
./system_host a.xclbin --graph=aieml2
```

The host starts consumer kernels (`s2mm`, required `leaky_relu` instances, and any `leaky_splitter` kernels), launches the AIE graph, then drives producer kernels (`mm2s` instances) to stream inputs, weights, and biases. The application waits for completion and dumps the results to standard output. Kernel instance names must match those declared in the linker configuration.