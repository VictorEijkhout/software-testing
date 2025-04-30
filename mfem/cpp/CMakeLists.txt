cmake_minimum_required( VERSION 3.24 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )

find_package( MPI REQUIRED )
# https://github.com/mfem/mfem/issues/4525
find_package( MFEM REQUIRED )

message( STATUS "Mfem includes: ${MFEM_INCLUDE_DIRS}" )
message( STATUS "Mfem libraries: ${MFEM_LIBRARY_DIRS}" )

##
## MKL
## https://www.intel.com/content/www/us/en/docs/onemkl/developer-guide-macos/2023-0/cmake-config-for-onemkl.html
##
find_package(MKL CONFIG REQUIRED)
message(STATUS "${MKL_IMPORTED_TARGETS}")

target_compile_options(
        ${PROJECTNAME} PUBLIC
        $<TARGET_PROPERTY:MKL::MKL,INTERFACE_COMPILE_OPTIONS>
	)
target_include_directories(
        ${PROJECTNAME} PUBLIC
        $<TARGET_PROPERTY:MKL::MKL,INTERFACE_INCLUDE_DIRECTORIES>
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        $<LINK_ONLY:MKL::MKL>
	)

##
## MPI, mfem
##
target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
##        ${MFEM_INCLUDE_DIRS}
      )
target_link_libraries(
        ${PROJECTNAME} PUBLIC mfem )

install( TARGETS ${PROJECTNAME} DESTINATION . )
