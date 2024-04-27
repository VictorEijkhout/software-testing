#include "petsc.h"

#if !defined(PETSC_USE_COMPLEX)
#error Does not have complex type
#endif

#undef __FUNCT__
#define __FUNCT__ "main"
int main(int argc,char **args)
{
  PetscErrorCode ierr;

  PetscInitialize(&argc,&args,0,0);
  printf("%ld\n",sizeof(PetscScalar));
  return PetscFinalize();
}

