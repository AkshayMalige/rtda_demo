#pragma once

#include <adf.h>
#include "kernels.h"
#include "system_settings.h"

using namespace adf;

class dense_graph : public graph {
public:
    kernel      k_dense1, k_relu, k_dense2;
    input_plio  in, wgt;
    output_plio out;

    dense_graph() {
        in  = input_plio::create("plio_input",   plio_32_bits, "data/input_data.h");
        wgt = input_plio::create("plio_weights", plio_32_bits, "data/weight_data.h");
        out = output_plio::create("plio_output",  plio_32_bits, "data/reference_data.h");

        k_dense1 = kernel::create(dense_1);
        k_relu   = kernel::create(leaky_relu);
        k_dense2 = kernel::create(dense_2);

        connect<window<INPUT_SIZE * sizeof(float)>>(in.out[0], k_dense1.in[0]);
        connect<window<HIDDEN_SIZE * sizeof(float)>>(k_dense1.out[0], k_relu.in[0]);
        connect<window<HIDDEN_SIZE * sizeof(float)>>(k_relu.out[0], k_dense2.in[0]);
        connect<window<HIDDEN_SIZE * sizeof(float)>>(wgt.out[0], k_dense2.in[1]);
        connect<window<OUTPUT_SIZE * sizeof(float)>>(k_dense2.out[0], out.in[0]);

        source(k_dense1) = "kernels/dense_1.cpp";
        source(k_relu)   = "kernels/leaky_relu.cpp";
        source(k_dense2) = "kernels/dense_2.cpp";

        runtime<ratio>(k_dense1) = 0.8;
        runtime<ratio>(k_relu)   = 0.2;
        runtime<ratio>(k_dense2) = 0.8;
    }
};