#include <stdio.h>
#include "mpi.h"

int main() {
  MPI_Init(0,0);
  MPI_Comm comm = MPI_COMM_WORLD;
  int nprocs,procno;
  MPI_Comm_size(comm,&nprocs);
  MPI_Comm_rank(comm,&procno);
  double buffer[1];
  MPI_Count buflen = 1;
  MPI_Bcast_c( buffer,buflen,MPI_DOUBLE,0,comm );
  MPI_Finalize();
  return 0;
}
