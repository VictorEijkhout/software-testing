##
## test all programs for this package,
## looping over locally available modules
##

module reset >/dev/null 2>&1
echo "================"
echo "==== Local modules"
echo "==== Package: ${package}, version: ${version}"
echo "================"

compilelog=local_tests_${package}-${version}.log
rm -f ${compilelog}
echo "full reporting in ${compilelog}"
for compiler in $( cat ../compilers.sh ) ; do

    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $compiler != *${matchcompiler}* ]] ; then continue ; fi
    fi

    ##
    ## load local configuration
    ##
    config=$( echo $compiler | tr -d '/' )
    ( echo && echo "==== Configuration: ${config}" ) | tee -a ${compilelog}
    envfile=${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh
    if [ ! -f "${envfile}" ] ; then
	echo "    undefined configuration for system <<${TACC_SYSTEM}>>"  | tee -a ${compilelog}
	continue
    fi
    source ${envfile}  >/dev/null 2>&1

    ## 
    ## load module and execute all tests
    ##
    module load ${package}/${version} >>${compilelog} 2>&1
    if [ $? -gt 0 ] ; then
	echo "     WARNING missing module ${package}/${version}"
	continue
    fi

    source ${package}_tests.sh

done
echo && echo "See: ${compilelog}" && echo

