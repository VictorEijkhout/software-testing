#!/bin/bash

package=kokkos
version=4.2.00-omp

extra_help="also version xxx-cuda"
source ../options.sh

##
## omp or cuda :
##
devtype=${version##*-}

##
## test all programs for this package,
## looping over locally available modules
##

module reset >/dev/null 2>&1
echo "================"
echo "==== Local modules"
echo "    testing ${package}/${version}"
echo "================"
echo 
compilelog=local_tests.log
export compilelog=local_test.log
rm -f ${compilelog}
for compiler in $( cat ../compilers.sh ) ; do \

    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}" | tee -a ${compilelog}
    retcode=0
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo ".... Unknown configuration ${compiler}" | tee -a ${compilelog}
    else
	echo "==== Configuration: ${compiler}" | tee -a ${compilelog}
	module load ${package}/${version} >/dev/null 2>&1
	( echo "Using prefix path:" && splitpath CMAKE_PREFIX_PATH ) >> ${compilelog}
	if [ $? -eq 0 ] ; then
	    if [ -z "${TACC_CXX}" ] ; then
		echo "ERROR set TACC_CXX" && exit 1
	    fi

	    retcode=0
	    if [ ${devtype} = "cuda" ] ; then 
		source ${package}_cuda_tests.sh 
	    else
		source ${package}_tests.sh 
	    fi
	else
	    echo "WARNING could not load ${package}/${version}"
	fi
    fi
done
echo && echo "See: ${compilelog}" && echo

