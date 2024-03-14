#include "petsc.h"

int main() {
#ifndef PETSC_HAVE_MUMPS
#error No mumps in this installation
#endif 

  PetscErrorCode ierr;

  PetscInitialize(&argc,&args,0,0);
  if ( sizeof(PetscInt)!=8 ) {
    return 1;
  }
  return PetscFinalize();

  return 0;
}
