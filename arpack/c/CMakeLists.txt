cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for Arpack testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( PkgConfig REQUIRED )
pkg_check_modules( HDF REQUIRED hdf5 )
message( STATUS "Hdf5 includes: ${HDF_INCLUDE_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${HDF_INCLUDE_DIRS}
	)

set( BLA_VENDOR "Intel10_64lp_seq" )
find_package( BLAS REQUIRED )      

# set( MKL_ARCH "intel64" )
# set( MKL_THREADING "sequential" )
# set( MKL_INTERFACE "lp64" )
# find_package( MKL CONFIG REQUIRED PATHS $ENV{MKLROOT} )

# find_package( MKL CONFIG REQUIRED )

target_compile_options(
        ${PROJECTNAME} PUBLIC
        $<TARGET_PROPERTY:MKL::MKL,INTERFACE_COMPILE_OPTIONS> )
target_include_directories(
        ${PROJECTNAME} PUBLIC
        $<TARGET_PROPERTY:MKL::MKL,INTERFACE_INCLUDE_DIRECTORIES> )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        $<LINK_ONLY:MKL::MKL>)

## find_package( OpenMP REQUIRED )

install( TARGETS ${PROJECTNAME} DESTINATION . )
