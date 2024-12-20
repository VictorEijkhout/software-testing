cmd_args=$*

defaultp=$( pwd )
defaultp=${defaultp##*/}

function usage() {
    echo "Usage: $0"
    echo "    [ -d mod1,mod2 ] [ -m ( use mpi ) ] "
    echo "    [ -p package (default: ${defaultp}) ]  [ -l logfile ] [ -x ( set x ) ]"
    echo "    [ -m : mpi mode ] [ -r : skip run ] [ -t v : test value ]"
    if [ "${buildsystem}" = "cmake" ] ; then 
	echo "    [ --cmake cmake options separated by commas ]"
    fi
    echo "    [ --in-build-run ]"
    echo "    [ --title test caption ]"
    echo "    program.{c.F90}"
}

if [ $# -eq 0 -o $1 = "-h" ] ; then 
    usage && exit 0
fi

package=unknown
loadpackage=unknown
cmake=
dir=dir
fulllog=
inbuildrun=
mpi=
modules=
noibrun=
run=1
testcaption=
testvalue=
x=
while [ $# -gt 1 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-b" ] ; then
	noibrun=1 && shift
    elif [ "$1" = "--cmake" ] ; then
	shift && cmake="$1" && shift
    elif [ "$1" = "-d" ] ; then 
	shift && modules="$1" && shift
    elif [ "$1" = "--dir" ] ; then 
	shift && dir=$( argument $1 ) && shift
    elif [ "$1" = "--in-build-run" ] ; then
	shift && inbuildrun=1
    elif [ "$1" = "-m" ] ; then 
	shift && mpi=1
	#echo "MPI mode"
    elif [ "$1" = "-l" ] ; then 
	shift && fulllog="$( argument $1 )" && shift
	if [ ! -f "${fulllog}" ] ; then 
	    echo "WARNING full log <<${fulllog}>> does not exist"
	fi
    elif [ "$1" = "-p" ] ; then 
	shift && package="$( argument $1 )" && shift
    elif [ "$1" = "-P" ] ; then 
	shift && loadpackage="$( argument $1 )" && shift
    elif [ "$1" = "-r" ] ; then 
	shift && run=
    elif [ "$1" = "-t" ] ; then 
	shift && testvalue="$1" && shift
    elif [ "$1" = "--title" ] ; then
	shift && testcaption="$( argument $1 )" && shift
    elif [ "$1" = "-x" ] ; then 
	shift && set -x && x="-x"
    else
	break
    fi
done

##
## Print caption before everything else
## makes it easier to see what causes an error
##
if [ ! -z "${testcaption}" ] ; then
    print_test_caption "${testcaption}" "${fulllog}"
    #echo "---- Test: ${testcaption}" | tee -a ${fulllog}
fi

##
## we need a package argument
##
if [ "${package}" = "unknown" ] ; then 
    echo "ERROR erroneous invocation: $0 ${cmd_args}" && exit 1
fi
if [ "${loadpackage}" = "unknown" ] ; then 
    export loadpackage=${package}
fi

##
## the leftover argument is the program
## in case of existence test this can not be directly tested
##
if [ $# -gt 1 ] ; then 
    echo "ERROR: unprocessed arguments more than just source: $*" && exit 1
elif [ $# -lt 1 ] ; then 
    echo "ERROR: no source file specified" && exit 1
else 
    source=$1
fi
executable=${source%%.*}
extension=${source##*.}

##
## parameter handling
#
if [ -z "${package}" ] ; then
    package=${defaultp}
fi

##
## log file handling
##
enforceexisting fulllog ""
logdir=${fulllog%%/*}
if [ -z "${logdir}" ] ; then logdir="." ; fi
if [ ! -d "${logdir}" ] ; then
    echo "INTERNAL ERROR null logdir in log: ${fulllog}" && exit 1
fi
testlog="${logdir}/$( echo ${source} | tr '/' '-' ).log"
rm -rf ${testlog} && touch ${testlog}

##
## Info message
##

echo "Test: buildsystem=<<$buildsystem>>, build and run, source=$source" >>${testlog}
echo "compiler=$matchcompiler log=$logfile mpi=$mpi run=$run version=$version" \
     >>${testlog}

