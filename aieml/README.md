# AI Engine-ML Graph

This directory contains the AI Engine-ML graph implementing the `dense1 → leaky_relu → dense2` pipeline. Source files such as `graph.cpp` and kernels in `kernels/` compile into `libadf.a` for integration with the rest of the system.

## Build

```bash
make graph    # compile the graph into Work/libadf.a
make sim      # optional: run aiesimulator or x86sim depending on TARGET
```

The `data/` subdirectory hosts utilities like `generate_test_data.py` for creating input stimuli and reference outputs.
