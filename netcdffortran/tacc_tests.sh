#!/bin/bash
################################################################
####
#### Tests for the Fortran interface to Netcdf
#### In the local install these are separate package, but
#### in the final TACC modules they are merged
####
################################################################

package=netcdffortran
version=4.6.1
modules=
loadpackage=netcdf
loadversion=4.9.2
# why 3.29? Frontera needs the rpath fix
cmakeversion=3.24

source ../options.sh
source ../tacc_tests.sh
