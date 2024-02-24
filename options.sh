function usage() {
    echo "Usage: $0 [ -v version (default=${version}) ]"
    echo "    [ -c compiler ]"
    if [ ! -z "${extra_help}" ] ; then echo ${extra_help} ; fi
}
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0
fi
compiler=
while [ $# -gt 0 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-c" ] ; then
	shift && compiler="$1" && shift
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    fi
done
