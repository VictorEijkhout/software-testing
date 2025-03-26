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

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--value Yes \
			--title "testing ${program}" \
			${program}.cxx

