##
## settings common to tacc & local tests
##

package=petsc
version=3.24
modules=
mkl=1
mpi=1
omp=1
python_option=1
optional_flags="--small --python_only"
optional_help="[ --small : no external package tests, slepc excluded; --python_only : only python tests ]"
