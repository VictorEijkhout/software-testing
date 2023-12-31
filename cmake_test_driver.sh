#!/bin/bash

##
## Driver for cmake_tests.sh
##

function usage() {
    echo "Usage: $0 [ -p package ]  [ -l logfile ] program.{c.F90}"
}

if [ $# -eq 0 ] ; then 
    usage && exit 0
fi

source ../failure.sh
package=unknown
compilelog=driver.log
while [ $# -gt 1 ] ; do
    if [ $1 = "-h" ] ; then
	usage && exit 0
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
( ibrun -n 1 ./build/${executable} >run_${executable}.log 2>&1 ) || retcode=$?
failure $retcode "${executable} test run"
