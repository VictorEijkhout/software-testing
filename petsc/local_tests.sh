#!/bin/bash

package=petsc
version=3.21
modules=
mpi=1
help_string="Loop over all compilers, testing package: ${package}, version: ${version}"

source ../options.sh
source ../local_tests.sh
