#

siesta_subtest(charge LABELS simple)
siesta_subtest(coop)
siesta_subtest(optical)
siesta_subtest(charge_sp)
siesta_subtest(coop_sp)
siesta_subtest(optical_sp)

siesta_subtest(charge_partial
  NAME_ALTER charge_partial-mulliken
  LABELS simple
  EXTRA_ARGS
    "-fdf Charge.Mulliken:init+geom+scf+scf-after-mix+end"
  )

siesta_subtest(charge_partial
  NAME_ALTER charge_partial-voronoi
  LABELS simple
  EXTRA_ARGS
    # init is not available, so here just to ensure it is accepted.
    "-fdf Charge.Voronoi:geom+scf+init+end"
  )

siesta_subtest(charge_partial
  NAME_ALTER charge_partial-hirshfeld
  LABELS simple
  EXTRA_ARGS
    # init is not available, so here just to ensure it is accepted.
    "-fdf Charge.Hirshfeld:geom+scf+init+end"
  )
