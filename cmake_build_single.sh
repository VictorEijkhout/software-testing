#!/bin/bash

##
## Test a program C/F given externally loaded compiler/mpi
## the output of this script is caught externally by cmake_test_driver.sh
##

function usage() {
    echo "Usage: $0 [ -m (use mpi) ] [ -p package ]  [ -v variant ] [ -x (set -x) ]"
    echo "    [ --cmake cmake options separated by commas ]"
    echo "    program.c/cxx/F90" 
}

package=unknownpackage
moduleversion="unknownversion"
cmake=
mpi=
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
	shift && mpi=1
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

if [ ! -z "${mpi}" ] ; then 
    export CC=mpicc
    export FC=mpif90
    export CXX=mpicxx
elif [ ! -z "${TACC_CCC}" ] ; then 
    export CC=${TACC_CC}
    export CXX=${TACC_CXX}
    export FC=${TACC_FC}
else
    case ${TACC_FAMILY_COMPILER} in
	( gcc ) export CC=gcc && export CXX=g++ && export FC=gfortran ;;
	( intel ) v=${TACC_FAMILY_COMPILER_VERSION}
	          v=${v%%.*}
	          if [ ${v} -gt 20 ] ; then
	            export CC=icx && export CXX=icpx && export FC=ifx 
	          else 
	            export CC=icc && export CXX=icpc && export FC=ifort 
                  fi ;; 
	( nvidia ) export CC=nvc && export CXX=nvc++ && export FC=nvfortran ;;
	( * ) echo "ERROR unhandled compiler family: <<${TACC_FAMILY_COMPILER}>>" && exit 1 ;; 
    esac
fi
echo "Using cmake: $( cmake --version | head -n 1 ) with CC=${CC}, CXX=${CXX}, FC=${FC}"

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

