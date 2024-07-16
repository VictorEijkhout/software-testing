##
## include file for top level both tacc/local tests
##

function usage() {
    if [ ! -z "${help_string}" ] ; then
	echo && echo ${help_string} && echo ; fi 
    echo "Usage: $0 [ -v version (default=${version}) ]"
    echo "    [ -c compiler ] [ -l logfile ] "
    echo "    [ -r (skip running) ] [ -x (set -x) ]"
    if [ "${python_option}" = "1" ] ; then
	echo "    [ -p : python tests only ]"
    fi
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
	mpi=1 && mpiflag=-m && shift
    elif [ "$1" = "-r" ] ; then
	run=0 && runflag=-r && shift
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    elif [ "$1" = "-x" ] ; then
	set -x && xflag=-x && shift 
    elif [ "${python_option}" = "1" -a "$1" = "-p" ] ; then
	# echo "(including python tests)"
	python=1 && shift
    else
	echo "ERROR: unrecognized option <<$1>>" && exit 1
    fi
done

if [ ! -z "${echo}" ] ; then
    echo "compiler=$matchcompiler log=$logfile mpi=$mpi run=$run version=$version" \
	 >${logfile}
fi

