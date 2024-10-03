#!/bin/bash

packages="\
    arpack boost cfitsio cxxopts eigen \
    fftw2 fftw3 hdf5 highfive hypre \
    kokkos mdspan mpl \
    netcdf netcdff p4est parmetis pcre2 \
    petsc pnetcdf siesta silo swig \
    trilinos udunits zlib \
    "
logdir=$(pwd)/all_logs
logfile=${logdir}/all.log
rm -rf ${logdir}
mkdir -p ${logdir}
for p in ${packages} ; do
    if [ -d "${p}" ] ; then 
	( cd ${p}
	  echo "================" && echo "Testing: $p" && echo "================" && echo
	  if [ -f tacc_tests.sh ] ; then
	      ./tacc_tests.sh $*
	  fi 2>&1 | tee ${logdir}/${p}.log
	) 
    else
	echo "================" && echo "No such tester: $p" 
    fi
done 2>&1 | tee ${logfile}

echo && echo "See ${logfile} and ${logdir}/*.log" && echo

