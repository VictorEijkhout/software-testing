##
## test all programs for this package,
## looping over locally available modules
##

module reset >/dev/null 2>&1
echo "================"
echo "==== TACC modules"
echo "==== Testing: ${package}/${version}"
echo "================"
compilelog=tacc_tests.log
rm -f ${compilelog}
for compiler in intel/19 intel/23 intel/24 gcc/9 gcc/11 gcc/12 gcc/13 ; do \
    retcode=0 && module load ${compiler} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo && echo "==== Configuration  ${compiler}: unknown" | tee -a ${compilelog}
    else
	echo && echo "==== Configuration: ${compiler}" | tee -a ${compilelog}
	if [ ! -z "${mpi}" ] ; then
	    module load impi >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     No MPI available"
		continue
	    fi
	fi 
	if [ "${package}" = "none" ] ; then 
	    retcode=0
	else
	    module load ${package}/${version} >/dev/null 2>&1 || retcode=$?
	fi
	if [ $retcode -eq 0 ] ; then

	    source ${package}_tests.sh

	else
	    echo "     WARNING could not load ${package}/${version}"
	fi
    fi
done
echo && echo "See: ${compilelog}" && echo

