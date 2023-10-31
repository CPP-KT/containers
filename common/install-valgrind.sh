#!/bin/bash
set -euo pipefail

VALGRIND_VERSION=3.21.0

DOWNLOAD_URL="https://sourceware.org/pub/valgrind"
FILENAME="valgrind-${VALGRIND_VERSION}.tar.bz2"

# Install dependencies
echo "Installing valgrind dependencies"
apt-get install -y --no-install-recommends \
  make bzip2 libc6-dbg

# Download
echo "Downloading ${FILENAME}"
wget -nv "${DOWNLOAD_URL}/${FILENAME}" -O "${FILENAME}"

# Unpack
echo "Unpacking ${FILENAME}"
tar xf "${FILENAME}"

SOURCE_DIR="valgrind-${VALGRIND_VERSION}"
cd "${SOURCE_DIR}"

# Build
echo "Building Valgrind"
./configure
make

# Install
echo "Installing Valgrind"
make install

# Clean up
cd ..
rm -rf "${SOURCE_DIR}"
rm "${FILENAME}"
