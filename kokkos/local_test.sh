#!/bin/bash

package=kokkos
version=3.3.10

##
## test all programs for this package,
## looping over locally available modules
##

source ../options.sh

module reset >/dev/null 2>&1
echo "================"
echo "==== Local modules"
echo "================"
echo 
compilelog=local_test.log
rm -f ${compilelog}
for compiler in intel/19 intel/23 gcc/9 gcc/11 gcc/13 ; do \
    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}" | tee -a ${compilelog}
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1
    source ${package}_tests.sh
done
echo && echo "See: ${compilelog}" && echo

