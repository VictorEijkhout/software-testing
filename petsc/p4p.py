import sys, petsc4py
print(sys.argv)
petsc4py.init(sys.argv)
from petsc4py import PETSc
from slepc4py import SLEPc
Print = PETSc.Sys.Print
print("Successful init")
