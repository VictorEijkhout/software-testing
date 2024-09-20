#!/bin/bash

package=netcdff
version=4.6.1
modules=netcdf/4.9.2
loadpackage=${package}

##
## test all programs for this package,
## looping over locally available modules
##

source ../options.sh

source ../local_tests.sh
