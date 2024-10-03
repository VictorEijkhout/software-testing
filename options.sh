##
## include file for top level both tacc/local tests
##

function usage() {
    if [ ! -z "${help_string}" ] ; then
	echo && echo ${help_string} && echo ; fi 
    echo "Usage: $0 [ -v version (default=${version}) ]"
    echo "    [ -c compiler ] [ -l logfile ] "
    echo "    [ -r (skip running) ] [ -4 (do 4py tests) ] "
    if [ "${python_option}" = "1" ] ; then
	echo "    [ -p : python tests only ]"
    fi
    echo "    [ -x (set -x) ]"
    if [ ! -z "${extra_help}" ] ; then
	echo ${extra_help}
    fi
}
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0
fi
logfile=
matchcompiler=
## mpi= this is set in the tacc/local_tests.sh top level file
run=1
skippy=1
python=
if [ -z "${loadpackage}" ] ; then
    loadpackage=${package}
fi

while [ $# -gt 0 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-c" ] ; then
	shift && matchcompiler=$( echo "$1" | tr -d '/' ) && shift
    elif [ "$1" = "-e" ] ; then
	echo=1  && shift
    elif [ "$1" = "-l" ] ; then
	shift && logfile="$1" && shift
    elif [ "$1" = "-m" ] ; then
	## top level this is set in *_tests.sh
	## in embedded calls this is set on the commandline
	mpi=1 && shift
    elif [ "$1" = "-P" ] ; then
       shift && loadpackage=$1 && shift
    elif [ "$1" = "-r" ] ; then
	run=0 && runflag=-r && shift
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    elif [ "$1" = "-x" ] ; then
	set -x && xflag=-x && shift 
    elif [ "$1" = "-4" ] ; then
	p4pflag=-4 && skippy=0 && shift
    elif [ "${python_option}" = "1" -a "$1" = "-p" ] ; then
	# echo "(including python tests)"
	python=1 && shift
    else
	echo "ERROR: unrecognized option <<$1>>" && exit 1
    fi
done

##
## actually loaded package name
## (this is mostly for netcdff/netcdf
##
if [ -z "${loadpackage}" ] ; then
    export loadpackage=${package}
    export loadversion=${version}
fi

##
## flag to pass to cmake driver
##
if [ "${mpi}" = "1" ] ; then 
    ## this can have been set by commandline option
    ## or in the *_tests.sh file at top level
    mpiflag=-m
fi

##
## set log file for the case where we run package_tests.sh by itself
##
if [ -z "${logfile}" ] ; then
    export logdir=${package}_logs
    echo "Logging to: ${logdir}"
    mkdir -p ${logdir}
    logfile=${logdir}/${package}.log
else
    echo "Using logfile: ${logfile}"
fi

if [ ! -z "${echo}" ] ; then
    echo "compiler=$matchcompiler log=$logfile mpi=$mpi run=$run version=$version" \
	 >${logfile}
fi

