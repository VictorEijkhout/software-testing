#!/bin/bash

package=$( cat package.sh | grep package= | cut -d '=' -f 2 )

trace=0
version=
while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	echo "$0 [ -h ] [ -t : trace ] [ -v 1.2.3 ]" && exit 0
    elif [ $1 = "-t" ] ; then 
	shift && trace=1
    elif [ $1 = "-v" ] ; then 
	shift && version=$1 && shift
    else
	echo "Unknown option <<$1>>" && exit 1 
    fi
done

echo "State of package: ${package}"
./tacc_tests.sh -r \
    $( if [ ! -z "${version}" ] ; then echo "-v ${version}" ; fi ) \
    | awk -v trace=${trace} '\
        trace==1 {print}
        /Configuration:/ {configuration = $3 }
        /could not load/ {missing = missing " " configuration }
        /failed.*compilation/ { errors = errors " " configuration }
        END { print "Missing:" missing ; print "Errors:" errors ;
            }
        ' 
    2>&1 | tee ${package}_summary.log
