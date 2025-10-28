#!/bin/bash
. ../../set_siesta_dir.sh "$1" $2

rm -r work
mkdir work
cd work
cp -r *.* .

echo "Running script with SIESTA=$SIESTA"

for siestarun in 'sih-pexsi' 'sih-pexsi-spin'
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../$siestarun.fdf > $siestarun.out

  cd ..
done
