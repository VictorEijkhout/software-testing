#!/bin/bash


echo "================"
echo "cmaking"
echo "================"
rm -rf build
mkdir build
cd build
cmake \
    -D CMAKE_CXX_COMPILER=${TACC_CXX} \
    -D PROJECTNAME=bind \
    ../cxx
make

echo "================"
echo "executing"
echo "================"
python3 -c "import bind; print(bind.add(1,2))"

