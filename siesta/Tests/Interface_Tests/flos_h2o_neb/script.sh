#!/bin/bash

LUA=lua
siestarun=flos_h2o_neb

if [ -z $LUA_PATH ]
then
  echo "Define environment variable for LUA_PATH, which must include flos."
fi

. ../../set_siesta_dir.sh "$1" $2

rm -r work
mkdir work
cd work
cp -r *.* .

echo "Running script with SIESTA=$SIESTA"

cp ../neb.lua .
cp ../image_*.xyz .
$SIESTA < ../$siestarun.fdf > $siestarun.out
