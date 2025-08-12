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
    assert W2.shape[0] % cascade_len == 0, "Input dimension must be divisible by cascade_len."
    split_size = W2.shape[0] // cascade_len
    W2_parts = []
    for i in range(cascade_len):
        part = W2[i * split_size : (i + 1) * split_size, :]
        W2_parts.append(part)
    return W2_parts

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--input-size', type=int, default=8)
    parser.add_argument('--hidden-size', type=int, default=128)
    parser.add_argument('--output-size', type=int, default=128)
    parser.add_argument('--dtype', type=str, default='float32', choices=DTYPE_MAP.keys())
    parser.add_argument('--cascade-len', type=int, default=2)
    args = parser.parse_args()

    dtype = args.dtype
    input_size = args.input_size
    hidden_size = args.hidden_size
    output_size = args.output_size
    cascade_len = args.cascade_len

    np.random.seed(42)

    # --- Input Vector ---
    x = np.random.uniform(-1.0, 1.0, input_size).astype(DTYPE_MAP[dtype])
    np.savetxt('input_data.txt', x, fmt=FMT_MAP[dtype])

    # --- Dense1 ---
    W1 = np.random.uniform(-1.0, 1.0, (hidden_size, input_size)).astype(DTYPE_MAP[dtype])
    b1 = np.random.uniform(-1.0, 1.0, hidden_size).astype(DTYPE_MAP[dtype])

    dense1_output = np.dot(W1, x) + b1
    np.savetxt('dense1_output_ref.txt', dense1_output, fmt=FMT_MAP[dtype])

    W1_to_save = W1.T
    np.savetxt('weights_dense1.txt', W1_to_save.flatten(), fmt=FMT_MAP[dtype])
    np.savetxt('bias_dense1.txt', b1, fmt=FMT_MAP[dtype])

    # --- LeakyReLU ---
    leakyrelu_output = leaky_relu(dense1_output)
    np.savetxt('leakyrelu_output_ref.txt', leakyrelu_output, fmt=FMT_MAP[dtype])

    # --- Dense2 ---
    W2 = np.random.uniform(-1.0, 1.0, (output_size, hidden_size)).astype(DTYPE_MAP[dtype])
    b2 = np.random.uniform(-1.0, 1.0, output_size).astype(DTYPE_MAP[dtype])

    W2_to_save = W2.T

    W2_parts = split_dense2_weights(W2_to_save, cascade_len)
    for i, W_part in enumerate(W2_parts):
        filename = f'weights_dense2_part{i}.txt'
        np.savetxt(filename, W_part.flatten(), fmt=FMT_MAP[dtype])

    np.savetxt('bias_dense2.txt', b2, fmt=FMT_MAP[dtype])

    # Split LeakyReLU Output as Dense2 Input for Cascade
    assert hidden_size % cascade_len == 0, "Hidden size must be divisible by cascade_len."
    split_size = hidden_size // cascade_len
    for i in range(cascade_len):
        part = leakyrelu_output[i * split_size : (i + 1) * split_size]
        np.savetxt(f'leakyrelu_output_part{i}.txt', part, fmt=FMT_MAP[dtype])

    # Compute Dense2 Output and final activation (Reference)
    dense2_linear = np.dot(W2, leakyrelu_output) + b2
    final_output = leaky_relu(dense2_linear)
    np.savetxt('output_data_ref.txt', final_output, fmt=FMT_MAP[dtype])

    print("\nSaved all reference and AIE input files successfully.\n")

if __name__ == "__main__":
    main()