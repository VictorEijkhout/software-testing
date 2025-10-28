#

siesta_subtest(save_outs LABELS simple)
siesta_subtest(save_init_rho)
siesta_subtest(s_only)
siesta_subtest(write_ncdf)
siesta_subtest(denchar)
siesta_subtest(kp_file FILES_SETUP kp_file.KP)
siesta_subtest(save_dm FILES_SETUP save_dm.DM LABELS simple)
