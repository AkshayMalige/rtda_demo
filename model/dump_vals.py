"""Utility script to dump ONNX submodule data.

This script loads the ONNX submodules produced by training and writes
inputs, weights, biases and outputs for dense layers to text files. It
also captures the inputs and outputs of any LeakyReLU activation layers
present in a submodule.
"""

import argparse
import os
from pathlib import Path
from typing import List, Tuple

import numpy as np
import onnx
from onnx import numpy_helper
import onnxruntime as ort

# Global defaults that can be overridden via CLI
OUT_DIR = "onnx_txt"
SAVE_DTYPE = "float32"


def assemble_np(array: np.ndarray, subset_size: int) -> np.ndarray:
    """Roll along axis=1 and concat along the last dim."""
    return np.concatenate([
        np.roll(array, shift=i, axis=1) for i in range(subset_size)
    ], axis=-1)


def _cast_for_save(arr: np.ndarray) -> np.ndarray:
    if SAVE_DTYPE == "float32":
        return arr.astype(np.float32, copy=False)
    elif SAVE_DTYPE == "float16":
        return arr.astype(np.float16, copy=False)
    raise ValueError(
        f"SAVE_DTYPE must be 'float16' or 'float32', got {SAVE_DTYPE!r}")


def save_txt(path: Path, arr: np.ndarray) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    arr_to_save = _cast_for_save(arr)
    np.savetxt(path, np.asarray(arr_to_save).reshape(-1), fmt="%.6f")


def _find_leaky_relu_nodes(model: onnx.ModelProto) -> List[Tuple[int, onnx.NodeProto]]:
    """Return list of (index, node) for LeakyRelu nodes."""
    nodes = []
    for idx, node in enumerate(model.graph.node):
        if node.op_type == "LeakyRelu":
            nodes.append((idx, node))
    return nodes


def run_and_dump(session: ort.InferenceSession, x: np.ndarray, tag: str) -> np.ndarray:
    """Run a session, dumping inputs/outputs and LeakyReLU activations."""
    subdir = Path(OUT_DIR) / tag
    save_txt(subdir / "input.txt", x)

    in_name = session.get_inputs()[0].name
    out_name = session.get_outputs()[0].name

    # Discover LeakyReLU nodes in the model to fetch their IO tensors
    model_path = getattr(session, "_model_path", None)
    leaky_nodes: List[Tuple[int, onnx.NodeProto]] = []
    extra_names: List[str] = []
    if model_path and os.path.exists(model_path):
        model = onnx.load(model_path)
        leaky_nodes = _find_leaky_relu_nodes(model)
        for node in leaky_nodes:
            idx, n = node
            if n.input:
                extra_names.append(n.input[0])
            if n.output:
                extra_names.append(n.output[0])
    # Remove duplicates but preserve order
    extra_names = list(dict.fromkeys(extra_names))

    fetches = [out_name] + extra_names
    outputs = session.run(fetches, {in_name: x})
    y = outputs[0]
    save_txt(subdir / "output.txt", y)

    # Map extra outputs back to names and dump LeakyReLU IO
    name_to_arr = {name: arr for name, arr in zip(extra_names, outputs[1:])}
    for idx, n in leaky_nodes:
        if n.input and n.input[0] in name_to_arr:
            save_txt(subdir / f"{idx:02d}_leakyrelu_input.txt", name_to_arr[n.input[0]])
        if n.output and n.output[0] in name_to_arr:
            save_txt(subdir / f"{idx:02d}_leakyrelu_output.txt", name_to_arr[n.output[0]])
    return y


def dump_dense_weights(model_path: str, tag: str) -> None:
    """Save weights/biases for Linear/Dense layers in an ONNX model."""
    model = onnx.load(model_path)
    inits = {i.name: numpy_helper.to_array(i) for i in model.graph.initializer}

    # Build consumer map to detect MatMul -> Add bias patterns
    consumers = {}
    for n in model.graph.node:
        for i in n.input:
            consumers.setdefault(i, []).append(n)

    subdir = Path(OUT_DIR) / tag
    subdir.mkdir(parents=True, exist_ok=True)

    idx = 0
    for n in model.graph.node:
        if n.op_type == "Gemm":
            W = inits.get(n.input[1]) if len(n.input) > 1 else None
            B = inits.get(n.input[2]) if len(n.input) > 2 else None
            if W is not None:
                save_txt(subdir / f"{idx:02d}_linear_W.txt", W)
            if B is not None:
                save_txt(subdir / f"{idx:02d}_linear_B.txt", B)
            idx += 1
        elif n.op_type == "MatMul" and len(n.input) > 1 and n.input[1] in inits:
            W = inits[n.input[1]]
            save_txt(subdir / f"{idx:02d}_linear_W.txt", W)
            B = None
            for c in consumers.get(n.output[0], []):
                if c.op_type == "Add":
                    other = [t for t in c.input if t != n.output[0]]
                    if other and other[0] in inits:
                        B = inits[other[0]]
                        break
            if B is not None:
                save_txt(subdir / f"{idx:02d}_linear_B.txt", B)
            idx += 1


def main() -> None:
    parser = argparse.ArgumentParser(description="Dump submodule values")
    parser.add_argument("--data-root", required=True,
                        help="Path to dataset root")
    parser.add_argument("--submodule-dir", required=True,
                        help="Directory containing submodule_*.onnx files")
    parser.add_argument("--subset-size", type=int, default=6,
                        help="Subset size used for solver inputs")
    parser.add_argument("--num-solvers", type=int, default=3,
                        help="Number of solver submodules")
    parser.add_argument("--batch-size", type=int, default=1)
    parser.add_argument("--num-particles", type=int, default=50)
    parser.add_argument("--out-dir", default="onnx_txt",
                        help="Directory for output text files")
    parser.add_argument("--save-dtype", choices=["float32", "float16"],
                        default="float32")
    args = parser.parse_args()

    global OUT_DIR, SAVE_DTYPE
    OUT_DIR = args.out_dir
    SAVE_DTYPE = args.save_dtype

    # Lazy imports for dataset related modules
    import torch
    from torch.utils.data import DataLoader
    from rtal.datasets.dataset import ROMDataset

    dataset = ROMDataset(args.data_root, split="train",
                         num_particles=args.num_particles)
    dataloader = DataLoader(dataset, batch_size=args.batch_size, shuffle=False)
    event = next(iter(dataloader))
    readout = event["readout_curr_cont"]  # (B, num_detectors, num_particles, 2)
    readout = torch.transpose(readout, 1, 2)
    readout = readout.flatten(-2, -1)

    embed_path = os.path.join(args.submodule_dir, "submodule_embed.onnx")
    embed_sess = ort.InferenceSession(embed_path)
    embed_in_type = embed_sess.get_inputs()[0].type
    np_dtype = np.float16 if "float16" in embed_in_type else np.float32
    onnx_inputs = readout.numpy().astype(np_dtype)

    solver_paths = [
        os.path.join(args.submodule_dir, f"submodule_solvers-{i}.onnx")
        for i in range(args.num_solvers)
    ]
    solver_sess = [ort.InferenceSession(p) for p in solver_paths]
    output_sess = ort.InferenceSession(
        os.path.join(args.submodule_dir, "submodule_output.onnx")
    )

    # Run the model chain dumping values for each submodule
    arr = run_and_dump(embed_sess, onnx_inputs, tag="embed")
    for i, sess in enumerate(solver_sess):
        arr = assemble_np(arr, args.subset_size)
        arr = run_and_dump(sess, arr, tag=f"solvers-{i}")
    run_and_dump(output_sess, arr, tag="output")

    # Dump weights/biases for dense layers
    dump_dense_weights(embed_path, "embed")
    for i, p in enumerate(solver_paths):
        dump_dense_weights(p, f"solvers-{i}")
    dump_dense_weights(os.path.join(args.submodule_dir, "submodule_output.onnx"),
                       "output")

    print("Done. Wrote TXT dumps under:", OUT_DIR)


if __name__ == "__main__":
    main()
