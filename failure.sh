function failure() {
    if [ $1 -gt 0 ] ; then 
	echo && echo "ERROR failed $2" && echo 
    fi
}
