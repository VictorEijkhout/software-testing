#!/bin/bash

package=boost
version=1.83.0

source ../options.sh

##
## test all programs for this package,
## looping over locally available modules
##

module reset >/dev/null 2>&1
echo "================"
echo "==== Package: ${package}, version: ${version}"
echo "==== Local modules"
echo "==== logfile: ${compilelog}"
echo "================"
echo 
compilelog=local_tests.log
rm -f ${compilelog}
for compiler in $( cat ../compilers.sh ) ; do 

    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}" | tee -a ${compilelog}
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1
    if [ $? -eq 0 ] ; then 
	module load ${package}/${version} >/dev/null 2>&1
	if [ $? -eq 0 ] ; then

	    source ${package}_tests.sh

	else
	    echo "WARNING could not load ${package}/${version}"
	fi
    else
	echo " .. could not load configuration <<${config}>>"
    fi
done
echo && echo "See: ${compilelog}" && echo

