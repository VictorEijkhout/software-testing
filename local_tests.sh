##
## test all programs for this package,
## looping over locally available modules
##

if [ -z "${package}" ] ; then
    echo "You are calling the general local_tests.sh without setting package"
    exit 1
fi

module reset >/dev/null 2>&1
echo "================"
echo "==== Local modules"
echo "==== Package: ${package}, version: ${version}"
echo "================"

compilelog=local_tests_${package}-${version:-none}.log
rm -f ${compilelog}

#
# compiler names without slash
#
compilers="$( for c in $( cat ../compilers.sh ) ; do echo $c | tr -d '/' ; done )"
for compiler in $compilers ; do 
    
    cname=${compiler%%[0-9]*}
    cvers=${compiler##*[a-z]}
    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $compiler != *${matchcompiler}* ]] ; then
	    echo "==== Skip compiler: $compiler"
	    continue
	fi
    fi

    ##
    ## load local configuration
    ##
    config=${cname}${cvers}
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
