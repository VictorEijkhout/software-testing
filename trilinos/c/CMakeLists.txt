cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for trilinos testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( MPI )
find_package(Trilinos REQUIRED )

message( STATUS "Trilinos includes: ${Trilinos_INCLUDE_DIRS}" )
message( STATUS "Trilinos libraries: ${Trilinos_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${Trilinos_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${Trilinos_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${Trilinos_LIBRARY_DIRS}
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
