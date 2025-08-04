# Programmable Logic Kernels

This directory holds Vitis HLS projects for the programmable logic. Kernels provide data movement and activation support for the AI Engine graph, including:

- `mm2s` / `s2mm` for memory-to-stream and stream-to-memory transfers
- `leaky_relu` for activation
- `leaky_splitter` for distributing data to multiple streams

## Build

Use the Makefile to synthesize all kernels:

```bash
make kernels   # run Vitis HLS to build all kernels
make sim       # optional: run C or co-simulation
```

Generated IP appears under `ip/` and can be consumed during system linking.
