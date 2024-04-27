#!/bin/bash

package=fftw2
version=2.1.5
help_string="Loop over all compilers, testing one package version"

##
## test all programs for this package,
## looping over locally available modules
##

source ../options.sh

source ../tacc_tests.sh
