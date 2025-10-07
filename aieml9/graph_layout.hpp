#pragma once
#include <array>
#include <vector>

inline void NeuralNetworkGraph::apply_layout() {
    struct KernelRuntimeSpec {
        kernel* target;
        double ratio;
    };

    const std::array<KernelRuntimeSpec, 15> runtime_specs = {{
        {&embed_bias0, 1.0},
        {&embed_bias1, 1.0},
        {&embed_relu0, 1.0},
        {&embed_relu1, 1.0},
        {&embed_split0, 1.0},
        {&solver_bias0, 0.45},
        {&solver_bias1, 0.45},
        {&solver_bias2, 0.45},
        {&solver_bias3, 0.45},
        {&solver_relu0, 0.5},
        {&solver_relu1, 0.5},
        {&solver_relu2, 0.5},
        {&solver_relu3, 0.5},
        {&solver_split0, 0.65},
        {&solver_split1, 0.65}
    }};

    for (const auto& spec : runtime_specs) {
        runtime<ratio>(*spec.target) = spec.ratio;
    }

    runtime<ratio>(solver_split2) = 0.65;
    runtime<ratio>(solver2_bias0) = 0.45;
    runtime<ratio>(solver2_bias1) = 0.45;
    runtime<ratio>(solver2_bias2) = 0.45;
    runtime<ratio>(solver2_bias3) = 0.45;
    runtime<ratio>(solver2_relu0) = 0.5;
    runtime<ratio>(solver2_relu1) = 0.5;
    runtime<ratio>(solver2_relu2) = 0.5;
    runtime<ratio>(solver2_relu3) = 0.5;
    runtime<ratio>(solver2_split0) = 0.65;
    runtime<ratio>(solver2_split1) = 0.65;
    runtime<ratio>(solver2_split2) = 0.65;
    runtime<ratio>(solver_rollconcat) = 1.0;
    runtime<ratio>(solver2_rollconcat) = 1.0;

    adf::location<adf::PLIO>(pipeline_in) = adf::shim(AIEML9_INPUT_SHIM);
    adf::location<adf::PLIO>(pipeline_out) = adf::shim(AIEML9_OUTPUT_SHIM);

    // Helper: spread cascade kernels across consecutive tiles along the X axis.
    const auto place_linear = [](kernel* kernels,
                                 std::size_t count,
                                 int base_col,
                                 int row,
                                 int stride = 1) {
        for (std::size_t idx = 0; idx < count; ++idx) {
            adf::location<adf::kernel>(kernels[idx]) = adf::tile(base_col + static_cast<int>(idx * stride), row);
        }
    };

    place_linear(embed_dense0.getKernels(), TP_CASC_LEN_STAGE1_LAYER0 * TP_SSR_STAGE1, 7, 2);
    place_linear(embed_dense1.getKernels(), TP_CASC_LEN_STAGE1_LAYER1 * TP_SSR_STAGE1, 8, 2);

    struct KernelPlacement {
        kernel* target;
        int col;
        int row;
    };

    // Stage 1 post-processing kernels share the embedding columns.
    const std::array<KernelPlacement, 10> stage1_kernels = {{
        {&embed_bias0, 7, 3},
        {&embed_relu0, 7, 4},
        {&embed_split0, 7, 5},
        {&embed_bias1, 9, 3},
        {&embed_relu1, 9, 4},
        {&solver_rollconcat, 12, 2},
        {&solver_bias0, 12, 3},
        {&solver_bias1, 13, 3},
        {&solver_bias2, 14, 3},
        {&solver_bias3, 15, 3}
    }};

    for (const auto& placement : stage1_kernels) {
        adf::location<adf::kernel>(*placement.target) = adf::tile(placement.col, placement.row);
    }

    const std::array<KernelPlacement, 8> stage1_activation_tiles = {{
        {&solver_relu0, 12, 4},
        {&solver_relu1, 13, 4},
        {&solver_relu2, 14, 4},
        {&solver_relu3, 15, 4},
        {&solver_split0, 22, 2},
        {&solver_split1, 22, 3},
        {&solver_split2, 22, 4},
        {&solver2_rollconcat, 32, 2}
    }};

    for (const auto& placement : stage1_activation_tiles) {
        adf::location<adf::kernel>(*placement.target) = adf::tile(placement.col, placement.row);
    }

    place_linear(solver_dense0.getKernels(), TP_CASC_LEN_STAGE2_LAYER0 * TP_SSR_STAGE2, 10, 0);
    place_linear(solver_dense1.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 23, 2);
    place_linear(solver_dense2.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 23, 3);
    place_linear(solver_dense3.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 23, 4);

    // Duplicate solver branch mirrors the first but shifted right.
    const std::array<KernelPlacement, 9> solver2_kernels = {{
        {&solver2_bias0, 32, 3},
        {&solver2_bias1, 33, 3},
        {&solver2_bias2, 34, 3},
        {&solver2_bias3, 35, 3},
        {&solver2_relu0, 32, 4},
        {&solver2_relu1, 33, 4},
        {&solver2_relu2, 34, 4},
        {&solver2_relu3, 35, 4},
        {&solver2_split0, 31, 2}
    }};

    for (const auto& placement : solver2_kernels) {
        adf::location<adf::kernel>(*placement.target) = adf::tile(placement.col, placement.row);
    }

    const std::array<KernelPlacement, 2> solver2_split_tiles = {{
        {&solver2_split1, 31, 3},
        {&solver2_split2, 31, 4}
    }};

    for (const auto& placement : solver2_split_tiles) {
        adf::location<adf::kernel>(*placement.target) = adf::tile(placement.col, placement.row);
    }

    place_linear(solver2_dense0.getKernels(), TP_CASC_LEN_STAGE2_LAYER0 * TP_SSR_STAGE2, 24, 0);
    place_linear(solver2_dense1.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 36, 2);
    place_linear(solver2_dense2.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 36, 3);
    place_linear(solver2_dense3.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 36, 4);

    place_linear(output_dense0.getKernels(), TP_CASC_LEN_STAGE3 * TP_SSR_STAGE3, 26, 2);
}
