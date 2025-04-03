#!/bin/bash
set -euo pipefail

apt-get install -y --no-install-recommends ccache

# Create a default cache directory
mkdir "${CCACHE_DIR}"
chmod -R a+rwx "${CCACHE_DIR}"


### WARM UP CCACHE ###

REPO_URL="https://github.com/cpp-kt/template-task.git"
CLONE_DIR="/opt/template-task"

export CCACHE_NOHASHDIR=1
export CCACHE_BASEDIR=${CLONE_DIR}
export CCACHE_IGNOREOPTIONS=-ffile-prefix-map*

if [ ! -d "${CLONE_DIR}" ]; then
    git clone "${REPO_URL}" "${CLONE_DIR}"
fi

pushd "${CLONE_DIR}"
export CCACHE_LOGFILE=ccache.log

if [ -f CMakePresets.json ]; then
    PRESETS=$(jq -r '.version as $v | .configurePresets[] | select(.hidden != true) | .name' CMakePresets.json)
else
    echo "CMakePresets.json not found!"
    exit 1
fi

for PRESET in $PRESETS; do
    echo "Building with: ${PRESET}"
    
    cmake --preset  ${PRESET}
    cmake --build build/${PRESET}
done

echo "All presets are built."

popd

rm -rf ${CLONE_DIR}
