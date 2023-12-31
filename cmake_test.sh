#!/bin/bash

##
## Driver for cmake_tests.sh
##

function usage() {
    echo "Usage: $0 [ -p package ]  [ -l logfile ] program.{c.F90}"
}

package=
compilelog=1
while [ $# -gt 1 ] ; do
    if [ $1 = "-p" ] ; then 
	shift && package=$1 && shift
    elif [ $1 = "-l" ] ; then 
	shift && compilelog=$1 && shift
    fi
done
source=$1
executable=${source%%\..*}
echo "$source $executable"
exit 0

retcode=0
../cmake_test.sh -p ${package} ${source} >>${compilelog} 2>&1 || retcode=$?
failure $retcode "${executable} compilation"
ibrun -n 1 ./build/${executable} || retcode=$?
failure $retcode "${executable} test run"
