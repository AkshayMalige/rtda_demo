import numpy as np

# Settings
INPUT_SIZE = 6
HIDDEN_SIZE = 128
OUTPUT_SIZE = 128

# Generate dummy input data (0.0, 1.0, ..., 5.0)
input_data = np.arange(INPUT_SIZE, dtype=np.float32)

# Generate dummy weights for dense_2: w2[o,i] = 0.005*(o - i)
w2 = np.fromfunction(lambda o, i: 0.005 * (o - i), (OUTPUT_SIZE, HIDDEN_SIZE), dtype=np.float32)

# Generate weights and bias for dense_1 (for reference computation)
b1 = np.full(HIDDEN_SIZE, 0.1, dtype=np.float32)
w1 = np.fromfunction(lambda o, i: 0.01 * (o + i), (HIDDEN_SIZE, INPUT_SIZE), dtype=np.float32)

# Compute reference output:
# Layer 1
y1 = w1.dot(input_data) + b1
# Leaky ReLU
y1 = np.where(y1 > 0, y1, y1 * 0.1)
# Layer 2 (no bias)
y2 = w2.dot(y1)

# Write header files
def write_header(path, name, array, shape_comment):
    with open(path, 'w') as f:
        f.write(f'#ifndef {name.upper()}_H\n')
        f.write(f'#define {name.upper()}_H\n\n')
        f.write(f'// {shape_comment}\n')
        f.write(f'static float {name}[] = {{\n')
        flat = array.flatten()
        for val in flat:
            f.write(f'  {val:.8f}f,\n')
        f.write('};\n\n#endif\n')

write_header('input_data.h', 'input_data', input_data, f'size = {INPUT_SIZE}')
write_header('weight_data.h', 'weight_data', w2, f'size = {OUTPUT_SIZE} x {HIDDEN_SIZE}')
write_header('reference_data.h', 'reference_data', y2, f'size = {OUTPUT_SIZE}')

print("Generated header files:")
print("input_data.h")
print("weight_data.h")
print("reference_data.h")
