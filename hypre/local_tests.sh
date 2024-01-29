#!/bin/bash

package=hypre
version=2.30.0

##
## test all programs for this package,
## looping over locally available modules
##

source ../options.sh

module reset >/dev/null 2>&1
echo "================"
echo "==== Package: ${package}, version: ${version}"
echo "==== Local modules"
echo "================"
echo 
compilelog=local_test.log
rm -f ${compilelog}
for compiler in $( cat ../compilers.sh ) ; do

    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}" | tee -a ${compilelog}
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1
    module load ${package}/${version} >/dev/null 2>&1
    if [ $? -eq 0 ] ; then

	source hypre_tests.sh

    else
	echo "WARNING could not load ${package}/${version}"
    fi
done
echo && echo "See: ${compilelog}" && echo

