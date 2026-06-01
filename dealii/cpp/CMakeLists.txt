##
## https://dealii.org/developer/users/cmake_user.html
##
cmake_minimum_required(VERSION 3.31.5)

project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for DealIItesting"
  VERSION 1.0 )

find_package( MKL CONFIG REQUIRED )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )

find_package( MPI )
find_package( deal.II REQUIRED )

target_link_libraries(
	${PROJECTNAME} PUBLIC
	dealii::dealii_release 
	$<LINK_ONLY:MKL::MKL>
)

install( TARGETS ${PROJECTNAME} DESTINATION . )
