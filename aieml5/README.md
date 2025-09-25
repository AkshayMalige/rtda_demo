# AI Engine-ML Graph: Matrix-Vector Multiplication with Stream Interface

This directory demonstrates a **128×8 matrix-vector multiplication** using Xilinx DSPLib
with stream-based data flow (TP_API=1) and runtime parameter (RTP) weight loading.

## Architecture Overview

**Current Configuration:**
- **Matrix A**: 128×8 weights (1024 floats) loaded via RTP ports
- **Vector B**: 8×1 input vector streamed through AIE core
- **Output**: 128×1 result vector
- **TP_API=1**: Stream interface for high-throughput data flow
- **TP_USE_MATRIX_RELOAD=1**: Runtime parameter weight loading

## Directory Layout

```
├── graph.cpp    # Instantiates `NeuralNetworkGraph` and runs it for simulation
├── graph.h      # Graph definition and PLIO connections
└── Makefile
```

## Build

The supplied `Makefile` wraps the standard build flow (now using `v++` so the
`aie.cfg` partition directives take effect). From the repository root, compile
the graph with:

```bash
cd aieml
make graph TARGET=hw       # or TARGET=hw_emu
```

To invoke the compiler directly without the wrapper:

```bash
cd aieml
v++ -c --mode aie --target hw graph.cpp \
    --platform=${PLATFORM} \
    --work_dir=Work \
    --config=aie.cfg \
    --include="./" \
    --include="../common" \
    --include="../dsp_lib/L1/src/aie" \
    --include="../dsp_lib/L1/include/aie" \
    --include="../dsp_lib/L2/include/aie"
```

Both commands produce `Work/libadf.a` inside this directory.

## Simulation

After a successful build, run cycle-approximate simulation:

```bash
make sim                  # uses `aiesimulator` under the hood
# or run manually
# aiesimulator --pkg-dir=Work --profile --dump-vcd=foo
```

## Data Flow for 8×128 Matrix-Vector Multiplication

### Data Path:

1. **Input Vector (8 floats)**:
   - Arrives via PLIO from `layer0_in` → `EMBED_INPUT_DATA` file
   - Streams directly into AIE core via `dense1.inB[0]` (TP_API=1)
   - No buffering - processed as stream

2. **Matrix Weights (1024 floats)**:
   - **NOT** from PLIO (removed `layer0_weights`)
   - Loaded via **RTP (Runtime Parameter)** ports due to `TP_USE_MATRIX_RELOAD=1`
   - Stored in AIE core's local memory banks
   - Can be updated at runtime without recompiling

3. **Computation**:
   - AIE core performs 128×8 matrix-vector multiplication
   - Uses hardware MAC (Multiply-Accumulate) units
   - Single iteration processes entire vector

4. **Output (128 floats)**:
   - Streams out via `dense1.out[0]`
   - Goes to PLIO `layer0_out` → `EMBED_DENSE0_OUTPUT` file

## Hardware Components Involved

### AIE Core Architecture:
1. **Vector Engine**: Handles float32 MAC operations
2. **Local Memory**: 32KB data memory stores matrix weights
3. **Stream Interfaces**: High-throughput data movement
4. **RTP Ports**: Runtime parameter loading for weights

### With TP_API=1 Configuration:
- **Stream Input**: Vector B flows through without buffering
- **RTP Matrix Loading**: Weights loaded once, reused for multiple vectors
- **Stream Output**: Results flow directly to next stage
- **No Window Buffers**: More memory available for weights/intermediate data

## Cascading Strategy for Larger Matrices (128×128)

For larger matrices that don't fit in a single AIE core, use cascading:

### Example: 128×128 Matrix-Vector Multiplication

```cpp
using dense128x128 = matrix_vector_mul_graph<
    float,      // TT_DATA_A
    float,      // TT_DATA_B
    128,        // TP_DIM_A (128 rows)
    128,        // TP_DIM_B (128 cols)
    0,          // TP_SHIFT
    TP_RND,     // TP_RND
    1,          // TP_NUM_FRAMES
    2,          // TP_CASC_LEN = 2 (use 2 AIE cores)
    0,          // TP_SAT
    1,          // TP_SSR
    1,          // TP_DIM_A_LEADING
    1,          // TP_USE_MATRIX_RELOAD=1
    1,          // TP_API=1
    0,          // TP_DUAL_IP
    1>;         // TP_NUM_OUTPUTS
```

### Cascading Architecture:

1. **Core 0**: Handles columns 0-63 (TP_DIM_B/TP_CASC_LEN = 128/2 = 64)
   - Input: 128×1 vector (full)
   - Matrix: 128×64 (first half of columns)
   - Output: 64 partial dot products

2. **Core 1**: Handles columns 64-127
   - Input: 128×1 vector (full)
   - Matrix: 128×64 (second half of columns)
   - Output: 64 partial dot products

3. **Cascade Connection**: Core 0 → Core 1
   - Core 0's partial results cascade to Core 1
   - Core 1 accumulates both results
   - Final 128×1 output from Core 1

### Memory Distribution:
- **Each Core**: Stores 64×128 = 8,192 floats (32KB)
- **Total Weight Storage**: 128×128 = 16,384 floats across both cores
- **Cascade Stream**: Carries partial accumulation results

### Performance Benefits of TP_API=1 with Cascading:

1. **Higher Throughput**: Stream interfaces eliminate buffer copy overhead
2. **Lower Latency**: Data flows through pipeline without waiting
3. **Efficient Memory Usage**: RTP allows runtime weight updates
4. **Scalable Architecture**: Add more cascade stages for larger matrices

### For Even Larger Matrices:

**TP_SSR (Super Sample Rate)**: Use parallel AIE cores
```cpp
// Example: 256×256 matrix with TP_SSR=2, TP_CASC_LEN=2
// Total: 4 AIE cores (2 SSR ranks × 2 cascade stages)
```

**Multi-Layer Cascading**: Chain multiple graph instances
```cpp
// Layer 1: 128×128 → 128×1
// Layer 2: 128×128 → 128×1
// Connected via streams for multi-layer neural networks
```

This architecture provides excellent scalability for neural network acceleration on Versal AI Engines, with stream-based data flow optimized for high-throughput inference.

## Files and Build Instructions

The PLIO files consumed by the graph reside in the project-parent
[`../data/`](../../data) directory. They are generated by
[`data/generate_test_data.py`](../data/generate_test_data.py).


<!-- -0.250920
0.901429
0.463988
0.197317
-0.687963
-0.688011
-0.883833
0.732352 -->