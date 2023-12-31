#include "petsc.h"

#undef __FUNCT__
#define __FUNCT__ "main"
int main(int argc,char **args)
{
  PetscErrorCode ierr;

  PetscInitialize(&argc,&args,0,0);
  // size of scalar
  printf("%ld\n",sizeof(PetscScalar));
  return PetscFinalize();
}

