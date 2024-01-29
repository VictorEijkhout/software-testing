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
echo "==== TACC modules"
echo "    testing ${package}/${version}"
echo "================"
echo 
compilelog=tacc_tests.log
rm -f ${compilelog}
for compiler in intel/19 intel/23 intel/24 gcc/9 gcc/11 gcc/12 gcc/13 ; do \

    retcode=0 && module load ${compiler} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo ".... Unknown configuration ${compiler}" | tee -a ${compilelog}
    else
	echo "==== Configuration: ${compiler}" | tee -a ${compilelog}
	module load ${package}/${version} >/dev/null 2>&1
	#export CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}:${TACC_KOKKOS_DIR}
	if [ $? -eq 0 ] ; then

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

