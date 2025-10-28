#
siesta_subtest(wannier FILES_SETUP wannier.nnkp LABELS simple)

if(SIESTA_WITH_WANNIER90)
  siesta_subtest(w90-on-the-fly LABELS long)
  siesta_subtest(graphene_w90 LABELS simple)

  if (SIESTA_TESTS_MPI_NUMPROCS GREATER 2)
    set(small_test_nprocs 2)
  else()
    set(small_test_nprocs ${SIESTA_TESTS_MPI_NUMPROCS})
  endif()
  siesta_subtest(w90-chem-h2 LABELS simple MPI_NPROC ${small_test_nprocs})
endif()


