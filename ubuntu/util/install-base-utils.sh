#!/bin/bash
set -euo pipefail

packages=()

# SSL certificates
packages+=(ca-certificates)

# Needed for line break checks
packages+=(dos2unix)

# Used for downloading dependencies in some installation scripts
packages+=(wget curl)

# Used for unpacking dependencies in some installation scripts
packages+=(zip unzip tar)

# Used by vcpkg
packages+=(pkg-config)

# Used to update tests
packages+=(git)

# Build system used by CMake
packages+=(ninja-build)

# For verbose messages in case of an abnormal program termination
packages+=(gdb)

# The Netwide Assembler
packages+=(nasm)

# For processing CTest's JSON output
packages+=(jq)

# Used for tests by various tasks
packages+=(python3)

apt-get install -y --no-install-recommends "${packages[@]}"
