##
## test all programs for this package,
## looping over tacc available modules
##

module reset >/dev/null 2>&1
echo "================"
echo "==== TACC modules"
echo "==== Testing: ${package}/${version}"
echo "================"

compilelog=tacc_tests_${package}-${version}.log
rm -f ${compilelog}
for compiler in $( cat ../compilers.sh ); do 

    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $compiler != *${matchcompiler}* ]] ; then continue ; fi
    fi

    ##
    ## load compiler and mpi if needed
    ##
    retcode=0 && module load ${compiler} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo && echo "==== Configuration  ${compiler}: unknown" | tee -a ${compilelog}
	continue
    fi

    echo && echo "==== Configuration: ${compiler}" | tee -a ${compilelog}
    if [ ! -z "${mpi}" ] ; then
	module load impi >/dev/null 2>&1 || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    echo "     No MPI available" | tee -a ${compilelog}
	    continue
	fi
    fi 
    ##
    ## load module and execute all tests
    ##
    if [ "${package}" != "none" ] ; then 
	module load ${package}/${version} >/dev/null 2>&1 || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    echo "     WARNING could not load ${package}/${version}" | tee -a ${compilelog}
	    continue
	fi
	for m in ${modules} ; do
	    module load $m >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     WARNING failed to load dependent module <<$m>>" | tee -a ${compilelog}
	    fi
	done
    fi

    source ${package}_tests.sh

done
echo && echo "See: ${compilelog}" && echo

