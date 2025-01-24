##
## Include file to
## test all programs for this package,
## looping over tacc available modules
##
## options have been set by options.sh at top level
##

if [ -z "${package}" ] ; then
    echo "You are calling ../tacc_tests.sh without setting package"
    exit 1
fi
if [ -z "${version}" ] ; then
    version=default
fi

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
     echo "==== available configuations: $( module -t spider ${loadpackage}/${loadversion} 2>&1 )" \
     ; fi \
 && echo "================" \
 && echo \
 ) | tee -a ${logfile}

#
# loop through compiler names without slash
#
compilers="$( for c in $( cat ../compilers.sh ) ; do echo $c | tr -d '/' ; done )"
for compiler in $compilers ; do 
    if [ ! -z "${matchcompiler}" -a "${matchcompiler}" != "${compiler}" ] ; then
	echo " ==== Configuration not matched: ${compiler}"
	continue
    fi
    configlog=${logdir}/${compiler}.log
    rm -f ${configlog}
    touch ${configlog}

    # split into name and version; 
    # report if skipped
    found=1
    compiler_name_and_version >>${logfile}
    if [ $found -eq 0 ] ; then continue ; fi

    ##
    ## load compiler by version
    ##
    echo >>${logfile}
    retcode=0 && module -t load ${cname}/${cversion} >>${logfile} 2>&1 || retcode=$?
    if [ $retcode -eq 0 ] ; then 
	## successful load needs to be visually offset
	( echo && echo "==== Configuration: ${compiler}" ) | tee -a ${logfile}
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
    ## load module (if there is one) and execute all tests
    ##
    source ../load_and_test.sh
    echo # blank line between successful configuration

    cat ${configlog} >>${logfile} 

done

echo && echo "See: ${logfile}" && echo
