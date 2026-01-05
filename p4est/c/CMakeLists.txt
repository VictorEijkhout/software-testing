cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for P4est testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( MPI )
find_package( PkgConfig REQUIRED )
pkg_check_modules( P4EST REQUIRED p4est )
pkg_check_modules( SC REQUIRED libsc )

message( STATUS "P4est includes: ${P4EST_INCLUDE_DIRS}" )
message( STATUS "P4est library dirs: ${P4EST_LIBRARY_DIRS}" )
message( STATUS "P4est libraries: ${P4EST_LIBRARIES}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${P4EST_INCLUDE_DIRS}
        ${SC_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${P4EST_LIBRARIES}
        ${SC_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${P4EST_LIBRARY_DIRS}
	${SC_LIBRARY_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC m
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
