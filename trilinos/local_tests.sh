#!/bin/bash

package=trilinos
version=16.0.0
mpi=1
help_string="Loop over all compilers, testing one package version"

##
## test all programs for this package,
## looping over locally available modules
##

source ../options.sh
source ../local_tests.sh
