#!/bin/bash

##
## run tests, given a loaded compiler & petsc version
##

package=petsc
help_string="Run tests given loaded compiler and petsc version"

command_args=$*
mpi=1
python_option=1
source ../options.sh
if [ "${run}" != "1" ] ; then
    runflag=-r
fi

if [ ! -z "${mpi}" ] ; then
    mpiflag=-m
fi

if [ -z "${logfile}" ] ; then
    locallog=1
    logfile=${package}.log
fi
echo "Invoking ${package} tests: ${command_args}" >> ${logfile}
source ../failure.sh

##
## C tests
##
if [ "${skipc}" != "1" ] ; then
    echo "C language"

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "Sanity test" \
			    sanity.c

    # echo "Test if we have amgx preconditioner"
    # retcode=0
    # ../cmake_build_single.sh -m -p ${package} amgx.c >>${logfile} 2>&1 || retcode=$?
    # failure $retcode "amgx compilation"

    if [[ "${PETSC_ARCH}" = *single* ]] ; then
	realsize=4 ; else realsize=8 ; fi
    if [[ "${PETSC_ARCH}" = *complex* ]] ; then
	realsize=$(( realsize * 2 )) ; fi
    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "size of scalar" \
	-t ${realsize} \
	scalar.c

    if [[ "${PETSC_ARCH}" = *i64* ]] ; then
	intsize=8 ; else intsize=4 ; fi
    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "size of int" \
	-t ${intsize} \
	int.c

    if [[ "${PETSC_ARCH}" = *complex* ]] ; then
	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
				--title "complex type" \
				complex.c
    fi

    if [ "${TACC_SYSTEM}" != "vista" ] ; then 
    ../cmake_test_driver.sh -d phdf5 ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of hdf5" \
			    hdf5.c
    fi

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of fftw3" \
	-t accuracy \
	fftw3.c

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of mumps" \
			    mumps.c

    if [[ "${PETSC_ARCH}" == *i64* ]] ; then 
	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
				--title "presence of mumpsi64" \
				mumpsi64.c
    fi

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of parmetis" \
			    parmetis.c

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of ptscotch" \
			    ptscotch.c

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --cmake "-DUSESLEPC=ON" \
			    --title "presence of slepc" \
			    slepceps.c
fi

##
## Fortran tests
##
if [ "${skipf}" != "1" ] ; then
    echo "Fortran language"

	# ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
	    # --title "can we compile fortran"
	    # fortran.F90

    if [[ "${PETSC_ARCH}" != *f08* ]] ; then 
	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
				--title "can we compile Fortran1990" \
				fortran1990.F90

	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
				--title "F90 vector insertion" \
				vec.F90
    else echo ".... skip f90 test"
    fi

    if [[ "${PETSC_ARCH}" = *f08* ]] ; then 
	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
				--title "can we compile Fortran2008" \
				fortran2008.F90
    else echo ".... skip f08 test"
    fi
fi

##
## Python tests
##
if [ "${skippy}" != "1" ] ; then 
    echo "Python language"

    set -o pipefail

    echo "Test if we have python interfaces" | tee -a ${logfile}
    retcode=0 && ( cd p && ibrun -n 2 python3 -c "import petsc4py,slepc4py; print(1)" ) \
	| grep -v TACC: || retcode=$?
    failure $retcode "python commandline import"

    echo "Test init from argv" | tee -a ${logfile}
    retcode=0 && ( cd p && ibrun -n 2 python3 p4p.py 2>../err_petsc4py.log ) \
    	| grep -v TACC: || retcode=$?
    failure $retcode "python petsc init"

    echo "Python allreduce" | tee -a ${logfile}
    retcode=0 && ( cd p && ibrun -n 2 python3 allreduce.py ) \
	| grep -v TACC: || retcode=$?
    failure $retcode "python allreduce"
fi

if [ ! -z "${locallog}" ] ; then 
    echo && echo "See: ${logfile}" && echo
fi

