#!/bin/bash

##
## Driver for python_run_single.sh
##

buildsystem=python
optional_flags="--seq"
optional_help="[ --seq : run single process ]"
source ../functions.sh
source ../failure.sh
source ../driver_options.sh

logfile=${testlog} load_dependencies

retcode=0
../python_run_single.sh -p ${package} ${x} ${extra_flags} \
    $( if [ ! -z "${mpi}" ] ; then echo "-m" ; fi ) \
    $( if [ ! -z "${cmake}" ] ; then echo "--cmake ${cmake}" ; fi ) \
    "${source}" \
    >>${testlog} 2>&1 || retcode=$?
# report failure but don't exit because we need to merge logs
failure $retcode "${executable} execution" | tee -a ${testlog}

echo " .. include testlog <<${testlog}>> into full log: <<${fulllog}>>" >>${fulllog}
cat ${testlog} >> ${fulllog}
