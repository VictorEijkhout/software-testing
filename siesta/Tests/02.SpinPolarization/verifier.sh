#!/bin/bash

mkdir work-yaml

for siestarun in 'fe_spin' 'fe_spin_directphi' 'fe_noncol' 'fe_noncol_gga' 'fe_noncol_kp' 'fe_noncol_sp'
do

  python3 ../yaml_compare.py -c ../test-cfg.yml -p ../out_digest_yaml.awk -r Reference/${siestarun}.out -t work/${siestarun}/${siestarun}.out -o work-yaml/${siestarun}.yml

done
