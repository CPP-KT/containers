#!/usr/bin/env bash
set -euo pipefail

VALGRIND_VERSION=3.25.1

DOWNLOAD_URL="https://sourceware.org/pub/valgrind"
FILENAME="valgrind-${VALGRIND_VERSION}.tar.bz2"

# Install dependencies
echo "Installing valgrind dependencies"
apt-get install -y --no-install-recommends \
  make bzip2 libc6-dbg

# Set working directory to /tmp
pushd /tmp

# Download
echo "Downloading ${FILENAME}"
wget -nv "${DOWNLOAD_URL}/${FILENAME}" -O "${FILENAME}"

# Unpack
echo "Unpacking ${FILENAME}"
tar xf "${FILENAME}"

SOURCE_DIR="valgrind-${VALGRIND_VERSION}"
pushd "${SOURCE_DIR}"

# Build
echo "Building Valgrind"
./configure
make -j

# Install
echo "Installing Valgrind"
make install

# Go back
popd
popd
