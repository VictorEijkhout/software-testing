#!/bin/bash

##
## run tests, given a loaded compiler & petsc version
##

package=petsc

if [ "$1" = "-h" ] ; then 
    echo "Run tests given loaded compiler and petsc version" && exit 0
fi
if [ -z "${TACC_PETSC_DIR}" ] ; then 
    echo "Please load module <<$package>>" && exit 1
fi

if [ -z "${compilelog}" ] ; then
    compilelog=${package}.log
fi

source ../failure.sh

echo "---- Sanity test"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} sanity.c

echo "---- Test if we can compile Fortran"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} fortran.F90

echo "---- Test if we have python interfaces"
retcode=0
./petsc4py_test.sh >>${compilelog} 2>&1 || retcode=$?
failure $retcode "py interfaces"

# echo "---- Test if we have amgx preconditioner"
# retcode=0
# ../cmake_build_single.sh -m -p ${package} amgx.c >>${compilelog} 2>&1 || retcode=$?
# failure $retcode "amgx compilation"

echo "---- Test size of scalar"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} scalar.c

echo "---- Test size of int"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} int.c

echo "---- Test presence of hdf5"
../cmake_test_driver.sh -d phdf5 -m -p ${package} -l ${compilelog} hdf5.c

echo "---- Test presence of parmetis"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} parmetis.c

echo "---- Test presence of ptscotch"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} ptscotch.c


echo && echo "See: ${compilelog}" && echo

