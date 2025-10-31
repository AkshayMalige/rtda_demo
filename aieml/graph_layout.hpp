#pragma once
#include <array>
#include <vector>

inline void NeuralNetworkGraph::apply_layout() {
    struct KernelRuntimeSpec {
        kernel* target;
        double ratio;
    };

    // const std::array<KernelRuntimeSpec, 10> runtime_specs = {{
    //     {&embed_bias_relu0, 0.95},
    //     {&embed_bias_relu1, 0.95},
    //     {&embed_split0, 1.0},
    //     {&solver0_bias_relu0, 0.95},
    //     {&solver0_bias_relu1, 0.95},
    //     {&solver0_split0, 0.65},
    //     {&solver0_bias_relu2, 0.95},
    //     {&solver0_split1, 0.65},
    //     {&solver0_bias_relu3, 0.95},
    //     {&solver0_split2, 0.65}
    // }};

    // for (const auto& spec : runtime_specs) {
    //     runtime<ratio>(*spec.target) = spec.ratio;
    // }

    runtime<ratio>(embed_bias_relu0) =  0.95;
    runtime<ratio>(embed_split0) =  1.0;
    runtime<ratio>(embed_bias_relu1) =  0.95;

    // runtime<ratio>(solver0_rollconcat) = 1.0;
    // runtime<ratio>(solver0_bias_relu0) =  0.95;
    // runtime<ratio>(solver0_split0) =  0.65;
    // runtime<ratio>(solver0_bias_relu1) =  0.95;
    // runtime<ratio>(solver0_split1) =  0.65;
    // runtime<ratio>(solver0_bias_relu2) =  0.95;
    // runtime<ratio>(solver0_split2) =  0.65;
    // runtime<ratio>(solver0_bias_relu3) = 0.95;

    // runtime<ratio>(solver1_rollconcat) = 1.0;
    // runtime<ratio>(solver1_bias_relu0) =  0.95;
    // runtime<ratio>(solver1_split0) =  0.65;
    // runtime<ratio>(solver1_bias_relu1) =  0.95;
    // runtime<ratio>(solver1_split1) =  0.65;
    // runtime<ratio>(solver1_bias_relu2) =  0.95;
    // runtime<ratio>(solver1_split2) =  0.65;
    // runtime<ratio>(solver1_bias_relu3) = 0.95;

    // runtime<ratio>(solver2_rollconcat) = 1.0;
    // runtime<ratio>(solver2_bias_relu0) =  0.95;
    // runtime<ratio>(solver2_split0) =  0.65;
    // runtime<ratio>(solver2_bias_relu1) =  0.95;
    // runtime<ratio>(solver2_split1) =  0.65;
    // runtime<ratio>(solver2_bias_relu2) =  0.95;
    // runtime<ratio>(solver2_split2) =  0.65;
    // runtime<ratio>(solver2_bias_relu3) = 0.95;


    // adf::location<adf::GMIO>(embed_input_gmio) = adf::shim(AIEML10_INPUT_SHIM);
    // adf::location<adf::GMIO>(embed_output_gmio) = adf::shim(AIEML10_OUTPUT_SHIM);

    // const auto place_linear = [](kernel* kernels,
    //                              std::size_t count,
    //                              int base_col,
    //                              int row,
    //                              int stride = 1) {
    //     for (std::size_t idx = 0; idx < count; ++idx) {
    //         adf::location<adf::kernel>(kernels[idx]) = adf::tile(base_col + static_cast<int>(idx * stride), row);
    //     }
    // };

    // Keep early stage anchors modest to guide placement without over-constraining
    // place_linear(embed_dense0.getKernels(), TP_CASC_LEN_STAGE1_LAYER0 * TP_SSR_STAGE1, 7, 2);
    // place_linear(embed_dense1.getKernels(), TP_CASC_LEN_STAGE1_LAYER1 * TP_SSR_STAGE1, 8, 2);

    // Distribute weight PLIOs near intended compute to avoid shim over-subscription
    // Embed stage weights
    // adf::location<adf::PLIO>(embed_layer0_weights) = adf::shim(7);
    // for (std::size_t i = 0; i < embed_dense1_weight_plios.size(); ++i) {
    //     adf::location<adf::PLIO>(embed_dense1_weight_plios[i]) = adf::shim(8 + static_cast<int>(i));
    // }

    // struct KernelPlacement {
    //     kernel* target;
    //     int col;
    //     int row;
    // };

    // const std::array<KernelPlacement, 10> stage1_kernels = {{
    //     {&embed_bias0, 7, 3},
    //     {&embed_relu0, 7, 4},
    //     {&embed_split0, 7, 5},
    //     {&embed_bias1, 9, 3},
    //     {&embed_relu1, 9, 4},
    //     {&solver0_rollconcat, 12, 2},
    //     {&solver0_bias_relu0, 12, 3},
    //     {&solver0_bias_relu1, 13, 3},
    //     {&solver0_bias_relu2, 14, 3},
    //     {&solver0_bias_relu3, 15, 3}
    // }};

    // for (const auto& placement : stage1_kernels) {
    //     adf::location<adf::kernel>(*placement.target) = adf::tile(placement.col, placement.row);
    // }

    // const std::array<KernelPlacement, 8> stage1_activation_tiles = {{
    //     {&solver0_bias_relu0, 12, 4},
    //     {&solver0_bias_relu1, 13, 4},
    //     {&solver0_bias_relu2, 14, 4},
    //     {&solver0_bias_relu3, 15, 4},
    //     {&solver0_split0, 22, 2},
    //     {&solver0_split1, 22, 3},
    //     {&solver0_split2, 22, 4},
    //     {&solver1_rollconcat, 32, 2}
    // }};

    // for (const auto& placement : stage1_activation_tiles) {
    //     adf::location<adf::kernel>(*placement.target) = adf::tile(placement.col, placement.row);
    // }

    // // Let the placer choose solver placements to reduce congestion.
    // // Hint with PLIO shims for weights to anchor proximity and spread traffic.
    // for (std::size_t i = 0; i < solver0_dense0_weight_plios.size(); ++i) {
    //     adf::location<adf::PLIO>(solver0_dense0_weight_plios[i]) = adf::shim(10 + static_cast<int>(i));
    // }
    // for (std::size_t i = 0; i < solver0_dense1_weight_plios.size(); ++i) {
    //     adf::location<adf::PLIO>(solver0_dense1_weight_plios[i]) = adf::shim(23 + static_cast<int>(i));
    // }
    // for (std::size_t i = 0; i < solver0_dense2_weight_plios.size(); ++i) {
    //     // Nudge one column away to avoid overload on a single shim
    //     adf::location<adf::PLIO>(solver0_dense2_weight_plios[i]) = adf::shim(25 + static_cast<int>(i));
    // }
    // for (std::size_t i = 0; i < solver0_dense3_weight_plios.size(); ++i) {
    //     adf::location<adf::PLIO>(solver0_dense3_weight_plios[i]) = adf::shim(27 + static_cast<int>(i));
    // }

    // for (std::size_t i = 0; i < solver1_dense0_weight_plios.size(); ++i) {
    //     adf::location<adf::PLIO>(solver1_dense0_weight_plios[i]) = adf::shim(30 + static_cast<int>(i));
    // }
    // for (std::size_t i = 0; i < solver1_dense1_weight_plios.size(); ++i) {
    //     adf::location<adf::PLIO>(solver1_dense1_weight_plios[i]) = adf::shim(32 + static_cast<int>(i));
    // }
    // for (std::size_t i = 0; i < solver1_dense2_weight_plios.size(); ++i) {
    //     adf::location<adf::PLIO>(solver1_dense2_weight_plios[i]) = adf::shim(34 + static_cast<int>(i));
    // }
    // for (std::size_t i = 0; i < solver1_dense3_weight_plios.size(); ++i) {
    //     adf::location<adf::PLIO>(solver1_dense3_weight_plios[i]) = adf::shim(36 + static_cast<int>(i));
    // }

    // for (std::size_t i = 0; i < solver2_dense0_weight_plios.size(); ++i) {
    //     // Place close to final output at shim 27, but spread across columns
    //     adf::location<adf::PLIO>(solver2_dense0_weight_plios[i]) = adf::shim(24 + static_cast<int>(i));
    // }

    // const std::array<KernelPlacement, 9> solver2_kernels = {{
    //     {&solver2_bias0, 32, 3},
    //     {&solver2_bias1, 33, 3},
    //     {&solver2_bias2, 34, 3},
    //     {&solver2_bias3, 35, 3},
    //     {&solver2_relu0, 32, 4},
    //     {&solver2_relu1, 33, 4},
    //     {&solver2_relu2, 34, 4},
    //     {&solver2_relu3, 35, 4},
    //     {&solver2_split0, 31, 2}
    // }};

    // for (const auto& placement : solver2_kernels) {
    //     adf::location<adf::kernel>(*placement.target) = adf::tile(placement.col, placement.row);
    // }

    // const std::array<KernelPlacement, 2> solver2_split_tiles = {{
    //     {&solver2_split1, 31, 3},
    //     {&solver2_split2, 31, 4}
    // }};

    // for (const auto& placement : solver2_split_tiles) {
    //     adf::location<adf::kernel>(*placement.target) = adf::tile(placement.col, placement.row);
    // }

    // place_linear(solver1_dense0.getKernels(), TP_CASC_LEN_STAGE2_LAYER0 * TP_SSR_STAGE2, 24, 0);
    // place_linear(solver1_dense1.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 36, 2);
    // place_linear(solver1_dense2.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 36, 3);
    // place_linear(solver1_dense3.getKernels(), TP_CASC_LEN_STAGE2_LAYERX * TP_SSR_STAGE2, 36, 4);
    // place_linear(output_dense0.getKernels(), TP_CASC_LEN_STAGE3 * TP_SSR_STAGE3, 26, 2);
}
