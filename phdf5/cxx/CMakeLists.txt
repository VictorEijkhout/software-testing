cmake_minimum_required( VERSION 3.19 ) # 3.19 needed for hdf5_cpp target
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( HDF5 REQUIRED COMPONENTS CXX C )
target_link_libraries(
    ${PROJECTNAME} PUBLIC
    hdf5::hdf5_cpp hdf5::hdf5 # both needed
)

install( TARGETS ${PROJECTNAME} DESTINATION . )
