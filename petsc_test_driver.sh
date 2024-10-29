#!/bin/bash

##
## Driver for make_build_single.sh
##

buildsystem=petsc
source ../functions.sh
source ../failure.sh
source ../driver_options.sh

logfile=${testlog} load_dependencies

retcode=0
../petsc_build_single.sh -p ${package} ${x} \
    $( if [ ! -z "${mpi}" ] ; then echo "-m" ; fi ) \
    $( if [ ! -z "${cmake}" ] ; then echo "--cmake ${cmake}" ; fi ) \
    "${source}" \
    >>${testlog} 2>&1 || retcode=$?
# report failure but don't exit because we need to merge logs
failure $retcode "${executable} compilation" | tee -a ${testlog}

##
## Run test
## if compilation successful, and not skipping runs
##
if [ $retcode -eq 0 -a ! -z "${run}" ] ; then

    run_executable
    
else
    echo " .. skipping run after unsuccessful compilation" >>${testlog}
fi

echo " .. include testlog <<${testlog}>> into full log: <<${fulllog}>>" >>${fulllog}
cat ${testlog} >> ${fulllog}
