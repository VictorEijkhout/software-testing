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

echo "State of package: ${package} " \
    $( if [ ! -z "${version}" ] ; then echo "version=${version}" ; fi )
./tacc_tests.sh -r \
    $( if [ ! -z "${version}" ] ; then echo "-v ${version}" ; fi ) \
    | awk -v trace=${trace} '\
        trace==1 {print}
        /Configuration:/ {configuration = $3 }
        /not installed here/ {missing["all"]=1 }
        /could not load/ {missing[configuration]=1 }
        /failed.*compilation/ { errors[configuration]=1 }
        END { mcount=0 ; for ( mkey in missing ) mcount++ ;
              if (mcount>0) { printf("Missing:") ; for (mkey in missing) printf(" %s",mkey) ; printf("\n"); }
              ecount=0 ; for ( ekey in errors ) ecount++ ;
              if (ecount>0) { printf("Errors:") ; for (ekey in errors) printf(" %s",ekey) ; printf("\n"); }
            }
        ' 
    2>&1 | tee ${package}_summary.log
