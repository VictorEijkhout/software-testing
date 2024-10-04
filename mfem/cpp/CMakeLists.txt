cmake_minimum_required( VERSION 3.24 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )

find_package( MPI REQUIRED )
find_package( MFEM REQUIRED )

message( STATUS "Mfem includes: ${MFEM_INCLUDE_DIRS}" )
message( STATUS "Mfem libraries: ${MFEM_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
##        ${MFEM_INCLUDE_DIRS}
      )
# target_link_directories(
#         ${PROJECTNAME} PUBLIC
# 	${MFEM_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC mfem )

install( TARGETS ${PROJECTNAME} DESTINATION . )
