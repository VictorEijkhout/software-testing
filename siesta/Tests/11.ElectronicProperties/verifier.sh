#!/bin/bash

mkdir work-yaml

for siestarun in 'charge' 'coop' 'optical' 'charge_sp' 'coop_sp' 'optical_sp'
do

  python3 ../yaml_compare.py -c ../test-cfg.yml -p ../out_digest_yaml.awk -r Reference/${siestarun}.out -t work/${siestarun}/${siestarun}.out -o work-yaml/${siestarun}.yml

done
