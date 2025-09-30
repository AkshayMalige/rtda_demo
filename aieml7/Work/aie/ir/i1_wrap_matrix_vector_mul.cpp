#include "/home/synthara/VersalPrjs/LDRD/rtda_demo/dsp_lib/L1/src/aie/matrix_vector_mul.cpp"
#include "matrix_vector_mul.hpp"
#include "/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml7/../dsp_lib/L1/include/aie/matrix_vector_mul.hpp"

template void xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul<float, float, 128, 768, 0, 0, 0, 1, 12, 1, 0, 0, 1, 10, true, true>::matVecMulMiddleRtp(const float (&)[8192],adf::io_buffer<float, adf::direction::in, adf::io_buffer_config<>> &__restrict,input_cascade<accfloat> *,output_cascade<accfloat> *);

xf::dsp::aie::blas::matrix_vector_mul::matrix_vector_mul<float, float, 128, 768, 0, 0, 0, 1, 12, 1, 0, 0, 1, 10, true, true> i1;
void* i1_user() {return &i1;}
