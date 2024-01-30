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
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1
    module load ${package}/${version} >/dev/null 2>&1
    if [ $? -eq 0 ] ; then

	source ${package}_tests.sh

    else
	echo "WARNING could not load ${package}/${version}"
    fi
done
echo && echo "See: ${compilelog}" && echo

