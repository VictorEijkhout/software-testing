#!/bin/bash

##
## run tests, given a loaded compiler & petsc version
##

package=petsc

if [ -z "${compilelog}" ] ; then
    compilelog=compile.log
fi

source ../failure.sh

for ext in "" "-single" "-cuda" ; do 
    echo "---- loading version: ${package}/${version}${ext}"
    module load ${package}/${version}${ext} >/dev/null 2>&1
    if [ $? -eq 0 ] ; then

	retcode=0
	petsc_pc_flags=$( pkg-config --cflags petsc >/dev/null 2>&1 ) || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    echo ">>>> petsc can not be found by pkg-config"
	else 
	    echo "    sanity test: pkg-config finds petsc:"
	    # echo "    PKG_CONFIG_PATH=${PKG_CONFIG_PATH}"
	    
	    # echo "    $( pkg-config --cflags petsc )"
	    echo "     Test size of scalar"
	    retcode=0
	    ../cmake_test.sh -p ${package} scalar.c >>${compilelog} 2>&1 || retcode=$?
	    failure $retcode "scalar compilation"
	    ./build/scalar

	    echo "     Test if we can compile Fortran"
	    retcode=0
	    ## ./petsc_cmake_test.sh fortran.F90 >>${compilelog} 2>&1 || retcode=$?
	    ../cmake_test.sh -p ${package} fortran.F90 >>${compilelog} 2>&1 || retcode=$?
	    failure $retcode "fortran compilation"

	    echo "     Test if we have python interfaces"
	    retcode=0
	    ./petsc4py_test.sh >>${compilelog} 2>&1 || retcode=$?
	    failure $retcode "py interfaces"

	    if [ "${compilelog}" = "compile.log" ] ; then
		echo "See: ${compilelog}"
	    fi

	    echo "     Test if we have amgx preconditioner"
	    retcode=0
	    ../cmake_test.sh -p ${package} ksp.c >>${compilelog} 2>&1 || retcode=$?
	    failure $retcode "amgx compilation"

	fi
    else
	echo "WARNING could not load ${package}/${version}${extension}" | tee -a ${compilelog}
    fi
done
