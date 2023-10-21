-include ../../../petscdir.mk

MANSEC          = Mat

include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

# set the conditional prerequisites after including the 'variables' file, so we
# can reference make macros defined by it, but before including the 'test' file,
# so that ex18 has correct full prerequisites (instead of the default ex18.o)
scalarobjs := scalar.o
ifneq ($(CUDAC),)
  scalarobjs += scalarcu.o
endif
ifneq ($(KOKKOS_LIB),)
  scalarobjs += scalarkok.o
endif
scalar : ${scalarobjs}

