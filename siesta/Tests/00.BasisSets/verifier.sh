#!/bin/bash

mkdir work-yaml

for basis in 'default_basis' 'fireballs' 'nodes' 'bessel' 'bessel_rich' 'custom_softbasis' 'charge_confinement' 'ghost_atom'
do

  python3 ../yaml_compare.py -c ../test-cfg.yml -p ../out_digest_yaml.awk -r Reference/${basis}.out -t work/${basis}/${basis}.out -o work-yaml/${basis}.yml

done
