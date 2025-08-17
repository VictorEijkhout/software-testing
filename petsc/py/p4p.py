import re

#
# sanity check on MPI
#
import MPI
mpi_init = MPI.__file__
print( f"MPI imported from <<{mpi_init}>>" )
pi_location = re.sub( "__init__.py", "", mpi_init )
print( f"MPI located at <<{mpi_location}>>" )

from mpi4py import MPI
comm = MPI.COMM_WORLD
procid = comm.Get_rank()

import sys, petsc4py
petsc4py.init(sys.argv)
if procid==0: print("Successful petsc init")
slepc4py.init(sys.argv)
if procid==0: print("Successful slepc init")

from petsc4py import PETSc
from slepc4py import SLEPc
Print = PETSc.Sys.Print
if procid==0: print("All imported")
