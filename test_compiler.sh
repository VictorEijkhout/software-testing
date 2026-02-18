#!/bin/bash

function usage () {
    echo "Usage: $0 [ -c compilercode ] [ -r : no run ]"
}

if [ $# -eq 0 ] ; then
    usage && exit 0
fi

while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-c" ] ; then
	shift && compiler="$1" && shift
    elif [ "$1" = "-r" ] ; then
	runflag="-r" && shift
    else
	echo "Unknown option <<$1>>" && exit 1
    fi
done

if [ -z "${compiler}" ] ; then
    echo "ERROR: no compiler specified" && exit 1
fi

packages="\
    adios2 arpack boost \
    catch2 cxxopts \
    dealii eigen \
    fftw2 fftw3 fmtlib \
    gmp gmsh gsl 
    hdf5 highfive hmmer hypre \
    jsonc libmesh \
    "
for p in ${packages} ; do
    ( cd $p && echo "Testing: $p"
      ./tacc_tests.sh -c ${compiler} ${runflag} 2>&1 \
	  | awk '\
	          /==== Configuration:/ {print} \
		  /Test: / {p=1} \
	          p==1 {print} NF==0 {p=0}'
    )
done


