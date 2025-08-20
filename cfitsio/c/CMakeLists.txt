##
## General test configuration for Cfitsio C programs
##
cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for Cfitsio testing"
  VERSION 1.0 LANGUAGES C )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( PkgConfig REQUIRED )
pkg_check_modules( CFITSIO REQUIRED cfitsio )

message( STATUS "Cfitsio includes: ${CFITSIO_INCLUDE_DIRS}" )
message( STATUS "Cfitsio libraries: ${CFITSIO_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${CFITSIO_INCLUDE_DIRS} )
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${CFITSIO_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC cfitsio m )

install( TARGETS ${PROJECTNAME} DESTINATION . )
