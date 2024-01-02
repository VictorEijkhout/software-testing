#!/bin/bash

##
## Driver for cmake_build_single.sh
##

function usage() {
    echo "Usage: $0 [ -m ] [ -p package ]  [ -l logfile ] program.{c.F90}"
}

if [ $# -eq 0 ] ; then 
    usage && exit 0
fi

source ../failure.sh
package=unknown
compilelog=${package}.log
mpi=
while [ $# -gt 1 ] ; do
    if [ $1 = "-h" ] ; then
	usage && exit 0
    elif [ $1 = "-m" ] ; then 
	shift && mpi=1 
    elif [ $1 = "-p" ] ; then 
	shift && package=$1 && shift
    elif [ $1 = "-l" ] ; then 
	shift && compilelog=$1 && shift
    fi
done
source=$1
executable=${source%%.*}
extension=${source##*.}
if [ ! -f "${extension}/${source}" ] ; then
    echo "ERROR: no file <<${extension}/${source}>>" && return 0
fi
echo "cmake build and run: source=$source" >>${compilelog}

retcode=0
../cmake_build_single.sh -p ${package} "${source}" >>${compilelog} 2>&1 || retcode=$?
failure $retcode "${executable} compilation"
if [ -z $mpi ] ; then
    ./build/${executable} \
	>run_${executable}.log 2>&1 || retcode=$?
else
    ibrun -n 1 ./build/${executable} \
	>run_${executable}.log 2>&1 || retcode=$?
fi
failure $retcode "${executable} test run"

cat run_${executable}.log >> ${compilelog}
if [ $retcode -eq 0 ] ; then
    if [ ! -z ${mpi} ] ; then
	cat run_${executable}.log | grep -v TACC
    else
	cat run_${executable}.log
    fi
fi
