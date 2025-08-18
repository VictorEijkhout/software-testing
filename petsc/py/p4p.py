import re
import sys

def module_report( m ):
    m_init = m.__file__
    print( f"module {m.__name__} imported from <<{m_init}>>" )
    m_location = re.sub( "__init__.py", "", m_init )
    print( f"module {m.__name__} located at <<{m_location}>>" )
    print()

#
# sanity check on MPI
#
import mpi4py
module_report(mpi4py)
from mpi4py import MPI
comm = MPI.COMM_WORLD
procid = comm.Get_rank()

import petsc4py
module_report(petsc4py)
petsc4py.init(sys.argv)
if procid==0: print("Successful petsc init")
from petsc4py import PETSc

import slepc4py
module_report(slepc4py)
slepc4py.init(sys.argv)
from slepc4py import SLEPc
if procid==0: print("Successful slepc init")

Print = PETSc.Sys.Print
if procid==0: print("All imported")
