cmake_minimum_required(VERSION 3.27.5)
project(container-test)

set(CMAKE_CXX_STANDARD 20)

find_package(GTest REQUIRED)

add_executable(test test.cpp)

target_compile_options(test PRIVATE -Wall -Wextra -Wno-sign-compare)
target_compile_options(test PRIVATE -Werror -pedantic-errors)

target_compile_options(test PRIVATE -fsanitize=address,undefined,leak -fno-sanitize-recover=all)
target_link_options(test PRIVATE -fsanitize=address,undefined,leak)

target_link_libraries(test GTest::gtest GTest::gtest_main)
