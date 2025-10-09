include(FetchContent)

message(STATUS "Fetching Catch2...")
FetchContent_Declare(
  Catch2
  URL https://github.com/catchorg/Catch2/archive/refs/tags/v3.8.0.tar.gz
  FIND_PACKAGE_ARGS
)
FetchContent_MakeAvailable(Catch2)
