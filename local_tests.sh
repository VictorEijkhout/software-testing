module reset >/dev/null 2>&1
echo "================"
echo "==== Package: ${package}, version: ${version}"
echo "==== Local modules"
echo "================"

compilelog=local_tests.log
rm -f ${compilelog}
for compiler in $( cat ../compilers.sh ) ; do

    config=$( echo $compiler | tr -d '/' )
    ( echo && echo "==== Configuration: ${config}" ) | tee -a ${compilelog}
    envfile=${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh
    if [ ! -f "${envfile}" ] ; then
	echo "    could not load configuration"
    else
	source ${envfile}  >/dev/null 2>&1
	module load ${package}/${version} >/dev/null 2>&1
	if [ $? -gt 0 ] ; then
	    echo "    WARNING missing module ${package}/${version}"
	else
	    source ${package}_tests.sh
	fi
    fi
done
echo && echo "See: ${compilelog}" && echo

