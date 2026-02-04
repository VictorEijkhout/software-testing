##
## Test configuration for Petsc C programs
##
cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for PETSc testing"
  VERSION 1.0 LANGUAGES C )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( MPI REQUIRED COMPONENTS C )
message( STATUS "MPI includes: ${MPI_C_INCLUDE_DIRS}" )

find_package( PkgConfig REQUIRED )
pkg_check_modules( PETSC REQUIRED petsc )
message( STATUS "PETSc includes: ${PETSC_INCLUDE_DIRS}" )
message( STATUS "PETSc libraries: ${PETSC_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${PETSC_INCLUDE_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC MPI::MPI_C
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${PETSC_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC petsc m )

option( USESLEPC "Enable slepc testing" OFF)
if( DEFINED USESLEPC )
  message( STATUS "CMake also linking to SLEPc" )
  target_link_libraries(
    ${PROJECTNAME} PUBLIC slepc m )
endif()

install( TARGETS ${PROJECTNAME} DESTINATION . )
