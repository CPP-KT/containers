#!/bin/bash
set -euo pipefail

apt-get install -y --no-install-recommends ccache

# Create a default cache directory
mkdir "${CCACHE_DIR}"
chmod -R a+rwx "${CCACHE_DIR}"

