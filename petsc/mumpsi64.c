#include "petsc.h"

int main() {
  KSP ksp;
  KSPSetType(ksp, KSPPREONLY);
  PC pc;
  KSPGetPC(ksp, &pc);
  PCSetType(pc, PCLU);
  PCFactorSetMatSolverType(pc, MATSOLVERMUMPS);
  return 0;
}
