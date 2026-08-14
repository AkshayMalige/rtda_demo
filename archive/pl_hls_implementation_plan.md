# PL-Only HLS Implementation Plan: RTDA MLP on Versal VEK280

**Status**: Verified against ONNX files, AIE source, notebook, and data/ weight files.  
**Target**: Vitis HLS 2024.2, hls4ml latest stable, float32 initial precision, xcve2802-vsvh1760-2MP-e-S (PL only).  
**Weights source**: Existing `data/*.txt` files (same as current AIE deployment).

---

## A. Model Architecture Audit

### A.1 Exact Layer Breakdown

All shapes and activation parameters are verified from:
- `punit/checks_stepwise_simple_full_compare.ipynb` (manual numpy validation cells)
- `punit/onnx_no-residual/onnx_files_narrow/simple_full/*.onnx` (ONNX graph inspection)
- `common/nn_defs10.h` (dimension constants)
- `data/*.txt` (weight file line counts)

---

**EMBED block** — input `(6,)` → output `(128,)`

| Layer | Operation | Weight shape | Bias shape | Input → Output | Activation |
|---|---|---|---|---|---|
| Dense0 | `x @ W + B` | `(6, 128)` | `(128,)` | `(6,) → (128,)` | LeakyReLU α=0.1 |
| Dense1 | `x @ W + B` | `(128, 128)` | `(128,)` | `(128,) → (128,)` | LeakyReLU α=0.1 |

Weight files: `embed_dense_0_weights.txt` (1024 values = 8×128; `GRAPH_INPUT_SIZE=8` for AIE int16 padding, but logical weight is 6×128 — the 2 extra rows are zeros), `embed_dense_1_weights_part{0,1}.txt` (8192 values each = 128×128/2 per cascade part).  
Bias files: `embed_dense_0_bias.txt` (128), `embed_dense_1_bias.txt` (128).

> **Note on embed_dense_0 weight shape**: The file has 1024 values but the model uses a `(6,128)` weight. The AIE pads inputs from 6 to 8 elements for SIMD alignment; rows 6 and 7 of the matrix are zero-padded. For the HLS implementation, load only the first 768 values and reshape to `(6,128)`, or load all 1024 and reshape to `(8,128)` and feed padded 8-element inputs. Both yield identical results. Recommended: use the unpadded `(6,128)` weight (first 768 values from the file) and feed raw 6-element inputs.

---

**roll_concat** — input `(128,)` → output `(256,)`, stateful (see §A.3)

---

**SOLVER-0, SOLVER-1, SOLVER-2** — input `(256,)` → output `(128,)`, distinct weights, identical structure

| Layer | Weight shape | Bias shape | Input → Output | Activation |
|---|---|---|---|---|
| Dense0 | `(256, 128)` | `(128,)` | `(256,) → (128,)` | LeakyReLU α=0.1 |
| Dense1 | `(128, 128)` | `(128,)` | `(128,) → (128,)` | LeakyReLU α=0.1 |
| Dense2 | `(128, 128)` | `(128,)` | `(128,) → (128,)` | LeakyReLU α=0.1 |
| Dense3 | `(128, 128)` | `(128,)` | `(128,) → (128,)` | LeakyReLU α=0.1 |

Weight files per solver `S ∈ {0,1,2}`:
- Dense0: `solver_{S}_dense_0_weights_part{0..3}.txt` (8192 values each = 256×128/4 per part)
- Dense1/2/3: `solver_{S}_dense_{1,2,3}_weights_part{0,1}.txt` (8192 each = 128×128/2 per part)
- Biases: `solver_{S}_dense_{0,1,2,3}_bias.txt` (128 values each)

All three solvers have separate weight files and different learned weights.

---

**OUTPUT block** — input `(128,)` → output `(27,)`, **no activation (pure linear)**

| Layer | Weight shape | Bias shape | Input → Output | Activation |
|---|---|---|---|---|
| Dense0 | `(128, 27)` | `(27,)` | `(128,) → (27,)` | None |

Weight file: `output_weights.txt` (3456 values = 128×27).  
Bias file: `output_bias.txt` (27 values).

> **Do not use `output_dense_0_weights.txt`** — that file has 4096 values (128×32, zero-padded for an unrelated script). The canonical file referenced by `data_paths.h` is `output_weights.txt`.

---

### A.2 Tensor Shape Boundary Map

```
Input cloud:   (1, 50, 6)         — 50 tracks, 6 raw features each
               ↓  [EMBED, per-track]
embed_buf:     (50, 128)           — buffered in HLS local BRAM
               ↓  [roll_concat]
assembled_0:   (50, 256)           — assembled[j] = [embed_buf[j], embed_buf[(j-1)%50]]
               ↓  [SOLVER-0, per-track]
solver0_buf:   (50, 128)
               ↓  [roll_concat]
assembled_1:   (50, 256)
               ↓  [SOLVER-1, per-track]
solver1_buf:   (50, 128)
               ↓  [roll_concat]
assembled_2:   (50, 256)
               ↓  [SOLVER-2, per-track]
solver2_buf:   (50, 128)
               ↓  [mean over 50 tracks on 128-dim vectors]
mean128:       (128,)
               ↓  [OUTPUT, once]
output:        (27,)               — final result
```

### A.3 roll_concat / assemble_np Semantics

**Python reference** (`assemble_np` from the notebook, `subset_size=2`):
```python
def assemble_np(a, subset_size=2):
    return np.concatenate([np.roll(a, shift=i, axis=1) for i in range(2)], axis=-1)
# assembled[j] = [ a[j], a[(j-1) mod 50] ]
#                  ^^^^    ^^^^^^^^^^^^^^^
#                current   previous track (wraps: track 0's prev = track 49)
```

This is a pure batch operation over the 50-track tensor. For each track `j`, the 256-element input to the first solver dense layer is the concatenation of the current track's 128-dim embedding and the previous track's 128-dim embedding, with periodic wrap.

The AIE `roll_concat.cpp` kernel implements this incrementally with a 2-frame ring buffer and a `first_snapshot` for wrap-around handling. It has a 1-sample warmup per stage, leading to 3 discarded outputs for 3 chained stages.

**In the HLS implementation, roll_concat is replaced by a direct buffer index operation — no state machine, no warmup.**

### A.4 Mean Reduction

The OUTPUT block is applied per-track yielding `(50, 27)`. The final result is `mean(axis=0)` → `(27,)`.

Since OUTPUT has no activation and is linear (`y = Wx + b`):
```
mean_j(W · solver2[j] + b)  =  W · mean_j(solver2[j])  +  b
```

Therefore: **compute mean of 50 solver2 outputs first (128-dim), then apply OUTPUT dense once**. This is algebraically equivalent and reduces OUTPUT computation from 50× to 1×.

### A.5 hls4ml Problem Flags (Verified)

| Block | Input shape | Bits @float32 | Risk | Status |
|---|---|---|---|---|
| EMBED Dense0 | `(6,)` | 192 bits | None | ✓ Clean |
| EMBED Dense1 | `(128,)` | 4096 bits | Borderline `io_stream` | Use `io_parallel` |
| SOLVER Dense0 | `(256,)` | **8192 bits** | **Hard fail `io_stream`** | **Must use `io_parallel`** |
| SOLVER Dense1/2/3 | `(128,)` | 4096 bits | Borderline `io_stream` | Use `io_parallel` |
| OUTPUT | `(128,)` | 4096 bits | None for hand-coded | Hand-write (1 layer) |
| **ONNX output shape** | `['batch_size', 50, 128]` | — | **Hard fail hls4ml** | **Must fix before conversion** |

The ONNX output shape issue is the most important finding. All five sub-models have correct rank-1 inputs (`[6]`, `[256]`, `[128]`) but stale output shapes `['batch_size', 50, 128]` from a tracing run. `onnx.shape_inference.infer_shapes()` does not fix the output annotation. This must be corrected before any `convert_from_onnx_model()` call.

---

## B. Streaming / Track-by-Track Decomposition Strategy

### B.1 Recommended Execution Model: Buffered-Batch (No Warmup)

Use a **fully buffered batch** model within the PL. Each stage buffers its complete 50-track output in local BRAM before the next stage begins. This is the direct HLS translation of the Python notebook reference.

The AIE's warmup exists because AIE tiles run as persistent kernels that cannot "look ahead" to retrieve track 49 when processing track 0. The HLS top function is invoked once per event and can index its local BRAM arbitrarily — the roll_concat becomes a pure array index with no state.

### B.2 HLS Intermediate Buffer Sizes

```c
float embed_buf  [50][128];   // 50 × 128 × 4 bytes = 25.6 KB
float solver0_buf[50][128];   // 25.6 KB
float solver1_buf[50][128];   // 25.6 KB
float solver2_buf[50][128];   // 25.6 KB
// Total intermediate: ~102 KB — well within VEK280 PL BRAM budget
```

### B.3 roll_concat in HLS

```c
// For solver stage s, producing assembled[j] = [stage_in[j], stage_in[(j-1)%50]]
void roll_concat(float stage_in[50][128], float assembled[50][256]) {
    for (int j = 0; j < 50; j++) {
        int prev_j = (j == 0) ? 49 : j - 1;
        for (int i = 0; i < 128; i++) {
            assembled[j][i]       = stage_in[j][i];
            assembled[j][128 + i] = stage_in[prev_j][i];
        }
    }
}
```

No state, no warmup, no ring buffer. The HLS tool will pipeline and partition this loop trivially.

### B.4 Warmup Period

**None.** All 50 outputs are valid. No outputs to discard.

### B.5 Functional Equivalence Argument

- Python reference: `assemble_np(embed_out, 2)[j] = [embed_out[j], embed_out[(j-1)%50]]`
- HLS implementation: `assembled[j][0..127] = embed_buf[j]`, `assembled[j][128..255] = embed_buf[prev_j]`
- These are identical operations on identical data. The AIE steady-state output converges to the same values (hence why 3 warmup outputs are discarded and all subsequent match `mlp_full.onnx`). The HLS implementation is immediately correct without any warmup.

---

## C. hls4ml Conversion Plan

### C.1 Mandatory Pre-Processing: Fix ONNX Output Shapes

Before any `convert_from_onnx_model()` call, strip the stale `['batch_size', 50, 128]` output shape annotation from all five ONNX files.

**Recommended approach: Re-export from Keras using weights from data/*.txt**

This is cleaner than patching ONNX output annotations and produces a well-formed Keras model that hls4ml handles natively.

```python
import numpy as np
import tensorflow as tf
from tensorflow.keras import Input, Model
from tensorflow.keras.layers import Dense

DATA_DIR = "/path/to/rtda_demo/data"

def leaky_relu_01(x):
    return tf.nn.leaky_relu(x, alpha=0.1)

# --- Build EMBED Keras model ---
def build_embed():
    x = Input(shape=(6,), name="input")

    # Dense0: load first 768 values of embed_dense_0_weights.txt, reshape (6,128)
    W0 = np.loadtxt(f"{DATA_DIR}/embed_dense_0_weights.txt")[:768].reshape(6, 128)
    B0 = np.loadtxt(f"{DATA_DIR}/embed_dense_0_bias.txt")        # (128,)
    d0 = Dense(128, activation=leaky_relu_01, name="dense0",
               kernel_initializer=tf.constant_initializer(W0),
               bias_initializer=tf.constant_initializer(B0),
               use_bias=True)

    # Dense1: concatenate 2 parts -> (128,128)
    W1 = np.concatenate([
        np.loadtxt(f"{DATA_DIR}/embed_dense_1_weights_part{i}.txt") for i in range(2)
    ]).reshape(128, 128)
    B1 = np.loadtxt(f"{DATA_DIR}/embed_dense_1_bias.txt")          # (128,)
    d1 = Dense(128, activation=leaky_relu_01, name="dense1",
               kernel_initializer=tf.constant_initializer(W1),
               bias_initializer=tf.constant_initializer(B1),
               use_bias=True)

    out = d1(d0(x))
    model = Model(inputs=x, outputs=out, name="embed")
    model(np.zeros((1, 6), dtype=np.float32))  # build weights
    return model

# --- Build SOLVER Keras model (s=0,1,2) ---
def build_solver(s):
    x = Input(shape=(256,), name="input")
    prev = x
    for layer_idx in range(4):
        if layer_idx == 0:
            # Dense0: 4 parts -> (256,128)
            W = np.concatenate([
                np.loadtxt(f"{DATA_DIR}/solver_{s}_dense_0_weights_part{i}.txt")
                for i in range(4)
            ]).reshape(256, 128)
        else:
            # Dense1/2/3: 2 parts -> (128,128)
            W = np.concatenate([
                np.loadtxt(f"{DATA_DIR}/solver_{s}_dense_{layer_idx}_weights_part{i}.txt")
                for i in range(2)
            ]).reshape(128, 128)
        B = np.loadtxt(f"{DATA_DIR}/solver_{s}_dense_{layer_idx}_bias.txt")  # (128,)
        in_dim = 256 if layer_idx == 0 else 128
        d = Dense(128, activation=leaky_relu_01, name=f"dense{layer_idx}",
                  kernel_initializer=tf.constant_initializer(W),
                  bias_initializer=tf.constant_initializer(B),
                  use_bias=True)
        prev = d(prev)
    model = Model(inputs=x, outputs=prev, name=f"solver{s}")
    model(np.zeros((1, 256), dtype=np.float32))
    return model
```

After building, run a single forward pass and compare against the ONNX `run_vec` output for at least one particle. The outputs must match to within `1e-6` (float32 rounding only) before proceeding to hls4ml conversion.

**Alternative (if Keras re-export is not desired): patch ONNX output shape directly**

```python
import onnx
from onnx import helper, TensorProto

def fix_onnx_output(model_path, out_path, correct_shape):
    m = onnx.load(model_path)
    old_out = m.graph.output[0]
    new_out = helper.make_tensor_value_info(old_out.name, TensorProto.FLOAT, correct_shape)
    m.graph.output.remove(old_out)
    m.graph.output.append(new_out)
    onnx.checker.check_model(m)
    onnx.save(m, out_path)

fix_onnx_output("simple_submodule_embed.onnx",    "fixed_embed.onnx",    [128])
fix_onnx_output("simple_submodule_solvers-0.onnx", "fixed_solver0.onnx",  [128])
fix_onnx_output("simple_submodule_solvers-1.onnx", "fixed_solver1.onnx",  [128])
fix_onnx_output("simple_submodule_solvers-2.onnx", "fixed_solver2.onnx",  [128])
fix_onnx_output("simple_submodule_output.onnx",   "fixed_output.onnx",   [27])
```

Verify each fixed ONNX with `onnx.checker.check_model()` before proceeding.

### C.2 EMBED Block

| Parameter | Value |
|---|---|
| Input shape | `(6,)` |
| Output shape | `(128,)` |
| IO strategy | `io_parallel` |
| Backend | `Vitis` |
| Part | `xcve2802-vsvh1760-2MP-e-S` |
| Conversion path | Keras model (preferred) or fixed ONNX |
| ReuseFactor | 1 (start here) |
| Precision | `ap_fixed<16,6>` model-wide default for initial testing |

```python
import hls4ml

embed_model = build_embed()
config = hls4ml.utils.config_from_keras_model(embed_model, granularity='name', backend='Vitis')
hls_embed = hls4ml.converters.convert_from_keras_model(
    embed_model,
    hls_config=config,
    output_dir='hls_projects/embed',
    backend='Vitis',
    part='xcve2802-vsvh1760-2MP-e-S',
    io_type='io_parallel'
)
```

### C.3 SOLVER-0, SOLVER-1, SOLVER-2 Blocks

**Mandatory**: `io_type='io_parallel'`. The 256-element float32 input (8192 bits) **hard-fails** `io_stream` — exceeds the hls4ml 4096-bit AXI-S maximum. This is non-negotiable for correct synthesis.

```python
for s in range(3):
    solver_model = build_solver(s)
    config = hls4ml.utils.config_from_keras_model(solver_model, granularity='name', backend='Vitis')
    hls4ml.converters.convert_from_keras_model(
        solver_model,
        hls_config=config,
        output_dir=f'hls_projects/solver{s}',
        backend='Vitis',
        part='xcve2802-vsvh1760-2MP-e-S',
        io_type='io_parallel'
    )
```

All three solvers are converted independently because hls4ml embeds weights as compile-time constants in the generated C++. Three separate HLS projects, three separate functions (`solver0`, `solver1`, `solver2`).

### C.4 OUTPUT Block

**Recommendation: hand-write in HLS.** The OUTPUT block is a single linear dense layer (no activation). 128×27 = 3456 MAC operations. Embedding this into the top-level HLS function directly avoids another hls4ml project and another function call overhead. The mean-first equivalence (§A.4) further reduces it to a single 128→27 matrix-vector product.

```c
// output_weights[128][27] and output_bias[27] are compile-time constants
// loaded from output_weights.txt and output_bias.txt at synthesis

void apply_output_dense(const float mean128[128], float out27[27]) {
    for (int o = 0; o < 27; o++) {
        float acc = OUTPUT_BIAS[o];
        for (int i = 0; i < 128; i++)
            acc += mean128[i] * OUTPUT_WEIGHT[i][o];
        out27[o] = acc;
    }
}
```

### C.5 Summary Table

| Block | hls4ml viable | io_type | Input shape | Output shape | Notes |
|---|---|---|---|---|---|
| EMBED | Yes | `io_parallel` | `(6,)` | `(128,)` | Fix ONNX shapes or re-export Keras |
| SOLVER-0 | Yes | **`io_parallel` only** | `(256,)` | `(128,)` | `io_stream` is a hard blocker |
| SOLVER-1 | Yes | **`io_parallel` only** | `(256,)` | `(128,)` | Same |
| SOLVER-2 | Yes | **`io_parallel` only** | `(256,)` | `(128,)` | Same |
| OUTPUT | Skip hls4ml | n/a | `(128,)` | `(27,)` | Hand-write; apply after mean reduction |
| roll_concat | Skip hls4ml | n/a | stateful buffer op | — | Direct array indexing in top function |
| mean reduction | Skip hls4ml | n/a | `(50,128)` → `(128,)` | — | Accumulator loop in top function |

---

## D. HLS Top-Level Integration Plan

### D.1 Top-Level Function Signature

```c
// rtda_top.cpp
void rtda_top(
    hls::stream<float> &track_in,    // 50 tracks × 6 features = 300 floats, flat
    hls::stream<float> &result_out   // 27 floats
);

#pragma HLS INTERFACE axis      port=track_in
#pragma HLS INTERFACE axis      port=result_out
#pragma HLS INTERFACE s_axilite port=return
```

### D.2 Complete Call Graph

```
rtda_top():
├── [STAGE 1] EMBED all 50 tracks
│     for j = 0 .. 49:
│       read 6 floats from track_in → in_vec[6]
│       hls_embed(in_vec, embed_buf[j])         ← hls4ml-generated
│
├── [STAGE 2] roll_concat + SOLVER-0 all 50 tracks
│     for j = 0 .. 49:
│       prev_j = (j==0) ? 49 : j-1
│       assembled[0..127]   = embed_buf[j]
│       assembled[128..255] = embed_buf[prev_j]
│       hls_solver0(assembled, solver0_buf[j])   ← hls4ml-generated
│
├── [STAGE 3] roll_concat + SOLVER-1 all 50 tracks
│     for j = 0 .. 49:
│       prev_j = (j==0) ? 49 : j-1
│       assembled[0..127]   = solver0_buf[j]
│       assembled[128..255] = solver0_buf[prev_j]
│       hls_solver1(assembled, solver1_buf[j])   ← hls4ml-generated
│
├── [STAGE 4] roll_concat + SOLVER-2 all 50 tracks
│     (same pattern, feeds solver2_buf)
│
└── [STAGE 5] Mean + OUTPUT (once)
      mean128[i] = sum_j(solver2_buf[j][i]) / 50.0f   for i in 0..127
      out27[o]   = dot(mean128, OUTPUT_WEIGHT[:,o]) + OUTPUT_BIAS[o]   for o in 0..26
      write 27 floats to result_out
```

### D.3 Pragma Recommendations

```c
// rtda_top.cpp

// Partition intermediate buffers on the feature dimension (dim=2)
// so hls4ml io_parallel functions can read/write all elements in 1 cycle
#pragma HLS ARRAY_PARTITION variable=embed_buf    dim=2 complete
#pragma HLS ARRAY_PARTITION variable=solver0_buf  dim=2 complete
#pragma HLS ARRAY_PARTITION variable=solver1_buf  dim=2 complete
#pragma HLS ARRAY_PARTITION variable=solver2_buf  dim=2 complete

// Weight constants for OUTPUT layer — keep in ROM (no BRAM needed, 3456 floats)
#pragma HLS BIND_STORAGE variable=OUTPUT_WEIGHT type=ROM_1P
```

**Do NOT use `DATAFLOW` at the top level.** The sequential staged structure (buffer-fill → buffer-read-compute-buffer-fill → ...) violates DATAFLOW's strict producer-consumer requirement. Add DATAFLOW only if you restructure stages into separate functions with `hls::stream` connections, which is a later optimization.

**Do NOT pipeline the outer 50-track loops** until the inner hls4ml functions have confirmed `II=1`. Pipeline the inner loops inside hls4ml functions — those are handled automatically by hls4ml's generated pragmas.

### D.4 What Stays in Host Software

Nothing. The complete inference pipeline runs in PL:
- EMBED, SOLVER-0/1/2, roll_concat, mean, OUTPUT — all in `rtda_top`
- Weights are compile-time C++ array constants (loaded from `data/*.txt` at project generation time, not at runtime)
- Host sends 300 floats (50 tracks × 6 features) via AXI-S and reads 27 floats back

No runtime weight DMA, no RTP updates (unlike the AIE approach).

---

## E. Validation Plan

### E.1 Reference Vector Generation (Python)

Before any HLS work, generate golden reference vectors from the Python reference:

```python
import numpy as np
import onnxruntime as ort

# Load sub-model sessions
sess_embed   = ort.InferenceSession("simple_submodule_embed.onnx")
sess_solver0 = ort.InferenceSession("simple_submodule_solvers-0.onnx")
sess_solver1 = ort.InferenceSession("simple_submodule_solvers-1.onnx")
sess_solver2 = ort.InferenceSession("simple_submodule_solvers-2.onnx")

def run_vec(sess, v):
    name = sess.get_inputs()[0].name
    return sess.run(None, {name: np.asarray(v, np.float32).reshape(-1)})[0]

def assemble_np(a):  # a: (50, 128)
    return np.concatenate([np.roll(a, i, axis=0) for i in range(2)], axis=-1)

# For each test event:
for event_idx in range(N_EVENTS):
    x = load_test_cloud(event_idx)                           # (50, 6)
    h_e = np.stack([run_vec(sess_embed, x[j]) for j in range(50)])    # (50, 128)
    h_a0 = assemble_np(h_e)                                            # (50, 256)
    h_s0 = np.stack([run_vec(sess_solver0, h_a0[j]) for j in range(50)])  # (50, 128)
    h_a1 = assemble_np(h_s0)
    h_s1 = np.stack([run_vec(sess_solver1, h_a1[j]) for j in range(50)])
    h_a2 = assemble_np(h_s1)
    h_s2 = np.stack([run_vec(sess_solver2, h_a2[j]) for j in range(50)])  # (50, 128)

    # Mean-then-output (matches full ONNX within float32 rounding)
    mean128 = h_s2.mean(axis=0)                                        # (128,)
    W_out = np.loadtxt("data/output_weights.txt").reshape(128, 27)
    B_out = np.loadtxt("data/output_bias.txt")
    y_ref = mean128 @ W_out + B_out                                    # (27,)

    np.save(f"test_data/input_{event_idx}.npy",  x.astype(np.float32))
    np.save(f"test_data/output_{event_idx}.npy", y_ref.astype(np.float32))
    # Save intermediates for stage-by-stage debug
    np.save(f"test_data/embed_out_{event_idx}.npy",   h_e)
    np.save(f"test_data/solver0_out_{event_idx}.npy", h_s0)
    np.save(f"test_data/solver1_out_{event_idx}.npy", h_s1)
    np.save(f"test_data/solver2_out_{event_idx}.npy", h_s2)
```

### E.2 C Simulation Strategy (Three Phases)

**Phase 1 — Validate each hls4ml sub-block independently**

For each hls4ml project, compile with `hls_model.compile()` and run:

```python
# Example for EMBED
hls_embed.compile()
for j in range(50):
    out_hls = hls_embed.predict(x[j:j+1])         # shape (1, 128)
    out_ref = h_e[j]                                # shape (128,)
    assert np.max(np.abs(out_hls[0] - out_ref)) < 1e-4, f"Embed mismatch at track {j}"
```

Run for all 50 tracks of at least 5 test events (250 track-level checks per block).

**Phase 2 — Validate roll_concat in isolation**

Feed known embed outputs, check that the assembled 256-dim vectors match `assemble_np` exactly.

**Phase 3 — Full top-level csim**

Run `hls_model.build(csim=True)` on the top-level project after integration. Feed the 300-float input stream, compare 27-float output against `y_ref`.

### E.3 Test Vector Counts

| Phase | Events | Rationale |
|---|---|---|
| Phase 1 sub-block | 5 events (250 tracks) | Confirm structural correctness per block |
| Phase 1 full event | 20 events | Build statistical confidence on output |
| Full csim | 5 events (fast) | Verify integration; csim is slow |

Include the first event from the existing `data/embed_input.txt` file for exact numerical comparison against the AIE simulation reference (`data/aieml10_output_aie.txt`).

### E.4 Acceptance Tolerances

| Comparison | Metric | Threshold |
|---|---|---|
| float32 HLS vs Python reference | max\|diff\| | `< 1e-4` |
| float32 HLS vs Python reference | RMSE | `< 1e-5` |
| HLS embed vs ONNX sub-block | max\|diff\| per element | `< 1e-5` |
| HLS solver vs ONNX sub-block | max\|diff\| per element | `< 1e-4` |

Start with float32 throughout (no `ap_fixed` in hls4ml config) to confirm structural correctness before introducing fixed-point quantisation.

---

## F. Open Questions Resolved / Remaining Risks

### F.1 Questions Resolved by ONNX Inspection

| Question | Finding |
|---|---|
| ONNX input rank | ✅ All rank-1: embed `[6]`, solvers `[256]`, output `[128]` |
| Per-layer LeakyReLU alpha | ✅ Uniform α=0.1 across all layers and all blocks |
| Reshape/unsupported ops in ONNX | ✅ None — only MatMul, Add, LeakyRelu |
| Weight dtype | ✅ float32 (elem_type=1) throughout |
| 3 SOLVER blocks have different weights | ✅ Confirmed (separate data files) |
| Canonical output weight file | ✅ `output_weights.txt` (3456 values = 128×27) |

### F.2 Confirmed Risks and Mitigations

**[Hard blocker — mitigated] ONNX output shape annotations are wrong**

All sub-models have output shape `['batch_size', 50, 128]` (stale from trace). `onnx.shape_inference` does not fix the final graph output — only intermediate tensor shapes are correctly inferred. If passed directly to `convert_from_onnx_model`, hls4ml will attempt to generate a 3D output type.

**Mitigation**: Re-export from Keras using weights loaded from `data/*.txt` (recommended), or manually patch the ONNX output tensor info before conversion. The Keras re-export path is preferred because it also validates that the weights load correctly.

**[Hard blocker — mitigated] SOLVER Dense0 io_stream width**

256 × float32 = 8192 bits exceeds the 4096-bit hls4ml `io_stream` maximum.

**Mitigation**: Use `io_parallel` for all sub-blocks. This is mandatory.

**[Architecture constraint] No DATAFLOW at top level**

The sequential buffered-batch execution model is incompatible with Vitis HLS DATAFLOW. DATAFLOW requires strict producer-consumer topology with no shared arrays and no feedback.

**Mitigation**: Do not add DATAFLOW. The latency is O(50 × per-block latency) per event. For correctness-first development this is acceptable. If throughput becomes a concern later, DATAFLOW can be enabled by restructuring each stage as a separate function communicating via `hls::stream` — this is a future optimisation, not a correctness requirement.

**[Low risk] Array partitioning interaction with hls4ml io_parallel**

hls4ml `io_parallel` generates code that reads all input elements in parallel. If the calling array is not partitioned on the feature dimension, HLS serialises the reads and degrades throughput.

**Mitigation**: Apply `#pragma HLS ARRAY_PARTITION variable=<buf> dim=2 complete` on all intermediate buffers. This is included in §D.3.

**[Low risk] embed_dense_0_weights.txt contains 8×128 = 1024 values, not 6×128 = 768**

The extra 2 rows are zero-padding added for the AIE int16 SIMD alignment (`GRAPH_INPUT_SIZE=8`).

**Mitigation**: For HLS, load only the first 768 values and reshape to `(6,128)`, or equivalently use the full `(8,128)` weight and pad the 6-element input to 8 elements. Recommended: use `(6,128)` + raw 6-element input to match the ONNX model exactly.

---

## G. Implementation Sequence

1. **Generate reference test vectors** (Python, §E.1) — do this first, gate all later steps on it
2. **Re-export Keras sub-models** from `data/*.txt` weights, validate against ONNX `run_vec` output
3. **Convert EMBED with hls4ml** (`io_parallel`), run `hls_embed.compile()`, validate Phase 1
4. **Convert SOLVER-0/1/2 with hls4ml** (`io_parallel`), validate Phase 1 each
5. **Write HLS top-level** (`rtda_top.cpp`): assemble stages, roll_concat, mean, hand-coded OUTPUT
6. **Integrate hls4ml sub-functions** into top-level (include generated headers)
7. **Run full csim** (Phase 3), compare against reference vectors
8. **Run C synthesis** (`hls_model.build(csim=False)`), check timing/resource reports
9. **Generate IP core** for PL integration on VEK280

---

## H. Weight Loading Reference

All weights are in `data/` relative to the project root. Row-major float32 text, one value per line.

| Block | Layer | File(s) | Shape | Notes |
|---|---|---|---|---|
| EMBED | Dense0 W | `embed_dense_0_weights.txt` | `(8,128)` | Use first 768 values as `(6,128)` |
| EMBED | Dense0 B | `embed_dense_0_bias.txt` | `(128,)` | |
| EMBED | Dense1 W | `embed_dense_1_weights_part{0,1}.txt` | 2×`(64,128)` | Cat → `(128,128)` |
| EMBED | Dense1 B | `embed_dense_1_bias.txt` | `(128,)` | |
| SOLVER-S | Dense0 W | `solver_{S}_dense_0_weights_part{0..3}.txt` | 4×`(64,128)` | Cat → `(256,128)` |
| SOLVER-S | Dense0 B | `solver_{S}_dense_0_bias.txt` | `(128,)` | |
| SOLVER-S | Dense{1,2,3} W | `solver_{S}_dense_{1,2,3}_weights_part{0,1}.txt` | 2×`(64,128)` | Cat → `(128,128)` |
| SOLVER-S | Dense{1,2,3} B | `solver_{S}_dense_{1,2,3}_bias.txt` | `(128,)` | |
| OUTPUT | Dense0 W | `output_weights.txt` | `(128,27)` | 3456 values |
| OUTPUT | Dense0 B | `output_bias.txt` | `(27,)` | |

Reconstruction pattern for partitioned weights:
```python
W = np.concatenate([np.loadtxt(f"solver_0_dense_0_weights_part{i}.txt") for i in range(4)])
W = W.reshape(256, 128)  # (in_dim, out_dim)
```

The AIE stores weights in `(out_dim, in_dim)` transposed format for its `matrix_vector_mul_graph` (A × v, A is row-major with rows = output neurons). The ONNX/Python reference uses `x @ W` convention where `W` is `(in_dim, out_dim)`. Verify orientation by checking the first forward pass output against the Python reference — a transposition error produces wildly wrong values (not small numerical drift).
