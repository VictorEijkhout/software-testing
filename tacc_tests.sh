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
module load cmake$( if [ ! -z ${cmakeversion} ] ; then echo "/${cmakeversion}" ; fi ) 2>/dev/null
##
## spider this package unless we're testing some environment like mpi
##
if [ "${loadpackage}" != "none" ] ; then 
    module -t spider ${loadpackage}/${loadversion} 2>/dev/null
    if [ $? -gt 0 ] ; then
	echo "================"
	echo "==== Package ${loadpackage}/${loadversion} not installed here"
	echo "================"
	echo
	exit 0
    fi
fi
( echo "================" \
 && echo "==== TACC modules" \
 && if [ "${package}" = "${loadpackage}" ] ; then \
     echo "==== Testing: ${package}/${version}" \
    ; else \
     echo "==== Testing: ${package}/${version} from ${loadpackage}/${loadversion}" \
    ; fi \
 && if [ "${loadpackage}" != "none" ] ; then \
     echo "==== available packages: $( module -t spider ${loadpackage}/${loadversion} 2>&1 )" \
     ; fi \
 && echo "================" \
 && echo \
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
    echo >>${fulllog}
    retcode=0 && module load ${cname}/${cversion} >>${fulllog} 2>&1 || retcode=$?
    if [ $retcode -eq 0 ] ; then 
	## successful load needs to be visually offset
	( echo && echo "==== Configuration: ${compiler}" ) | tee -a ${fulllog}
	echo "Loaded compiler: ${cname}/${cversion}"  >>${fulllog}
    else
	# echo "==== Configuration: ${compiler}" | tee -a ${fulllog}
	# echo ".... can not load compiler ${cname}/${cversion}" | tee -a ${fulllog}
	continue
    fi

    ##
    ## Load the default mpi for this compiler
    ##
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

    ##
    ## Load prereq modules
    ##
    for m in ${modules} ; do
	if [ $m = "mkl" ] ; then
	    if [ "${TACC_SYSTEM}" = "vista" ] ; then
		echo "Loading mkl substitute nvpl for vista system" >>${fulllog}
		module load nvpl
	    elif [ $cname = "intel" ] ; then
		echo "Ignoring mkl load for intel compiler" >>${fulllog}
		continue
	    else
		echo "Loading mkl" >>${fulllog}
		module load mkl
	    fi
	else
	    echo "Loading dependent module: $m" >>${fulllog}
	    module load $m >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     WARNING failed to load dependent module <<$m>>"
	    fi
	fi
    done

    ##
    ## Load actual module and execute all tests
    ##
    if [ "${loadpackage}" != "none" ] ; then 
	module load ${loadpackage}/${loadversion} >/dev/null 2>&1 || retcode=$?
	if [ $retcode -eq 0 ] ; then
	    echo "Loaded package:  ${loadpackage}/${loadversion}" >>${fulllog}
	else 
	    echo "     could not load ${loadpackage}/${loadversion}" >>${fulllog}
	    continue
	fi
    fi
    ( \
      echo "Running with modules: " \
	  && echo "$( module -t list 2>&1 | sort | awk '{m=m FS $1} END {print m}' )" \
	  && echo "----------------" \
      ) | tee -a ${fulllog}

    cmdline="./${package}_tests.sh \
      -e -P ${loadpackage} \
      ${mpiflag} ${runflag} ${p4pflag} ${xflag} \
      -l ${configlog}"
    echo "cmdline=$cmdline" >>${fulllog}
    eval $cmdline
    cat ${configlog} >>${fulllog} 

done | tee ${shortlog}

echo && echo "See: ${shortlog} and ${fulllog}" && echo
