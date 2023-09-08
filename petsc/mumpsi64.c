#include "petsc.h"

int main() {
  PetscInitialize(0,0,0,0);
  MPI_Comm comm = MPI_COMM_WORLD;
  KSP ksp;
  KSPCreate(comm,&ksp);
  KSPSetType(ksp, KSPPREONLY);
  PC pc;
  KSPGetPC(ksp, &pc);
  PCSetType(pc, PCLU);
  PCFactorSetMatSolverType(pc, MATSOLVERMUMPS);
  return 0;
}
