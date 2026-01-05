/*

  cmake generates:
  -isystem /opt/apps/intel24/impi21/parpack/3.9.1/include/arpack

  otherwise we'd do
  #include "arpack/parpack.h"

  I think this is bad design, but the official examples seem to use this
*/
#include "parpack.h"

int main() {

  return 0;
}
