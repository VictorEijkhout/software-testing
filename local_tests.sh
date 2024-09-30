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

logdir=${package}_logs
fulllog=${logdir}/full.log
shortlog=tacc_tests.log
mkdir -p ${logdir}
rm -f ${fulllog}
touch ${fulllog}
touch ${shortlog}

#
# loop through compiler names without slash
#
compilers="$( for c in $( cat ../compilers.sh ) ; do echo $c | tr -d '/' ; done )"
for compiler in $compilers ; do 
    
    cname=${compiler%%[0-9]*}
    cvers=${compiler##*[a-z]}
    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $compiler != *${matchcompiler}* ]] ; then
	    echo "==== Skip compiler: $compiler" >>${fulllog}
	    continue
	fi
    fi

    ##
    ## load local configuration
    ##
    config=${cname}${cvers}
    envfile=${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh
    if [ ! -f "${envfile}" ] ; then
	echo "    undefined configuration for system <<${TACC_SYSTEM}>>" >>${fulllog}
	continue
    else
	( echo && echo "==== Configuration: ${config}" ) | tee -a ${fulllog}
    fi
    source ${envfile}  >/dev/null 2>&1
    for m in ${modules} ; do
	echo "Loading dependent module: $m" >>${fulllog}
	module load $m
    done

    ## 
    ## load module (if there is one) and execute all tests
    ##
    if [ "${loadpackage}" != "mpi" ] ; then 
	echo "Loading package:  ${loadpackage}/${version}" >>${fulllog}
	retcode=0
	module load ${loadpackage}/${version} >/dev/null 2>&1 || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    echo "     could not load ${loadpackage}/${version}" | tee -a ${fulllog}
	    echo "Currently loaded: $( module -t list 2>&1 ) " >>${fulllog}
	    continue
	fi
    fi
    echo "Running with modules: $( module -t list 2>&1 )" >>${fulllog}

    ./${package}_tests.sh -l ${fulllog} 

done | tee ${shortlog}

echo && echo "See: ${shortlog} and ${fulllog}" && echo
