
if(SIESTA_WITH_DFTD3)
  siesta_subtest(dftd3 LABELS simple)
endif()

# This test might fail if LUA is not present.
if(SIESTA_WITH_FLOOK)
  siesta_subtest(lua_h2o FILES_SETUP siesta.lua)
endif()
