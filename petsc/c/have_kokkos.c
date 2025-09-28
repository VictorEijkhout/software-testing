#include "petsc.h"

int main( int argc,char **argv ) {
#ifndef PETSC_HAVE_KOKKOS
#error No kokkos in this installation
#endif 

  PetscErrorCode ierr;

  PetscInitialize(&argc,&argv,0,0);
  printf("Have kokkos\n");
  return PetscFinalize();

  return 0;
}

/*
#define PETSC_HAVE_KOKKOS 1
#define PETSC_HAVE_KOKKOS_INIT_WARNINGS 1
#define PETSC_HAVE_KOKKOS_KERNELS 1
#define PETSC_HAVE_KOKKOS_WITHOUT_GPU 1
/scratch/00434/eijkhout/installation/installation-petsc-3.23.6-stampede3-gcc15.1-impi21.15-3.23.6/3.23.6/include/petscconf.h
*/
