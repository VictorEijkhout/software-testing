#!/bin/bash
################################################################
####
#### Tests for the Fortran interface to Netcdf
#### In the local install these are separate package, but
#### in the final TACC modules they are merged
####
################################################################

package=netcdff
version=4.6.1
modules=
loadpackage=netcdf/4.9.2

source ../options.sh
source ../tacc_tests.sh

