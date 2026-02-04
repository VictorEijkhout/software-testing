#1/bin/bash

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                        ${p4pflag} \
			--title "have cuda" \
			--run_args "-dm_vec_type cuda" \
			has_cuda.cu

../petsc_test_driver.sh ${standardflags} -l ${logfile} \
			--title "cu example 47" \
			--run_args "-dm_vec_type cuda -da_grid_x 3000000" \
			ex47cu.cu

exit 0

if [ ! -d "c" ] ; then 
    echo "Need c directory for making" && exit 1
fi

cp scalar.c c/
cd c
make scalar
./scalar
