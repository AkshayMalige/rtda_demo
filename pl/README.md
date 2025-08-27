# PL Kernels

This directory contains several Vitis HLS kernels used to move and process data between DDR memory and the AI Engine graph.

## Available kernels
- **switch_mm2s_pl** – memory‑to‑stream mover with a selectable source, allowing the host to switch between multiple input buffers at run time.
- **s2mm_pl** – streams data from the AI Engine back to memory via an AXI master interface.
- **demux_8_pl** – demultiplexes one input stream into eight independent AXI4‑Stream outputs for distribution to downstream kernels.

Each kernel has a matching `*_test.cpp` file (for example, `s2mm_test.cpp`) used for functional validation.

Test benches reference file names from [`common/data_paths.h`](../common/data_paths.h)
and honour the `DATA_DIR` environment variable, which lets you relocate the
text files used during simulation.

## Build scripts
The top-level [Makefile](Makefile) orchestrates all kernel builds using the accompanying TCL scripts:

- `switch_mm2s_project.tcl`
- `s2mm_project.tcl`
- `demux_8_project.tcl`

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
The system project consumes the generated kernels via the `pl_kernels` component defined in [`system_project.yaml`](../system_project.yaml). After building, ensure the expected `.xo` files (for example, `switch_mm2s_8_128.xo` or `demux_8.xo`) reside in `pl/build_<target>/` so the link step can find them.

## Testing
Run `make sim` or invoke `vitis_hls -f <kernel>_project.tcl csim` to execute the C++ test benches. These tests verify kernel functionality before synthesis.
