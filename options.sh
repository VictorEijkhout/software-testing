##
## include file for top level both tacc/local tests
##

function usage() {
    if [ ! -z "${help_string}" ] ; then
	echo && echo ${help_string} && echo ; fi 
    echo "Usage: $0 [ -v version (default=${version}) ]"
    echo "    [ -b (no ibrun) ] [ -c compiler ]"
    if [ "${python_option}" = "1" ] ; then
	echo "    [ -p : do python tests ]"
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
noibrun=
python=
while [ $# -gt 0 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-b" ] ; then
	noibrun=1 && shift
    elif [ "$1" = "-c" ] ; then
	shift && matchcompiler=$( echo "$1" | tr -d '/' ) && shift
    elif [ "$1" = "-l" ] ; then
	shift && logfile="$1" && shift
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    elif [ "${python_option}" = "1" -a "$1" = "-p" ] ; then
	python=1
    else
	echo "ERROR: unrecognized option <<$1>>" && exit 1
    fi
done
