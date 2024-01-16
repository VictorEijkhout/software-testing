#!/bin/bash

package=petsc

function failure() {
    if [ $1 -gt 0 ] ; then 
	echo && echo "ERROR failed $2" && echo 
    fi
}

version=3.19
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
export compilelog=tacc_test.log
rm -f ${compilelog}
touch ${compilelog}
echo "================"
echo "==== Package: ${package}, version: ${version}"
echo "==== TACC modules"
echo "==== logfile: ${compilelog}"
echo "================"
for compiler in intel/19 intel/23 intel/24 gcc/9 gcc/13 ; do \
    echo && echo "==== Compiler: ${compiler}"
    retcode=0
    module load ${compiler} >/dev/null 2>&1 || retcode=$?
    if [ $? -eq 0 ] ; then
	source petsc_tests.sh
    else
	echo " .. could not load compiler ${compiler}"
    fi
done
echo && echo "See: ${compilelog}" && echo
