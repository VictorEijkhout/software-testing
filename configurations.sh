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
    if [ "${loadpackage}" != "none" ] ; then
	configs=$( module -t spider ${loadpackage}/${loadversion} 2>&1 | cut -d ' ' -f 1 | sort -u )
	#echo $configs
	nconfigs=$( echo ${configs} | wc -w )
	#echo $nconfigs
    fi
}
