#!/usr/bin/env python3
"""Dump real model inputs, weights, biases and reference outputs.

This script mirrors the logic previously stored in ``dump_vals.ipynb``. It
loads submodule ONNX files, runs inference for one event from the ROM dataset,
then writes AIE‐ready text files containing padded inputs, transposed/split
weights, biases, and reference activations.
"""
from __future__ import annotations

import argparse
from pathlib import Path
import numpy as np
import onnx
import onnxruntime as ort
from onnx import numpy_helper

# Optional imports (dataset utilities)
try:
    import torch
    from torch.utils.data import DataLoader
    from rtal.datasets.dataset import ROMDataset
except ImportError:  # pragma: no cover - allows py_compile without deps
    torch = None
    DataLoader = None
    ROMDataset = None

# ----------------------------- Helpers ------------------------------------

def assemble_np(array: np.ndarray, subset_size: int) -> np.ndarray:
    """Roll along axis=1 and concatenate along last dimension."""
    return np.concatenate([np.roll(array, shift=i, axis=1) for i in range(subset_size)], axis=-1)

def split_dense_weights(W: np.ndarray, cascade_len: int) -> list[np.ndarray]:
    assert W.shape[0] % cascade_len == 0, "Input dimension must be divisible by cascade_len"
    split_size = W.shape[0] // cascade_len
    return [W[i * split_size : (i + 1) * split_size, :] for i in range(cascade_len)]

def _cast_for_save(arr: np.ndarray, dtype: str) -> np.ndarray:
    if dtype == "float32":
        return arr.astype(np.float32, copy=False)
    if dtype == "float16":
        return arr.astype(np.float16, copy=False)
    raise ValueError(f"Unsupported dtype {dtype}")

def save_txt(path: Path, arr: np.ndarray, dtype: str = "float32") -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    arr_to_save = _cast_for_save(arr, dtype)
    np.savetxt(path, np.asarray(arr_to_save).reshape(-1), fmt="%.6f")

def dump_dense_weights(model_path: Path, prefix: str, cascade_len: int, pad_to: int | None, out_dir: Path, dtype: str) -> None:
    """Extract first dense layer weights/bias from an ONNX model and save them.

    Parameters
    ----------
    model_path: Path to ONNX file containing a single Gemm/MatMul layer.
    prefix:     Filename prefix such as ``"dense1"`` or ``"dense2"``.
    cascade_len:If >1, split weight matrix rows for cascade.
    pad_to:     Optional number of input features to pad weights to (zero columns).
    out_dir:    Directory to write the files.
    dtype:      Floating point precision for saved files.
    """
    m = onnx.load(model_path)
    inits = {i.name: numpy_helper.to_array(i) for i in m.graph.initializer}

    W = B = None
    for n in m.graph.node:
        if n.op_type == "Gemm" and len(n.input) >= 2:
            W = inits.get(n.input[1])
            B = inits.get(n.input[2]) if len(n.input) > 2 else None
            break
        if n.op_type == "MatMul" and len(n.input) > 1 and n.input[1] in inits:
            W = inits[n.input[1]]
            # search for Add bias
            for nn in m.graph.node:
                if nn.op_type == "Add" and n.output[0] in nn.input:
                    other = [t for t in nn.input if t != n.output[0]]
                    if other and other[0] in inits:
                        B = inits[other[0]]
                        break
            break
    if W is None:
        raise RuntimeError(f"No dense weights found in {model_path}")

    W = W.T  # column-major for AIE
    if pad_to and W.shape[1] < pad_to:
        W = np.pad(W, ((0,0),(0,pad_to - W.shape[1])), constant_values=0)
    if cascade_len > 1:
        parts = split_dense_weights(W, cascade_len)
        for i, part in enumerate(parts):
            save_txt(out_dir / f"weights_{prefix}_part{i}.txt", part, dtype)
    else:
        save_txt(out_dir / f"weights_{prefix}.txt", W, dtype)
    if B is not None:
        save_txt(out_dir / f"bias_{prefix}.txt", B, dtype)

# ----------------------------- Main ---------------------------------------

def main() -> None:
    p = argparse.ArgumentParser(description="Dump real model data and weights")
    p.add_argument("--data-root", default="data/rom_det-3_part-200_cont-and-rounded_excerpt/", help="ROMDataset root")
    p.add_argument("--submodule-dir", default="submodule_onnx", help="Directory containing submodule ONNX files")
    p.add_argument("--out-dir", default=str(Path(__file__).resolve().parents[1] / "data"), help="Where to write txt dumps")
    p.add_argument("--dtype", default="float32", choices=["float32","float16"], help="Precision for saved txt files")
    p.add_argument("--tp-casc-len-layer2", type=int, default=2, help="Cascade length for second dense layer")
    args = p.parse_args()

    out_dir = Path(args.out_dir)
    dtype = args.dtype

    if torch is None:
        raise ImportError("Required packages (torch, rtal) are not installed")

    dataset = ROMDataset(args.data_root, split="train", num_particles=50)
    dataloader = DataLoader(dataset, batch_size=1, shuffle=False)
    event = next(iter(dataloader))
    readout = event['readout_curr_cont']  # (B, num_detectors, num_particles, 2)
    readout = torch.transpose(readout, 1, 2)            # (B, num_particles, num_detectors, 2)
    readout = readout.flatten(-2, -1)                   # (B, num_particles, in_features)

    embed_path = Path(args.submodule_dir) / "submodule_embed.onnx"
    output_path = Path(args.submodule_dir) / "submodule_output.onnx"
    solver_paths = [Path(args.submodule_dir) / f"submodule_solvers-{i}.onnx" for i in range(3)]

    embed_sess = ort.InferenceSession(str(embed_path))
    embed_in_type = embed_sess.get_inputs()[0].type
    np_dtype = np.float16 if 'float16' in embed_in_type else np.float32

    onnx_inputs = readout.numpy().astype(np_dtype)

    # Save padded input for AIE (dense8x128 expects 8 features)
    padded_inputs = onnx_inputs
    if onnx_inputs.shape[-1] < 8:
        pad_width = ((0, 0), (0, 0), (0, 8 - onnx_inputs.shape[-1]))
        padded_inputs = np.pad(onnx_inputs, pad_width, mode="constant")
    save_txt(out_dir / "input_data.txt", padded_inputs.reshape(-1), dtype)

    # Run embed on unpadded inputs (model expects 6 features)
    embed_in = onnx_inputs
    embed_out = embed_sess.run(
        [embed_sess.get_outputs()[0].name],
        {embed_sess.get_inputs()[0].name: embed_in},
    )[0]
    save_txt(out_dir / "dense1_output_ref.txt", embed_out, dtype)

    arr = embed_out
    # run solver submodules sequentially
    for pth in solver_paths:
        sess = ort.InferenceSession(str(pth))
        arr = assemble_np(arr, subset_size=6)
        arr = sess.run([sess.get_outputs()[0].name], {sess.get_inputs()[0].name: arr})[0]
    # arr is input to final dense layer
    save_txt(out_dir / "leakyrelu_output_ref.txt", arr, dtype)
    # split for cascade
    split_size = arr.shape[-1] // args.tp_casc_len_layer2
    for i in range(args.tp_casc_len_layer2):
        part = arr[..., i*split_size:(i+1)*split_size]
        save_txt(out_dir / f"leakyrelu_output_part{i}.txt", part, dtype)

    # Run output layer for final reference
    output_sess = ort.InferenceSession(str(output_path))
    final_out = output_sess.run([output_sess.get_outputs()[0].name], {output_sess.get_inputs()[0].name: arr})[0]
    save_txt(out_dir / "output_data_ref.txt", final_out, dtype)

    # Dump weights/biases
    dump_dense_weights(
        embed_path, prefix="dense1", cascade_len=1, pad_to=8, out_dir=out_dir, dtype=dtype
    )
    dump_dense_weights(
        output_path,
        prefix="dense2",
        cascade_len=args.tp_casc_len_layer2,
        pad_to=None,
        out_dir=out_dir,
        dtype=dtype,
    )

    print(f"Saved dumps to {out_dir}")
