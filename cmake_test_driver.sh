#!/bin/bash

##
## Driver for cmake_build_single.sh
##

buildsystem=cmake
source ../functions.sh
source ../driver_options.sh
source ../failure.sh

echo "Test: cmake build and run, source=$source" >>${testlog}
echo "compiler=$matchcompiler log=$logfile mpi=$mpi run=$run version=$version" \
     >>${testlog}

retcode=0
if [ ! -z "${modules}" ] ; then
    echo " .. loading modules: ${modules}" >>${testlog} 2>&1
    for m in $( echo ${modules} | tr ',' ' ' ) ; do
	module load $m >>${testlog} 2>&1
    done
    ( echo "modules loaded:" && module -t list 2>&1 ) >>${testlog}
fi

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
if [ $retcode -eq 0 -a ! -z "${run}" ] ; then

    runlog=${logdir}/${executable}_run.log
    rm -f ${runlog}
    if [ -z "${mpi}" ] ; then
	if [ ! -z "${inbuildrun}" ] ; then 
	    cmdline="( cd build && ./${executable} )"
	else
	    cmdline="./build/${executable}"
	fi
    else
	cmdline="ibrun -np 1 ./build/${executable}"
    fi
    echo "Running: $cmdline" >>${testlog}
    eval $cmdline  >>${runlog} 2>&1 || retcode=$?
    failure $retcode "${executable} test run" | tee -a ${testlog}

    if [ $retcode -eq 0 ] ; then
	if [ ! -z "${testvalue}" ] ; then
	    lastline=$( cat ${runlog} | grep -v TACC | tail -n 1 )
	    if [[ "${lastline}" = *${testvalue}* ]] ; then
		echo "     correct output: ${lastline}"
	    else
		echo "     ERROR output: ${lastline} s/b ${testvalue}"
	    fi
	fi
    fi | tee -a ${testlog}
    ( echo ">>>> runlog:" && cat ${runlog} && echo ".... runlog" ) >>${testlog}

else
    echo " .. skipping run after unsuccessful compilation" >>${testlog}
fi

echo " .. include testlog <<${testlog}>> into full log: <<${fulllog}>>" >>${fulllog}
cat ${testlog} >> ${fulllog}
