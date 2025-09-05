cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( HighFive REQUIRED )
target_link_libraries( ${PROJECTNAME} HighFive)

install( TARGETS ${PROJECTNAME} DESTINATION . )
