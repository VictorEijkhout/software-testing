cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( PkgConfig REQUIRED )
pkg_check_modules( FMTLIB REQUIRED fmt )
message( STATUS "Fmtlib includes: ${FMTLIB_INCLUDE_DIRS}" )

target_include_directories(
	${PROJECTNAME} PUBLIC ${FMTLIB_INCLUDE_DIRS}
	)
target_link_directories(
	${PROJECTNAME} PUBLIC ${FMTLIB_LIBRARY_DIRS}
	)
target_link_libraries(
	${PROJECTNAME} PUBLIC ${FMTLIB_LIBRARIES}
	)
set_target_properties(
	${PROJECTNAME} PROPERTIES
	BUILD_RPATH   "${FMTLIB_LIBRARY_DIRS}"
	INSTALL_RPATH "${FMTLIB_LIBRARY_DIRS}"
    )

install( TARGETS ${PROJECTNAME} DESTINATION . )
