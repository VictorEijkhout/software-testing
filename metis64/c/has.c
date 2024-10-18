#include <stdio.h>
#include "metis.h"

#if IDXTYPEWIDTH != 64
#error Not a 64 bit version
#endif

int main() {
  printf("%d\n",METIS_OK);
  return 0;
}
