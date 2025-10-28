#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

for siestarun in 'lyp' 'pbe' 'pbesol' 'am05' 'vdw_vv' 'vdw_drsll' 'c6' 'ldau' 'dftu_soc'
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done
