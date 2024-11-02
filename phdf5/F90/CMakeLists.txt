cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

enable_language( Fortran )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.F90 )

find_package( MPI REQUIRED COMPONENTS Fortran )
## find_package( PkgConfig REQUIRED )
## pkg_check_modules( HDF REQUIRED hdf5 )
## message( STATUS "Hdf5 includes: ${HDF_INCLUDE_DIRS}" )

## target_include_directories(
##         ${PROJECTNAME} PUBLIC
##         ${HDF_INCLUDE_DIRS}
## 	)
find_package( HDF5 REQUIRED COMPONENTS C Fortran )
target_link_libraries(
    ${PROJECTNAME} PUBLIC
    hdf5::hdf5_fortran
)

install( TARGETS ${PROJECTNAME} DESTINATION . )
