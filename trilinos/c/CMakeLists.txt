cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( MPI )
find_package(Trilinos REQUIRED )

message( STATUS "Trilinos includes: ${TRILINOS_INCLUDE_DIRS}" )
message( STATUS "Trilinos libraries: ${TRILINOS_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${TRILINOS_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${TRILINOS_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${TRILINOS_LIBRARY_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC trilinos
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
