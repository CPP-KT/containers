cmake_minimum_required(VERSION 3.24...3.31)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(ConfigureCompiler)
include(CompilerWarnings)

project(template LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

ct_configure_compiler()
include(Dependencies)

# Setup a 'tests' target
set(TESTS_SOURCES test.cpp)
add_executable(tests ${TESTS_SOURCES})
target_include_directories(tests PRIVATE test)
ct_set_compiler_warnings(tests)

# Link tests with dependencies
find_package(Catch2 CONFIG REQUIRED)
target_link_libraries(tests PRIVATE Catch2::Catch2WithMain)
