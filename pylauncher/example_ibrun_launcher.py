#!/usr/bin/env python
################################################################
####
#### This file is part of the `pylauncher' package
#### for parametric job launching
####
#### Copyright Victor Eijkhout 2010-2025
#### eijkhout@tacc.utexas.edu
####
#### https://github.com/TACC/pylauncher
####
#### Example of the pylauncher with MPI jobs.
####
################################################################

import os
import pylauncher 

##
## spawn a bunch of MPI parallel jobs, with a core count
## that is constant, specified here.
##
example="ibrun"
print( f"Script: {example}_launcher\n .. running: IbrunLauncher" )
commandlines = "parallellines"
if not os.path.exists(commandlines):
    raise Exception( f"input does not exist: {commandlines}" )
print( f" .. input: {commandlines}\n" )

pylauncher.IbrunLauncher\
    ( commandlines,cores=3,
      workdir=f"pylauncher_tmp_{example}_{ os.environ['SLURM_JOBID'] }",
      debug="job+host+task+exec")
