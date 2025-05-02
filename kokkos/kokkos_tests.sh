#!/bin/bash

source ../test_setup.sh

##
## Tests
##

echo "testing version $loadversion"
case ${loadversion} in
    ( *omp ) 
    program=enabled-omp ;;
    ( *cuda ) 
    program=enabled-cuda ;;
    ( *sycl ) 
    program=enabled-sycl ;;
esac

export OMP_PROC_BIND=spread
export OMP_PLACES=threads
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--value Yes \
			--title "testing ${program}" \
			${program}.cxx

