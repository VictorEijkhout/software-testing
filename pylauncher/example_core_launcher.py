#!/usr/bin/env python
if not os.path.exists(commandlines):
    raise Exception( f"input does not exist: {commandlines}" )
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
################################################################

import os
import pylauncher

##
## Emulate the classic launcher, using a one liner
##

example="core"
print( f"Script: {example}_launcher\n .. running: ClassicLauncher" )
commandlines = "commandlines"
if not os.path.exists(commandlines):
    raise Exception( f"input does not exist: {commandlines}" )
print( f" .. input: {commandlines}\n" )

pylauncher.ClassicLauncher\
    (commandlines,
     cores=11,
     workdir=f"pylauncher_tmp_{example}_{ os.environ['SLURM_JOBID'] }",
     debug="job+host+exec",
     )
