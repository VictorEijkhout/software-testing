##
## test all programs for this package,
## looping over locally available modules
##

module reset >/dev/null 2>&1
echo "================"
echo "==== Local modules"
echo "==== Package: ${package}, version: ${version}"
echo "================"

compilelog=local_tests_${package}-${version:-none}.log
rm -f ${compilelog}
echo "full reporting in ${compilelog}"
for compiler in $( cat ../compilers.sh ) ; do

    echo | tee -a ${compilelog}
    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $( echo $compiler | tr -d '/' ) != *${matchcompiler}* ]] ; then
	    echo "==== Skipping non-matched compiler ${compiler}" | tee -a ${compilelog}
	    continue
	fi
    fi

    ##
    ## load local configuration
    ##
    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}" | tee -a ${compilelog}
    envfile=${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh
    if [ ! -f "${envfile}" ] ; then
	echo "    undefined configuration for system <<${TACC_SYSTEM}>>"  | tee -a ${compilelog}
	continue
    fi
    source ${envfile}  >/dev/null 2>&1

    ## 
    ## load module (if there is one) and execute all tests
    ##
    if [ "${package}" != "mpi" ] ; then 
	module load ${package}/${version} >>${compilelog} 2>&1
	if [ $? -gt 0 ] ; then
	    echo "     WARNING missing module ${package}/${version}"
	    continue
	fi
    fi

    source ${package}_tests.sh

done
echo && echo "See: ${compilelog}" && echo

