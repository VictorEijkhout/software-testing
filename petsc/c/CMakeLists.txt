cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME} VERSION 1.0 LANGUAGES C )

add_executable( ${PROJECTNAME} ${PROJECT_NAME}.c )

find_package( MPI )
find_package( PkgConfig REQUIRED )
pkg_check_modules( PETSC REQUIRED petsc )

message( STATUS "PETSc includes: ${PETSC_INCLUDE_DIRS}" )
message( STATUS "PETSc libraries: ${PETSC_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${PETSC_INCLUDE_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${PETSC_C_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${PETSC_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC petsc )

install( TARGETS ${PROJECTNAME} DESTINATION . )
