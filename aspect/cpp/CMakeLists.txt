cmake_minimum_required(VERSION 3.31.5)

project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )

find_package( MPI )
find_package( deal.II REQUIRED )
find_package( Aspect REQUIRED )

IF (NOT Aspect_FOUND)
  MESSAGE(FATAL_ERROR "\n"
	"Could not find a valid ASPECT build/installation directory. "
	"Please specify the directory where you are building ASPECT by passing\n"
	"   -D Aspect_DIR=<path to ASPECT>\n"
	"to cmake or by setting the environment variable ASPECT_DIR in your shell "
	"before calling cmake. See the section 'How to write a plugin' in the "
        "manual for more information.")
ENDIF ()

DEAL_II_INITIALIZE_CACHED_VARIABLES()

ASPECT_SETUP_PLUGIN(${PROJECTNAME})

