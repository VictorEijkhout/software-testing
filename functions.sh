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
    case "$1" in 
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
	    found=0
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
	    retcode=0
	    module load $m >/dev/null 2>&1 || retcode=$?
	    if [ $retcode -gt 0 ] ; then
		echo "     WARNING failed to load dependent module <<$m>>"
	    fi
	fi
    done
    if [ ! -z "${docuda}" ] ; then
	echo "Loading CUDA" >>${logfile}
	module load cuda
    fi
}

#
# options for the build_sing.sh
#
function parse_build_options () {

    if [ $# -eq 1 -a "$1" = "-h" ] ; then
	build_usage && exit 0 
    fi

    while [ $# -gt 1 ] ; do
	#echo " .. parse option <<$1>>"
	if [ $1 = "-p" ] ; then 
	    shift && package=$1 && shift
	elif [ $1 = "--cmake" ] ; then
	    shift && cmake=$1 && shift
	    echo "Cmake flags: ${cmake}"
	elif [ $1 = "-m" ] ; then
	    shift && mpi=1
	elif [ $1 = "-v" ] ; then
	    shift && variant=$1 && shift 
	elif [ $1 = "-x" ] ; then
	    shift && set -x
	else
	    echo "ERROR unknown option <<$1>>" && exit 1
	fi
    done

    if [ $# -eq 0 ] ; then
	echo "Source file missing from invocation: $0 ${cmd_args}"
	build_usage && exit 1
    fi

    program=$1
    base=${program%.*}
    lang=${program#*.}
    if [ "${variant}" = "default" ] ; then
	variant=${lang}
    fi

    if [ ! -d "${variant}" ] ; then
	echo "ERROR no language directory <<${variant}>>" && return 1
    fi

}

#
# compilers
#
function set_compilers () {
    if [ ! -z "${mpi}" ] ; then 
	export CC=mpicc
	export FC=mpif90
	export CXX=mpicxx
    elif [ ! -z "${TACC_CCC}" ] ; then 
	export CC=${TACC_CC}
	export CXX=${TACC_CXX}
	export FC=${TACC_FC}
    else
	case ${TACC_FAMILY_COMPILER} in
	    ( gcc ) export CC=gcc && export CXX=g++ && export FC=gfortran ;;
	    ( intel ) v=${TACC_FAMILY_COMPILER_VERSION}
	    v=${v%%.*}
	    if [ ${v} -gt 20 ] ; then
	        export CC=icx && export CXX=icpx && export FC=ifx 
	    else 
	        export CC=icc && export CXX=icpc && export FC=ifort 
            fi ;; 
	    ( nvidia ) export CC=nvc && export CXX=nvc++ && export FC=nvfortran ;;
	    ( * ) echo "ERROR unhandled compiler family: <<${TACC_FAMILY_COMPILER}>>" && exit 1 ;; 
	esac
    fi
    case ${lang} in
	( c ) export compiler=${CC} ;;
	( cu ) export compiler=${CC} ;;
	( cxx ) export compiler=${CXX} ;;
	( F90 ) export compiler=${FC} ;;
    esac
}    

#
# run
#
function run_executable () {

    runlog=${logdir}/${executable}_run.log
    rm -f ${runlog}
    if [ -z "${mpi}" ] ; then
	if [ ! -z "${inbuildrun}" ] ; then 
	    cmdline="( cd build && ./${executable} )"
	else
	    cmdline="./build/${executable}"
	fi
    else
	cmdline="ibrun -np 1 ./build/${executable}"
    fi
    echo "Running: $cmdline" >>${testlog}
    eval $cmdline  >>${runlog} 2>&1 || retcode=$?
    failure $retcode "${executable} test run" | tee -a ${testlog}

    if [ $retcode -eq 0 ] ; then
	if [ ! -z "${testvalue}" ] ; then
	    lastline=$( cat ${runlog} | grep -v TACC | tail -n 1 )
	    if [[ "${lastline}" = *${testvalue}* ]] ; then
		echo "     correct output: ${lastline}"
	    else
		echo "     ERROR output: ${lastline} s/b ${testvalue}"
	    fi
	fi
    fi | tee -a ${testlog}
    ( echo ">>>> runlog:" && cat ${runlog} && echo ".... runlog" ) >>${testlog}

}

function build_usage () {
    echo "Usage: $0 [ -m moduleversion ] [ -p package ]  [ -v variant ] [ -x (set -x) ]"
    if [ "${buildsystem}" = "cmake" ] ; then 
	echo "    [ --cmake cmake options separated by commas ]"
    fi
    echo "    program.c/cxx/cu/F90" 
}

function build_final_report () {
    if [ ${retcode} -ne 0 ] ; then 
	echo
	echo "    ERROR compilation failed program=${program} and ${package}/${v}"
	echo
	exit ${retcode}
    fi
    echo "    SUCCESS"
}
