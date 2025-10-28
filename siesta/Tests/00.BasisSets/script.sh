#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2

echo "Running script with SIESTA=$SIESTA"

for basis in 'default_basis' 'fireballs' 'nodes' 'bessel' 'bessel_rich' 'custom_softbasis' 'charge_confinement' 'ghost_atom'
do
  mkdir $basis
  cd $basis

  $SIESTA < ../../$basis.fdf > $basis.out

  cd ..
done
