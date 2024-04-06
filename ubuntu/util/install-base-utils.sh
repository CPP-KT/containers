#!/bin/bash
set -euo pipefail

packages=()

# SSL certificates
packages+=(ca-certificates)

# Needed for line break checks
packages+=(dos2unix)

# Used in multiple installation scripts
packages+=(wget)

# Used to update tests
packages+=(git)

# Build system used by CMake
packages+=(ninja-build)

# For verbose messages in case of an abnormal program termination
packages+=(gdb)

# For processing CTest's JSON output
packages+=(jq)

apt-get install -y --no-install-recommends "${packages[@]}"
