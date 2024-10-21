################################################################
####
#### functions.sh : include file for utility functions
####
################################################################

function enforcenonzero () {
    eval v=\${$1}
    #echo "variable <<$1>> has value <<$v>>"
    if [ -z "$v" ] ; then 
	msg="ERROR variable <<$1>> is null"
	if [ ! -z "$2" ] ; then 
	    echo "$msg" | tee -a $2
	else 
	    echo "$msg"
	fi
	exit 1
    fi
}

function enforceexisting () {
    eval v=\${$1}
    #echo "variable <<$1>> has value <<$v>>"
    if [ ! -f "$v" ] ; then 
	msg="ERROR file <<$1>> not found"
	if [ ! -z "$2" ] ; then 
	    echo "$msg" | tee -a $2
	else 
	    echo "$msg"
	fi
	exit 1
    fi
}

function print_test_caption() {
    caption=$1
    log=$2
    if [ ! -z "${caption}" ] ; then
	if [ ! -f "${log}" ] ; then 
	    echo "ERROR in print_test_caption: logfile <<${log}>> does not exist"
	else
	    echo "---- Test: ${caption}" | tee -a ${log}
	fi
    fi
}

function argument () {
    case $1 in 
	( -* ) echo "WARNING option argument <<$1> start with hyphen" ;;
    esac
    echo $*
}

#
# parse compiler name and version;
# this is used in both tacc & local tests
#
function compiler_name_and_version () {
    cname=${compiler%%[0-9]*}
    cversion=${compiler##*[a-z]}
    if [ ! -z "${matchcompiler}" ] ; then 
	if [[ $compiler != *${matchcompiler}* ]] ; then
	    echo "==== Skip compiler: $compiler" >>${logfile}
	    continue
	fi
    fi
}

#
# load prerequisite modules
#
function load_dependencies () {
    for m in ${modules} ; do
	if [ $m = "mkl" ] ; then
	    if [ "${TACC_SYSTEM}" = "vista" ] ; then
		echo "Loading mkl substitute nvpl for vista system" >>${logfile}
		module load nvpl
	    elif [ $cname = "intel" ] ; then
		echo "Ignoring mkl load for intel compiler" >>${logfile}
		continue
	    else
		echo "Loading mkl" >>${logfile}
		module load mkl
	    fi
	else
	    echo "Loading dependent module: $m" >>${logfile}
	    module load $m >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     WARNING failed to load dependent module <<$m>>"
	    fi
	fi
    done
}
