defaultp=$( pwd )
defaultp=${defaultp##*/}

function usage() {
    echo "Usage: $0"
    echo "    [ -d mod1,mod2 ] [ -m ( use mpi ) ] "
    echo "    [ -p package (default: ${defaultp}) ]  [ -l logfile ] [ -x ( set x ) ]"
    echo "    [ -m : mpi mode ] [ -r : skip run ] [ -t v : test value ]"
    echo "    [ --cmake cmake options separated by commas ]"
    echo "    [ --title test caption ]"
    echo "    program.{c.F90}"
}

## echo "Invocation: $*"
if [ $# -eq 0 -o $1 = "-h" ] ; then 
    usage && exit 0
fi

source ../failure.sh
package=unknown
cmake=
fulllog=
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
	#echo "Using extra cmake flags: ${cmake}"
    elif [ "$1" = "-d" ] ; then 
	shift && modules="$1" && shift
	#echo "Using dependent modules: ${modules}"
    elif [ "$1" = "-m" ] ; then 
	shift && mpi=1
	#echo "MPI mode"
    elif [ "$1" = "-l" ] ; then 
	shift && fulllog="$1" && shift
    elif [ "$1" = "-p" ] ; then 
	shift && package="$1" && shift
    elif [ "$1" = "-r" ] ; then 
	shift && run=
    elif [ "$1" = "-t" ] ; then 
	shift && testvalue="$1" && shift
    elif [ "$1" = "--title" ] ; then
	shift && testcaption="$1" && shift
    elif [ "$1" = "-x" ] ; then 
	shift && set -x && x="-x"
    else
	break
    fi
done

##
## the leftover argument is the program
##
source=$1
if [ -z "${source}" ] ; then 
    echo "ERROR: no source file specified" && exit 1 ; fi
executable=${source%%.*}
extension=${source##*.}
if [ ! -f "${extension}/${source}" ] ; then
    echo "ERROR: no file <<${extension}/${source}>>" && exit 0
fi

##
## parameter handling
#
if [ -z "${package}" ] ; then
    package=${defaultp}
fi

##
## log file handling
##
if [ -z "${fulllog}" ] ; then
    fulllog=${executable}.log
    rm -f ${fulllog}
fi
logdir=${fulllog} && logdir=${fulllog%%/*}
if [ -z "${logdir}" ] ; then logdir="." ; fi
if [ ! -d "${logdir}" ] ; then
    echo "INTERNAL ERROR null logdir in log: ${fulllog}" && exit 1
fi
testlog="${logdir}/${source}.log"
rm -rf ${testlog} && touch ${testlog}

if [ ! -z "${testcaption}" ] ; then
    echo "---- Test: ${testcaption}" | tee -a ${testlog}
fi
