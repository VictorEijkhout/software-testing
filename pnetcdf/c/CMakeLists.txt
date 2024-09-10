cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( PkgConfig REQUIRED )
pkg_check_modules( PNETCDF REQUIRED pnetcdf )

find_package( MPI )
message( STATUS "Pnetcdf includes: ${PNETCDF_INCLUDE_DIRS}" )
message( STATUS "Pnetcdf libraries: ${PNETCDF_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${PNETCDF_INCLUDE_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${PNETCDF_LIBRARIES} )
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${PNETCDF_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC pnetcdf )

install( TARGETS ${PROJECTNAME} DESTINATION . )
