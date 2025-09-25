#!/bin/bash

##
## Driver for cmake_build_single.sh
##

buildsystem=cmake
source ../functions.sh
source ../failure.sh
source ../driver_options.sh

logfile=${testlog} load_dependencies

( echo && echo "${buildsystem} build single: ${source}" && echo ) >>${testlog}

retcode=0
../cmake_build_single.sh -p ${package} ${x} \
    $( if [ ! -z "${mpi}" ] ; then echo "-m" ; fi ) \
    $( if [ ! -z "${cmake}" ] ; then echo "--cmake ${cmake}" ; fi ) \
    "${source}" \
    >>${testlog} 2>&1 || retcode=$?
failure $retcode "${executable} compilation" | tee -a ${testlog}

##
## Run test
## if compilation successful, and not skipping runs
##
if [ $retcode -eq 0 ] ; then

    # report shared libraries
    ( echo "ldd ${executable}:" && ldd "./build/${executable}" ) >>${fulllog}

    if [ ! -z "${run}" ] ; then
	( echo && echo "Run executable: ${source}" && echo ) >>${testlog}
	run_executable
    fi
else
    echo " .. skipping run after unsuccessful compilation" >>${testlog}
fi

echo " .. include testlog <<${testlog}>> into full log: <<${fulllog}>>" >>${fulllog}
cat ${testlog} >> ${fulllog}
