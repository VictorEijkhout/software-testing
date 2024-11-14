cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

enable_language( Fortran )
add_executable( ${PROJECTNAME} ${PROJECTNAME}.F90 )

find_package( PkgConfig REQUIRED )
pkg_check_modules( NETCDF REQUIRED netcdf-fortran )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${NETCDF_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${NETCDF_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${NETCDF_LIBRARY_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC netcdf )

install( TARGETS ${PROJECTNAME} DESTINATION . )
