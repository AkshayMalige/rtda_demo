# AI Engine-ML Graph: Complete 11-Layer Neural Network (Merged Architecture)

This directory implements the **complete end-to-end neural network** by merging the three independently tested components and
duplicating the solver stack to form two sequential inference stages:
- **aieml6**: Embedding layers (dense 8×128 → dense 128×128)
- **aieml7**: Solver block **A** (roll-concat + dense 768×128 → 3× dense 128×128)
- **aieml7 (re-used)**: Solver block **B** (second roll-concat + identical dense stack)
- **aieml8**: Output layer (dense 128×32)

The merged graph creates a unified 11-layer neural network with 128 intermediate dimensions and efficient shared buffer management for both 768×128 layers.

## Architecture

### Complete Pipeline
1. **Embedding Block** (from aieml6):
   - `embed_dense0` (8×128) → bias → leaky_relu → split
   - `embed_dense1` (128×128, casc=2) → bias → leaky_relu

2. **Solver Block A** (from aieml7):
   - `roll_concat` (128→768) → shared_buffer
   - `solver_dense0` (768×128, casc=12) → bias → leaky_relu → split
   - `solver_dense1` (128×128, casc=2) → bias → leaky_relu → split
   - `solver_dense2` (128×128, casc=2) → bias → leaky_relu → split
   - `solver_dense3` (128×128, casc=2) → bias → leaky_relu

3. **Solver Block B** (re-used aieml7 stack):
   - `roll_concat1` (128→768) → shared_buffer
   - `solver_dense4` (768×128, casc=12) → bias → leaky_relu → split
   - `solver_dense5` (128×128, casc=2) → bias → leaky_relu → split
   - `solver_dense6` (128×128, casc=2) → bias → leaky_relu → split
   - `solver_dense7` (128×128, casc=2) → bias → leaky_relu

4. **Output Block** (from aieml8):
   - `output_dense0` (128×32)

### Layer Summary
- **Total Dense Layers**: 11 (2 embedding + 8 solver + 1 output)
- **Activation Functions**: 10 Leaky ReLU kernels
- **Cascade Configurations**:
  - TP_CASC_LEN_LAYER1 = 1 (simple layers)
  - TP_CASC_LEN_LAYER2 = 2 (128×128 layers)
  - TP_CASC_LEN_LAYER3 = 12 (768×128 large layer)
- **Window Splitters**: 7 kernels for cascade input distribution
- **Shared Buffers**: Two 768-element buffers with 12-way tiled access (one per solver block)

## Directory Layout

```
├── graph.cpp                       # Instantiates complete NeuralNetworkGraph
├── graph.h                         # Merged graph definition with placement constraints
├── leaky_relu.cpp/.h               # Leaky ReLU activation kernel
├── bias_add.cpp/.h                 # Bias addition kernel
├── window_split_128_to_64x2.cpp/.h # Window splitter for cascade inputs
├── roll_concat.cpp/.h              # Roll-concat kernel (128→768)
├── aie.cfg                         # AIE compiler configuration
└── Makefile                        # Build targets
```

## Build & Compilation

### Compile AI Engine Graph
```bash
cd aieml9
make graph TARGET=hw       # or TARGET=hw_emu
```
Produces `Work/libadf.a` containing the compiled graph.

## Data Flow

### Input/Output PLIO
- **Input**: `layer0_in` reads from `../data/embed_input_data.txt` (8 floats)
- **Output**: `layer_out` writes to `../data/output_dense0_output.txt` (32 floats)

### Runtime Parameters (RTP)
All weights provided via RTP connections:

**Embedding Block:**
- `matrixA_embed0_rtp`: 8×128 weights
- `bias_embed0_rtp`: 128-element bias
- `matrixA_embed1_rtp[2]`: Two 64×128 weight matrices (cascade)
- `bias_embed1_rtp`: 128-element bias

**Solver Block A:**
- `matrixA_solver0_rtp[12]`: Twelve weight matrices for 12-way cascade
- `bias_solver0_rtp`: 128-element bias
- `matrixA_solver1_rtp[2]`: Two weight matrices (cascade)
- `bias_solver1_rtp`: 128-element bias
- `matrixA_solver2_rtp[2]`: Two weight matrices (cascade)
- `bias_solver2_rtp`: 128-element bias
- `matrixA_solver3_rtp[2]`: Two weight matrices (cascade)
- `bias_solver3_rtp`: 128-element bias

**Solver Block B:**
- `matrixA_solver4_rtp[12]`: Twelve weight matrices for 12-way cascade
- `bias_solver4_rtp`: 128-element bias
- `matrixA_solver5_rtp[2]`: Two weight matrices (cascade)
- `bias_solver5_rtp`: 128-element bias
- `matrixA_solver6_rtp[2]`: Two weight matrices (cascade)
- `bias_solver6_rtp`: 128-element bias
- `matrixA_solver7_rtp[2]`: Two weight matrices (cascade)
- `bias_solver7_rtp`: 128-element bias

**Output Block:**
- `matrixA_output0_rtp`: 128×32 weight matrix

### Complete Processing Pipeline
```
input(8) →
  embed_dense0(8×128) → bias → leaky_relu → split →
  embed_dense1(128×128, casc=2) → bias → leaky_relu →
  roll_concat(128→768) → shared_buffer[768] →
  solver_dense0(768×128, casc=12) → bias → leaky_relu → split →
  solver_dense1(128×128, casc=2) → bias → leaky_relu → split →
  solver_dense2(128×128, casc=2) → bias → leaky_relu → split →
  solver_dense3(128×128, casc=2) → bias → leaky_relu →
  roll_concat1(128→768) → shared_buffer[768] →
  solver_dense4(768×128, casc=12) → bias → leaky_relu → split →
  solver_dense5(128×128, casc=2) → bias → leaky_relu → split →
  solver_dense6(128×128, casc=2) → bias → leaky_relu → split →
  solver_dense7(128×128, casc=2) → bias → leaky_relu →
  output_dense0(128×32) →
output(32)
```

## AIE Tile Placement

The graph includes **manual kernel placement** (lines 332-369 in graph.h) to optimize resource usage and minimize routing congestion:

### Placement Strategy
1. **Embedding Block** (columns 3-6): Early layers placed near input PLIO
2. **Roll-Concat Buffer A** (column 8): Centrally located between embedding and first solver block
3. **Solver Block A** (columns 11-23): Large cascade chain with vertical runway
4. **Roll-Concat Buffer B** (column 26): Bridges into the second solver stack
5. **Solver Block B** (columns 29-41): Mirrors solver A with relaxed column spacing for routing slack
6. **Output Block**: Follows solver chain near output PLIO

### Key Placements
- `k_bias_embed0`: tile(3,2) — Near input shim
- `k_rollconcat`: tile(8,3) — Central buffer location for solver block A
- `k_rollconcat1`: tile(26,4) — Anchor for second roll-concat stage
- `k_bias_solver0`: tile(11,4) — Solver block A anchor
- `k_bias_solver4`: tile(29,3) — Solver block B anchor with additional spacing eastward
- Cascaded layers distributed across columns 11–41 with vertical spacing to ease routing

## Shared Buffer Configuration

Each roll-concat stage owns a dedicated shared buffer that distributes 768 elements to the 12 cascade kernels:
- **Buffer Size**: 768 floats (per buffer)
- **Tile Count**: 12 (one per cascade kernel)
- **Tile Size**: 64 floats per kernel (ROLL_CONCAT_TILE_SPAN)
- **Write**: The corresponding `roll_concat` kernel writes the full 768-element array
- **Read**: Each of 12 kernels reads its 64-element tile with offset `i * 64`

## Relationship to Component Projects

| Component | Source Project | Description |
|-----------|---------------|-------------|
| Embedding | aieml6 | 2-layer embedding network with activation |
| Solver A | aieml7 | 4-layer solver with roll-concat and shared buffer |
| Solver B | aieml7 (re-used) | Second solver stack fed by intermediate activations |
| Output | aieml8 | Single-layer output projection |
| **Merged** | **aieml9** | **Complete 11-layer end-to-end network** |

## Performance Considerations

- **Large Cascade**: 12-way cascade on solver_dense0 requires careful placement and routing
- **Shared Buffer**: Reduces memory traffic by 12× compared to replicated data
- **Manual Placement**: Optimized tile locations minimize NoC congestion
- **Window Sizes**: All inter-kernel windows sized for efficient DMA (256/512 bytes)

## Notes
- Test data is generated by `../data/generate_test_data.py`
- This is the production-ready merged architecture combining all validated components
- Kernel placement constraints ensure successful place-and-route
- All weights and biases are runtime-programmable via RTP for flexibility
