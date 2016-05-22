#include "catch.hpp"
#include "cppproject.h"

TEST_CASE("Project", "[project]") {
  SECTION("section") {
    REQUIRE(cppproject::api() == true);
  }
}
