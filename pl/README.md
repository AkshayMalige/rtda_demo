# PL Kernels

This directory contains Vitis HLS kernels used to move and process data.

## Available kernels
- **demux_8_pl** – routes packets from a single AXI4-Stream input to one of eight outputs based on the packet TDEST field.
- **switch_mm2s_pl** – reads packetised data from memory and forwards it to an AXI4-Stream, tagging each word with a bus ID.

Each kernel has a matching `*_test.cpp` file used for functional validation.

Test benches reference file names from [`common/data_paths.h`](../common/data_paths.h)
and honour the `DATA_DIR` environment variable, which lets you relocate the
text files used during simulation.

## Build scripts
The top-level [Makefile](Makefile) orchestrates all kernel builds using the accompanying TCL scripts:

- `demux_8_project.tcl`
- `switch_mm2s_project.tcl`

The default target list can be overridden using the `KERNELS` variable. Useful commands:

```bash
cd pl
make kernels           # synthesize and export all kernels
make sim TARGET=csim   # run C simulation for listed kernels
make sim TARGET=hw_emu # run co-simulation for hardware emulation
make clean             # remove generated outputs
```

Synthesis places exported XO/IP files in the `ip/` directory.

## Testing
Run `make sim` or invoke `vitis_hls -f <kernel>_project.tcl csim` to execute the C++ test benches. These tests verify kernel functionality before synthesis.
