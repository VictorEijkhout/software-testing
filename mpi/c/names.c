#include <stdio.h>
#include "mpi.h"

int main() {
  MPI_Init(0,0);

  MPI_Accumulate(0,0,0, 0,0,0, 0,0,0);
  PMPI_Accumulate(0,0,0, 0,0,0, 0,0,0);

  MPI_Accumulate_c(0,0,0, 0,0,0, 0,0,0);
  PMPI_Accumulate_c(0,0,0, 0,0,0, 0,0,0);

  MPI_Finalize();
  return 0;
}
