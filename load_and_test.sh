################################################################
####
#### Given an environment load module and run tests
####
################################################################

##
## Load actual module and execute all tests
##
if [ "${loadpackage}" != "none" ] ; then 
    if [ "${loadpackage}" != "mpi" ] ; then 
	( echo " .. available:" \
	      && module -t avail ${loadpackage}/${loadversion} 2>&1 \
	    ) >>${logfile}
	retcode=0
	module load ${loadpackage}/${loadversion} >/dev/null 2>&1 || retcode=$?
	if [ $retcode -eq 0 ] ; then
	    echo "Loaded package:  ${loadpackage}/${loadversion}" >>${logfile}
	    echo " .. $( module -t show ${loadpackage}/${loadversion} 2>&1 )" >>${logfile}
	else 
	    echo "     could not load ${loadpackage}/${loadversion}" | tee -a ${logfile}
	    echo "     currently loaded: $( module -t list 2>&1 ) " >>${logfile}
	    continue
	fi
    fi
fi

( \
    echo "Running with modules: " \
    && echo "$( module -t list 2>&1 | sort | awk '{m=m FS $1} END {print m}' )" \
    && echo "----------------" \
    ) | tee -a ${logfile}

cmdline="./${package}_tests.sh ${standardflags} \
      -l ${configlog}"
echo "cmdline=$cmdline" >>${logfile}
eval $cmdline

echo # blank line between successful configuration
