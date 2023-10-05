#!/bin/bash

package=petsc
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
echo "================"
echo "==== Local modules"
echo "================"
echo 
export compilelog=local_test.log
rm -f ${compilelog}
for compiler in intel/19 intel/23 gcc/9 gcc/13 ; do \
    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}" | tee -a ${compilelog}
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1
    module load ${package}/${version}${extension} >/dev/null 2>&1
    if [ $? -eq 0 ] ; then

	source petsc_tests.sh

    else
	echo "WARNING could not load ${package}/${version}${extension}" | tee -a ${compilelog}
    fi
done
echo && echo "See: ${compilelog}" && echo
