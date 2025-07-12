#include "petsc.h"

#if defined(PETSC_USE_DEBUG)
#error debug mode not disabled
#endif

#undef __FUNCT__
#define __FUNCT__ "main"
int main(int argc,char **args)
{
  PetscErrorCode ierr;

  PetscInitialize(&argc,&args,0,0);
  return PetscFinalize();
}

