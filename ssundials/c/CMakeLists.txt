cmake_minimum_required(VERSION 3.31.5)

project( ${PROJECTNAME}
  DESCRIPTION "C programs for sundials testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( SUNDIALS REQUIRED )

target_link_libraries(
        ${PROJECTNAME} PUBLIC
	# there are many of these targets;
	# these are just for this example.
	SUNDIALS::cvode
	SUNDIALS::kinsol
	# prevent gcc stumbling on math operations @@GLIBC
	m dl
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
