#include "petsc.h"

int main( int argc,char **argv ) {
#ifndef PETSC_HAVE_MUMPS
#error No mumps in this installation
#endif 

  PetscErrorCode ierr;

  PetscInitialize(&argc,&argv,0,0);
  int s = sizeof(PetscInt);
  printf("Have mumps and size of int=%d\n",s);
  return PetscFinalize();

  return 0;
}
