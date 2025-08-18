import re

import petsc4py

petsc_init = petsc4py.__file__
print( f"petsc4py imported from <<{petsc_init}>>" )
petsc_location = re.sub( "__init__.py", "", petsc_init )
print( f"PETSc located at <<{petsc_location}>>" )

from petsc4py import PETSc
print( "from petsc4py imported PETSc successfull" )
