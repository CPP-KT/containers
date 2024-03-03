#!/bin/bash
set -euo pipefail

GCC_VERSION=$1

apt-get install -y --no-install-recommends \
  "gcc-${GCC_VERSION}" \
  "g++-${GCC_VERSION}"

ln -sf "$(which "gcc-${GCC_VERSION}")" /usr/bin/gcc
ln -sf "$(which "g++-${GCC_VERSION}")" /usr/bin/g++

ln -sf /usr/bin/gcc /usr/bin/cc
ln -sf /usr/bin/g++ /usr/bin/c++
