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
