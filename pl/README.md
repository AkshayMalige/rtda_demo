# PL Kernels

This directory contains several Vitis HLS kernels used to move and process data between DDR memory and the AI Engine graph.

## Available kernels
- **mm2s_pl** – transfers `float` words from memory to an AXI4-Stream interface using an AXI master port and a simple pipeline loop.
- **s2mm_pl** – reads data from an AXI4-Stream and writes it back to memory through an AXI master port.
- **leaky_relu_pl** – leaky ReLU stage; the system instantiates two of these kernels.
- **leaky_splitter_pl** – splits a single input stream into multiple cascaded outputs.

Each kernel has a matching `*_test.cpp` file (for example, `mm2s_test.cpp`) used for functional validation.

## Build scripts
The top-level [Makefile](Makefile) orchestrates all kernel builds using the accompanying TCL scripts:

- `mm2s_project.tcl`
- `s2mm_project.tcl`
- `leaky_relu_project.tcl`
- `leaky_splitter_project.tcl`

The default target list can be overridden using the `KERNELS` variable. Useful commands:

```bash
cd pl
make kernels           # synthesize and export all kernels
make sim TARGET=csim   # run C simulation for listed kernels
make sim TARGET=hw_emu # run co-simulation for hardware emulation
make clean             # remove generated outputs
```

Synthesis places exported XO/IP files in the `ip/` directory. When preparing a system build, copy or link the required `*.xo` into a build folder such as `build_hw_emu/` referenced by `system_project.yaml`.

## Integration with the system project
The system project consumes the generated kernels via the `pl_kernels` component defined in [`system_project.yaml`](../system_project.yaml). After building, ensure the expected `.xo` files (e.g. `mm2s_8_128.xo`) reside in `pl/build_<target>/` so the link step can find them.

## Testing
Run `make sim` or invoke `vitis_hls -f <kernel>_project.tcl csim` to execute the C++ test benches. These tests verify kernel functionality before synthesis.