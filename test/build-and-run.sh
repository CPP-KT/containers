#!/bin/bash
set -euo pipefail

# Ensure that cc and c++ are valid commands
cc --version
c++ --version

# Build
echo 'Building test target'

BUILD_DIR=cmake-build
mkdir -p "${BUILD_DIR}"

cmake \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -S . -B "${BUILD_DIR}"

cmake --build "${BUILD_DIR}"

# Run
echo 'Running test target'
export ASAN_OPTIONS=alloc_dealloc_mismatch=0 # https://github.com/llvm/llvm-project/issues/59432
"${BUILD_DIR}"/test

# Clean up
rm -rf "$BUILD_DIR"
