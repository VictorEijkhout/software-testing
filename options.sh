##
## include file for top level both tacc/local tests
## also loaded in ${package}_tests.sh
##

source ../functions.sh

function usage() {
    if [ ! -z "${help_string}" ] ; then
	echo && echo ${help_string} && echo ; fi 
    echo "Usage: $0 [ -v version (default=${version}) ]"
    echo "    [ -c compiler ] [ -l logfile ] [ -r (skip running) ] "
    echo "    [ -4 (do 4py tests) ] [ -u (do cuda tests) ]"
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

#
# logfile is null in tacc/local_tests, but pass in package_tests
#
logfile=

matchcompiler=
## mpi= this is set in the tacc/local_tests.sh top level file
run=1
docuda=
skipcu=1
skippy=1
python=

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
    elif [ "$1" = "-p" ] ; then
       shift && package=$1 && shift
    elif [ "$1" = "-P" ] ; then
       shift && loadpackage=$1 && shift
    elif [ "$1" = "-r" ] ; then
	run= && runflag=-r && shift
    elif [ "$1" = "-u" ] ; then
	shift && docuda=1 && skipcu=0 && cudaflag=-u
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    elif [ "$1" = "-x" ] ; then
	set -x && xflag=-x && shift 
    elif [ "$1" = "-4" ] ; then
	p4pflag=-4 && skippy=0 && shift
    else
	echo "ERROR: unrecognized option <<$1>>" && exit 1
    fi
done

##
## Package is set by package.sh at top level,
## or through the "-p" option in package_tests.sh
##
enforcenonzero package "${logfile}"

##
## actually loaded package name
## (this is mostly for netcdff/netcdf)
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

#
# logfile is null in tacc/local_tests, but pass in package_tests
#
if [ -z "${logfile}" ] ; then 
    logdir=${package}_logs
    mkdir -p ${logdir}
    logfile=${logdir}/full.log
    rm -f ${logfile}
    touch ${logfile}
    echo "Using logfile: ${logfile}"
fi
if [ ! -f "${logfile}" ] ; then 
    echo "ERROR could not find logfile <<${logfile}>>" && exit 1
fi

echo "compiler=$matchcompiler log=$logfile mpi=$mpi run=$run version=$version" \
     >>${logfile}

export standardflags
function set_flags () {
    if [ "${run}" != "1" ] ; then
	runflag=-r
    fi

    if [ ! -z "${mpi}" ] ; then
	mpiflag=-m
    fi

    if [ -z "${logfile}" ] ; then
	locallog=1
	logfile=${package}.log
    fi
    # command_args have been set in the calling environment
    echo "Invoking ${package} tests: ${command_args}" >> ${logfile}
    standardflags="${mpiflag} ${cudaflag} ${runflag} ${xflag} -p ${package} -P ${loadpackage} -l ${logfile}"
    #echo " .. running with standardflags=<<${standardflags}>>"
}
