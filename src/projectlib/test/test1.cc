#include "catch.hpp"
#include "project.h"

TEST_CASE("Project", "[project]") {
  SECTION("section") {
    REQUIRE(project::api() == true);
  }
}
