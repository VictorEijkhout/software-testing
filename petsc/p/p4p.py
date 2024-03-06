import sys, petsc4py,slepc4py
print(sys.argv)
petsc4py.init(sys.argv)
print("Successful petsc init")
slepc4py.init(sys.argv)
print("Successful slepc init")

from petsc4py import PETSc
from slepc4py import SLEPc
Print = PETSc.Sys.Print
print("All imported")
