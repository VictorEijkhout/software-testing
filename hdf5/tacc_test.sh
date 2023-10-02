#!/bin/bash

package=phdf5

function failure() {
    if [ $1 -gt 0 ] ; then 
	echo && echo "ERROR failed $2" && echo 
    fi
}

version=1.14
extension=
function usage() {
    echo "Usage: $0 [ -v version (default=${version} ] [ -x extension ]"
}
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0
fi
while [ $# -gt 0 ] ; do
    if [ "$1" = "-x" ] ; then
	shift && extension="-$1" && shift
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    fi
done

module reset >/dev/null 2>&1
echo "================"
echo "==== TACC modules"
echo "================"
for compiler in intel/19 intel/23 gcc/9 gcc/13 ; do \
    config=$( echo $compiler | tr -d '/' )
    echo && echo "==== Configuration: ${config}"
    module load ${compiler} >/dev/null 2>&1
    module load ${package}/${version}${extension} >/dev/null 2>&1
    if [ $? -eq 0 ] ; then

	case ${compiler} in ( intel* ) fc=ifort ;; ( gcc* ) fc=gfortran ;; esac
	case ${compiler} in ( intel* ) cc=icc ;; ( gcc* ) cc=gcc ;; esac

	echo "==== Test if we can compile C"
	cmdline="${cc} -I${TACC_HDF5_INC} -c has.c"
	echo " .. compile ${package} $v : $cmdline"
	retcode=0 && eval $cmdline || retcode=$?
	failure $retcode "C compilation"

	echo "==== Test if we can compile Fortran"
	cmdline="${fc} -I${TACC_HDF5_INC} -c fmod.F90"
	echo " .. compile ${package} $v : $cmdline"
	retcode=0 && eval $cmdline || retcode=$?
	failure $retcode "fortran compilation"

    else
	echo "WARNING could not load ${package}/${version}${extension}"
    fi
done
