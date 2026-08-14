# Mapping a neural network onto AIE-ML, properly

**From "I wrote a kernel per layer" to "I tile the problem to fit the hardware's
atom."**

This document explains the design in `aie_batch/`, using this repo's own code.
It is written for someone who has already built an AIE graph the
straightforward way — a kernel per layer, matrix × vector, weights via RTP —
and wants to understand why the batched version looks completely different and
runs 29× faster.

Everything here is checkable against the files named. Nothing is generic AIE
advice.

> **This is the reference, not the lesson.** It is dense on purpose and assumes
> you can read the code alongside it. If the ideas are new, read
> **`aie_tutorial.html`** in this directory first — it builds the same picture up
> one step at a time, with diagrams and a worked example, and defers all code to
> the end. Come back here for the exact numbers.

---

# Part 0 — The one idea

Your first design asked: **"what does a layer do, and how do I write a kernel
for it?"** That is the right question for a CPU or a GPU. On AIE-ML it is the
wrong starting point, and the reason is one number.

The AIE-ML vector unit's matrix-multiply instruction computes, for float32:

```
C[4][8] ... no. Precisely:   C[4][4]  +=  A[4][8] × B[8][4]
                                 M=4      M=4 K=8    K=8 N=4
```

**It multiplies a 4×8 block of A by an 8×4 block of B in one instruction.** Not
a vector by a matrix — a *block* by a *block*.

Now look at what matrix × vector asks it to do. Your input is one track: a
vector of 128 numbers, i.e. a 1×128 matrix. `M = 1`. The instruction still
computes 4 rows. Three of them are fed garbage or zeros and their results are
thrown away.

**You paid for 4 rows of multipliers and used 1. Three quarters of every
instruction was discarded, on every layer, for every track.**

That is the entire story. The batched design exists to make `M = 4` real by
processing four tracks at once — and then 8, because of a padding rule we will
get to.

Measured, in this repo: **17,770 ns/track → 615 ns/track (fp32), 245 ns/track
(bf16).**

> **The pivot in one sentence.** Stop thinking "kernel per layer, sample flows
> through." Start thinking "**the hardware's atom is a small matrix × matrix.
> My job is to chop my problem into those atoms and keep every one of them
> full.**"

---

# Part 1 — The atom: `aie::mmul<M, K, N>`

Everything in `aie_batch/src_fp32/kernels/dense_bias_relu/dense_bias_relu.cpp`
is built on this one type:

```cpp
using MMUL = aie::mmul<M, K, N, data_t, weight_t, acc_scalar_t>;
```

with `M = 4, K = 8, N = 4` for float32 (see `parameters.h`, every `L*Cfg`).

It gives you three sizes, and they are the shapes you must think in:

| | meaning | value here |
|---|---|---|
| `MMUL::size_A` = M×K | one **input** micro-tile: 4 rows (tracks) × 8 features | 32 floats |
| `MMUL::size_B` = K×N | one **weight** micro-tile: 8 in-features × 4 out-features | 32 floats |
| `MMUL::size_C` = M×N | one **output** micro-tile: 4 tracks × 4 out-features | 16 floats |

And three operations:

```cpp
C.mul(A, B);        // C  = A × B      (start an accumulation)
C.mac(A, B);        // C += A × B      (continue it)
C.to_accum();       // hand the raw accumulator somewhere else
C.to_vector<result_t>(SHIFT);   // round/saturate down to the output type
```

**The accumulator stays wide the whole time.** `acc_scalar_t` is `accfloat` for
fp32. You accumulate across the entire input dimension in full accumulator
precision and only convert once, at the end. This is why the fp32 build reaches
7.5e-07 against the ONNX.

## The three loop levels

A dense layer of shape `[batch][K_total] × [K_total][N_total]` becomes three
nested loops over micro-tiles. From the real kernel:

```cpp
for (unsigned z = 0; z < rowA / M; z += 2) {          // over the BATCH
  for (unsigned j = 0; j < colB / N; j += 2) {        // over OUTPUT features
    ...
    for (unsigned i = 1; i < colA / K; ++i)           // over INPUT features
      chess_prepare_for_pipelining
    { ... C00.mac(A0, B0); ... }
```

- **`z`** walks the batch in steps of `M` (4 tracks).
- **`j`** walks the output features in steps of `N` (4 outputs).
- **`i`** walks the input features in steps of `K` (8 inputs) — this is the
  *reduction*, so it accumulates rather than storing.

Notice `z += 2` and `j += 2`, and the four accumulators `C00, C01, C10, C11`.
The kernel deliberately keeps **two row-blocks × two column-blocks = 4
accumulations in flight**, so the vector unit always has independent work while
earlier MACs are still in the pipeline. That is a software-pipelining trick, and
it is why the batch must be a multiple of `2 × M = 8`:

```cpp
static_assert(ConfigT::padded_independent_extent % (2 * ConfigT::M) == 0,
              "padded_independent_extent must be divisible by 2*M");
```

**This is also the explanation for a result that surprises people:** batch 4 and
batch 8 measure *identical* II. A batch of 4 is padded up to 8
(`padded_independent_extent`) and the hardware does exactly the same work. Batch
8 is therefore free — you get 8 tracks for the price of 4.

---

# Part 2 — What a "dense layer" becomes

In your GEMV design, one dense layer = one kernel (or a small chain).

Here, one dense layer = **a subgraph of `CAS_NUM × CAS_LENGTH` kernels**, and
each kernel is one of four roles:

| role | reads | writes | when |
|---|---|---|---|
| `dense_single` | ifm buffer | ofm buffer | the layer fits in one tile |
| `dense_first` | ifm buffer | **cascade** | first tile of a chain |
| `dense_middle` | ifm buffer + **cascade** | **cascade** | middle of a chain |
| `dense_last` | ifm buffer + **cascade** | ofm buffer | last tile of a chain |

All four are in `dense_bias_relu.cpp`. They are the same triple loop; they
differ only in where the accumulator comes from and goes to.

## The cascade is the point

A **cascade** is a dedicated hardware path between physically adjacent AIE
tiles that carries **raw accumulator values** — not rounded outputs. Look at
`dense_first`:

```cpp
writeincr(outCascade, C00.to_accum());   // full accumulator precision
```

and `dense_last`:

```cpp
MMUL C00(readincr_v<MMUL::size_C>(inCascade));   // resume, don't restart
...
C00.mac(A0, B0);                                  // keep accumulating
```

So a 256-input dense layer split across 4 tiles computes a partial sum of 64
inputs on each tile and passes the *unrounded* accumulator down the chain. The
arithmetic is identical to doing it on one tile. **You split the work without
splitting the precision.**

This is the AIE-ML equivalent of what you were doing by hand with intermediate
buffers, except it costs no memory and no rounding.

---

# Part 3 — The two ways to split a layer

This is the concept that makes `parameters.h` readable. Every layer config has:

```cpp
static constexpr int CAS_LENGTH = 4;   // split along INPUT features  (K)
static constexpr int CAS_NUM    = 2;   // split along OUTPUT features (N)
```

**They are different axes and they behave differently.**

```
                    OUTPUT features (N) ─────────────►
                  ┌─────────────────┬─────────────────┐
   INPUT       │  │  tile[0][0]     │  tile[1][0]     │   CAS_NUM = 2
   features    │  │   K 0..63       │   K 0..63       │   independent chains
   (K)         │  │   N 0..63       │   N 64..127     │
               │  ├─────────────────┼─────────────────┤
               ▼  │  tile[0][1]     │  tile[1][1]     │   CAS_LENGTH = 4
                  │   K 64..127     │   K 64..127     │   cascade-linked,
                  │   N 0..63       │   N 64..127     │   partial sums
                  ├─────────────────┼─────────────────┤
                  │      ...        │      ...        │
                  └─────────────────┴─────────────────┘
                     chain 0            chain 1
```

- **`CAS_LENGTH` splits the reduction.** Each tile sees a *slice of the input
  features* and computes a partial sum. They must be chained, because their
  results have to be added. Cost: cascade latency. Benefit: the weight slice per
  tile shrinks.

- **`CAS_NUM` splits the output.** Each chain produces a *different set of
  output features*. They are completely independent — no communication. Cost:
  the input has to be broadcast to every chain. Benefit: linear parallelism.

For `L3Cfg` (a solver's 256→128 dense): `CAS_LENGTH = 4, CAS_NUM = 2` = **8
tiles** for one layer, each holding a 64×64 weight slice.

## What actually forces the split

Not performance — **memory**. From the kernel's own static assert:

```cpp
static_assert(ConfigT::OUT_FEAT_SLICE * ConfigT::IN_FEAT_SLICE * sizeof(weight_t) <= 16384,
              "Weight size per tile must not exceed one AIE-ML memory bank (16 KiB)");
```

An AIE-ML tile has 64 KB of data memory in 4 banks of 16 KB. **The weight slice
on one tile must fit in one bank.** For fp32 that is 4096 weights = 64×64.

So: a 256×128 layer is 32,768 weights = 128 KB. It *cannot* live on one tile.
`CAS_LENGTH=4 × CAS_NUM=2` gives 8 slices of 64×64 = 4096 weights = 16 KB each.
Exactly one bank.

**This is the first calculation you do when mapping a new model.** Weight bytes
per layer ÷ 16 KB = minimum tile count. Everything else follows from it.

## The proof, from this design's own numbers

Every layer in `parameters.h`, with the arithmetic worked out:

```
layer    IN  OUT  CAS_L CAS_N  tiles      slice   KB/tile
L1       16  128      1     1      1     16x128         8
L2      128  128      2     2      4      64x64        16
L3      256  128      4     2      8      64x64        16     <- solver dense0
L4      128  128      2     2      4      64x64        16
...                                                            (L5..L14 identical to L4,
L11     256  128      4     2      8      64x64        16      L7/L11 identical to L3)
L14     128  128      2     2      4      64x64        16

  weight ports 65 + bias ports 27 = 92    <- exactly the manifest's 92 RTP ports
```

**Look at the last column.** Every layer except the first sits at *exactly*
16 KB per tile. That is not a coincidence and it is not tuning — it is the bank
limit, and the tile count was chosen to hit it. L1 is the only exception because
16×128 is only 8 KB and already fits.

So the split for a 128→128 layer is 2×2 and not 1×4 or 4×1 because:
`128×128×4 B = 64 KB`, and `64 KB / 16 KB = 4 tiles minimum`. Any factorisation
into 4 works for memory; 2×2 is chosen over 1×4 because it halves the cascade
depth (latency) compared with 4 chained stages.

---

# Part 4 — Weights: where they live and how they get there

## They live on the tile, permanently

```cpp
connect<parameter>(wts[idx], async(kk[idx].in[1]));
single_buffer(kk[idx].in[1]);
```

(`dense_bias_relu_graph.h`)

`connect<parameter>` is an **RTP port** — the same mechanism you already used.
`async` means the host writes it once and the graph reads it whenever it likes.
`single_buffer` means no double-buffering: one copy, because it never changes.

So the weights are pushed **once, before the run**, and then every iteration is
pure compute. This part of your original design was already right; it did not
need to change.

In this project there are **92 such ports** (14 layers × their tile counts, plus
biases). The host reads `sysdata_<P>/rtp_manifest.txt` — a list of
`<port_name> <n_elems> <dtype> <path>` — and pushes each `.bin`. Port names are
literal, e.g. `dut.dut.emb_d0_aie.kk[0].in[1]`.

## But the *layout* is not what you would write

Here is the part that trips everyone. The kernel loads weights like this:

```cpp
aie::vector<weight_t, MMUL::size_B> B0 = aie::load_v<MMUL::size_B>(pB1);
pB1 += MMUL::size_B * (colB / N);
```

A single contiguous 32-float load, then a jump. **The weight array is not
`[in][out]` or `[out][in]` — it is a sequence of pre-arranged 8×4 micro-tiles**,
ordered so that the kernel's pointer walk is contiguous.

`analysis/rtda_reference.ipynb` contains the packer, and it is the clearest
statement of the layout:

```python
def pack_mmul(Wm, K, N, K_slice, N_slice, mk, mn, cas_length, cas_num):
    tk, tn = K_slice // mk, N_slice // mn        # micro-tiles per slice
    out = np.zeros((cas_num, cas_length, tk * tn * mk * mn), np.float32)
    for c in range(cas_num):                     # which output chain
        n_base = c * N_slice
        for s in range(cas_length):              # which cascade stage
            i = 0
            for kt in range(tk):                 # walk K in steps of mk=8
                gk = s * K_slice + kt * mk
                for nt in range(tn):             # walk N in steps of mn=4
                    tile = Wm[gk:gk+mk, gn:gn+mn]        # an 8x4 block
                    out[c, s, i*mk*mn:(i+1)*mk*mn] = tile.ravel('C')
                    i += 1
    return out
```

Read that as: **for each (chain, cascade stage), emit the 8×4 blocks of the
weight matrix in (K-major, N-minor) order, each block flattened row-major.**

Two things worth internalising:

1. **The packing is part of the design, not a detail.** If you get it wrong the
   graph runs, produces plausible numbers, and is wrong. This repo therefore
   *checks* it: notebook §1 "link 2" re-packs the weights from
   `model/weights_fp32/` and diffs against all 92 payloads on the SD card,
   expecting **0.000e+00**.

2. **Padding is handled here, not in the kernel.** `emb_d0` is a 6→128 layer
   but is presented as 16→128 (`IN_FEAT = 16`). The packer zero-fills. The
   kernel never knows.

## Bias, and why it is free

```cpp
if constexpr (ConfigT::USE_BIAS) {
  aie::vector<bias_t, N> bias_v_0 = aie::load_v<N>(pBias + j * N);
  auto bias_block_0 = replicate_rows<M, bias_t, N>(bias_v_0);
  C00 = bias_block_0; C00.mac(A0, B0);      // <-- bias is the INITIAL VALUE
}
```

Instead of computing `y = Wx` and then adding `b`, the accumulator is
**initialised to the bias** and the MACs accumulate on top. `replicate_rows`
copies the 4-wide bias vector across all M rows of the block, because every
track in the batch gets the same bias.

**Cost: zero extra instructions.** Your hand-written bias-add kernel — a whole
extra tile, an extra buffer, extra latency — disappears into the initial value
of a register.

(For `dense_last` the bias is added *after* the cascade sum instead, since the
accumulator arrives already loaded. Same idea, different insertion point.)

## Activation, likewise

```cpp
template<typename ConfigT, bool RELU, typename AccT>
static inline auto apply_activation(const AccT& acc) {
  const auto y = acc.template to_vector<result_t>(SHIFT);
  if constexpr (ConfigT::LEAKY_ALPHA == 0.0f) return aie::max(y, result_t(0));
  else {
    const auto slope = aie::broadcast<result_t, N>(result_t(ConfigT::LEAKY_ALPHA));
    return aie::max(y, aie::mul(y, slope).template to_vector<result_t>());
  }
}
```

Called at the store:

```cpp
aie::store_v(pC1, apply_activation<ConfigT, ConfigT::USE_RELU>(C00));
```

The leaky ReLU happens **in the same instruction stream as the conversion from
accumulator to output**, on data already in registers. Your separate
`leaky_relu` kernel becomes three vector instructions folded into the store.

> **The lesson generalises.** Anything elementwise — bias, ReLU, scale, clamp —
> should be fused into the producer's epilogue, never given its own kernel. A
> kernel costs a tile, a buffer, a DMA and a synchronisation. An elementwise op
> costs one instruction.

---

# Part 5 — Data movement: `shared_buffer` and tiling

This is what you said you did not fully understand, and it is genuinely the
hardest part. It is also where your original 512 KB tile-buffer roll-concat
was pointing in the right direction.

## What a `shared_buffer` is

```cpp
adf::shared_buffer<float> buffer_r_e0;

self.buffer_r_e0 = adf::shared_buffer<float>::create({128, 8}, 1, 2);
num_buffers(self.buffer_r_e0) = 2;
```

(`graph_plan.h`)

A **memtile**: 512 KB of memory that sits between compute tiles, with its own
DMA engines. `create({128, 8}, 1, 2)` means "a 128×8 array, **1 writer, 2
readers**". `num_buffers = 2` makes it double-buffered — one being written while
the other is read.

Think of it as **a small 2-D array with programmable DMA views**. Not a FIFO.

## Tiling = a DMA access pattern, not a copy

```cpp
write_access(self.buffer_r_e0.in[0]) = adf::tiling({
  .buffer_dimension = {128, 8},
  .tiling_dimension = {4, 4},
  .offset           = {0, 0},
  .tile_traversal = { {.dimension=0, .stride=4, .wrap=32},
                      {.dimension=1, .stride=4, .wrap=2} }
});
```

Read this as a sentence:

- **`buffer_dimension {128, 8}`** — the memtile holds 128 features × 8 tracks.
- **`tiling_dimension {4, 4}`** — the producer delivers it in 4×4 chunks.
  (That is `MMUL::size_C`: 4 outputs × 4 tracks. The dense kernel writes exactly
  these.)
- **`tile_traversal`** — how those chunks sweep the array: 32 steps of 4 along
  the feature axis, then 2 steps of 4 along the track axis.

And the matching read:

```cpp
read_access(self.buffer_r_e0.out[0]) = adf::tiling({
  .buffer_dimension = {128, 8},
  .tiling_dimension = {8, 4},          // <-- 8x4, not 4x4
  .offset           = {0, 0},
  ...
});
connect<>(self.buffer_r_e0.out[0], self.emb_d1_aie.in1[0]);
```

The consumer wants **8 features × 4 tracks** — that is `MMUL::size_A`.

> **This is the whole trick.** The producer writes in `size_C` shape; the
> consumer reads in `size_A` shape. **The reshape between one layer's output
> and the next layer's input is done by the DMA, for free, while the data
> moves.** No kernel, no cycles, no extra memory.
>
> In your GEMV design this reshaping either did not arise or cost you a kernel.
> Here it is a property of the wiring.

## The `offset` field does the splitting

Look at the second reader of the same buffer:

```cpp
read_access(self.buffer_r_e0.out[1]) = adf::tiling({
  ...
  .offset = {64, 0},                    // <-- start at feature 64
});
connect<>(self.buffer_r_e0.out[1], self.emb_d1_aie.in1[1]);
```

`emb_d1` has `CAS_LENGTH = 2`: stage 0 needs input features 0..63, stage 1 needs
64..127. **Two readers of one buffer with different offsets** feed them. The
"splitter" kernel you would have written by hand is an offset field.

## Why this replaces your hand-written roll-concat

Your 512 KB tile buffer with manual read/write access was doing exactly this
kind of thing — you had found the right mechanism. What the generated design
adds is that the *shapes* are chosen to match the mmul micro-tiles, so the DMA
does the reshape that the kernel would otherwise have to.

---

# Part 6 — The two hand-written kernels, and why they exist

Not everything is a dense layer. Two things in this network are not, and they
are worth studying because they show what you *do* still write by hand.

## `roll_concat_batch` — stateful data movement

```cpp
alignas(32) static float carry[FEAT] = {};      // <-- STATIC

for (int t = 0; t < TRACKS; ++t) {
    const float* cur  = pi + t * FEAT;
    const float* prev = (t == 0) ? carry : (pi + (t - 1) * FEAT);
    // write [cur | prev] into a 2*FEAT-wide row
}
// hand this block's last track to the next invocation
```

It turns a `[8][128]` block into the `[8][256]` the solver's first dense wants,
pairing each track with its predecessor.

**The `static` is the entire semantic content of this kernel.** A kernel's
statics persist across invocations and are initialised at **ELF load**, not at
`graph.run()`. Consequences, all of which this project hit:

- Track 0 of a block pairs with the *previous block's last track* — so the roll
  is **streaming**, not circular. This is the single biggest source of
  "why don't my numbers match the reference" in this repo.
- A second `graph.run()` on an already-loaded xclbin starts with the previous
  run's leftover carry. Fixed by a **flush event**: one all-zero event whose
  result is discarded.

> **Rule:** if your kernel has a `static`, you have a state machine, and you now
> own its reset semantics. Write them down.

## `track_accum` — reduction with a rate mismatch

Averages 50 tracks and emits one 128-wide result. The tricky part:

```cpp
if (seen < TA_EVENT) {
    // emit ZEROS -- but emit SOMETHING
    for (int j = 0; j < TA_OUT_W; j += VEC) aie::store_v(po + j, z);
    return;
}
```

**ADF buffer rates are static.** A kernel wired to an output port *must write on
every invocation*. It cannot say "no output this time". So it writes zeros for
6 of every 7 iterations and the real mean on the 7th.

This is a general and important constraint: **the AIE dataflow graph has fixed
production/consumption rates.** Anything with a duty cycle — an accumulator, a
decimator, an event boundary — must be expressed as "produce a defined value
every time," not "produce sometimes."

## And one thing deliberately *not* done in the AIE

The final 128→27 dense is computed on the host, not in the array. The kernel
header says why:

```
The dense operates on a SINGLE averaged vector, so it is an M=1 GEMV -- exactly
the shape this project exists to avoid on AIE-ML. It is 3,456 MACs (0.03% of an
event) but measured at 15-19 us however it is written, against 4.2 us for the
whole 14-layer pipeline. On the host it is free.
```

**Know when not to use the accelerator.** A batch-1 operation on a machine whose
atom is 4 rows wide is a bad fit no matter how small it is.

---

# Part 7 — How it all connects

```
host ──RTP(92 ports)──► weights + biases, written once, live on the tiles
                        │
host ──GMIO/PLIO──► [16×8] ──► buffer_x ──(tiling 8×4)──► emb_d0  (1 tile)
                                                            │ size_C 4×4
                                              buffer_r_e0 ◄─┘
                                        ┌── out[0] offset {0,0}  ──► emb_d1 stage 0
                                        └── out[1] offset {64,0} ──► emb_d1 stage 1
                                                            │  (cascade between them)
                                              buffer_emb_out
                                                            │
                                                        roll0  (static carry)
                                                            │ [8][256]
                                              buffer_s0_in ──► s0_d0 (4×2 = 8 tiles)
                                                            │
                                        ... s0_d1, s0_d2, s0_d3 ...
                                        ... solver1, solver2 ...
                                                            │
                                                        track_accum (static sum)
                                                            │ every 7th iteration
host ◄──GMIO──── the 128-wide event mean
```

Per graph iteration: **8 tracks in, 8 tracks of work through 14 dense layers.**
Seven iterations = 56 slots = one 50-track event plus 6 padding slots.

The pieces, and which file to read for each:

| what | where |
|---|---|
| per-layer shapes, tile counts, placement | `src_fp32/parameters.h` |
| the four dense kernel roles | `src_fp32/kernels/dense_bias_relu/dense_bias_relu.cpp` |
| how a layer's tiles are created and cascaded | `.../dense_bias_relu_graph.h` |
| which layer connects to which | `src_fp32/top_graph.h` |
| **all memtiles, tiling and DMA patterns** | `src_fp32/graph_plan.h` |
| the two hand-written kernels | `src_fp32/kernels/{roll_concat_batch,track_accum}/` |
| RTP ports, host-side push, PLIO vs GMIO | `aie_batch/app.cpp` |
| weight packing (the readable version) | `analysis/rtda_reference.ipynb` §1 |

---

# Part 8 — The recipe: mapping a new model

Someone hands you a network. Here is the order of operations. **Do the
arithmetic before you write any code** — most of the design is decided by the
first three steps.

### 1. Get a trusted reference first
Before any hardware work: a numpy or ONNX model you believe, and a stimulus.
In this repo that is `model/rtda_ref.py` + `model/mlp_fp32.onnx`, and *every*
implementation is scored against it. Without this you cannot tell a mapping bug
from a precision effect, and you will waste days on that confusion.

### 2. Count weight bytes per layer → minimum tile count
```
tiles ≥ ceil(K × N × sizeof(weight_t) / 16384)
```
16 KB is one AIE-ML memory bank and it is a hard limit
(`static_assert` in the kernel). A 256×128 fp32 layer needs ≥ 8 tiles.

### 3. Choose the split, `CAS_LENGTH` × `CAS_NUM`
Both must divide the layer, and `IN_FEAT_SLICE = K/CAS_LENGTH`,
`OUT_FEAT_SLICE = N/CAS_NUM`. Prefer `CAS_NUM` (independent) over `CAS_LENGTH`
(cascade latency) when you have the choice — but `CAS_LENGTH` is what shrinks the
weight slice, so memory usually decides.

### 4. Choose the batch
Must be a multiple of `2 × M` (= 8 for fp32). Bigger batch amortises weight
reuse and DMA, but costs latency and buffer memory. **This project measured
batch 4 and batch 8 as identical**, because 4 is padded to 8 — so 8 is the
smallest sensible choice, not 4.

### 5. Make every dimension a multiple of 16 elements
Otherwise memtile buffer descriptors are exhausted. This is why `INPUT_DIM = 16`
here for a 6-feature input. Pad in the weight packer, not in the kernel.

### 6. Fuse everything elementwise
Bias → accumulator initial value. Activation → the store epilogue. Never a
separate kernel.

### 7. Design the buffers by matching shapes
Producer writes `size_C` (M×N). Consumer reads `size_A` (M×K). Use `offset` to
feed cascade stages from one buffer. Let the DMA do every reshape.

### 8. Isolate anything stateful
Statics = state machine = you own the reset. Decide the semantics *before*
building, and add a flush mechanism if the array can be warm-started.

### 9. Check the weights actually arrived
Re-pack from source, diff against what the host pushed, expect bit-exact.
This repo's notebook §1 does it and it has caught real bugs.

### 10. Measure II, not wall-clock
`make report` reads the `T <ns>` markers from the simulator output. II is the
array's true throughput; wall-clock on the board includes DMA and per-`run()`
host cost that do not scale with the array. This project's fp32→bf16 is 4.03× in
II but 2.52× on silicon — and the difference *is* the finding.

---

# Part 9 — Building the expertise

**Read in this order.** Each is a day or less and each unlocks the next.

1. **`aie::mmul` in the AI Engine API docs.** Just the shapes: `size_A/B/C`,
   which `M,K,N` combinations exist for each dtype. Everything else follows from
   knowing your atom.
2. **This repo's `dense_bias_relu.cpp`**, the `dense_single` function only.
   Trace one iteration on paper with M=4, K=8, N=4 and a 16×128 layer. Draw
   which 32 floats each `load_v` touches.
3. **`graph_plan.h`**, one buffer. Draw the 128×8 array, then draw the 4×4 write
   tiles and the 8×4 read tiles on top of it. This is the moment tiling stops
   being magic.
4. **The AIE-ML memory model.** 64 KB per tile in 4 banks of 16 KB; memtiles are
   512 KB; cascade is tile-to-tile only, physically adjacent. Almost every
   structural constraint in a design comes from these three numbers.
5. **Vitis Analyzer** on a real run (`make -C aie_batch analyze`). Look at where
   the stalls are. It will usually not be where you guessed.

**Exercises against this repo**, in increasing difficulty:

- Change `BATCH` to 16 in `aie_batch/Makefile` and `make regen`. Predict the
  tile count and II before you measure.
- Take `emb_d1` (128→128, currently 2×2) and re-derive why it is not 1×4 or 4×1.
- Work out what `L3Cfg`'s 8 tiles hold, weight slice by weight slice, and check
  it against `pack_mmul`.
- Implement the `W_curr`/`W_prev` split described in `aie_batch/HANDOFF.md`
  (two 128-wide GEMMs + a row-shifted add, replacing roll-concat). The PL flow
  in `pl_fixed/` already computes it that way, so the weight split is done.

**The habits that matter more than the API:**

- **Compute the tile count and the buffer bytes before writing code.** If the
  arithmetic does not work, no amount of code will fix it.
- **Keep one trusted reference and score everything against it**, always in the
  same metric, always on the same stimulus.
- **Distinguish a convention difference from an error.** The 1.556e-02 in this
  repo is the roll convention; the 7.5e-07 is arithmetic. Conflating them sends
  you hunting for a bug that does not exist.
- **When a number surprises you, measure the decomposition.** The `pl_fixed`
  precision work in this repo produced a result where *three of four changes
  were individually harmful*. Nobody would have guessed that; the ablation
  showed it.

---

# Appendix — Quick reference

| symbol | meaning | typical |
|---|---|---|
| `M, K, N` | mmul micro-tile: `C[M][N] += A[M][K] × B[K][N]` | 4, 8, 4 (fp32) |
| `size_A/B/C` | `M*K`, `K*N`, `M*N` | 32, 32, 16 |
| `padded_independent_extent` | the batch, padded to a multiple of `2*M` | 8 |
| `IN_FEAT / OUT_FEAT` | the layer's logical shape | 256 / 128 |
| `CAS_LENGTH` | tiles splitting the **input** (cascade-linked) | 1, 2, 4 |
| `CAS_NUM` | tiles splitting the **output** (independent) | 1, 2 |
| `IN_FEAT_SLICE` | `IN_FEAT / CAS_LENGTH` — per-tile input width | 64 |
| `OUT_FEAT_SLICE` | `OUT_FEAT / CAS_NUM` — per-tile output width | 64 |
| `N_ITER` | graph iterations per host `run()` | 7 (= 56 slots) |

**Hard limits to memorise**

| limit | value | consequence |
|---|---|---|
| weight slice per tile | **16 KB** (one bank) | sets the minimum tile count |
| tile data memory | 64 KB (4 banks) | ifm + ofm + weights + stack must fit |
| memtile | 512 KB | shared buffers between stages |
| batch granularity | multiple of `2×M` | 4 and 8 cost the same |
| any tensor dimension | multiple of 16 elements | or buffer descriptors are exhausted |
| cascade | physically adjacent tiles only | constrains placement |
| ADF rates | static | a wired output must be written every iteration |
