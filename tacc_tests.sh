##
## Include file to
## test all programs for this package,
## looping over tacc available modules
##
## options have been set by options.sh at top level
##
## this file is textually included
##

if [ -z "${package}" ] ; then
    echo "You are calling ../tacc_tests.sh without setting package"
    exit 1
fi
if [ -z "${version}" ] ; then
    version=default
fi

module reset >/dev/null 2>&1

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
     echo "==== available configuations: $( module -t spider ${loadpackage}/${loadversion} 2>&1 )" \
     ; fi \
 && echo "================" \
 && echo \
 ) | tee -a ${logfile}

#
# loop through compiler names without slash
#
compilers="$( if [ -f "../compilers_${TACC_SYSTEM}.sh" ] ; then cat ../compilers_${TACC_SYSTEM}.sh ; else cat ../compilers.sh ; fi )"
for compiler in $compilers ; do 

    #
    # parse compiler & possible module use path
    #
    if [[ ${compiler} = *:* ]] ; then
	usepath=$( echo ${compiler} | cut -d ':' -f 1 )
	compiler=$( echo ${compiler} | cut -d ':' -f 2 )
    else usepath= ; fi

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

    # split into name and version; 
    # report if skipped
    ## found=1
    compiler_name_and_version >>${logfile}
    ## if [ $found -eq 0 ] ; then continue ; fi
    
    # local log file
    configlog=${logdir}/${cname}${cversion}.log
    rm -f ${configlog}
    touch ${configlog}

    ##
    ## load compiler by version
    ##
    echo >>${logfile}
    if [ ! -z "${usepath}" ] ; then 
	if [ ! -d "${usepath}" ] ; then
	    echo "ERROR invalid module use path <<${usepath}>>" | tee -a ${logfile}
	    continue # try next compiler
	fi
	module use ${usepath} >>${logfile} 2>&1
    fi
    retcode=0 && module -t load ${cname}/${cversion} >>${logfile} 2>&1 || retcode=$?
    if [ $retcode -eq 0 ] ; then 
	## successful load needs to be visually offset
	( echo && echo "==== Configuration: ${compiler}" ) | tee -a ${logfile}
	if [ ! -z "${usepath}" ] ; then 
	    echo "     from path: ${usepath}" | tee -a ${logfile}
	fi
	echo "Loaded compiler: ${cname}/${cversion}"  >>${logfile}
    else
	echo "==== Configuration failed to load: ${cname}/${cversion}" | tee -a ${logfile}
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
		echo "     No MPI available" | tee -a ${logfile}
		continue
	    fi
	fi
    fi 

    ##
    ## Load prereq modules
    ##
    load_dependencies

    ##
    ## load cmake
    ## Note: on frontera this may do some libc path fixes
    ##
    module load cmake$( if [ ! -z ${cmakeversion} ] ; then echo "/${cmakeversion}" ; fi ) \
	2>/dev/null

    ## 
    ## load module (if there is one) and execute all tests
    ##
    source ../load_and_test.sh

    cat ${configlog} >>${logfile} 

done

echo && echo "See: ${logfile}" && echo
