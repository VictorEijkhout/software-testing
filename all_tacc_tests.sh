#!/bin/bash

packages="\
    arpack boost cfitsio cxxopts eigen \
    fftw2 fftw3 hdf5 highfive hypre \
    kokkos mdspan mpl \
    netcdf netcdff p4est parmetis pcre2 \
    petsc pnetcdf siesta silo swig \
    trilinos udunits zlib \
    "
echo $*
for p in ${packages} ; do
    if [ -d "${p}" ] ; then 
	( cd ${p} \
	      && echo "================" && echo "Testing: $p" && echo "================" && echo \
	      && ./tacc_tests.sh $*
	)
    else
	echo "================" && echo "No such tester: $p" 
    fi
done
