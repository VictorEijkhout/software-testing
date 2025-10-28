
add_executable(
  test-citations
  test_citations.f90
  ${PROJECT_SOURCE_DIR}/Src/m_cite.F90
)

file(MAKE_DIRECTORY "${PROJECT_BINARY_DIR}/unit_tests")

add_test(  NAME    citations-test
           COMMAND $<TARGET_FILE:test-citations>
	   WORKING_DIRECTORY "${PROJECT_BINARY_DIR}/unit_tests"
	)

set_property (TEST citations-test
              PROPERTY PASS_REGULAR_EXPRESSION "0953-8984")
