#1/bin/bash

if [ ! -d "c" ] ; then 
    echo "Need c directory for making" && exit 1
fi

cp scalar.c c/
cd c
make scalar
./scalar
