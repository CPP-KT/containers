#!/bin/bash
set -eou pipefail

# Install dependencies
echo "Installing vcpkg dependencies"
apt-get install -y --no-install-recommends \
  curl zip unzip tar pkg-config

# Download vcpkg
echo "Cloning vcpkg repository"
git clone https://github.com/microsoft/vcpkg.git /opt/vcpkg

# Install vcpkg
echo "Installing vcpkg"
/opt/vcpkg/bootstrap-vcpkg.sh -disableMetrics

# Install commonly used packages
packages=(gtest)
echo "Installing commonly used vcpkg packages (${packages[*]})"
mkdir "${VCPKG_DEFAULT_BINARY_CACHE}"
/opt/vcpkg/vcpkg install "${packages[@]}"

# Allow modification of .vcpkg-root by any user
chmod a+w /opt/vcpkg/.vcpkg-root
