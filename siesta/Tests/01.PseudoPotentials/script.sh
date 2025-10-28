#!/bin/sh

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

for pseudos in 'psf' 'full.psml' 'sl.psml' 'soft.psml' 'soft-full.psml' 'reparam' 'reparam-rgoff'
do
  mkdir $pseudos
  cd $pseudos

  $SIESTA < ../../$pseudos.fdf > $pseudos.out

  cd ..
done
