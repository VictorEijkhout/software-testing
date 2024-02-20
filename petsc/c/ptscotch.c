#include "petsc.h"

#ifndef PETSC_HAVE_PTSCOTCH
#error Variable PETSC_HAVE_PTSCOTCH not set
#endif

#undef __FUNCT__
#define __FUNCT__ "main"
int main(int argc,char **args)
{
  PetscErrorCode ierr;
  MPI_Comm comm;
  Mat A;
  PetscScalar one = 1.0;
  
  PetscFunctionBegin;
  PetscInitialize(&argc,&args,0,0);
  return PetscFinalize();
}

