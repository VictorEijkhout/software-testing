cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package(Boost COMPONENTS 
    filesystem
    iostreams
    log
    serialization
    system
    REQUIRED)

message( "Found include dirs: ${Boost_INCLUDE_DIRS}" )
target_include_directories(
    ${PROJECTNAME} PUBLIC ${Boost_INCLUDE_DIRS})

message( "Found include dirs: ${Boost_LIBRARY_DIRS}" )
target_link_directories(
    ${PROJECTNAME} PUBLIC ${Boost_LIBRARY_DIRS})

target_link_libraries(
    ${PROJECT_NAME} PRIVATE 
    Boost::boost 
    Boost::filesystem
    Boost::serialization
    Boost::system Boost::iostreams)

install( TARGETS ${PROJECTNAME} DESTINATION . )
