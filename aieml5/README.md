# AI Engine-ML Graph: Packet-Based Neural Network with Stream Processing

This directory demonstrates a **packet-based neural network processing pipeline** using Xilinx DSPLib
with stream-based data flow, packet routing, and runtime parameter (RTP) weight loading.

## Architecture Overview

**Current Configuration:**
- **Neural Network**: Single dense layer (8×128 matrix-vector multiplication)
- **Matrix A**: 8×128 weights (1024 floats) loaded via RTP ports
- **Vector B**: 8×1 input vector processed through packet stream
- **Output**: 128×1 result vector
- **Packet Processing**: Custom packetization and routing kernels
- **TP_API=1**: Stream interface for high-throughput data flow
- **TP_USE_MATRIX_RELOAD=1**: Runtime parameter weight loading

## Directory Layout

```
├── graph.cpp                        # Instantiates `NeuralNetworkGraph` and runs it for simulation
├── graph.h                          # Graph definition with packet processing pipeline
├── packetize.cpp/h                  # Converts float stream to packet stream
├── pkt_to_stream_with_routing.cpp/h # Routes packets and converts back to float stream
├── leaky_relu.cpp/h                 # Leaky ReLU activation function (unused in current flow)
├── aie.cfg                          # AIE configuration file
└── Makefile                         # Build configuration
```

## Build

The supplied `Makefile` wraps the standard build flow using `v++` with AIE configuration.
From this directory, compile the graph with:

```bash
make graph TARGET=hw       # or TARGET=hw_emu (default: hw)
make all                   # same as 'make graph'
```

To invoke the compiler directly:

```bash
v++ -c --mode aie --target hw graph.cpp leaky_relu.cpp \
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

## Data Flow for Packet-Based Neural Network Processing

### Packet Processing Pipeline:

1. **Input Vector (8 floats)**:
   - Arrives via PLIO from `layer0_in` → `EMBED_INPUT_DATA` file
   - **Float Stream** → `packetize_kernel` → **Packet Stream**
   - Packet header includes ID, type, and payload length

2. **Packet Routing and Conversion**:
   - **Packet Stream** → `pkt_to_stream_with_routing` → **Float Stream**
   - Kernel checks packet ID (only processes ID=0 for dense1)
   - Converts packet data back to float stream for neural network

3. **Matrix-Vector Multiplication**:
   - **Matrix A (8×128 weights)**: Loaded via **RTP (Runtime Parameter)** ports
   - **Vector B (8×1 input)**: Processed through packet → stream conversion
   - AIE core performs 8×128 matrix-vector multiplication using DSPLib
   - Uses hardware MAC (Multiply-Accumulate) units

4. **Output (128 floats)**:
   - Streams out via `dense1.out[0]`
   - Goes to PLIO `layer0_out` → `EMBED_DENSE0_OUTPUT` file

## Hardware Components Involved

### AIE Kernels in Pipeline:
1. **Packetize Kernel** (`packetize_kernel`):
   - Converts float stream to packet stream
   - Adds packet header with ID and type information
   - Uses `getPacketid()` for router-assigned packet IDs

2. **Packet-to-Stream Routing Kernel** (`pkt_to_stream_with_routing`):
   - Routes packets based on ID (only processes ID=0)
   - Converts packet data back to float stream
   - Discards non-matching packets

3. **DSPLib Matrix-Vector Multiplication** (`dense8x128`):
   - Performs 8×128 matrix-vector multiplication
   - Uses hardware MAC operations with TP_API=1 stream interface
   - Matrix weights loaded via RTP ports

### AIE Core Architecture:
- **Vector Engine**: Handles float32 MAC operations
- **Local Memory**: 32KB data memory stores matrix weights
- **Stream Interfaces**: High-throughput data movement between kernels
- **Packet Streams**: Support for packetized data with routing
- **RTP Ports**: Runtime parameter loading for neural network weights

## Key Design Features

### Packet-Based Architecture Benefits:
1. **Routing Flexibility**: Packets can be routed to different processing cores
2. **Multiplexing Support**: Multiple data streams can share packet infrastructure
3. **Protocol Compatibility**: Enables integration with PL packet processing
4. **Error Detection**: Packet headers provide data integrity checking

### Current Implementation Details:
- **Packet Type**: 0 (configurable for different data types)
- **Packet ID**: 0 (assigned by router, filtered by routing kernel)
- **Payload Size**: 8 floats (EMBED_DENSE0_INPUT_SIZE)
- **Matrix Dimensions**: 8×128 (INPUT_SIZE × HIDDEN_SIZE from nn_defs.h)

### Expansion for Multi-Layer Networks:
This packet-based approach can be extended for larger neural networks by:

```cpp
// Example: Multi-layer with different packet IDs
// Packet ID 0: Layer 1 input (8×128)
// Packet ID 1: Layer 2 input (128×128)
// Packet ID 2: Output layer input
```

### Integration with PL Domain:
The packet-based design enables seamless integration with the broader system:

1. **System-Level Data Flow**:
   - PL kernels can generate packets for AIE processing
   - AIE can output packets back to PL for post-processing
   - Common packet format enables interoperability

2. **Multi-Domain Processing**:
   - Neural network inference in AIE domain
   - Pre/post-processing in PL domain
   - Unified packet-based communication protocol

This packet-based neural network architecture provides a foundation for scalable AI acceleration on Versal AI Engines, with efficient stream processing and flexible data routing capabilities.

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