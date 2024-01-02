#!/bin/bash

##
## run tests, given a loaded compiler
##

package=hypre
if [ -z "${TACC_HYPRE_DIR}" ] ; then 
    echo "Please load module <<$package>>" && exit 1
fi

if [ -z "${compilelog}" ] ; then
    compilelog=compile.log
    rm -f ${compilelog}
fi

source ../failure.sh

set -x
echo "==== Test if we can compile"
retcode=0
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} has.c

if [ "${compilelog}" = "compile.log" ] ; then
    echo "See: ${compilelog}"
fi
