# AI Engine-ML Graph: ADF Packet-Switched Neural Network with Stream Processing

This directory demonstrates a **ADF packet-switched neural network processing pipeline** using Xilinx DSPLib
with stream-based data flow, ADF packet switching infrastructure, and runtime parameter (RTP) weight loading.

## Architecture Overview

**Current Configuration:**
- **Neural Network**: Single dense layer (8×128 matrix-vector multiplication)
- **Matrix A**: 8×128 weights (1024 floats) loaded via RTP ports
- **Vector B**: 8×1 input vector processed through packet stream
- **Output**: 128×1 result vector
- **Packet Processing**: ADF packet switching with pktsplit/pktmerge infrastructure
- **TP_API=1**: Stream interface for high-throughput data flow
- **TP_USE_MATRIX_RELOAD=1**: Runtime parameter weight loading

## Directory Layout

```
├── graph.cpp                        # Instantiates `NeuralNetworkGraph` and runs it for simulation
├── graph.h                          # Graph definition with packet processing pipeline
├── packetize.cpp/h                  # Converts float stream to packet stream
├── pkt_to_stream.cpp/h               # Converts packet stream back to float stream
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
v++ -c --mode aie --target hw graph.cpp leaky_relu.cpp packetize.cpp pkt_to_stream.cpp \
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

## Data Flow for ADF Packet-Switched Neural Network Processing

### ADF Packet Switching Pipeline:

1. **Input Vector (8 floats)**:
   - Arrives via PLIO from `layer0_in` → `EMBED_INPUT_DATA` file
   - **Float Stream** → `packetize_kernel` → **Packet Stream**
   - Packet header automatically managed by ADF infrastructure

2. **ADF Packet Routing**:
   - **Packet Stream** → `pktsplit<1>` → **Routed Packet Stream**
   - ADF automatically handles packet ID assignment and routing
   - No manual packet ID checking required

3. **Packet-to-Stream Conversion**:
   - **Routed Packet Stream** → `pkt_to_stream` → **Float Stream**
   - Simple conversion without manual routing logic
   - ADF ensures packets reach the correct destination

4. **Matrix-Vector Multiplication**:
   - **Matrix A (8×128 weights)**: Loaded via **RTP (Runtime Parameter)** ports
   - **Vector B (8×1 input)**: Processed through ADF packet switching
   - AIE core performs 8×128 matrix-vector multiplication using DSPLib
   - Uses hardware MAC (Multiply-Accumulate) units

5. **Output (128 floats)**:
   - Streams out via `dense1.out[0]`
   - Goes to PLIO `layer0_out` → `EMBED_DENSE0_OUTPUT` file

## Hardware Components Involved

### AIE Kernels in Pipeline:
1. **Packetize Kernel** (`packetize_kernel`):
   - Converts float stream to packet stream
   - Uses `getPacketid()` for ADF-assigned packet IDs
   - Automatic packet header generation with ADF infrastructure

2. **ADF Packet Splitter** (`pktsplit<1>`):
   - Built-in ADF packet switching primitive
   - Automatically routes packets based on ID
   - No custom routing logic required

3. **Packet-to-Stream Kernel** (`pkt_to_stream`):
   - Simple packet stream to float stream conversion
   - No manual packet filtering needed
   - ADF routing ensures correct packets arrive

4. **DSPLib Matrix-Vector Multiplication** (`dense8x128`):
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

### ADF Packet Switching Architecture Benefits:
1. **Automatic Routing**: ADF handles packet ID assignment and routing automatically
2. **Reliability**: Built-in ADF infrastructure eliminates manual routing errors
3. **Scalability**: Easy to expand to multiple processing cores using pktsplit<N>
4. **Protocol Compatibility**: Standard ADF packet format enables PL integration
5. **Simplified Development**: No manual packet filtering or ID management needed

### Current Implementation Details:
- **Packet Type**: 0 (configurable for different data types)
- **Packet ID**: Automatically assigned by ADF pktsplit infrastructure
- **Payload Size**: 8 floats (EMBED_DENSE0_INPUT_SIZE)
- **Matrix Dimensions**: 8×128 (INPUT_SIZE × HIDDEN_SIZE from nn_defs.h)
- **ADF Components**: pktsplit<1> for automatic packet routing

### Expansion for Multi-Layer Networks:
This ADF packet-switched approach can be extended for larger neural networks by:

```cpp
// Example: Multi-layer with ADF packet switching
pktsplit<3> layer_splitter;    // Route to 3 different layers
pktmerge<2> output_merger;     // Merge outputs from 2 layers

// ADF automatically handles packet routing:
// - No manual packet ID management
// - Automatic load balancing across cores
// - Built-in error handling and flow control
```

### Integration with PL Domain:
The ADF packet-switched design enables seamless integration with the broader system:

1. **System-Level Data Flow**:
   - PL kernels can generate packets for AIE processing
   - AIE can output packets back to PL for post-processing
   - Standard ADF packet format ensures compatibility

2. **Multi-Domain Processing**:
   - Neural network inference in AIE domain using ADF packet switching
   - Pre/post-processing in PL domain
   - Unified ADF packet-based communication protocol
   - Automatic load balancing and fault tolerance

3. **ADF Infrastructure Benefits**:
   - Built-in packet routing eliminates custom switching logic
   - Automatic backpressure and flow control
   - Hardware-optimized packet processing performance

This ADF packet-switched neural network architecture provides a robust foundation for scalable AI acceleration on Versal AI Engines, with reliable packet routing and simplified development workflow.

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