cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "Fortran programs for Parpack testing"
  VERSION 1.0 )

enable_language( Fortran )
add_executable(${PROJECTNAME} ${PROJECTNAME}.f)

if( DEFINED ENV{TACC_NVPL_DIR} )
  find_package( NVPL REQUIRED )
  target_link_libraries( ${PROJECTNAME} PUBLIC nvpl::blas_lp64_seq )
elseif( DEFINED ENV{TACC_MKL_DIR} )

  set( MKL_ARCH "intel64" )
  set( MKL_THREADING "sequential" )
  set( MKL_INTERFACE "lp64" )
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
endif()

find_package(arpackng)
target_include_directories(${PROJECTNAME} PUBLIC
  ${MPI_Fortran_INCLUDE_DIRS}
)
target_link_libraries(${PROJECTNAME} PUBLIC
  ${MPI_Fortran_LIBRARIES} 
  ARPACK::ARPACK)

find_package( MPI )


install( TARGETS ${PROJECTNAME} DESTINATION . )
