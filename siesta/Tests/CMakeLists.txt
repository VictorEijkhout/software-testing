# This is the main engine for SIESTA tests.
# We should probably leave only the "simple" tests as the default
# without their output verification. This can be done by choosing
# the appropriate tests when making the cmake targets (maybe via labels?)

# TODO
# Instead of doing everything in CMake, first running, then checking.
# It would be better to control the 2nd run in a wrapper executable.
# This executable would run siesta, then check.
# That would also remove the problem of labels for tests.

# Include the tests setup scripts that define
# the required test variables/functions.
include(tests/SiestaTests)

# TODO consider changing this to a fixture.
file(
  COPY
    test-cfg.yml
    out_digest_yaml.awk
    yaml_compare.py
  DESTINATION
    "${SIESTA_TESTS_BINARY_DIR}"
)


list(APPEND CMAKE_MESSAGE_CONTEXT test)
message(STATUS "Default pseudo directory for tests: ${SIESTA_TESTS_PSEUDO_DIR}")

# Checking the output files requires Python3
# The siesta_verifyout function may break
# if Python 3 cannot be located!
find_package(Python3
  3.5.0 # subprocess limitation
  COMPONENTS Interpreter
  )

# TODO add check for import of the ruamel.yaml package.


add_subdirectory(00.BasisSets)
add_subdirectory(01.PseudoPotentials)
add_subdirectory(02.SpinPolarization)
add_subdirectory(03.SpinOrbit)
add_subdirectory(04.SCFMixing)
add_subdirectory(05.Bands)
add_subdirectory(06.DensityOfStates)
add_subdirectory(07.ForceConstants)
add_subdirectory(08.GeometryOptimization)
add_subdirectory(09.MolecularDynamics)
add_subdirectory(10.Functionals)
add_subdirectory(11.ElectronicProperties)
add_subdirectory(12.Solvers)
add_subdirectory(13.MiscOptions)
add_subdirectory(14.FileIO)
add_subdirectory(15.TDDFT)
add_subdirectory(16.TranSiesta)

add_subdirectory(17.Wannier90)
add_subdirectory(Dependency_Tests)
add_subdirectory(Unit_Tests)

# Pop back the test context
list(POP_BACK CMAKE_MESSAGE_CONTEXT)
