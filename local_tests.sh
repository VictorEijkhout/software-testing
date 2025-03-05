##
## test all programs for this package,
## looping over locally available modules
##
## this file is textually included
##

if [ -z "${package}" ] ; then
    echo "You are calling ../local_tests.sh without setting package"
    exit 1
fi

module reset >/dev/null 2>&1
( echo "================" \
 && echo "==== Local modules" \
 && echo "==== Package: ${package}, version: ${version}" \
 && echo "================" \
 ) | tee -a ${logfile}

shortlog=local_tests.log
touch ${shortlog}

#
# loop through compiler names without slash
#
compilers="$( for c in $( cat ../compilers.sh ) ; do echo $c | tr -d '/' ; done )"
failed=
for compiler in $compilers ; do 
    
    configlog=${logdir}/${compiler}.log
    rm -f ${configlog}
    touch ${configlog}

    # split into name and version
    found=1
    compiler_name_and_version >>${logfile}
    if [ $found -eq 0 ] ; then continue ; fi

    ##
    ## load local configuration
    ## which includes MPI
    ##
    config=${cname}${cversion}
    envfile=${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh
    if [ ! -f "${envfile}" ] ; then
	if [ -z "${failed}" ] ; then 
	    echo | tee -a ${logfile}
	fi
	echo "==== Configuration: ${config} undefined for system ${TACC_SYSTEM}" | tee -a ${logfile}
	failed=1
	continue
    else
	( echo && echo "==== Configuration: ${config}" ) | tee -a ${logfile}
	echo " .. loaded from ${envfile}" >>${logfile}
	failed=
    fi
    source ${envfile}  >/dev/null 2>&1

    ##
    ## Load prereq modules
    ##
    load_dependencies

    ## 
    ## load module (if there is one) and execute all tests
    ##
    source ../load_and_test.sh

    cat ${configlog} >>${logfile} 

done

echo && echo "See: ${logfile}" && echo
