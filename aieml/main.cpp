#include "graph.h"

NeuralNetworkGraph g;

int main() {
    g.init();
    g.run(1);
    g.end();
    return 0;
}
