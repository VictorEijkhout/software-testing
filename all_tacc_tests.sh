#!/bin/bash

packages="\
    arpack boost cfitsio cxxopts eigen \
    fftw2 fftw3 hdf5 highfive hypre \
    kokkos mdspan mpl \
    netcdf netcdff p4est parmetis pcre2 \
    petsc pnetcdf siesta silo swig \
    trilinos udunits zlib \
    "
logdir=all_logs
rm -rf ${logdir}
mkdir -p ${logdir}
for p in ${packages} ; do
    if [ -d "${p}" ] ; then 
	( cd ${p} \
	      && echo "================" && echo "Testing: $p" && echo "================" && echo \
	      && ./tacc_tests.sh $*
	) \
	    | awk '\
	      	    /Configuration/ { c=$0; s=1 } \
		    c!="" && !/can not load/ { c="" ; print c ; print; s=1 } \
		    s!=1 { print } \
		    s==1 { s==0 } \
		    '
    else
	echo "================" && echo "No such tester: $p" 
    fi
done
