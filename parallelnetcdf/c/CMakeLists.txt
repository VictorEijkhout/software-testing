##
## Cmake setup for:
## parallel version of netcdf
##
## C codes testing;
## see parallelnetcdff for Fortran tests
##
cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for parallel-netcdf testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( PkgConfig REQUIRED )
pkg_check_modules( NETCDF REQUIRED netcdf )

find_package( MPI )
message( STATUS "Netcdf includes: ${NETCDF_INCLUDE_DIRS}" )
message( STATUS "Netcdf libraries: ${NETCDF_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${NETCDF_INCLUDE_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${NETCDF_LIBRARIES} )
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${NETCDF_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC netcdf )

install( TARGETS ${PROJECTNAME} DESTINATION . )
