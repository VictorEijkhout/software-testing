cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "Fortran programs for cfitsio testing"
  VERSION 1.0 )

enable_language( Fortran )
add_executable( ${PROJECTNAME} ${PROJECTNAME}.f )

find_package( PkgConfig REQUIRED )
pkg_check_modules( CFITSIO REQUIRED cfitsio )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${CFITSIOF_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${CFITSIOF_LIBRARIES} ${CFITSIO_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${CFITSIOF_LIBRARY_DIRS}	${CFITSIO_LIBRARY_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC cfitsio )

install( TARGETS ${PROJECTNAME} DESTINATION . )
