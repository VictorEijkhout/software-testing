#!/bin/bash

##
## Test a petsc program C/F given externally loaded compiler/mpi
##

function usage() {
    echo "Usage: $0.[ -c compilername ] [ -v moduleversion ]  program.c/cxx/F90" 
}

compiler=${TACC_FAMILY_COMPILER}
version="unknownversion"
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0 
fi
while [ $# -gt 1 ] ; do
    if [ $1 = "-c" ] ; then
	shift && compiler=$1 && shift 
    elif [ $1 = "-v" ] ; then
	shift && version=$1 && shift 
    fi
done

if [ $# -eq 0 ] ; then
    usage && exit 1
fi

program=$1
base=${program%.*}
lang=${program#*.}

cp ${program} ${lang}/
echo "testing <<${lang}/${program}>>"
rm -rf build && mkdir build && pushd build >/dev/null

export CC=mpicc
export FC=mpif90
retcode=0 && cmake -D CMAKE_VERBOSE_MAKEFILE=ON \
    -D PROJECTNAME=${base} ../${lang} || retcode=$?
if [ ${retcode} -ne 0 ] ; then 
    echo
    echo "ERROR CMake failed program=${program} compiler=${compiler} and petsc/${v}"
    echo
fi

retcode=0 && make || retcode=$?
if [ ${retcode} -ne 0 ] ; then 
    echo
    echo "ERROR compilation failed program=${program} compiler=${compiler} and petsc/${v}"
    echo
fi
popd >/dev/null

