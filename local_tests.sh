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
if [ -z "${version}" ] ; then
    version=default
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
compilers="$( if [ -f "../compilers_${TACC_SYSTEM}.sh" ] ; then cat ../compilers_${TACC_SYSTEM}.sh ; else cat ../compilers.sh ; fi )"
failed=
for compiler in $compilers ; do
    
    #
    # parse compiler & possible module use path
    # NOTE: for local tests we don't actually use the usepath
    #
    if [[ ${compiler} = *:* ]] ; then
	usepath=$( echo ${compiler} | cut -d ':' -f 1 )
	compiler=$( echo ${compiler} | cut -d ':' -f 2 )
    else usepath= ; fi
    compiler=$( echo $compiler | tr -d '/' )

    #
    # skip if we match a particular compiler
    #
    if [ ! -z "${matchcompiler}" ] ; then
	# test equality of sanitized names
	if [[ $( echo ${compiler} | tr -d '/\.' ) \
	      != \
	      $( echo ${matchcompiler} | tr -d '/\.' )* ]] ; then
	    echo " ==== Configuration not matched: ${compiler} to desired ${matchcompiler}"
	    continue
	fi
    fi

    # split into name and version
    found=1
    compiler_name_and_version >>${logfile}
    if [ $found -eq 0 ] ; then continue ; fi

    # local log file
    configlog=${logdir}/${compiler}.log
    rm -f ${configlog}
    touch ${configlog}

    ##
    ## load local configuration
    ## which includes MPI
    ##
    envfile=${HOME}/Software/env_${TACC_SYSTEM}_${configuration}.sh
    if [ ! -f "${envfile}" ] ; then
	if [ -z "${failed}" ] ; then 
	    echo | tee -a ${logfile}
	fi
	echo "==== Configuration: ${configuration} undefined for system ${TACC_SYSTEM}" | tee -a ${logfile}
	failed=1
	continue
    else
	( echo && echo "==== Configuration: ${configuration}" ) | tee -a ${logfile}
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
