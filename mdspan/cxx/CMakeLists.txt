cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for mdspan testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_20 )

target_include_directories(
	${PROJECTNAME} PUBLIC "$ENV{TACC_MDSPAN_INC}"
	)

set_target_properties(
	${PROJECTNAME} PROPERTIES
	BUILD_RPATH   "${TACC_MDSPAN_DIRS}"
	INSTALL_RPATH "${TACC_MDSPAN_DIRS}"
    )

install( TARGETS ${PROJECTNAME} DESTINATION . )
