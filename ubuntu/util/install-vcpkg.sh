#!/bin/bash
set -euo pipefail

# Install dependencies
echo "Installing vcpkg dependencies"
apt-get install -y --no-install-recommends \
  curl zip unzip tar pkg-config

# Download vcpkg
echo "Cloning vcpkg repository"
git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg --depth 1

# Install vcpkg
echo "Installing vcpkg"
/opt/vcpkg/bootstrap-vcpkg.sh -disableMetrics

# Install commonly used packages
packages=(gtest catch2)
echo "Installing commonly used vcpkg packages (${packages[*]})"
mkdir "${VCPKG_DEFAULT_BINARY_CACHE}"
/opt/vcpkg/vcpkg install "${packages[@]}"

# Allow write access for all users
chmod -R a+w /opt/vcpkg "${VCPKG_DEFAULT_BINARY_CACHE}"
