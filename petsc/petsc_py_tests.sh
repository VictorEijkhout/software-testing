if [ -z "${SLURM_JOBID}" ] ; then
    echo "ERROR can only do python tests in SLURM" && exit 1
fi

if [ "$( which python3 )" = "/usr/bin/python3" ] ; then 
    echo "Loading python3 module" # >>${locallog}
    module load python3 && module list 2>/dev/null
fi

../python_test_driver.sh ${standardflags} -l ${logfile} \
			 --title "import 4py modules" \
			 importpetsc.py

../python_test_driver.sh ${standardflags} -l ${logfile} \
			 --title "Test init from argv" \
			 p4p.py 

../python_test_driver.sh ${standardflags} -l ${logfile} \
			 --title "Python allreduce" \
			 allreduce.py

