##
## test all programs for this package,
## looping over locally available modules
##

if [ -z "${package}" ] ; then
    echo "You are calling ../local_tests.sh without setting package"
    exit 1
fi

module reset >/dev/null 2>&1
echo "================"
echo "==== Local modules"
echo "==== Package: ${package}, version: ${version}"
echo "================"

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
    compiler_name_and_version

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
    if [ "${loadpackage}" != "mpi" ] ; then 
	echo "Loading package:  ${loadpackage}/${version}" >>${logfile}
	retcode=0
	module load ${loadpackage}/${version} >/dev/null 2>&1 || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    echo "     could not load ${loadpackage}/${version}" | tee -a ${logfile}
	    echo "Currently loaded: $( module -t list 2>&1 ) " >>${logfile}
	    continue
	fi
    fi
    echo "Running with modules: $( module -t list 2>&1 )" >>${logfile}

    cmdline="./${package}_tests.sh \
      -p ${package} \
      ${mpiflag} ${runflag} ${p4pflag} ${xflag} \
	-l ${configlog}"
    echo "cmdline=$cmdline" >>${logfile}
    eval $cmdline
    cat ${configlog} >>${logfile} 

done

echo && echo "See: ${logfile}" && echo
