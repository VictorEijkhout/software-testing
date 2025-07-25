################################################################
####
#### Given an environment load module and run tests
####
################################################################

function check_dir () {
    pkg=$1
    if [ -z "${pkg}" ] ; then
	echo "INTERNAL ERROR zero pkg argument" && exit 1
    fi
    dir=$2
    if [ -z "${dir}" ] ; then
	echo "INTERNAL ERROR zero dir argument" && exit 1
    fi
    dirname=TACC_$( echo ${pkg} | tr a-z A-Z )_$( echo $dir | tr a-z A-Z )
    eval variable=\${${dirname}}
    if [ ! -z "${variable}" ] ; then
	if [ ! -d "${variable}" ] ; then
	    echo "FATAL: package <<$pkg>> variable <<$dir>>: <<${variable}>> does not exist" \
		| tee -a ${logfile}
	fi
    fi
}

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
	    for dir in dir bin inc lib ; do
		check_dir "${loadpackage}" "$dir"
	    done
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
