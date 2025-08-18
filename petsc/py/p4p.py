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
# mpi_init = mpi4py.__file__
# print( f"mpi4py imported from <<{mpi_init}>>" )
# mpi_location = re.sub( "__init__.py", "", mpi_init )
# print( f"mpi4py located at <<{mpi_location}>>" )

from mpi4py import MPI
comm = MPI.COMM_WORLD
procid = comm.Get_rank()

import petsc4py
module_report(petsc4py)

petsc4py.init(sys.argv)
if procid==0: print("Successful petsc init")
slepc4py.init(sys.argv)
if procid==0: print("Successful slepc init")

from petsc4py import PETSc
from slepc4py import SLEPc
Print = PETSc.Sys.Print
if procid==0: print("All imported")
