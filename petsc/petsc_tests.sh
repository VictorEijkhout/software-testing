#!/bin/bash

##
## run tests, given a loaded compiler & petsc version
##

package=petsc
help_string="Run tests given loaded compiler and petsc version"

if [ ! -z "${noibrun}" ] ; then
    mpiflag=
else
    mpiflag=-m
fi
if [ -z "${logfile}" ] ; then
    locallog=1
    logfile=${package}.log
else
    locallog=
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
if [[ "${PETSC_ARCH}" = *single* ]] ; then
    realsize=4 ; else realsize=8 ; fi
if [[ "${PETSC_ARCH}" = *complex* ]] ; then
    realsize=$(( realsize * 2 )) ; fi
../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} \
			-t ${realsize} \
			scalar.c

echo "---- Test size of int"
if [[ "${PETSC_ARCH}" = *i64* ]] ; then
    intsize=8 ; else intsize=4 ; fi
../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} \
			-t ${intsize} \
			int.c

if [[ "${PETSC_ARCH}" = *complex* ]] ; then
    echo "---- Test complex type"
    ../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} complex.c
fi

echo "---- Test presence of hdf5"
../cmake_test_driver.sh -d phdf5 ${mpiflag} -p ${package} -l ${logfile} hdf5.c

echo "---- Test presence of fftw3"
../cmake_test_driver.sh ${mpiflag} -p ${package} -l ${logfile} \
			-t accuracy \
			fftw3.c

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
if [ "${python}" = "1" ] ; then 
    echo "Python language"

    echo "---- Test if we have python interfaces"
    retcode=0 && ibrun python3 -c "import petsc4py,slepc4py" || retcode=$?
    failure $retcode "python commandline import"

    retcode=0 && ( cd p && ibrun python3 p4p.py ) | grep -v TACC: || retcode=$?
    failure $retcode "python petsc init"

    echo "---- Python allreduce"
    retcode=0 && ( cd p && ibrun python3 allreduce.py ) | grep -v TACC: || retcode=$?
    failure $retcode "python allreduce"

fi

if [ ! -z "${locallog}" ] ; then 
    echo && echo "See: ${logfile}" && echo
fi

