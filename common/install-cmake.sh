#!/bin/bash
set -eou pipefail

CMAKE_VERSION=3.27.4
CMAKE_ARCH=linux-x86_64

DOWNLOAD_URL="https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/"
FILENAME="cmake-${CMAKE_VERSION}-${CMAKE_ARCH}.sh"

# Download CMake
echo "Downloading ${FILENAME}"
wget -nv "${DOWNLOAD_URL}/${FILENAME}" -O "${FILENAME}"

# Install CMake
echo "Installing CMake"
bash "${FILENAME}" --skip-license --prefix=/usr/local --exclude-subdir

# Clean up
rm "${FILENAME}"
