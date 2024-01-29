cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( PkgConfig REQUIRED )
pkg_check_modules( NETCDF REQUIRED netcdf )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${NETCDF_INCLUDE_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${NETCDF_LIBRARIES} )
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${NETCDF_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC netcdf )

install( TARGETS ${PROJECTNAME} DESTINATION . )
