################################################################
####
#### functions.sh : include file for utility functions
####
################################################################

function enforcenonzero () {
    eval v=\${$1}
    #echo "variable <<$1>> has value <<$v>>"
    if [ -z "$v" ] ; then 
	msg="ERROR variable <<$1>> is null"
	if [ ! -z "$2" ] ; then 
	    echo "$msg" | tee -a $2
	else 
	    echo "$msg"
	fi
	exit 1
    fi
}

function enforceexisting () {
    eval v=\${$1}
    #echo "variable <<$1>> has value <<$v>>"
    if [ ! -f "$v" ] ; then 
	msg="ERROR file <<$1>> not found"
	if [ ! -z "$2" ] ; then 
	    echo "$msg" | tee -a $2
	else 
	    echo "$msg"
	fi
	exit 1
    fi
}

