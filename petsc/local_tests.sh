#!/bin/bash

package=petsc
version=3.20

extension=
function usage() {
    echo "Usage: $0 [ -v version (default=${version} ]"
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

source ../local_tests.sh 

# module reset >/dev/null 2>&1
# export compilelog=local_test.log
# rm -f ${compilelog}
# touch ${compilelog}
# echo "================"
# echo "==== Package: ${package}, version: ${version}"
# echo "==== Local modules"
# echo "==== logfile: ${compilelog}"
# echo "================"
# echo 
# for compiler in $( cat ../compilers.sh ) ; do

#     config=$( echo $compiler | tr -d '/' )
#     echo "==== Configuration: ${config}" | tee -a ${compilelog}
#     retcode=0
#     source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1 || retcode=$?
#     if [ $retcode -eq 0 ] ; then 
# 	source petsc_tests.sh
#     else
# 	echo "==== Could not load configuration ${config}"
#     fi
# done
# echo && echo "See: ${compilelog}" && echo
