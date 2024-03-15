cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

enable_language( Fortran )
add_executable(${PROJECTNAME} ${PROJECTNAME}.f)

find_package( MKL CONFIG REQUIRED )
target_compile_options(
	${PROJECTNAME} PUBLIC
	$<TARGET_PROPERTY:MKL::MKL,INTERFACE_COMPILE_OPTIONS> )
target_include_directories(
	${PROJECTNAME} PUBLIC
	$<TARGET_PROPERTY:MKL::MKL,INTERFACE_INCLUDE_DIRECTORIES> )
target_link_libraries(
	${PROJECTNAME} PUBLIC 
	$<LINK_ONLY:MKL::MKL>)


find_package(arpackng)
target_include_directories(${PROJECTNAME} PUBLIC ARPACK::ARPACK)
target_link_libraries(${PROJECTNAME} PUBLIC
    ARPACK::ARPACK)

install( TARGETS ${PROJECTNAME} DESTINATION . )
