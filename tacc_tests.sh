##
## Include file to
## test all programs for this package,
## looping over tacc available modules
##
## options have been set by options.sh at top level
##

if [ -z "${package}" ] ; then
    echo "You are calling the general tacc_tests.sh without setting package"
    exit 1
fi

module reset >/dev/null 2>&1
echo "================"
echo "==== TACC modules"
echo "==== Testing: ${package}/${version}"
echo "==== available packages: $( module -t spider ${package}/${version} 2>&1 )"
echo "================"

logdir=tacc_logs
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
    
    # split into name and version
    cname=${compiler%%[0-9]*}
    cversion=${compiler##*[a-z]}
    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $compiler != *${matchcompiler}* ]] ; then
	    echo "==== Skip compiler: $compiler" >>${fulllog}
	    continue
	fi
    fi

    ##
    ## load compiler and mpi if needed
    ##
    echo "==== Configuration: ${compiler}" | tee -a ${fulllog}
    echo "Loading compiler: ${cname}/${cversion}"  >>${fulllog}
    retcode=0 && module load ${cname}/${cversion} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo ".... unknown configuration on this machine" | tee -a ${fulllog}
	continue
    fi
    if [ ! -z "${mpi}" ] ; then
	module load impi >/dev/null 2>&1 || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    echo "     No MPI available" >>${fulllog}
	    continue
	fi
    fi 
    for m in ${modules} ; do
	echo "Loading dependent module: $m" >>${fulllog}
	module load $m
    done

    ##
    ## load module and execute all tests
    ##
    if [ "${package}" != "none" ] ; then 
	echo "Loading package:  ${package}/${version}" >>${fulllog}
	module load ${package}/${version} >/dev/null 2>&1 || retcode=$?
	if [ $retcode -gt 0 ] ; then
	    echo "     could not load ${package}/${version}" | tee -a ${fulllog}
	    echo "Currently loaded: $( module -t list 2>&1 ) " >>${fulllog}
	    continue
	fi
	for m in ${modules} ; do
	    if [ $m = "mkl" -a $cname = "intel" ] ; then continue ; fi
	    module load $m >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     WARNING failed to load dependent module <<$m>>"
	    fi
	done
    fi
    echo "Running with modules: $( module -t list 2>&1 )" >>${fulllog}
    echo "$( module -t list 2>&1 | awk '{m=m FS $1} END {print m}' )"
    echo "----------------"

    ./${package}_tests.sh \
      -e \
      $( if [ ! -z "${mpi}" ] ; then echo -m ; fi ) \
      $( if [ -z "${run}" ] ; then echo -r ; fi ) \
      -l ${fulllog} 

done | tee ${shortlog}

echo && echo "See: ${shortlog} and ${fulllog}" && echo
