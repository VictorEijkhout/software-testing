cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for MPI testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( MPI REQUIRED )

target_link_libraries(
	${PROJECTNAME} PUBLIC
	MPI::MPI_CXX
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
