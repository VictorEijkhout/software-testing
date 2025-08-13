cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for Metis64 testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

target_include_directories(
        ${PROJECTNAME} PUBLIC
	$ENV{TACC_METIS_INC}
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
