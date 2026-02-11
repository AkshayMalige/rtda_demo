#pragma once

inline void NeuralNetworkGraph::apply_layout() {

    // Embed stage
    runtime<ratio>(embed_bias_relu0) = 0.95;
    runtime<ratio>(embed_split0)     = 0.95;
    runtime<ratio>(embed_bias_relu1) = 0.95;

    // Solver0 stage
    runtime<ratio>(solver0_rollconcat) = 1.0;

    runtime<ratio>(solver0_bias_relu0) = 0.95;
    runtime<ratio>(solver0_split0)     = 0.65;
    runtime<ratio>(solver0_bias_relu1) = 0.95;
    runtime<ratio>(solver0_split1)     = 0.65;
    runtime<ratio>(solver0_bias_relu2) = 0.95;
    runtime<ratio>(solver0_split2)     = 0.65;
    runtime<ratio>(solver0_bias_relu3) = 0.95;

    runtime<ratio>(solver1_rollconcat) = 1.0;
    runtime<ratio>(solver1_bias_relu0) = 0.95;
    runtime<ratio>(solver1_split0)     = 0.65;
    runtime<ratio>(solver1_bias_relu1) = 0.95;
    runtime<ratio>(solver1_split1)     = 0.65;
    runtime<ratio>(solver1_bias_relu2) = 0.95;
    runtime<ratio>(solver1_split2)     = 0.65;
    runtime<ratio>(solver1_bias_relu3) = 0.95;

    runtime<ratio>(solver2_rollconcat) = 1.0;
    runtime<ratio>(solver2_bias_relu0) = 0.95;
    runtime<ratio>(solver2_split0)     = 0.65;
    runtime<ratio>(solver2_bias_relu1) = 0.95;
    runtime<ratio>(solver2_split1)     = 0.65;
    runtime<ratio>(solver2_bias_relu2) = 0.95;
    runtime<ratio>(solver2_split2)     = 0.65;
    runtime<ratio>(solver2_bias_relu3) = 0.95;
}
