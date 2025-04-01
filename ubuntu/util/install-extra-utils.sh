#!/bin/bash
set -euo pipefail

pushd "$(dirname "${BASH_SOURCE[0]}")"

./install-cmake.sh
./install-ccache.sh
./install-valgrind.sh
./install-vcpkg.sh

popd
