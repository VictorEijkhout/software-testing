#!/bin/bash

##
## Test a program C/F given externally loaded compiler/mpi
## the output of this script is caught externally by cmake_test_driver.sh
##

function usage() {
    echo "Usage: $0 [ -m moduleversion ] [ -p package ]  [ -v variant ] [ -x (set -x) ]"
    echo "    [ --cmake cmake options separated by commas ]"
    echo "    program.c/cxx/F90" 
}

package=unknownpackage
moduleversion="unknownversion"
cmake=
variant="default"
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0 
fi
while [ $# -gt 1 ] ; do
    if [ $1 = "-p" ] ; then 
	shift && package=$1 && shift
    elif [ $1 = "--cmake" ] ; then
	shift && cmake=$1 && shift
	echo "Cmake flags: ${cmake}"
    elif [ $1 = "-m" ] ; then
	shift && moduleversion=$1 && shift 
    elif [ $1 = "-v" ] ; then
	shift && variant=$1 && shift 
    elif [ $1 = "-x" ] ; then
	shift && set -x
    fi
done

if [ $# -eq 0 ] ; then
    usage && exit 1
fi

program=$1
base=${program%.*}
lang=${program#*.}
if [ "${variant}" = "default" ] ; then
    variant=${lang}
fi

if [ ! -d "${variant}" ] ; then
    echo "ERROR no language directory <<${variant}>>" && return 1
fi

echo "----" && echo "testing <<${variant}/${program}>>" && echo "----"
rm -rf build && mkdir build && pushd build >/dev/null

export CC=mpicc
export FC=mpif90
export CXX=mpicxx
retcode=0 && cmake -D CMAKE_VERBOSE_MAKEFILE=ON \
    -D PROJECTNAME=${base} \
    $( if [ ! -z "${cmake}" ] ; then echo ${cmake} | tr ',' ' ' ; fi ) \
    ../${variant} || retcode=$?
if [ ${retcode} -ne 0 ] ; then 
    echo
    echo "    ERROR CMake failed program=${program} and ${package}/${v}; exit ${retcode}"
    echo
    exit ${retcode}
fi

retcode=0 && make || retcode=$?
if [ ${retcode} -ne 0 ] ; then 
    echo
    echo "    ERROR compilation failed program=${program} and ${package}/${v}"
    echo
    exit ${retcode}
fi
echo "    SUCCESS"
popd >/dev/null

