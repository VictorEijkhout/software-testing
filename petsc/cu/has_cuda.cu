// -*- c -*-

#include <petscdm.h>
#include <petscdmda.h>
#include <petscsnes.h>

int main(int argc, char **argv)
{
  DM        da;
  char     *tmp, typeName[256];
  PetscBool flg;

  PetscFunctionBeginUser;
  PetscCall(PetscInitialize(&argc, &argv, NULL, help));

  // we set "-dm_vec_type cuda" on the commandline
  PetscCall(DMDACreate1d(PETSC_COMM_WORLD, DM_BOUNDARY_NONE, 8, 1, 1, NULL, &da));
  PetscCall(DMDestroy(&da));

  PetscCall(PetscFinalize());
  return 0;
}
