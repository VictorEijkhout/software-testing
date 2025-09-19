cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for Arpack testing"
  VERSION 1.0 )
enable_language( Fortran )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( MPI REQUIRED )
find_package( arpackng )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${HDF_INCLUDE_DIRS}
	${ARPACK_INCLUDE_DIRS}
	)

set( BLA_VENDOR "Intel10_64lp_seq" )
find_package( BLAS REQUIRED )      

find_package( MKL CONFIG REQUIRED PATHS $ENV{MKLROOT} )

target_compile_options(
        ${PROJECTNAME} PUBLIC
        $<TARGET_PROPERTY:MKL::MKL,INTERFACE_COMPILE_OPTIONS>
      )
target_include_directories(
        ${PROJECTNAME} PUBLIC
        $<TARGET_PROPERTY:MKL::MKL,INTERFACE_INCLUDE_DIRECTORIES>
      )
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${MPI_LIBRARY_DIRS}
      )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        $<LINK_ONLY:MKL::MKL>
      )
target_link_libraries(
  ${PROJECTNAME} PUBLIC
  ${MPI_Fortran_LIBRARIES}
  # MPI::MPI_Fortran
  # ARPACK::ARPACK
)

install( TARGETS ${PROJECTNAME} DESTINATION . )
