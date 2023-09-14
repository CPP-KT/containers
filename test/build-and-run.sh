#!/bin/bash
set -eou pipefail

# Ensure that cc and c++ are valid commands
cc --version
c++ --version

# Build
echo 'Building test target'

BUILD_DIR=cmake-build
mkdir "${BUILD_DIR}"

cmake \
  -DCMAKE_TOOLCHAIN_FILE=/opt/vcpkg/scripts/buildsystems/vcpkg.cmake \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
   -S . -B "${BUILD_DIR}"

cmake --build "${BUILD_DIR}"

# Run
echo 'Running test target'
"${BUILD_DIR}"/test
