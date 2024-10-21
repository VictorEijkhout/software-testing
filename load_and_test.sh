################################################################
####
#### Given an environment load module and run tests
####
################################################################

##
## Load actual module and execute all tests
##
if [ "${loadpackage}" != "none" ] ; then 
    module load ${loadpackage}/${loadversion} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -eq 0 ] ; then
	echo "Loaded package:  ${loadpackage}/${loadversion}" >>${logfile}
    else 
	echo "     could not load ${loadpackage}/${loadversion}" >>${logfile}
	continue
    fi
fi
( \
    echo "Running with modules: " \
    && echo "$( module -t list 2>&1 | sort | awk '{m=m FS $1} END {print m}' )" \
    && echo "----------------" \
    ) | tee -a ${logfile}

cmdline="./${package}_tests.sh \
      -p ${package} \
      ${mpiflag} ${runflag} ${p4pflag} ${xflag} \
      -l ${configlog}"
echo "cmdline=$cmdline" >>${logfile}
eval $cmdline
