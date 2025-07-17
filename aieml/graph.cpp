#include "graph.h"
NeuralNetworkGraph g;
#if defined(__AIESIM__) || defined(__X86SIM__)
int main() {
  g.init();
  g.run();
  g.wait();
  g.end();
  return 0;
}
#endif