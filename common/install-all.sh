#!/bin/bash
set -eou pipefail

pushd "$(dirname "${BASH_SOURCE[0]}")"

./install-base-utils.sh
./install-cmake.sh
#./install-valgrind.sh
./install-vcpkg.sh

popd
