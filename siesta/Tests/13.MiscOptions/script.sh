#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

for siestarun in 'dip_corr' 'dip_corr_vac' 'gate_charge' 'gate_hartree' 'net_charge' 'net_charge_dope' 'gcs' 'highmesh' 'filter_cutoff' 'filter_tol' 'shift_cop' 'bulk_bias' 'synth_atom'
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done
