#include <cstdlib>
#include <cstdio>
#include <cstdint>
#include <type_traits>
#include "scotch.h"

static_assert( std::is_same< int32_t, SCOTCH_Num >::value );
int main() {}

