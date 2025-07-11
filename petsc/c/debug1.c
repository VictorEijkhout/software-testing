#include "petsc.h"

#if PETSC_USE_DEBUG == 0
#error debug mode not activated
#endif

#undef __FUNCT__
#define __FUNCT__ "main"
int main(int argc,char **args)
{
  PetscErrorCode ierr;

  PetscInitialize(&argc,&args,0,0);
  return PetscFinalize();
}

