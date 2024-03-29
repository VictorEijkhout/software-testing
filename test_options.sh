##
## this gets included in all package/package_tests.sh files
##

package=$( pwd )
package=${package##*/}

while [ $# -gt 0 ] ; do
    if [ $1 = "-l" ] ; then
	shift && logfile=$1 && shift
    fi
done

