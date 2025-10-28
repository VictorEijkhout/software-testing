#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

for siestarun in 'cg' 'cg_vc' 'cg_vc_constantvol' 'broyden' 'broyden_vc' 'fire' 'fire_vc' 'zm_cg' 'zm_broyden' 'zm_fire'
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done

