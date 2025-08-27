# System Project Overview

The `system_project.yaml` file describes how the host application, AI Engine-ML graph, PL kernels, and the hardware link output are combined into a complete design for the VEK280 platform.

## Components

- **host_app** – Linux application running on the PS that manages buffer allocation, device control, and execution of the accelerated graph.
- **aie_graph** – AI Engine-ML graph implementing dense1 and dense2.
- **pl_kernels** – Precompiled data-mover kernels (`s2mm_hls.xo`, `switch_mm2s_hls.xo`, `demux_8_hls.xo`) that stream data between DDR and the AIE array.
- **hw_link_output** – The hardware linkage output (`design_hw_emu.xsa`) that ties the PS, PL, and AIE-ML domains into a single platform image.

## Building the System

1. Source the Vitis environment:
   ```bash
   source /tools/Xilinx/Vitis/2024.2/settings64.sh
   ```
2. Invoke the system build using the YAML description:
   ```bash
   v++ --project system_project.yaml
   ```
   The target (default `hw_emu`) and platform are taken from the YAML file.

The build produces a packaged `.xclbin` under `package.hw_emu/` ready for emulation or deployment.

## High-Level Architecture

```
+-------------+       AXI/XRT        +-------------+
|  Host (PS)  | <------------------> | PL Kernels  |
+-------------+                      +-------------+
        |                                 |
        | Streams via switch_mm2s/demux_8/s2mm |
        v                                 v
      +-------------------------------------+
      |            AIE-ML Graph             |
      +-------------------------------------+
```

The host program coordinates execution, the PL kernels move data between memory and the AI Engine array, and the hardware link output packages everything into a runnable design.
