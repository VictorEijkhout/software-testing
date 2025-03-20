cmake_minimum_required( VERSION 3.21 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

target_include_directories(
        ${PROJECTNAME} PUBLIC
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
