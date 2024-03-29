#!/bin/bash

package=netcdff
version=4.6.1

source ../options.sh

source ../tacc_tests.sh

# module reset >/dev/null 2>&1
# echo "================"
# echo "==== TACC modules"
# echo "    testing ${package}/${version}"
# echo "================"
# echo 
# compilelog=tacc_tests.log
# rm -f ${compilelog}
# for compiler in intel/19 intel/23 intel/24 gcc/9 gcc/11 gcc/12 gcc/13 ; do \
#     retcode=0 && module load ${compiler} >/dev/null 2>&1 || retcode=$?
#     if [ $retcode -gt 0 ] ; then 
# 	echo ".... Unknown configuration ${compiler}" | tee -a ${compilelog}
#     else
# 	echo "==== Configuration: ${compiler}" | tee -a ${compilelog}
# 	module load ${package}/${version} >>${compilelog} 2>&1
# 	if [ $? -eq 0 ] ; then

# 	    source ${package}_tests.sh

# 	else
# 	    echo "WARNING could not load ${package}/${version}"
# 	fi
#     fi
# done
# echo && echo "See: ${compilelog}" && echo

