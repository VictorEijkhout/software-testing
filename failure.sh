################################################################
####
#### failure.sh : include file for regression tests
####
################################################################

function failure() {
    if [ $1 -gt 0 ] ; then 
	echo ">>>> ERROR failed $2"
	case $1 in
	    ( 10 ) echo "    (failure to load module)" ;;
	    ( 11 ) echo "    (failure to compile)" ;;
	    ( 12 ) echo "    (runtime failure)" ;;
	esac
    else
	echo "     $2"
    fi
}
