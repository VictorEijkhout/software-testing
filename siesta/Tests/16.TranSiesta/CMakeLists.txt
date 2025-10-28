siesta_subtest(ts_n_terminal_elec_x LABELS simple
  FIXTURES_SETUP ts_elec_chain_x
  # Return values
  TEST_WORKING_DIRECTORY elec_chain_x_WDIR
)
siesta_subtest(ts_n_terminal_elec_z LABELS simple
  FIXTURES_SETUP ts_elec_chain_z
  # Return values
  TEST_WORKING_DIRECTORY elec_chain_z_WDIR
)


if( SIESTA_WITH_NCDF )

  # TranSiesta run + TBtrans for n_terminal_3
  siesta_subtest(ts_n_terminal_3
    FILES_SETUP
      "${elec_chain_x_WDIR}/ts_n_terminal_elec_x.TSHS"
      "${elec_chain_z_WDIR}/ts_n_terminal_elec_z.nc"
    FIXTURES_SETUP ts_n_terminal_3
    FIXTURES_REQUIRED ts_elec_chain_x ts_elec_chain_z
    # Return values
    TEST_WORKING_DIRECTORY n_terminal_3_WDIR
    FILES_CLEANUP ts_n_terminal_3.TSDE ts_n_terminal_3.TSGFel-1 ts_n_terminal_3.TSGFel-3 ts_n_terminal_3.TSGFel-4
  )
  siesta_subtest(ts_n_terminal_3 NAME_ALTER ts_n_terminal_3_tbt
    EXEC ${PROJECT_NAME}.tbtrans
    FILES_SETUP
      "${elec_chain_x_WDIR}/ts_n_terminal_elec_x.TSHS"
      "${elec_chain_z_WDIR}/ts_n_terminal_elec_z.nc"
      # Explicitly test the full reading of TSHS file
      "${n_terminal_3_WDIR}/ts_n_terminal_3.TSHS"
    # This requires the TS test to have runned, but the FIXTURE there depends on another
    FIXTURES_REQUIRED ts_n_terminal_3
    FILES_CLEANUP ts_n_terminal_3.TBT.nc
  )

endif()

# TranSiesta run + TBtrans for ts_chain
siesta_subtest(ts_chain
  FILES_SETUP
    "${elec_chain_x_WDIR}/ts_n_terminal_elec_x.HSX"
  FIXTURES_SETUP ts_chain
  FIXTURES_REQUIRED ts_elec_chain_x
  TEST_WORKING_DIRECTORY chain_WDIR
  FILES_CLEANUP ts_chain.TSDE ts_chain.TSGFhigh ts_chain.TSGFlow
)
siesta_subtest(ts_chain NAME_ALTER ts_chain_tbt
  EXEC ${PROJECT_NAME}.tbtrans
  FILES_SETUP
    "${elec_chain_x_WDIR}/ts_n_terminal_elec_x.HSX"
    "${chain_WDIR}/ts_chain.TS.HSX"
  # This requires the TS test to have runned, but the FIXTURE there depends on another
  FIXTURES_REQUIRED ts_chain
  FILES_CLEANUP ts_chain.TBT.nc
)
