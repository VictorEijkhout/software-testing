#include <stdio.h>
#define METIS_EXPORT
#include "metis.h"
#include "parmetis.h"

int main() {
  printf("%d\n",PARMETIS_OP_KMETIS);
  return 0;
}
