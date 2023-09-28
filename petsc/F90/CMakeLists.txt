##
## General test configuration for Petsc Fortran programs
##
cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

enable_language( Fortran )
add_executable( ${PROJECTNAME} ${PROJECT_NAME}.F90 )

find_package( MPI )
find_package( PkgConfig REQUIRED )
pkg_check_modules( PETSC REQUIRED petsc )

message( STATUS "PETSc includes: ${PETSC_INCLUDE_DIRS}" )
message( STATUS "PETSc libraries: ${PETSC_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_Fortran_INCLUDE_DIRS} 
        ${PETSC_INCLUDE_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_Fortran_LIBRARIES} 
        ${PETSC_Fortran_LIBRARIES} )
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${PETSC_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC petsc )

install( TARGETS ${PROJECTNAME} DESTINATION . )
