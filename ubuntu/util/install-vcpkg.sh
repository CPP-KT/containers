#!/bin/bash
set -euo pipefail

# Install dependencies
echo "Installing vcpkg dependencies"
apt-get install -y --no-install-recommends \
  curl zip unzip tar pkg-config

# Download vcpkg
echo "Cloning vcpkg repository"
git clone https://github.com/cpp-kt/vcpkg.git /opt/vcpkg --branch year2025 --depth 1

# Install vcpkg
echo "Installing vcpkg"
/opt/vcpkg/bootstrap-vcpkg.sh -disableMetrics

# Install commonly used packages
packages=(gtest catch2 benchmark)
echo "Installing commonly used vcpkg packages (${packages[*]})"
mkdir "${VCPKG_DEFAULT_BINARY_CACHE}"
/opt/vcpkg/vcpkg install "${packages[@]}"

# Provide access to all users
chmod -R a+rwx /opt/vcpkg "${VCPKG_DEFAULT_BINARY_CACHE}"
