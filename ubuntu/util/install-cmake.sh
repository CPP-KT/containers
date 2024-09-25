#!/bin/bash
set -euo pipefail

CMAKE_VERSION=3.30.3
CMAKE_ARCH=linux-$(uname -m)

DOWNLOAD_URL="https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/"
FILENAME="cmake-${CMAKE_VERSION}-${CMAKE_ARCH}.sh"

# Set working directory to /tmp
pushd /tmp

# Download CMake installation script
echo "Downloading ${FILENAME}"
wget -nv "${DOWNLOAD_URL}/${FILENAME}" -O "${FILENAME}"

# Install CMake
echo "Installing CMake"
bash "${FILENAME}" --skip-license --prefix=/usr --exclude-subdir

# Go back
popd
