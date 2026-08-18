# Mapping a neural network onto AIE-ML, properly

**From "I wrote a kernel per layer" to "I tile the problem to fit the hardware's
atom."**

This document explains the design in `aie_batch/`, using this repo's own code.
It is written for someone who has already built an AIE graph the
straightforward way — a kernel per layer, matrix × vector, weights via RTP —
and wants to understand why the batched version looks completely different and
runs 29× faster.

Everything here is checkable. Design claims cite the files named; hardware claims
cite **AM020** (the Versal AIE-ML Architecture Manual) or a header in your Vitis
install; counts cite `aie_batch/Map_Report.csv` and the reports in `results/`.
Nothing is generic AIE advice, and nothing is inferred from how it "must" work.

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

The AIE-ML vector unit's matrix-multiply instruction computes:

```
C[4][8] ... no. Precisely:   C[4][4]  +=  A[4][8] × B[8][4]
                                 M=4      M=4 K=8    K=8 N=4
```

**It multiplies a 4×8 block of A by an 8×4 block of B in one instruction.** Not
a vector by a matrix — a *block* by a *block*.

That shape is not a library author's preference, and it is worth knowing where it
comes from before anything else. AM020 states the vector unit's throughput
directly: *"Vector unit supports 128 bfloat16 MAC operations with FP32
accumulation."* And 4 × 8 × 4 = 128. Lay the operands against the 512-bit
registers and every dimension is pinned:

| | in bf16 | bits |
|---|---|---|
| A = M×K = 4×8 | 32 values | 512 — one vector register |
| B = K×N = 8×4 | 32 values | 512 — one vector register |
| C = M×N = 4×4 | 16 accumulators × 32b | 512 — one accumulator, and exactly the cascade width |

**512 bits in from the left, 512 in from the top, 512 of accumulator out, 128
MACs, one cycle.** Ask for a bigger atom and you are asking for a wider datapath.
(See Part 1a for what this means when your data type is float32, which is *not*
the type the sentence above is about.)

Now look at what matrix × vector asks it to do. Your input is one track: a
vector of 128 numbers, i.e. a 1×128 matrix. `M = 1`. The instruction still
computes 4 rows. Three of them are fed garbage or zeros and their results are
thrown away.

**You paid for a 4-row instruction and filled 1 row. Three quarters of every
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

with `M = 4, K = 8, N = 4` — for **both** precisions (see `parameters.h`, every
`L*Cfg`, and `src_bf16/parameters.h` likewise).

## You do not choose the shape; you pick from a short list

The available shapes per data type are enumerated in a header on this machine,
`$XILINX_VITIS/aietools/include/aie_api/detail/mmul.hpp`, under "Supported
Matrix Multiplication Modes". For AIE-ML:

| data type | shapes on AIE-ML | issued natively |
|---|---|---|
| **float × float** | 4×8×4, 4×1×4 ᵇ, 4×1×8 ᵃᵇ | **4×8×4** — the only useful one |
| **bf16 × bf16** | 4×8×4, 8×8×4 ᵃ, 4×16×8 ᵃᵇ, 8×8×8 ᵃᵇ | **4×8×4** — the rest are built from it |
| int8 × int8 | 4×8×4 ᵃᵇ, 2×8×8, 4×8×8, 8×8×8 ᵃ, … | 2×8×8 / 4×8×8 |
| int16 × int16 | 4×4×4, 2×4×8, 4×2×8, 8×2×8 ᵃ, … | 4×4×4 / 2×4×8 |

ᵃ emulated using multiple intrinsic calls. ᵇ requires additional data
manipulation. Both notations are the header's own.

Read the bf16 row carefully: the bigger entries exist, but they are marked ᵃ —
the library builds them out of several 4×8×4 instructions. **For both of this
project's precisions, 4×8×4 is the only shape the hardware issues in one go.**
That is what lets `gen_graph.py` say

```python
# On AIE-ML both use the SAME aie::mmul microtile, (4,8,4) -- see
# op_impls/families/matmul/common.py MICROTILE_OPTIONS -- so BATCH stays 8
```

and mean it. The int8 row shows the general rule: find your type's MACs/cycle
(int8 gets 256, twice bf16's 128), factor it into M·K·N, and the menu will be
the sensible factorisations of that number.

## The three sizes

`MMUL` exposes three, and they are the shapes you must think in:

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

---

# Part 1a — There is no float32 multiplier on this chip

This is the single most important thing that is true of the fp32 build and is
easy to miss, because nothing warns you. It compiles cleanly, runs, and matches
the reference to 7.5e-07. It just costs about **nine times** what you think.

AIE-ML deleted the fp32 vector datapath that AIE-1 had. AM020 is blunt:

> *"32-bit floating-point vector data path is not directly supported but can be
> emulated via decomposition into multiple multiplications of 16 × 16-bit."*
> — AM020, *AIE-ML Processor*

and the AI Engine API header repeats it as a footnote to the shape table:
*"float multiplications are emulated on AIE-ML/XDNA 1 using native bfloat16
multiplications."*

## What "emulated" costs, from the source on disk

The emulation is not hidden. It is C in
`$XILINX_VITIS/aietools/data/aie_ml/lib/me_vmult_float_emulated.h`. Each fp32
operand is split into **three** bf16 terms — a coarse term, a correction, and a
correction to the correction — and then every cross product is accumulated:

```c
// mac_4x8_8x4_accuracy_safe_inner(), the DEFAULT. A splits into a,b,c; B into d,e,f.
v16accfloat tmp = mul_4x8_8x4_conf(c, f, sub_mul);
tmp += mul_4x8_8x4_conf(c, e, sub_mul);
tmp += mul_4x8_8x4_conf(b, f, sub_mul);
tmp += mul_4x8_8x4_conf(a, f, sub_mul);
tmp += mul_4x8_8x4_conf(b, e, sub_mul);
tmp += mul_4x8_8x4_conf(c, d, sub_mul);
tmp += mul_4x8_8x4_conf(b, d, sub_mul);
tmp += mul_4x8_8x4_conf(a, e, sub_mul);
tmp += mul_4x8_8x4_conf(a, d, sub_mul);   // nine of them
```

plus the split itself: six `msc_elem_16_2` ops and a dozen shuffles/inserts. And
the operands are twice the bytes — `vector<float,32>` is 1024 bits, two register
loads per operand rather than one.

**There are three modes, and they are a supported knob:**

| mode | bf16 mmuls per fp32 mmul | how to select |
|---|---|---|
| `accuracy_safe` | **9** | the default — this build |
| `accuracy_fast` | **6** | `-DAIE_FP32_EMULATION_ACCURACY_FAST` |
| `accuracy_low` | **3** | `-DAIE_FP32_EMULATION_ACCURACY_LOW` |

Documented at `me_vmult.h:3213`. **This design sets none of them and is paying
the full nine.**

## Why this reframes the fp32-vs-bf16 comparison

The natural story — "bf16 is half the bytes, so it's a bit faster" — is wrong
here, and being wrong about it leads to the wrong optimisation. The truth:

- **bf16 is the machine's native type.** One `mac`, one cycle.
- **fp32 is a software construction on top of it.** Nine `mac`s, plus the split,
  plus double the operand bytes.

So the honest framing of the two builds is not "the same design at two
precisions". It is **"the design, and the design run through a 9× emulation
layer"** — a completely reasonable thing to do when you want 7.5e-07 against the
reference, and a completely unreasonable thing to do by accident.

### Then why is the measured II ratio only 4.03×?

II is 4161 ns (fp32) against 1033 ns (bf16). Not 9×, because **the bf16 build is
no longer limited by the vector unit.** `analysis/rtda_scan.ipynb` measured
**39.4%** of the bf16 design's time outside the array against **3.4%** for fp32,
and that fraction does not fall from 1000 to 10,000 events, so it is not launch
overhead. The suspect is the output DMA: the 27 outputs come back as fp32 in
*both* precisions, so bf16 halves the input and changes the output not at all.

Read the numbers this way: **fp32 at 4161 ns is telling you about the emulation;
bf16 at 1033 ns is telling you about the DMA.** They are measuring two different
bottlenecks, which is exactly why the ratio is neither 9 nor 2.

> **The actionable item.** Before optimising anything else in an fp32 AIE-ML
> design, build with `-DAIE_FP32_EMULATION_ACCURACY_FAST` and measure both the II
> and the error against the reference. You are trading 9 mmuls for 6. This repo
> has a trusted reference and a one-command crosscheck, so the experiment costs a
> build. Be careful rather than eager: the modes differ in how many correction
> terms survive, and the ones you drop are exactly the low-order bits the 7.5e-07
> is made of. Measure, do not assume.

---

# Part 1b — The three loop levels

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
tiles that carries **raw accumulator values** — not rounded outputs. On AIE-ML it
is **512 bits wide**, which is exactly `MMUL::size_C` = 16 accumulators × 32 bits
— one atom's output is one cascade word. That is not a coincidence; it is the
same 512-bit granularity the whole datapath is built on.

Look at `dense_first`:

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

Two properties of the hardware link that shape the design:

- **It has a small FIFO.** AM020 describes *"a small, two-deep, 512-bit wide FIFO
  on both the input and output streams that allow storing up to four values
  between AIE-MLs."* So a stage can run slightly ahead of its neighbour without
  stalling instantly — but only by four accumulator words. Beyond that the
  producer blocks, and a slow stage becomes everyone's problem.
- **It constrains placement, hard.** Cascade partners must be physically
  adjacent. That is why `place_graph()` computes an explicit
  `adf::tile(tileCol, tileRow)` for every kernel rather than letting the mapper
  choose, and why `parameters.h` carries a `col_placement` / `row_placement` pair
  per layer. **On this device, cascade depth is a floorplanning decision.** The
  cascade runs *along a row* (`tileCol = COL_START + idx % CAS_LENGTH`); the
  independent chains occupy *different rows* (`tileRow = ROW_START + idx /
  CAS_LENGTH`).

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

> **A known inconsistency in the assertions next to it.** The following
> `static_assert` checks `IN_FEAT_SLICE % (2 * ConfigT::N)` but its message reads
> *"IN_FEAT_SLICE must be divisible by 2\*K"*. With `N = 4`, `K = 8` and 64-wide
> slices both readings pass, so it has never fired. If you reshape a layer and hit
> it, believe the code, not the string — and consider whether the intended check
> was against `K`.

AM020 gives the memory exactly, and the second sentence is the one that matters:

> *"Data memory is increased from 32 KB to 64 KB organized as eight banks of 8 KB
> from a hardware perspective. From a programmer's perspective, every two banks
> are interleaved to form one bank, that is, a total of four banks of 16 KB."*
> — AM020, *AIE-ML Tile Architecture*

So 16 KB is not folklore — it is the granularity you allocate in. **In this
design the weight slice on one tile must fit in one bank.** For fp32 that is
4096 weights = 64×64.

Be precise about what kind of rule that is. Nothing in the silicon forbids a
32 KB buffer spanning two banks. The 16 KB limit here is **self-imposed**,
enforced by the `static_assert` above *and* by explicit bank pinning in
`place_graph()`, and the reason is **bank conflicts**: in the inner loop the
vector unit issues a load of A, a load of B and eventually a store of C every
iteration. If two of those share a bank the accesses serialise, the pipeline
stalls, and the four accumulators you carefully kept in flight are suddenly
waiting on memory.

The discipline that follows: *give each thing the unit touches simultaneously its
own bank.* Your bank budget is not "64 KB, spend it how you like" — it is "four
slots, and things read in the same cycle must not share one."

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

## Where the four banks actually go — and why there are eight

The weights get a bank. What has the other three? The answer is written out in
`place_graph()` and it is not what you would guess:

```cpp
adf::location<adf::buffer>(kk[idx].in[0]) = {          // the INPUT block...
    adf::bank(tileCol - 1, tileRow, 0),                // ...in the WEST NEIGHBOUR, bank 0 (ping)
    adf::bank(tileCol - 1, tileRow, 3)                 // ...and its bank 3          (pong)
};
adf::location<adf::stack>(kk[idx])        = adf::bank(tileCol, tileRow, 1);
adf::location<adf::buffer>(kk[idx].in[1]) = adf::bank(tileCol, tileRow, 2);  // weights
if (is_last) {
  adf::location<adf::buffer>(kk[idx].out[0]) = {       // the OUTPUT block...
      adf::bank(tileCol, tileRow, 0),                  // ...own bank 0 (ping)
      adf::bank(tileCol, tileRow, 3)                   // ...own bank 3 (pong)
  };
  ... bias -> adf::bank(tileCol, tileRow, 1);
}
```

```
        WEST NEIGHBOUR tile (col-1, row)          COMPUTE tile (col, row)
        no kernel of ours runs here               the kernel runs here
      ┌──────┬──────┬──────┬──────┐             ┌──────┬──────┬──────┬──────┐
      │ bnk0 │ bnk1 │ bnk2 │ bnk3 │  ── reads ─►│ bnk0 │ bnk1 │ bnk2 │ bnk3 │
      │ ifm  │ RTP  │ RTP  │ ifm  │             │ ofm  │stack │WEIGHT│ ofm  │
      │ PING │ sel  │ sel  │ PONG │             │ PING │+bias │ 16KB │ PONG │
      └──────┴──────┴──────┴──────┘             └──────┴──────┴──────┴──────┘
```

**Four banks are not enough for one kernel, so it uses eight.** This is legal
because AM020 says an AIE-ML tile *"can access data memory modules on all four
directions... accessed as one contiguous memory"* — a tile's addressable space is
five tiles wide.

Verified, not inferred: in `aie_batch/Map_Report.csv`, kernel `emb_d0` is placed
at tile **(7, 0)**; its weight RTP sits at (7,0) bank 2, its bias at (7,0) bank 1,
its output ping/pong at (7,0) banks 0 and 3 — and its input ping/pong (`buf0`,
`buf353`) at **(6, 0)** banks 0 and 3. Across the whole design, of **489**
core-tile buffer allocations, none exceeds 16,384 bytes and none crosses a bank
boundary.

Note also the placement rule for `in[0]`: because the ifm lives one column *west*,
`COL_START` for a layer must leave a spare column to its left, and a cascade of
length 4 therefore occupies five columns of the array, not four.

## Ping-pong, in three different mechanisms

"Double buffering" appears three times under three names, configured in three
places. Separating them is worth doing once:

| where | how you ask | what it buys | here |
|---|---|---|---|
| kernel **ifm / ofm buffer** | default; two banks listed in `location<buffer>` | DMA fills one copy while the vector unit reads the other | ifm → neighbour banks 0/3; ofm → own banks 0/3 |
| kernel **weight (RTP) buffer** | `single_buffer(kk[idx].in[1])` | nothing — deliberately. One copy, written once, never changes | halves the weight footprint |
| **`shared_buffer`** (memtile) | `num_buffers(self.buffer_x) = 2` | producer writes one frame while consumer reads the previous | all 18 shared buffers |

> **`single_buffer()` on the weight port is load-bearing, not a micro-optimisation.**
> Without it the port is double-buffered and a 16 KB slice needs **32 KB** — two
> banks — and the whole allocation scheme collapses. Your `static_assert` still
> passes and the mapper fails later with an error that says nothing about weights.
> It is *safe* to single-buffer because a double buffer exists so a writer and a
> reader can proceed at once, and the weights have no concurrent writer after
> startup. There is nothing to overlap.

## Why 2×2 and not 1×4 or 4×1 — work all three

`128×128×4 B = 64 KB`, and `64 KB / 16 KB = 4 tiles minimum`. **All three
factorisations fit the memory exactly**, so memory does not decide this one — it
already did its job by saying "4 tiles".

| arrangement | per tile | bytes | cascade depth | reader ports on the input memtile |
|---|---|---|---|---|
| **1 × 4** — one chain, 4 deep | 32 in × 128 out | 16 KB | 4 — worst | 1 |
| **2 × 2** — two chains, 2 deep | 64 in × 64 out | 16 KB | 2 | 2 |
| **4 × 1** — four chains, no cascade | 128 in × 32 out | 16 KB | 1 — best | **4 — too many** |

On latency alone **4 × 1 should win**: no cascade at all, nothing waiting on a
neighbour. It is chosen against anyway, for a reason in neither column.

**Every chain has to be fed.** Four independent chains means four separate read
streams out of the shared buffer holding the layer's input — and an AIE-ML memory
tile has only **six MM2S channels** (and six S2MM), total, shared with everything
else reading that buffer, across 48 buffer descriptors. Ask for 4 chains on the
128-wide layers and you run out. `gen_graph.py` says so in as many words:

```python
# cas_num is capped at 2 on the 128-wide layers: the default of 4
# saturates the 6 MM2S DMA channels of a memory tile (per aie4ml tutorial_3).
```

So 2 × 2 is the compromise: the best cascade depth still reachable inside the
channel budget. **The latency rule picked 4 × 1; a countable resource elsewhere
overruled it.** That pattern — a clean principle overruled by some other resource
you have to go and count — is most of what designing for this device feels like,
and it is why "why is it 2?" almost never has an answer in the layer's own
arithmetic.

The knock-on: the 256→128 layer needs 8 tiles and chains are capped at 2, so its
cascade is 4 deep — the depth we just called worst — because the options were
2 × 4 or nothing. The deepest cascade in the network is set by the widest layer,
and the widest layer exists because the roll-concat doubles 128 into 256. The
cost of that concatenation shows up four tiles from where it was introduced.

> **One deliberate non-optimisation.** The cascade lengths here are *pinned by
> hand*, not chosen by the resolver — see the `CAS_LENGTH` dict in
> `gen_graph.py`. bf16 halves the weight bytes, so the resolver would give it
> shorter cascades than fp32 (emb_d1 2→1, solver d0 4→2), and the two builds would
> then differ in *parallelism* as well as precision, making the comparison
> meaningless. The price is visible in the build: in bf16 each 64×64 slice is only
> **8 KB**, so half of the weight bank sits empty. That is the cost of a
> controlled experiment, paid knowingly.

---

# Part 4 — Weights: where they live and how they get there

## They live on the tile, permanently

```cpp
connect<parameter>(wts[idx], async(kk[idx].in[1]));
single_buffer(kk[idx].in[1]);
```

(`dense_bias_relu_graph.h`)

Three keywords, and each one is doing a specific job:

| the word | what it means | what breaks without it |
|---|---|---|
| `connect<parameter>` | this port is written by the **host**, not by another kernel | the compiler expects a stream and the graph will not wire up |
| `async(...)` | the kernel does **not** block waiting for a fresh value each iteration; it uses whatever is there | a synchronous RTP stalls the graph every iteration waiting for a host write that never comes |
| `single_buffer(...)` | one copy in memory, no ping-pong | 16 KB becomes 32 KB and the bank allocation collapses (Part 3) |

So the weights are pushed **once, before the run**, and then every iteration is
pure compute. This part of your original design was already right; it did not
need to change.

## The 92 ports, and the path they travel

```
model/weights_fp32/  ──pack_mmul──►  extract_rtp.py  ──►  sysdata_<P>/
  plain text, [in][out]              92 .bin payloads     rtp_manifest.txt
                                     + port names
                                            │
                          sim:  dut.update(port, ptr, n)          (app.cpp)
                          hw:   xrt::graph::update(port, span)    (host_batch.cpp)
                                            │
                            memory-mapped AXI writes straight into
                                  tile (col,row) bank 2
```

**92 = 65 weight ports + 27 bias ports.** One weight port per dense tile (65 of
them, which is also the dense tile count); one bias port per *chain* per layer,
because only `dense_last` carries a bias — the earlier stages hand on a raw
accumulator. That asymmetry is why the two numbers differ.

The manifest is the contract between packer and host: a list of
`<port_name> <n_elems> <dtype> <path>`. Port names are literal and come from the
graph metadata, never guessed — e.g. `dut.dut.emb_d0_aie.kk[0].in[1]`. Change the
graph and the names change with it, which is exactly why `host_batch.cpp` replays
a manifest rather than hard-coding anything. There are only four distinct element
counts in the whole graph (64, 128, 2048, 4096), which is why the host switches on
length: `xrt::graph::update` takes a sized span.

The mapper also allocates a **32-byte control word per RTP port** — visible as 92
rows of `SIZE 32` in `Map_Report.csv`, sitting in the neighbour tile's banks 1
and 2. Whole payload: about 1 MB, pushed once, zero per-run cost afterwards.

> **A trap this project hit.** Generated bf16 weight headers store raw
> `uint16_t` bit patterns (C++ has no portable bfloat16 literal), but the RTP port
> is typed `bfloat16`. Passing the array directly gives
> `adf::graph::update parameter type uint16 is inconsistent with RTP port ... type
> bfloat16`, after which **no weights arrive and the graph deadlocks — while the
> x86 simulator still exits 0 and prints "Simulation completed successfully."**
> The fix is the `reinterpret_cast` in `as_weights<Cfg>()` (`app.cpp`), correct
> rather than lossy: the uint16 *is* the bf16 encoding.
>
> General lesson: **an RTP that never arrived looks exactly like a graph that
> hangs for a scheduling reason.** Verify the payloads landed before debugging the
> dataflow.

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

Its budget, from AM020's *AIE-ML Memory Tile Overview and Features*, and every
number in it constrains something in this design:

| memory tile resource | value | what it costs you here |
|---|---|---|
| memory | 512 KB, 16 banks | holds all 18 inter-stage buffers |
| MM2S (read) channels | **6** | **caps `CAS_NUM` at 2** — every chain is a reader |
| S2MM (write) channels | 6 | one per producing chain |
| buffer descriptors | **48 shared** (24 reachable per channel) | why every dimension must be a multiple of 16 |
| neighbour access | channels 0–3 reach east/west memtiles | lets a buffer be read from an adjacent column |

There are **18** `shared_buffer` objects in `top_graph.h`; the mapper packs them
into memory tiles, several to a tile where the channel budget allows.

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

And each of those readers costs one of the memory tile's six MM2S channels. That
is the same budget Part 3 spent when it capped `CAS_NUM` at 2 — the offset field
is free, but the *port* it belongs to is not.

## Where the "multiple of 16 elements" rule comes from

Not alignment for its own sake, and not superstition: **buffer descriptors**. A
memory tile has 48 of them across its twelve channels, 24 reachable by any one
channel, and a tiling pattern that needs a fresh descriptor per row burns through
them fast. `gen_graph.py` records exactly what happened when the input was left at
its natural width:

```python
# aie4ml aligns the contracted dimension to lhs_align = 2 * microtile_k = 16.
# At width 6 or 8 the input is padded 6->16, and that strided staging needs one
# memory-tile buffer descriptor per batch row, which exhausts the BD pool for
# batch > 8 ("[aiecompiler 77-4352] Failed to allocate buffer descriptors for
# buffer_x"). At width 16 the copy is contiguous and the problem disappears.
```

So `INPUT_DIM = 16` for a 6-feature input converts a strided staging copy into a
contiguous one, and a contiguous copy needs **one** descriptor instead of eight.
Pad in the weight packer, never in the kernel.

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

- Track 0 of a block pairs with the *previous block's last track*, and track 0 of
  the **very first** block pairs with the zero-initialised `carry` — so the roll
  is **streaming**, not circular. The ONNX reference rolls *circularly* within a
  50-track event (track 0 pairs with track 49), which a streaming graph cannot do
  without buffering the whole event. This is the single biggest source of "why
  don't my numbers match the reference" in this repo, and it is why the comparison
  excludes a 3-track warm-up: the network's receptive field is 4 tracks deep, so
  the reference's first three outputs are contaminated anyway.
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

The 7 is the event size over the batch: **50 tracks, padded to 56 slots, at 8
tracks per iteration = 7 iterations** (`N_ITER` in `parameters.h`). Emitting zeros
rather than a partial sum is a deliberate interface choice: the consumer never
needs to know that 7 is the magic number. It can sum all frames, or take the
non-zero one, and stays correct if `N_ITER` changes.

### The padding slots are not harmless — read this before copying the pattern

The obvious implementation sums all 56 slots and divides by 50. That is wrong,
and the kernel's header explains why: **every dense layer has a bias, so a
zero-input track still produces a sizeable output** — measured |max| 0.13 against
0.49 for a real track. Summing 56 and dividing by 50 shifts every element of the
mean by ~6.6% of signal.

So the kernel **counts** and stops at 50. Which introduces its own limitation,
also written down: it counts *slots consumed*, not real tracks — it cannot tell
them apart, because by the time a zero-input slot arrives here it carries a
bias-determined activation like any other. **Every event must therefore carry
exactly 50 real tracks.** A short final event yields a wrong mean (measured
8.0e-02 for a 20-track event) that still looks entirely plausible. The host warns;
`sim_events.py --tracks` warns; fixing it properly needs the real count delivered
per event (an RTP, or a sentinel slot), which is a design change, not a tweak.

That is what "expressing a duty cycle in a static-rate system" actually costs.
Not a hack — a contract, with a precondition you must enforce upstream.

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

## The tile census

Counted from the 69 `PT` (placed-tile) rows of `aie_batch/Map_Report.csv`, not
from the prose:

| | tiles | |
|---|---|---|
| dense kernels | **65** | 1 + 4 + 8 + 12 + 8 + 12 + 8 + 12, per the table in Part 3 |
| `roll_concat_batch` | 3 | one per solver block |
| `track_accum` | 1 | the event mean |
| **total compute tiles** | **69** | of 304 on the XCVE2802 |
| `shared_buffer` objects | 18 | packed into memory tiles by the mapper |

(The top-level `README.md` quotes "65 compute tiles", which is the *dense* count;
the array actually holds 69 placed kernels.)

**Why not use all 304?** Because there is nothing left to split. Every layer but
the first already sits at exactly 16 KB per tile, and the chain count is capped by
the memtile's six read channels. You could run *more copies of the whole network*
side by side and process several independent track streams — a throughput win, not
a latency win — but this design did not need it: the fp32 build spends only **3.4%**
of its time outside the array. There is no headroom to reclaim by adding tiles,
because the array is not what you are waiting for.

The pieces, and which file to read for each:

| what | where | origin |
|---|---|---|
| the ONNX, the `cas_num`/`cas_length` directives, padding, the precision switch | `aie_batch/gen_graph.py` | hand-written |
| per-layer shapes, tile counts, placement | `src_<P>/parameters.h` | generated |
| the four dense kernel roles — **the only file with arithmetic in it** | `src_<P>/kernels/dense_bias_relu/dense_bias_relu.cpp` | generated |
| how a layer's tiles are created, cascaded, banked | `.../dense_bias_relu_graph.h` | generated |
| which layer connects to which | `src_<P>/top_graph.h` | generated + hand-edited |
| **all memtiles, tiling and DMA patterns** | `src_<P>/graph_plan.h` | generated |
| the two hand-written kernels | `src_<P>/kernels/{roll_concat_batch,track_accum}/` | hand-written |
| RTP ports, host-side push, PLIO vs GMIO | `aie_batch/app.cpp` | generated + hand-edited |
| RTP payloads and port names → `sysdata/` | `aie_batch/extract_rtp.py` | hand-written |
| the XRT host: xclbin, manifest replay, GMIO | `aie_batch/host/host_batch.cpp` | hand-written |
| weight packing (the readable version) + the bit-exactness check | `analysis/rtda_reference.ipynb` §1 | hand-written |

> **Most of `src_<P>/` is generated.** `gen_graph.py` builds the network as ONNX
> from `model/weights_fp32/`, hands it to **aie4ml**, and aie4ml lowers each
> `Gemm` to an `aie::mmul` kernel and emits an ordinary Vitis AIE project. Two
> consequences: **do not hand-edit the generated files** and expect the edit to
> survive `make regen`; and — the useful half — **everything it emits is something
> you could have written yourself.** The output is plain ADF C++ with no runtime
> attached. The generator is a convenience, not a dependency.
>
> The hand-written additions are `roll_concat_batch`, `track_accum`, and the
> wiring in `top_graph.h` / `graph_plan.h` that connects them — precisely the parts
> that were not expressible as an ONNX `Gemm`.

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

### 2. Pick the data type, then look up its atom
Find MACs/cycle for that type on AIE-ML (bf16: 128, int8: 256), factor into
M·K·N, and confirm the shape actually exists in
`$XILINX_VITIS/aietools/include/aie_api/detail/mmul.hpp`. Prefer a shape *not*
marked ᵃ, or you are paying for an emulation.

**If you chose float32, read Part 1a first.** You are choosing a 9× bf16
emulation, and you should choose it on purpose, with the accuracy-mode flag in
hand.

### 3. Count weight bytes per layer → minimum tile count
```
tiles ≥ ceil(IN_FEAT × OUT_FEAT × sizeof(weight_t) / 16384)
```
16 KB is one AIE-ML memory bank; the `static_assert` in the kernel makes it a
compile error. A 256×128 fp32 layer needs ≥ 8 tiles. Do this for every layer, in
a spreadsheet, before writing anything.

### 4. Choose the split, `CAS_LENGTH` × `CAS_NUM`
Both must divide the layer, and `IN_FEAT_SLICE = IN_FEAT/CAS_LENGTH`,
`OUT_FEAT_SLICE = OUT_FEAT/CAS_NUM`. Prefer `CAS_NUM` (independent, no cascade
latency) over `CAS_LENGTH` — **then check the chain count against the feeding
memory tile's 6 MM2S channels, counting every other reader of that buffer too.**
That check is what will actually decide it, not the latency preference. Budget one
spare column to the west of each layer for the ifm buffers.

### 5. Choose the batch
Must be a multiple of `2 × M` (= 8 for fp32). Bigger batch amortises weight
reuse and DMA, but costs latency and buffer memory. **This project measured
batch 4 and batch 8 as identical**, because 4 is padded to 8 — so 8 is the
smallest sensible choice, not 4.

### 6. Make every dimension a multiple of 16 elements
Otherwise memtile buffer descriptors are exhausted. This is why `INPUT_DIM = 16`
here for a 6-feature input. Pad in the weight packer, not in the kernel.

### 7. Fuse everything elementwise
Bias → accumulator initial value. Activation → the store epilogue. Never a
separate kernel.

### 8. Design the buffers by matching shapes
Producer writes `size_C` (M×N). Consumer reads `size_A` (M×K). Use `offset` to
feed cascade stages from one buffer. Let the DMA do every reshape.

### 9. Isolate anything stateful
Statics = state machine = you own the reset. Decide the semantics *before*
building, and add a flush mechanism if the array can be warm-started.

### 10. Check the weights actually arrived
Re-pack from source, diff against what the host pushed, expect bit-exact.
This repo's notebook §1 does it and it has caught real bugs.

### 11. Measure II, not wall-clock
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
4. **The AIE-ML memory model**, from AM020 rather than from folklore. 64 KB per
   tile as 8 hardware banks of 8 KB, interleaved in pairs into 4 programmer banks
   of 16 KB; a tile can address its neighbours' data memory in all four
   directions as one contiguous space; memtiles are 512 KB with 6 MM2S + 6 S2MM
   channels and 48 buffer descriptors; the cascade is 512 bits, adjacent tiles
   only, with a 4-deep FIFO. Almost every structural constraint in a design comes
   from these numbers, and the ones that bite are the *channel* and *descriptor*
   counts, not the byte counts.
5. **Vitis Analyzer** on a real run (`make -C aie_batch analyze`). Look at where
   the stalls are. It will usually not be where you guessed.

**Exercises against this repo**, in increasing difficulty:

- Build the fp32 design with `-DAIE_FP32_EMULATION_ACCURACY_FAST`. Predict the II
  from Part 1a's 9→6 ratio, then measure it *and* the error against the reference.
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
| `M, K, N` | mmul micro-tile: `C[M][N] += A[M][K] × B[K][N]` | 4, 8, 4 (both precisions) |
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
| vector unit | **128 bf16 MACs/cycle**, 256 int8 | fixes the atom at 4×8×4 for bf16 |
| **fp32 multiply** | **none — emulated** | **9 bf16 mmuls each (6 FAST, 3 LOW)** |
| weight slice per tile | **16 KB** (one bank) | sets the minimum tile count |
| tile data memory | 64 KB = 8×8 KB hw = **4×16 KB** as seen | ifm + ofm + weights + stack must fit |
| neighbour memory | addressable in all 4 directions | the ifm ping/pong lives in the west tile |
| cascade | **512 bits**, adjacent tiles, 4-deep FIFO | = `size_C` exactly; constrains placement |
| memtile | 512 KB, 16 banks | shared buffers between stages |
| **memtile DMA** | **6 MM2S + 6 S2MM** | **caps `CAS_NUM` at 2** |
| memtile buffer descriptors | 48 shared, 24 per channel | why any tensor dim must be a multiple of 16 |
| batch granularity | multiple of `2×M` | 4 and 8 cost the same |
| ADF rates | static | a wired output must be written every iteration |
| tiles on the XCVE2802 | 304 | this design places 69 (65 dense + 3 roll + 1 accum) |

**Where these came from.** The hardware rows are AM020 (*AIE-ML Processor*,
*Tile Architecture*, *Interfaces*, *Memory Tile Overview and Features*). The mmul
shape menu and the fp32 emulation counts are headers in your Vitis install
(`aie_api/detail/mmul.hpp`, `data/aie_ml/lib/me_vmult_float_emulated.h`,
`me_vmult.h:3213`). The tile, port and bank counts are read off
`aie_batch/Map_Report.csv`. The timing numbers are `RUNBOOK.md` and
`results/*/hw/run_info.txt`.
