cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "Fortran programs for Pnetcdf testing"
  VERSION 1.0 )

enable_language( Fortran )
add_executable( ${PROJECTNAME} ${PROJECTNAME}.F90 )

find_package( MPI REQUIRED )
find_package( PkgConfig REQUIRED )
pkg_check_modules( NETCDFF REQUIRED netcdf-fortran )
pkg_check_modules( NETCDF REQUIRED netcdf )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${NETCDFF_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${NETCDFF_LIBRARIES} ${NETCDF_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${NETCDFF_LIBRARY_DIRS}	${NETCDF_LIBRARY_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC netcdf )

install( TARGETS ${PROJECTNAME} DESTINATION . )
