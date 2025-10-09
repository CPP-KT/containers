#!/usr/bin/env bash
set -euo pipefail

LLVM_VERSION=$1

source /etc/os-release
DEBIAN_VERSION=$VERSION_CODENAME

BASE_URL='http://apt.llvm.org'
REPO_NAME="llvm-toolchain-${DEBIAN_VERSION}-${LLVM_VERSION}"
DEB_LINE="deb ${BASE_URL}/${DEBIAN_VERSION}/ ${REPO_NAME} main"

wget -qO- "${BASE_URL}/llvm-snapshot.gpg.key" > /etc/apt/trusted.gpg.d/apt.llvm.org.asc

echo "${DEB_LINE}" > /etc/apt/sources.list.d/apt.llvm.org.list
apt-get update -qq

apt-get install -y --no-install-recommends \
  "llvm-${LLVM_VERSION}" \
  "clang-${LLVM_VERSION}" \
  "clang-tools-${LLVM_VERSION}" \
  "clang-format-${LLVM_VERSION}" \
  "clang-tidy-${LLVM_VERSION}" \
  "libc++-${LLVM_VERSION}-dev" \
  "libc++abi-${LLVM_VERSION}-dev" \
  "libclang-rt-${LLVM_VERSION}-dev" \
  "liblldb-${LLVM_VERSION}-dev"

ln -sf "/usr/lib/llvm-${LLVM_VERSION}/bin"/* /usr/bin
ln -sf /usr/bin/clang /usr/bin/cc
ln -sf /usr/bin/clang++ /usr/bin/c++
