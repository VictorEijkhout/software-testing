#!/bin/bash

package=kokkos
version=3.3.10

cuda=0
function usage() {
    echo "Usage: $0 [ -c cuda tests ]"
    echo "    [ -v version (default: ${version}) ]"
}
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0
fi
while [ $# -gt 0 ] ; do
    if [ "$1" = "-c" ] ; then
	cuda=1 && shift
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    fi
done

##
## test all programs for this package,
## looping over locally available modules
##

source ../failure.sh

module reset >/dev/null 2>&1
export compilelog=local_test.log
rm -f ${compilelog}
touch ${compilelog}
echo "================"
echo "==== Package: ${package}, version: ${version}"
echo "==== Local modules"
echo "==== logfile: ${compilelog}"
echo "================"
echo 
for compiler in intel/19 intel/23 gcc/9 gcc/11 gcc/13 ; do \

    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}" | tee -a ${compilelog}
    retcode=0
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1 || retcode=$?
    if [ $retcode -eq 0 ] ; then 
	if [ -z "${TACC_CXX}" ] ; then
	    echo "ERROR set TACC_CXX" && exit 1
	fi

	retcode=0
	if [ $cuda -eq 1 ] ; then 
	    source ${package}_cuda_tests.sh 
	else
	    source ${package}_tests.sh 
	fi
    else
	echo "     Could not load configuration ${config}"
    fi
done
echo && echo "See: ${compilelog}" && echo

