#!/bin/bash

if [ $# -lt 1 ] ; then 
    echo "Usage: $0 program.[ -c compilername ] [ -v moduleversion ] c/cxx/f" && exit 1
fi

compiler=${TACC_FAMILY_COMPILER}
version="unknownversion"
while [ $# -gt 1 ] ; do
    if [ $1 = "-c" ] ; then
	shift && compiler=$1 && shift 
    elif [ $1 = "-v" ] ; then
	shift && version=$1 && shift 
    fi
done

program=$1
base=${program%.*}
lang=${program#*.}

if [ ${lang} = "F90" ] ; then cc=mpif90 ; else cc=mpicc ; fi

rm -rf build && mkdir build
cp ${program} ${lang}/
pushd ${lang} >/dev/null
export CC=${cc}
## -D CMAKE_VERBOSE_MAKEFILE=ON 
retcode=0 && ( \
    cmake -D PROJECTNAME=${base} ../c \
    && make ) || retcode=$?
if [ ${retcode} -ne 0 ] ; then 
    echo && echo "ERROR compilation failed with compiler=${compiler} and petsc/${v}" && echo
fi
popd >/dev/null

