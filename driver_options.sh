cmd_args=$*

defaultp=$( pwd )
defaultp=${defaultp##*/}

function usage() {
    echo "Usage: $0"
    echo "    [ -d mod1,mod2 ] [ -m ( use mpi ) ] "
    echo "    [ -p package (default: ${defaultp}) ] [ -v version ]"
    echo "    [ -l logfile ] [ -x ( set x ) ]"
    echo "    [ -m : mpi mode ] [ -r : skip run ] [ -4 : do python tests ]"
    echo "    [ -t / --value v : test value ]"
    if [ "${buildsystem}" = "cmake" ] ; then 
	echo "    [ --cmake cmake options separated by commas ]"
    fi
    echo "    [ --in-build-run ] [ --run-options options ]"
    echo "    [ --ldd ]"
    echo "    [ --title test caption ]"
    echo "    [ --run_args \"arg1 arg2 arg3\" ]"
    echo "    program.{c.F90}"
}

if [ $# -eq 0 -o "$1" = "-h" ] ; then 
    usage && exit 0
fi

package=unknown
loadpackage=unknown
cmake=
dir=dir
dopy=
fulllog=
inbuildrun=
runoptions=
mpi=
docuda=
ldd=
modules=
noibrun=
pkgconfig=
run=1
runargs=
testcaption=
testvalue=
version=unknownversion
x=
while [ $# -gt 1 ] ; do
    #echo "option: <<$1>>"
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
    elif [ "$1" = "--run-options" ] ; then
	shift && runoptions="$1" && shift
    elif [ "$1" = "--ldd" ] ; then
	shift && ldd=1
    elif [ "$1" = "-m" ] ; then 
	shift && mpi=1
    elif [ "$1" = "-l" ] ; then 
	shift && fulllog="$( argument $1 )" && shift
	if [ ! -f "${fulllog}" ] ; then 
	    echo "WARNING full log <<${fulllog}>> does not exist"
	fi
    elif [ "$1" = "-p" ] ; then 
	shift && package="$( argument $1 )" && shift
    elif [ "$1" = "-P" ] ; then 
	shift && loadpackage="$( argument $1 )" && shift
    elif [ "$1" = "--pkg-config" ] ; then
	shift && pkgconfig="$1" && shift
    elif [ "$1" = "-r" ] ; then 
	shift && run=
    elif [ "$1" = "--run_args" ] ; then
	shift && runargs="$1" && shift
    elif [ "$1" = "-t" -o "$1" = "--value" ] ; then 
	shift && testvalue="$1" && shift
    elif [ "$1" = "--title" ] ; then
	shift && testcaption="$( argument $1 )" && shift
    elif [ "$1" = "-u" ] ; then
	shift && docuda=1
    elif [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    elif [ "$1" = "-V" ] ; then
	shift && loadversion="$1" && shift
    elif [ "$1" = "-4" ] ; then 
	shift && dopy=1
    elif [ "$1" = "-x" ] ; then 
	shift && set -x && x="-x"
    else
	echo "Unknown option <<$1>>" && break
    fi
done

##
## Print caption before everything else
## makes it easier to see what causes an error
##
if [ ! -z "${testcaption}" ] ; then
    print_test_caption "${testcaption}" "${fulllog}"
    #echo "---- Test: ${testcaption}" | tee -a ${fulllog}
else 
    print_test_caption "Test:" "${fulllog}"
fi

##
## we need a package argument
##
if [ "${package}" = "unknown" ] ; then 
    echo "ERROR package unknown in invocation: $0 ${cmd_args}" && exit 1
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
echo " .. log=$testlog mpi=$mpi run=$run version=$version" \
     >>${testlog}

if [ ! -z "${pkgconfig}" ] ; then 
    for p in ${pkgconfig} ; do 
	echo " .. pkg config dir for ${p}: $( echo ${PKG_CONFIG_PATH} | tr ':' '\n' | grep ${p} )" \
	    >>${testlog}
	echo " .. has: $( echo ${PKG_CONFIG_PATH} | tr ':' '\n' | grep ${p} | xargs ls )" \
	    >>${testlog}
    done
fi
