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

def leaky_relu(x, alpha=-0.1):
    return np.where(x > 0, x, alpha * x)

def split_dense2_weights(W2, cascade_len=2):
    # Split along input dimension (inner)
    assert W2.shape[0] % cascade_len == 0, "Input dimension must be divisible by cascade_len"
    split_size = W2.shape[0] // cascade_len  # 128 // 2 = 64

    W2_parts = []
    for i in range(cascade_len):
        start = i * split_size
        end = (i + 1) * split_size
        part = W2[start:end, :].reshape(-1)  # Flatten row-major
        W2_parts.append(part)

    return W2_parts

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

    # Save dense1 weights as odd/even
    W1_flat = W1.flatten()
    np.savetxt('weights_dense1a.txt', W1_flat[1::2], fmt=FMT_MAP[args.dtype])
    np.savetxt('weights_dense1b.txt', W1_flat[0::2], fmt=FMT_MAP[args.dtype])
    np.savetxt('weights_dense1.txt', W1_flat.astype(dtype_np), fmt=FMT_MAP[args.dtype])

    # Save dense2 weights split for cascade_len=2
    dense2_parts = split_dense2_weights(W2, cascade_len=2)
    np.savetxt('weights_dense2_part0.txt', dense2_parts[0], fmt=FMT_MAP[args.dtype])
    np.savetxt('weights_dense2_part1.txt', dense2_parts[1], fmt=FMT_MAP[args.dtype])
    np.savetxt('weights_dense2.txt', W2.flatten().astype(dtype_np), fmt=FMT_MAP[args.dtype])

    # Forward pass
    dense1_out = input_vec @ W1.astype(np.float32)
    np.savetxt('dense1_output.txt', dense1_out, fmt='%.6f')

    act = leaky_relu(dense1_out, alpha=-0.1)
    np.savetxt('leakyrelu_output.txt', act, fmt='%.6f')

    # Save leakyrelu output identical to both cascade stages
    np.savetxt('leakyrelu_output_part0.txt', act, fmt='%.6f')
    np.savetxt('leakyrelu_output_part1.txt', act, fmt='%.6f')

    output = act @ W2.astype(np.float32)
    np.savetxt('output_data.txt', output, fmt='%.6f')

    print('\nGenerated:')
    for f in [
        'input_data.txt',
        'weights_dense1a.txt','weights_dense1b.txt','weights_dense1.txt',
        'weights_dense2_part0.txt','weights_dense2_part1.txt','weights_dense2.txt',
        'dense1_output.txt','leakyrelu_output.txt',
        'leakyrelu_output_part0.txt','leakyrelu_output_part1.txt',
        'output_data.txt']:
        print('  ', f)

if __name__ == '__main__':
    main()