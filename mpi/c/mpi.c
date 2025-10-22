#include <stdio.h>
#include "mpi.h"

int main() {
  MPI_Init(0,0);
  MPI_Comm comm = MPI_COMM_WORLD;
  int nprocs,procno;
  MPI_Comm_size(comm,&nprocs);
  MPI_Comm_rank(comm,&procno);
  if (procno==0)
    printf("Running on %d processes\n",nprocs);
  MPI_Finalize();
  return 0;
}
