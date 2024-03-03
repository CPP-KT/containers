#!/bin/bash
set -euo pipefail

LLVM_VERSION=$1

source /etc/os-release
DEBIAN_VERSION=$VERSION_CODENAME

BASE_URL='http://apt.llvm.org'
REPO_NAME="deb ${BASE_URL}/${DEBIAN_VERSION}/ llvm-toolchain-${DEBIAN_VERSION}-${LLVM_VERSION} main"

wget -qO- "${BASE_URL}/llvm-snapshot.gpg.key" | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc

echo "${REPO_NAME}" > /etc/apt/sources.list.d/apt.llvm.org.list
apt-get update

apt-get install -y --no-install-recommends \
  "clang-${LLVM_VERSION}" \
  "clang-tools-${LLVM_VERSION}" \
  "clang-format-${LLVM_VERSION}" \
  "clang-tidy-${LLVM_VERSION}" \
  "libc++-${LLVM_VERSION}-dev" \
  "libc++abi-${LLVM_VERSION}-dev" \
  "libclang-rt-${LLVM_VERSION}-dev" \
  "liblldb-${LLVM_VERSION}-dev"

ln -sf "/usr/lib/llvm-${LLVM_VERSION}/bin"/* /usr/bin
ln -sf clang /usr/bin/cc
ln -sf clang++ /usr/bin/c++
