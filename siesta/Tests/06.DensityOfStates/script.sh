#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

for siestarun in 'ldos' 'pdos_g' 'pdos_k' 'pdos_kp' 'pdos_kp_pol' 'pdos_kp_nc' 'pdos_kp_soc'
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done

