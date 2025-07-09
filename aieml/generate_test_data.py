
#!/usr/bin/env python3
"""generate_dense_leaky_data.py

Creates dummy data and reference output for a small network:

    (Dense1 + add) -> LeakyReLU(alpha=-0.1) -> (Dense2 + add)

Files written
-------------
input_data.txt            : one line per input value (length = input_dim)
weights_dense1a.txt       : Dense‑1 flattened weights, ODD indices
weights_dense1b.txt       : Dense‑1 flattened weights, EVEN indices
weights_dense2a.txt       : Dense‑2 flattened weights, ODD indices
weights_dense2b.txt       : Dense‑2 flattened weights, EVEN indices
output_data.txt           : reference network output (length = output_dim)

All numeric data are plain text, one value per line, ready for PLIO streaming.

Example
-------
python generate_dense_leaky_data.py --input-dim 6 --hidden-dim 128 \
       --output-dim 128 --dtype float32 --seed 123
"""

import argparse
from pathlib import Path
import numpy as np

DTYPE_MAP = {
    "int8":   np.int8,
    "int16":  np.int16,
    "float16": np.float16,
    "float32": np.float32,
}
FMT_MAP = {
    "int8":   "%d",
    "int16":  "%d",
    "float16": "%.6f",
    "float32": "%.6f",
}

def split_and_save(flat: np.ndarray, odd_path: str, even_path: str, dtype: str):
    even = flat[::2]
    odd  = flat[1::2]
    np.savetxt(odd_path,  odd.astype(DTYPE_MAP[dtype]), fmt=FMT_MAP[dtype])
    np.savetxt(even_path, even.astype(DTYPE_MAP[dtype]), fmt=FMT_MAP[dtype])

def interleave_to_matrix(odd_vals, even_vals, shape, dtype):
    total = len(odd_vals) + len(even_vals)
    flat = np.empty(total, dtype=dtype)
    flat[1::2] = odd_vals
    flat[0::2] = even_vals
    return flat.reshape(shape)

def leaky_relu(x, alpha=-0.1):
    return np.where(x > 0, x, alpha * x)

def main():
    p = argparse.ArgumentParser()
    p.add_argument('--input-dim', type=int, default=6)
    p.add_argument('--hidden-dim', type=int, default=128)
    p.add_argument('--output-dim', type=int, default=128)
    p.add_argument('--dtype', choices=list(DTYPE_MAP.keys()), default='float32')
    p.add_argument('--seed', type=int, default=42)
    args = p.parse_args()

    rng = np.random.default_rng(args.seed)
    dtype_np = DTYPE_MAP[args.dtype]

    # Input vector
    input_vec = rng.uniform(-1, 1, size=(args.input_dim,)).astype(np.float32)
    np.savetxt('input_data.txt', input_vec, fmt='%.6f')

    # Random weight matrices
    def rand_weights(shape):
        if np.issubdtype(dtype_np, np.integer):
            info = np.iinfo(dtype_np)
            return rng.integers(info.min//2, info.max//2, size=shape, dtype=dtype_np)
        else:
            return rng.uniform(-1, 1, size=shape).astype(dtype_np)

    W1 = rand_weights((args.input_dim, args.hidden_dim))
    W2 = rand_weights((args.hidden_dim, args.output_dim))

    # Save weights split into odd/even
    split_and_save(W1.flatten(), 'weights_dense1a.txt', 'weights_dense1b.txt', args.dtype)
    split_and_save(W2.flatten(), 'weights_dense2a.txt', 'weights_dense2b.txt', args.dtype)

    # === Reload from files to validate round‑trip and generate reference output ===
    odd1  = np.loadtxt('weights_dense1a.txt', dtype=dtype_np)
    even1 = np.loadtxt('weights_dense1b.txt', dtype=dtype_np)
    odd2  = np.loadtxt('weights_dense2a.txt', dtype=dtype_np)
    even2 = np.loadtxt('weights_dense2b.txt', dtype=dtype_np)

    W1_recon = interleave_to_matrix(odd1, even1, W1.shape, dtype_np).astype(np.float32)
    W2_recon = interleave_to_matrix(odd2, even2, W2.shape, dtype_np).astype(np.float32)

    # Forward pass
    dense1_out = input_vec @ W1_recon
    act = leaky_relu(dense1_out, alpha=-0.1)
    output = act @ W2_recon

    np.savetxt('output_data.txt', output, fmt='%.6f')

    print('\nGenerated:')
    for f in ['input_data.txt',
              'weights_dense1a.txt','weights_dense1b.txt',
              'weights_dense2a.txt','weights_dense2b.txt',
              'output_data.txt']:
        print('  ', f)

if __name__ == '__main__':
    main()
