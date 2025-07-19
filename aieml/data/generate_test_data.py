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

    # Generate dense1 weights and input
    x = np.random.uniform(-1.0, 1.0, input_size).astype(DTYPE_MAP[dtype])
    W1 = np.random.uniform(-1.0, 1.0, (hidden_size, input_size)).astype(DTYPE_MAP[dtype])

    # Dense1 computation
    dense1_output = np.dot(W1, x)

    # LeakyReLU activation
    leakyrelu_output = leaky_relu(dense1_output)

    # Save dense1 input, weights, and leakyrelu output
    np.savetxt('input_data.txt', x, fmt=FMT_MAP[dtype])
    np.savetxt('dense1_output.txt', dense1_output.flatten(), fmt=FMT_MAP[dtype])
    np.savetxt('weights_dense1.txt', W1.flatten(), fmt=FMT_MAP[dtype])
    np.savetxt('leakyrelu_output.txt', leakyrelu_output, fmt=FMT_MAP[dtype])

    print(f"Saved input_data.txt ({x.shape})")
    print(f"Saved weights_dense1.txt ({W1.shape})")
    print(f"Saved leakyrelu_output.txt ({leakyrelu_output.shape})")

    # Generate dense2 weights
    W2 = np.random.uniform(-1.0, 1.0, (output_size, hidden_size)).astype(DTYPE_MAP[dtype])

    # Transpose for column-major (assuming TP_DIM_A_LEADING=1)
    W2 = W2.T  # Shape: (hidden_size, output_size)

    # Split dense2 weights for cascade
    W2_parts = split_dense2_weights(W2, cascade_len)

    for i, W_part in enumerate(W2_parts):
        filename = f"weights_dense2_part{i}.txt"
        np.savetxt(filename, W_part.flatten(), fmt=FMT_MAP[dtype])
        print(f"Saved {filename} with shape {W_part.shape}")

    # Split leakyrelu_output as input to cascade kernels
    assert hidden_size % cascade_len == 0, "Hidden size must be divisible by cascade_len."
    split_size = hidden_size // cascade_len

    for i in range(cascade_len):
        start_idx = i * split_size
        end_idx = (i + 1) * split_size
        x_part = leakyrelu_output[start_idx:end_idx]
        filename = f"leakyrelu_output_part{i}.txt"
        np.savetxt(filename, x_part, fmt=FMT_MAP[dtype])
        print(f"Saved {filename} with shape {x_part.shape}")

    dense2_output = np.dot(W2.T, leakyrelu_output)
    np.savetxt('output_data_reference.txt', dense2_output, fmt=FMT_MAP[dtype])
    print(f"Saved output_data_reference.txt ({dense2_output.shape}) — use this to compare with AIE-ML sim output")

if __name__ == "__main__":
    main()