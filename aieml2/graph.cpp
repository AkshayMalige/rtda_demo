#include "graph.h"

SingleDenseGraph g;

#if defined(__AIESIM__) || defined(__X86SIM__)
int main() {
  g.init();
  g.run(1);
  g.wait();
  g.end();
  return 0;
}
#endif
