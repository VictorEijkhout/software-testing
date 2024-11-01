#!/bin/bash
################################################################
####
#### Tests for the Fortran interface to Netcdf
#### In the local install these are separate package, but
#### in the final TACC modules they are merged
####
################################################################

source ./package.sh
loadpackage=netcdf
loadversion=4.9.2
source ../options.sh
source ../tacc_tests.sh

