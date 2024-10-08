#!/bin/bash

##
## Driver for make_build_single.sh
##

buildsystem=make
source ../driver_options.sh
source ../failure.sh

echo "Test: make build and run, source=$source" >>${testlog}
echo "compiler=$matchcompiler log=$logfile mpi=$mpi run=$run version=$version" \
     >>${testlog}

retcode=0
if [ ! -z "${modules}" ] ; then
    echo " .. loading modules: ${modules}" >>${testlog} 2>&1
    for m in $( echo ${modules} | tr ',' ' ' ) ; do
	module load $m >>${testlog} 2>&1
    done
fi

../make_build_single.sh -p ${package} ${x} \
    $( if [ ! -z "${mpi}" ] ; then echo "-m" ; fi ) \
    $( if [ ! -z "${cmake}" ] ; then echo "--cmake ${cmake}" ; fi ) \
    "${source}" \
    >>${testlog} 2>&1 || retcode=$?
failure $retcode "${executable} compilation" | tee -a ${testlog}

if [ -z $mpi ] ; then
    echo " .. running non-mpi executable: ${executable}" >>${testlog}
    ./build/${executable} \
	>run_${executable}.log 2>err_${executable}.log || retcode=$?
else
    echo " .. running mpi executable on one node: ${executable}" >>${testlog}
    ibrun -n 1 ./build/${executable} \
	>run_${executable}.log 2>err_${executable}.log || retcode=$?
fi
failure $retcode "${executable} test run"

cat run_${executable}.log >> ${testlog}
if [ $retcode -eq 0 ] ; then
    if [ ! -z ${mpi} ] ; then
	cat run_${executable}.log | grep -v TACC
    else
	cat run_${executable}.log
    fi
fi
