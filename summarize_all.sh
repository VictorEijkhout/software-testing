#!/bin/bash

trace=
while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	echo "$0 [ -h ] [ -t : trace ]" && exit 0
    elif [ $1 = "-t" ] ; then 
	shift && trace="-t"
    else
	echo "Unknown option <<$1>>" && exit 1 
    fi
done

for p in \
    adios2 arpack aspect boost catch2 \
    cfitsio cxxopts dealii eigen fftw2 fftw3   \
    gsl hypre jsonc libmesh metis mfem     \
    netcdf parallelnetcdf pnetcdf              \
    octopus p4est pcre2 scotch ptscotch        \
    siesta silo sqlite3 suitesparse sundials    \
    swig sz trilinos zlib                      \
    ; do 
    ( cd $p && ../summarize_package.sh ${trace} )
done

# packages with multiple versions
( cd hdf5 && ../summarize_package.sh ${trace} )
( cd hdf5 && ../summarize_package.sh -v 1.14.3 ${trace} )

( cd kokkos && ../summarize_package.sh -v 4.6.01-omp  ${trace} )
( cd kokkos && ../summarize_package.sh -v 4.6.01-cuda ${trace} )
( cd kokkos && ../summarize_package.sh -v 4.6.01-sycl ${trace} )
