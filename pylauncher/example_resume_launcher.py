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
import pylauncher as launcher

##
## Emulate the classic launcher, using a one liner
##

launcher.ClassicLauncher\
    ("queuestate314",
     resume=1,
     debug="host+exec+job")

