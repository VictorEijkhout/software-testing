!
! triggered by:
! https://consult.tacc.utexas.edu/Ticket/Display.html?id=97607
!

Program vecinsert
#include <petsc/finclude/petsc.h>
  use petsc
  Vec :: xvec
  integer :: near_nbasis_at_proc_solver
  integer,dimension(5) :: indices
  PetscScalar,dimension(5) :: rj
  integer :: ierr

  call VecSetValues(xvec,near_nbasis_at_proc_solver,&
     indices,rj,INSERT_VALUES,ierr)

End Program vecinsert

