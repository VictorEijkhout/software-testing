##
## Kokkos tests
##
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                        ${p4pflag} \
			--title "have kokkos" \
			have_kokkos.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                        ${p4pflag} \
			--title "ksp19 kokkos" \
			--run_args "-ksp_type cg -pc_type bjkokkos -pc_bjkokkos_ksp_max_it 60 -pc_bjkokkos_ksp_type tfqmr -pc_bjkokkos_pc_type jacobi -pc_bjkokkos_ksp_rtol 1e-3 -mat_type aijkokkos" \
			ksp19kokkos.c

