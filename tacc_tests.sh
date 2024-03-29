##
## test all programs for this package,
## looping over tacc available modules
##

module reset >/dev/null 2>&1
echo "================"
echo "==== TACC modules"
echo "==== Testing: ${package}/${version}"
echo "==== available packages: $( module -t spider ${package}/${version} 2>&1 )"
echo "================"

compilelog=tacc_tests_${package}-${version}.log
rm -f ${compilelog}

#
# compiler names without slash
#
compilers="$( for c in $( cat ../compilers.sh ) ; do echo $c | tr -d '/' ; done )"
for compiler in $compilers ; do 
    
    cname=${compiler%%[0-9]*}
    cversion=${compiler##*[a-z]}
    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $compiler != *${matchcompiler}* ]] ; then
	    echo "==== Skip compiler: $compiler"
	    continue
	fi
    fi

    ##
    ## load compiler and mpi if needed
    ##
    retcode=0 && module load ${cname}/${cversion} >/dev/null 2>&1 || retcode=$?
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
	    echo "Currently loaded: $( module -t list 2>&1 ) " >>${compilelog}
	    continue
	fi
	for m in ${modules} ; do
	    if [ $m = "mkl" -a $cname = "intel" ] ; then continue ; fi
	    module load $m >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     WARNING failed to load dependent module <<$m>>" | tee -a ${compilelog}
	    fi
	done
    fi
    echo "Running with modules: $( module -t list 2>&1 )" >>${compilelog}

    source ${package}_tests.sh

done
echo && echo "See: ${compilelog}" && echo

