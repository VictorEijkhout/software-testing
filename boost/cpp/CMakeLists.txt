cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( Boost )

target_include_directories(
    ${PROJECTNAME} PUBLIC ${BOOST_INCLUDE_DIRS})


install( TARGETS ${PROJECTNAME} DESTINATION . )
