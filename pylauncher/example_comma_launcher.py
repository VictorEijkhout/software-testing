#!/usr/bin/env python
################################################################
####
#### This file is part of the `pylauncher' package
#### for parametric job launching
####
#### Copyright Victor Eijkhout 2010-2024
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

pylauncher.ClassicLauncher\
    ("commalines",
     # optional spec of output dir:
     workdir=f"pylauncher_tmp_comma",
     debug="host+exec+task+job")
