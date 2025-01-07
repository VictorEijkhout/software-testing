cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_20 )

find_package( range-v3 REQUIRED )
target_link_libraries( ${PROJECTNAME} PUBLIC range-v3::range-v3 )

install( TARGETS ${PROJECTNAME} DESTINATION . )
