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

if [ -z "${logfile}" ] ; then
    locallog=1
    logfile=${package}.log
else
    locallog=
fi

if [ ! -z "${noibrun}" ] ; then
    mpiflag=
else
    mpiflag=-m
fi

source ../failure.sh

##
## C tests
##
echo "C language"

echo "---- Sanity test"
../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} sanity.c

# echo "---- Test if we have amgx preconditioner"
# retcode=0
# ../cmake_build_single.sh -m -p ${package} amgx.c >>${logfile} 2>&1 || retcode=$?
# failure $retcode "amgx compilation"

echo "---- Test size of scalar"
../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} scalar.c

echo "---- Test size of int"
../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} int.c

echo "---- Test presence of hdf5"
../cmake_test_driver.sh -d phdf5 ${mpiflag} -p ${package} -l ${logfile} hdf5.c

if [[ "${PETSC_ARCH}" == *i64* ]] ; then 
    echo "---- Test presence of mumpsi64"
    ../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} mumpsi64.c
fi

echo "---- Test presence of parmetis"
../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} parmetis.c

echo "---- Test presence of ptscotch"
../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} ptscotch.c


##
## Fortran tests
##
echo "Fortran language"

# echo "---- Test if we can compile Fortran"
# ../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} fortran.F90

if [[ "${PETSC_ARCH}" != *f08* ]] ; then 
    echo "---- Test if we can compile Fortran1990"
    ../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} fortran1990.F90
else echo ".... skip f90 test"
fi

if [[ "${PETSC_ARCH}" = *f08* ]] ; then 
    echo "---- Test if we can compile Fortran2008"
    ../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} fortran2008.F90
else echo ".... skip f08 test"
fi

##
## Python tests
##
if [ "${py}" = "1" ] ; then 
    echo "Python language"

    echo "---- Test if we have python interfaces"
    retcode=0
    ./petsc4py_test.sh >>${logfile} 2>&1 || retcode=$?
    failure $retcode "py interfaces"
fi

if [ ! -z "${locallog}" ] ; then 
    echo && echo "See: ${logfile}" && echo
fi

