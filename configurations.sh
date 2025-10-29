function package_header () {
    echo "================" 
    echo "==== TACC modules"
    if [ "${package}" = "${loadpackage}" ] ; then
	echo "==== Testing: ${package}/${version}"
    else
	echo "==== Testing: ${package}/${version} from ${loadpackage}/${loadversion}"
    fi
    echo "================"
    echo
}

function list_configurations () {
    local package=$1
    local version=$2
    local compiler=$3
    if [ "${package}" != "none" ] ; then
	module -t spider ${package}/${version} 2>/dev/null
	if [ $? -eq 0 ] ; then 
	    if [ ! -z "$compiler" ] ; then
		configs=$( module -t spider ${package}/${version} 2>&1 \
			       | grep $compiler \
			       | cut -d ' ' -f 1 | sort -u )
	    else
		configs=$( module -t spider ${package}/${version} 2>&1 \
			       | cut -d ' ' -f 1 | sort -u )
	    fi
	    #echo "configs: ${configs}"
	    nconfigs=$( echo ${configs} | wc -w )
	    configs=$( echo ${configs} | paste -sd ' ' )
	else
	    nconfigs=0 && configs=""
	fi
    fi
}

function report_configurations () {
    if [ ! -z "${logfile}" ] ; then 
	echo "testing $nconfigs installations: ${configs}"
    else 
	echo "testing $nconfigs installations: ${configs}" | tee ${logfile}
    fi
}
