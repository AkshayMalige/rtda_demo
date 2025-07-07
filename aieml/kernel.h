#ifndef __KERNEL_H__
#define __KERNEL_H__

void dense_1(input_window<float>* in, output_window<float>* out);
void dense_2(input_window<float>* in, output_window<float>* out);
void leaky_relu(input_window<float>* in, output_window<float>* out);

#endif
