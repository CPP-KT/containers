#include <catch2/catch_test_macros.hpp>

#include <stdexcept>

static void throwing_func() {
  throw std::logic_error("some exception");
}

TEST_CASE("ABI") {
  REQUIRE_THROWS_AS(throwing_func(), std::logic_error);
}
