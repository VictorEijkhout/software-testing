##
## Include file to
## test all programs for this package,
## looping over tacc available modules
##
## options have been set by options.sh at top level
##

if [ -z "${package}" ] ; then
    echo "You are calling the general tacc_tests.sh without setting package"
    exit 1
fi
if [ -z "${version}" ] ; then
    version=default
fi

logdir=${package}_logs
fulllog=${logdir}/${version}.log
shortlog=tacc_tests.log
mkdir -p ${logdir}
rm -f ${fulllog}
touch ${fulllog}
touch ${shortlog}

module reset >/dev/null 2>&1
( echo "================" \
 && echo "==== TACC modules" \
 && echo "==== Testing: ${package}/${version}" \
 && echo "==== available packages: $( module -t spider ${package}/${version} 2>&1 )" \
 && echo "================" \
 ) | tee -a ${fulllog}

#
# loop through compiler names without slash
#
compilers="$( for c in $( cat ../compilers.sh ) ; do echo $c | tr -d '/' ; done )"
for compiler in $compilers ; do 
    
    configlog=${logdir}/${compiler}.log

    # split into name and version
    cname=${compiler%%[0-9]*}
    cversion=${compiler##*[a-z]}
    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $compiler != *${matchcompiler}* ]] ; then
	    echo "==== Skip compiler: $compiler" >>${fulllog}
	    continue
	fi
    fi

    ##
    ## load compiler and mpi if needed
    ##
    ( echo && echo "==== Configuration: ${compiler}" ) | tee -a ${fulllog}
    echo "For compiler: ${compiler} loading module: ${cname}/${cversion}"  >>${fulllog}
    retcode=0 && module load ${cname}/${cversion} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo ".... can not load ${cname}/${cversion} for compiler ${compiler}" | tee -a ${fulllog}
	continue
    fi
    if [ ! -z "${mkl}" ] ; then
	## mkl loading is allowed to fail for intel
	module load mkl >/dev/null 2>&1
    fi
    if [ ! -z "${mpi}" ] ; then
	retcode=0
	module load impi >/dev/null 2>&1 || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    retcode=0
	    module load openmpi >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     No MPI available" | tee -a ${fulllog}
		continue
	    fi
	fi
    fi 
    for m in ${modules} ; do
	echo "Loading dependent module: $m" >>${fulllog}
	module load $m
    done

    ##
    ## load module and execute all tests
    ##
    if [ "${package}" != "none" ] ; then 
	echo "Loading package:  ${package}/${version}" >>${fulllog}
	module load ${package}/${version} >/dev/null 2>&1 || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    echo "     could not load ${package}/${version}" | tee -a ${fulllog}
	    continue
	fi
	for m in ${modules} ; do
	    if [ $m = "mkl" -a $cname = "intel" ] ; then continue ; fi
	    module load $m >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     WARNING failed to load dependent module <<$m>>"
	    fi
	done
    fi
    echo "Running with modules: $( module -t list 2>&1 )" >>${fulllog}
    echo "$( module -t list 2>&1 | awk '{m=m FS $1} END {print m}' )"
    echo "----------------"

    cmdline="./${package}_tests.sh \
      -e \
      ${mpiflag} ${runflag} ${p4pflag} ${xflag} \
      -l ${configlog}"
    echo "cmdline=$cmdline" >>${fulllog}
    eval $cmdline
    cat ${configlog} >>${fulllog} 

done | tee ${shortlog}

echo && echo "See: ${shortlog} and ${fulllog}" && echo
