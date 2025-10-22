cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for P4est testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )

find_package( MPI )
find_package( P4EST REQUIRED )

target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
	P4EST::P4EST
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC m
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
