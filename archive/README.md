# archive/ — the retired 1-track GEMV design

Kept intact, not maintained. Nothing in the live build reads anything here.

## What it is

The original AIE-ML implementation: **matrix × vector, one track per
iteration**, using the Vitis DSP Library's `matrix_vector_mul_graph`, with the
event average done by a PL kernel (`track_average_pl`).

It works and it was measured on silicon at **17,770 ns/track**. `aie_batch/`
supersedes it at 615 ns (fp32) and 245 ns (bf16) — **28.9× faster** — by
batching 8 tracks per iteration so that `aie::mmul`'s 4-row instruction is not
¾ wasted, and by moving the track average into the array.

## Contents

| | |
|---|---|
| `aieml/` | the GEMV graph, kernels and testbench |
| `pl/` | `track_average_pl` and its HLS project — only this design used it |
| `host/` | the XRT host for that flow |
| `dsp_lib/` | vendored Vitis DSP Library (L1/L2), needed only by `aieml/` |
| `data/` | **overwritten with random int16** by `gen_int16_data.py` in Aug 2026. Not the weights. |
| `data_int16/` | the int16 quantization experiment's weights |
| `common/` | `nn_defs10.h`, `data_paths.h`, the `linker_aieml*.cfg` variants |
| `pkg_float/`, `pkg_int16/` | old SD packages |
| `AIE_PERF_REPORT.md` | per-kernel timing of the GEMV design |
| `ARCHITECTURE_COMPARISON.md` | GEMV vs batched, written while deciding |
| `GEMM_FEASIBILITY.md` | the analysis that led to `aie_batch/` |
| `pl_hls_implementation_plan.md` | the PL implementation plan; still the best description of the layer shapes and the 8→6 embed padding |
| `screenshots/` | figures from earlier reports |

## Its results are still used

`model/weights_fp32/aieml10_output_aie.txt` is a real per-track VEK280 dump
from this design. `analysis/rtda_reference.ipynb` §2 compares the ONNX against
it as an independent check that the reference matches something that physically
ran — it agrees to 1.06e-06 on tracks 3..49. That file lives in `model/`, not
here, because it is still an input.

## Resurrecting it

It was driven by the old root Makefile's `AIE_DIR=aieml`, which no longer
exists. You would need to restore those rules (`git log -- Makefile`, before
the restructure commit) and repoint:

- `common/linker_aieml.cfg` — wires the AIE PLIO output to `track_average_pl`
- weights: `model/weights_fp32/`, **not** `archive/data/`
- `dsp_lib/` must be on the include path for `matrix_vector_mul_graph`

The int16 path additionally needs `PRECISION=int16`, which padded
`GRAPH_INPUT_SIZE` from 8 to 16 for 256-bit alignment and swapped `DATA_TYPE`
via `config_gen.h`.
