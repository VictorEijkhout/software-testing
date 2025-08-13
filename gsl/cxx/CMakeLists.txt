cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for GSL testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( PkgConfig REQUIRED )
pkg_check_modules( GSL REQUIRED gsl )
message( STATUS "Cxxopts includes: ${GSL_INCLUDE_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${GSL_INCLUDE_DIRS}
	)
target_link_directories(
	${PROJECTNAME} PUBLIC
	${GSL_LIBRARY_DIRS}
	)
target_link_libraries(
	${PROJECTNAME} PUBLIC
	${GSL_LIBRARIES}
	)

set_target_properties(
	${PROJECTNAME} PROPERTIES
	BUILD_RPATH   "${GSL_LIBRARY_DIRS}"
	INSTALL_RPATH "${GSL_LIBRARY_DIRS}"
    )

install( TARGETS ${PROJECTNAME} DESTINATION . )
