function usage() {
    echo "Usage: $0 [ -v version (default=${version}) ]"
}
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0
fi
while [ $# -gt 0 ] ; do
    if [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    fi
done
