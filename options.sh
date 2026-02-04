 ##
## include file for top level both tacc/local tests
## also loaded in ${package}_tests.sh
##

source ../functions.sh

function usage() {
    if [ ! -z "${help_string}" ] ; then
	echo && echo ${help_string} && echo ; fi 
    echo "Usage: $0 [ -v version (default=${version}) ] [ -V loadversion (default: version) ]"
    echo "    [ -c compiler ] [ -l logfile ] [ -r (skip running) ] "
    echo "    [ -4 (do 4py tests) ] [ -f : skip fortran ]"
    echo "    [ -o : openmp mode ] [ -u (do cuda tests) ]"
    if [ "${python_option}" = "1" ] ; then
	echo "    [ -p : python tests only ]"
    fi
    echo "    [ -x (set -x) ]"
    echo "    [ --cmake_version 1.2.3 ]"
    echo "    [ --mvapich ]"
    if [ ! -z "${optional_help}" ] ; then
	echo "    ${optional_help}"
    fi
}
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0
fi

#
# logfile is null in tacc/local_tests, but pass in package_tests
#
logfile=

# do not set matchcompiler other than through commandline options;
# this way it can be set in the package.sh
## matchcompiler=

## mpi= this is set in the tacc/local_tests.sh top level file
run=1
docuda=
dofortran=1
mvapich=
omp=
skipcu=1
# by default don't do python tests
dopy=
cmakeversion=
python=

while [ $# -gt 0 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-c" ] ; then
	shift && matchcompiler=$( echo "$1" | tr -d '/' ) && shift
    elif [ "$1" = "-e" ] ; then
	echo=1  && shift
    elif [ "$1" = "-f" ] ; then
	dofortran=  && shift
    elif [ "$1" = "-l" ] ; then
	shift && logfile="$1" && shift
    elif [ "$1" = "-m" ] ; then
	## top level this is set in *_tests.sh
	## in embedded calls this is set on the commandline
	mpi=1 && shift
    elif [ "$1" = "--mvapich" ] ; then
	mvapich=1 && shift
    elif [ "$1" = "-o" ] ; then
	omp=$1 && shift
    elif [ "$1" = "-p" ] ; then
       shift && package=$1 && shift
    elif [ "$1" = "-P" ] ; then
       shift && loadpackage=$1 && shift
    elif [ "$1" = "-r" ] ; then
	run="" && shift
    elif [ "$1" = "-u" ] ; then
	shift && docuda=1 && skipcu=0 && cudaflag="-u"
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    elif [ "$1" = "-V" ] ; then
	shift && loadversion="$1" && shift
    elif [ "$1" = "-x" ] ; then
	set -x && xflag="-x" && shift 
    elif [ "$1" = "--cmake_version" ] ; then
	shift && cmakeversion=$1 && shift
    elif [ "$1" = "-4" ] ; then
	p4pflag="-4" && dopy=1 && shift
    elif [[ "${optional_flags}" = *$1* ]] ; then
	# echo " .. parsing extra flag <<$1>>"
	flag=$1 && flag=${flag##*\-}
	extra_flags="${extra_flags} --${flag}"
	eval ${flag}=1
	shift
    else
	echo "ERROR: unrecognized option <<$1>>" && exit 1
    fi
done

echo "Testing $package/$version, loaded as $loadpackage/$loadversion"

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
fi
if [ -z "${loadversion}" ] ; then
    export loadversion=${version}
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
    if [ -z "${run}" ] ; then
	runflag="-r"
    fi

    if [ ! -z "${dofortran}" ] ; then fortranflag="-f"; fi
    if [ ! -z "${mpi}" ]       ; then mpiflag="-m"    ; fi
    if [ ! -z "${omp}" ]       ; then ompflag="-o"    ; fi

    if [ -z "${logfile}" ] ; then
	locallog=1
	logfile=${package}.log
    fi
    # command_args have been set in the calling environment
    echo "Invoking package=${package} tests: ${command_args}" >> ${logfile}
    standardflags="\
	${ompflag} ${mpiflag} ${cudaflag} ${p4pflag} ${runflag} ${xflag} -p ${package} -P ${loadpackage} -v ${version} -V ${loadversion} \
    	$( if [ ! -z "${cmakeversion}" ] ; then echo  --cmake_version ${cmakeversion} ; fi ) \
	"
    echo " .. running with standardflags=<<${standardflags}>>" >> ${logfile}
}
set_flags
