#!/bin/bash

source ../test_setup.sh

##
## Tests
##

echo "testing version $loadversion"
case ${loadversion} in
    ( *omp ) 
    header=Kokkos_Core.hpp ;
    program=enabled-omp ;;
    ( *cuda ) 
    header=Kokkos_Core.hpp ;
    program=enabled-cuda ;;
    ( *sycl ) 
    header=Kokkos_Core.hpp ;
    program=enabled-sycl ;;
    ( * )
    header=Kokkos_Core.hpp
    program=SET-OMP-CUDA-SYCL
esac

export OMP_PROC_BIND=spread
export OMP_PLACES=threads
../existence_test.sh    ${standardflags} -l ${logfile} \
			--title "Header" \
			--dir inc "${header}"

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--value Yes \
			--title "testing ${program}" \
			${program}.cxx

